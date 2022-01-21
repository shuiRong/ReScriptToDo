@module("./App.module.scss") external styles: {..} = "default"

@react.component
let make = () => {
  let store: Types.ref = React.useRef([])
  let (lists, setLists) = React.useState(_ => [])
  let title = React.string("todos")

  <div className={styles["container"]}>
    <a href="https://github.com/shuiRong/ReScriptToDo" target="_blanket" className={styles["ribbon"]}>
      <img
        width="149"
        height="149"
        src="https://github.blog/wp-content/uploads/2008/12/forkme_right_darkblue_121621.png?resize=149%2C149"
        alt="Fork me on GitHub"
      />
    </a>
    <h1 className={styles["title"]}> title </h1>
    <div>
      <Input setLists store />
      <List data={lists} setLists store />
      <Footer length={Belt.Array.length(lists)} setLists store />
    </div>
  </div>
}
