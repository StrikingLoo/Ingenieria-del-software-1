class BooksCatalogComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      details: {},
      loading: false,
      error: null,
    }
  }
  
  reloadDetails(){
    const ISBN = this.props.ISBN
    const cartId = this.props.cartId
    
    this.setState({
      loading: true,
      error: null,
    })
    
    getLocalAsJson(`detailView?cartId=${cartId}&book=${ISBN}`)
      .then(function (response) {
        return response.json()
      })
      .then((details) => {
        this.setState({
          loading: false,
          details: details
        })
      })
      .catch(err => {
        alert("error")
        this.setState({
          loading: false,
          error: err,
        })
      })
  }
  
  handleAddBook(cartId, ISBN){
    this.props.handleAddBook(cartId, ISBN)
    this.reloadDetails()
  }
  
  handleRemoveBook(cartId, ISBN){
    this.props.handleRemoveBook(cartId, ISBN)
    this.reloadDetails()
  }
  
  componentDidMount(){
    this.reloadDetails()
  }

  render() {
	  const {
      router,
      classes,
      cartId,
      ISBN,
    } = this.props

    const {
      details,
      loading,
      error,
    } = this.state

    if (loading) return (<div>Loading...</div>)
    if (error) return (<div>{error}</div>)
    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          Detalles de <b>{ISBN}</b>
        </Typography>

        <TextField
          id="outlined-read-only-input"
          label="Título"
          defaultValue={details["title"]}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />

        <TextField
          id="outlined-read-only-input"
          label="Autore"
          defaultValue={details["author"]}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />
        <TextField
          id="outlined-read-only-input"
          label="Código ISBN"
          defaultValue={details["ISBN"]}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />
        <TextField
          id="outlined-read-only-input"
          label="Precio"
          defaultValue={details["price"]}
          className={classes.textFieldDetails}
          margin="normal"
          InputProps={{
            readOnly: true,
          }}
          variant="outlined"
        />

        Cantidad:
        <Button onClick={()=>this.handleRemoveBook(cartId, ISBN)}>-</Button>
        {details["quantity"]}
        <Button onClick={()=>this.handleAddBook(cartId, ISBN)}>+</Button>
      </div>
    )
  }
}

// Add style
const BooksCatalogView = withStyles(styles, {
  withTheme: true
})(BooksCatalogComponent)
