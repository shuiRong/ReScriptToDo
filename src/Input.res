@module("./App.module.scss") external styles: {..} = "default"
@module("./assets/check.svg") external checkAllSVG: string = "default"

@react.component
let make = (~setLists, ~store: Types.ref) => {
  let onKeyDown = evt => {
    let key = ReactEvent.Keyboard.key(evt)
    let value = ReactEvent.Keyboard.target(evt)["value"]
    switch key {
    | "Enter" if value != "" => {
        setLists(_ => {
          let newLists = Js.Array.concat(
            store.current,
            [
              {
                id: Js.Date.now(),
                label: value,
                done: false,
              },
            ],
          )
          store.current = newLists
          newLists
        })
        ReactEvent.Keyboard.target(evt)["value"] = ""
      }
    | _ => ()
    }
  }

  let completeAll = (_)=>{
    setLists(_ => {
      let newLists = Js.Array2.map(store.current, item => ({
        ...item,
        done: true,
      }))
      store.current = newLists

      newLists
    })
  }

  <div className={styles["inputBox"]}>
    <img src={checkAllSVG} onClick={completeAll}/>
    <input
      className={styles["input"]} type_="text" onKeyDown placeholder="What needs to be done?"
    />
  </div>
}
