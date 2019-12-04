class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      substrings: [],
      selectedSubstring: "",
      cartId: -1,
    };
  }
  
  handleRemoveBook(cartId, ISBN){
    getLocalAsJson(`removeFromCart?cartId=${cartId}&book=${ISBN}`)
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
  }
  
  handleAddBook(cartId, ISBN){
    getLocalAsJson(`addToCart?cartId=${cartId}&book=${ISBN}`)
    .catch(err => {
      this.setState({
        loading: false,
        error: err,
      })
    })
  }

  render() {
    let title = "Substrings Finder 6000"
    let content = "Where am I?"
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        // http://es6-features.org/#SpreadOperator
        this.setState({ ...state, path: path })
      }
    }

    if (this.state.path === "/") {
      content = (<StringInputView
        router={router}
      />)
    } else if (this.state.path === "/list") {
      content = (<SubstringsView
        router={router}
        substrings={this.state.substrings}
        cartId={this.state.cartId}
        handleAddBook={this.handleAddBook}
        handleRemoveBook={this.handleRemoveBook}
      />)
    } else if (this.state.path === "/details") {
      content = (<SubstringDetailsView
        router={router}
        cartId={this.state.cartId}
        ISBN={this.state.ISBN}
        handleAddBook={this.handleAddBook}
        handleRemoveBook={this.handleRemoveBook}
      />)
    }
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
