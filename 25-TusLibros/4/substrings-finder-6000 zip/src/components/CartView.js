class CartComponent extends React.Component {
  constructor(props) {
    super(props)
    
    this.state = {
      details: {},
      cartInfo: [],
      loading: false,
      error: null,
    }
  }
  
  reloadCart() {
    const cartId = this.props.cartId
	  
    this.setState({
      loading: true,
      error: null,
    })
    
    let cartInfo = []
    getLocalAsJson(`cartView?cartId=${cartId}`)
      .then(function (response) {
        return response.json()
      })
      .then((cartInfo) => {
        this.setState({
          loading: false,
          cartInfo: cartInfo
        })
      })
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
  }
  
  componentDidMount() {
    this.reloadCart()
  }
  
  handleAddBook(ISBN){
    const cartId = this.props.cartId
	  this.props.handleAddBook(cartId, ISBN)
	  this.reloadCart();
  }
  
  handleRemoveBook(ISBN){
	  const cartId = this.props.cartId
	  this.props.handleRemoveBook(cartId, ISBN)
	  this.reloadCart();
  }
  
  navigateToDetailView(ISBN){
    this.setState({
      ISBN: ISBN
    })
	  this.props.router.navigate("/details", {ISBN: ISBN});
  }

  render() {
    const {
      router,
      classes,
      cartId,
    } = this.props
    
    const {
      details,
      cartInfo,
      loading,
      error,
    } = this.state
	
    if (loading) return <div>Loading...</div>
    if (error) return <div>{error}</div>

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Vista de carrito:
          </Typography>
        <List component="nav" className={classes.rootList} aria-label="books">
          {
            cartInfo.map((cartItem, ix) => {
              return (
                <ListItem>
                  <ListItemText primary={cartItem['ISBN']} />
                  <ListItemText primary={cartItem['title']} />
                  <Button onClick={()=>this.handleRemoveBook(cartItem['ISBN'])}> - </Button>
                  <ListItemText primary={cartItem['quantity']} />
                  <Button onClick={()=>this.handleAddBook(cartItem['ISBN'])}> + </Button>
                  <Button onClick={()=>this.navigateToDetailView(cartItem['ISBN'])}> Detalles </Button>
                </ListItem>
              )
            })
          }
        </List>
      </div>
    )
  }
}

// Add style
const CartView = withStyles(styles, {
  withTheme: true
})(CartComponent)
