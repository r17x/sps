@module("./logo.svg") external logo: string = "default"
%%raw(`import './App.css'`)

@react.component
let make = () => {
  let (state, send) = Core.reducer()

  let result = Core.render(
    ~onDraw=(a, b) => `a: ${a->Core.suitToString} vs b: ${b->Core.suitToString} - Draw`,
    ~onLose=(a, b) => `a: ${a->Core.suitToString} vs b: ${b->Core.suitToString} - You'r Lose!`,
    ~onWon=(a, b) => `a: ${a->Core.suitToString} vs b: ${b->Core.suitToString} - Hey Winner!`,
  )

  let suitSelections =
    Core.suits->Array.map(suit =>
      <button key={suit->Core.suitToString} onClick={_ => Core.Choose(suit)->send}>
        {suit->Core.suitToString->React.string}
      </button>
    )

  let result = switch (state.history, state.with_) {
  | (list{}, None) =>
    Core.players->Array.map(player =>
      <button onClick={_ => Core.PlayWith(player)->send} key={player->Core.playerToString}>
        {player->Core.playerToString->React.string}
      </button>
    )
  | (list{}, Some(Computer as player)) =>
    [
      <label key={player->Core.playerToString}>
        {`Bermain dengan: ${player->Core.playerToString}`->React.string}
      </label>,
    ]->Array.concat(suitSelections)
  | (histories, Some(Computer as player)) =>
    [
      <label key={player->Core.playerToString}>
        {`Bermain dengan: ${player->Core.playerToString}`->React.string}
      </label>,
    ]
    ->Array.concat(
      histories
      ->List.mapWithIndex((index, history) => {
        let (a, b, _) = history
        <p key={index->Int.toString}> {a->result(b)->React.string} </p>
      })
      ->List.toArray,
    )
    ->Array.concat(suitSelections)
  | _ => []
  }

  <div className="App">
    <header className="App-header">
      <img src={logo} className="App-logo" alt="logo" />
      // <label>{`a (${a->Int.toString}) vs b (${b->Int.toString})`->React.string}</label>
      {result->React.array}
    </header>
  </div>
}
