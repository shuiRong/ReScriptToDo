@module("./App.module.scss") external styles: {..} = "default"

  type operation = Active | Complete | Clear | All

  @react.component
  let make = (~length, ~setLists, ~store: Types.ref) => {
    let (page, setPage) = React.useState(_ => All)

    let changeVisibility = (which: operation) => {
      setPage(_ => which)

      switch which {
      | All => setLists(_ => store.current)
      | Active =>
        setLists(_ => {
          Js.log("active")
          let newLists = store.current->Js.Array2.filter(item => !item.done)
          Js.log2(newLists, store.current)
          newLists
        })
      | Complete =>
        setLists(_ => {
          Js.log("complete")
          let newLists = store.current->Js.Array2.filter(item => item.done)
          newLists
        })
      | Clear =>
        setLists(_ => {
          let newLists = store.current->Js.Array2.filter(item => !item.done)

          store.current = newLists

          setPage(_ => All)

          newLists
        })
      }
    }

    let hasCompleted = store.current->Js.Array2.filter(item => item.done)->Js.Array2.length !== 0

    <div className={styles["footer"]}>
      <span> {React.int(length)} {React.string(" items left")} </span>
      <div>
        <button className={page === All ? styles["selected"] : ""} onClick={_ => changeVisibility(All)}>
          {React.string("All")}
        </button>
        <button
          className={page === Active ? styles["selected"] : ""} onClick={_ => changeVisibility(Active)}>
          {React.string("Active")}
        </button>
        <button
          className={page === Complete ? styles["selected"] : ""} onClick={_ => changeVisibility(Complete)}>
          {React.string("Complete")}
        </button>
      </div>
      {hasCompleted ? <button onClick={_ => changeVisibility(Clear)}> {React.string("Clear completed")} </button> : React.string("\b")}
    </div>
  }