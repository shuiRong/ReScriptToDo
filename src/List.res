@module("./App.module.scss") external styles: {..} = "default"

@react.component
let make = (~data: array<Types.item>, ~setLists, ~store: Types.ref) => {
  let onChangeStatus = (id: float) => {
    setLists(_ => {
      let newLists = store.current->Js.Array2.map(item =>
        item.id == id
          ? {
              ...item,
              done: !item.done,
            }
          : item
      )

      store.current = newLists
      newLists
    })
  }

  let onRemove = (id: float) => {
    setLists((lists: array<Types.item>) => {
      let newwLists = lists->Js.Array2.filter(item => item.id != id)

      store.current = store.current->Js.Array2.filter(item => item.id != id)
      newwLists
    })
  }

  data
  ->Js.Array2.map(item =>
    <div className={styles["item"]} key={Belt.Float.toString(item.id)}>
      <span
        className={`${styles["toggleIcon"]} ${item.done ? styles["checked"] : ""}`}
        onClick={_ => onChangeStatus(item.id)}
      />
      <p> {React.string(item.label)} </p>
      <button onClick={_ => onRemove(item.id)}> {React.string("X")} </button>
    </div>
  )
  ->React.array
}
