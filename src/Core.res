type suit =
  | Gunting
  | Batu
  | Kertas

type play =
  | Won
  | Draw
  | Lose

let suits = [Gunting, Batu, Kertas]

let suitFromInt = n =>
  switch n {
  | 0 => Gunting
  | 1 => Batu
  | _ => Kertas
  }

let suitToString = n =>
  switch n {
  | Gunting => "Gunting"
  | Batu => "Batu"
  | Kertas => "Kertas"
  }

let play = (a, b) =>
  switch (a, b) {
  | (Gunting, Gunting) => Draw
  | (Gunting, Batu) => Lose
  | (Gunting, Kertas) => Won
  | (Batu, Batu) => Draw
  | (Batu, Kertas) => Lose
  | (Batu, Gunting) => Won
  | (Kertas, Kertas) => Draw
  | (Kertas, Gunting) => Lose
  | (Kertas, Batu) => Won
  }

let mulF = (a, b) => a *. b

let randomSuit = () => Math.random()->mulF(3.0)->Math.floor->Float.toInt->suitFromInt

type matchHistory = (suit,suit,play)

let playRandom = a => {
  let b = randomSuit()
    (a, b, play(a, b))
  }

let render = (~onDraw, ~onLose, ~onWon, a, b) =>
  switch play(a, b) {
  | Won => onWon(a, b)
  | Draw => onDraw(a, b)
  | Lose => onLose(a, b)
  }

type player =
  | Human
  | Computer

let playerToString = player =>
  switch player {
  | Human => "Human"
  | Computer => "Computer"
  }

let players = [Human, Computer]

type action =
  | Idle
  | PlayWith(player)
  | Choose(suit)


type state = {
  with_: option<player>,
  history: list<matchHistory>
}


let reducer = () => {
  let reducer = (s, action) =>
    switch action {
    | Idle => s
    | PlayWith(with_) => {...s, with_: Some(with_)}
    | Choose(a) => {...s, history: list{playRandom(a), ...s.history } }
    }
  React.useReducer(reducer, {with_: None, history: list{} })
}
