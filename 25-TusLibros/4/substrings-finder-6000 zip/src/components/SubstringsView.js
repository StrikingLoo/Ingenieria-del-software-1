class BookDetailsComponent extends React.Component {
  constructor(props) {
    super(props)
    
    this.state = {
      details: {},
      catalogInfo: [],
      loading: false,
      error: null,
    }
  }
  
  reloadCatalog() {
	const cartId = this.props.cartId
	  
    this.setState({
      loading: true,
      error: null,
    })
    
    let catalogInfo = []
    getLocalAsJson(`catalogView?cartId=${cartId}`)
      .then(function (response) {
        return response.json()
      })
      .then((catalogInfo) => {
        this.setState({
          loading: false,
          catalogInfo: catalogInfo
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
    this.reloadCatalog()
  }
  
  handleAddBook(ISBN){
    const cartId = this.props.cartId
	  this.props.handleAddBook(cartId, ISBN)
	  this.reloadCatalog();
  }
  
  handleRemoveBook(ISBN){
	  const cartId = this.props.cartId
	  this.props.handleRemoveBook(cartId, ISBN)
	  this.reloadCatalog();
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
      substrings,
      classes,
    } = this.props
    
    const {
      details,
      catalogInfo,
      loading,
      error,
    } = this.state
	
    if (loading) return <div>Loading...</div>
    if (error) return <div>{error}</div>

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Vista de catálogo:
          </Typography>
        <List component="nav" className={classes.rootList} aria-label="substrings">
          {
            catalogInfo.map((catalogItem, ix) => {
              return (
                <ListItem>
                  <ListItemText primary={catalogItem['ISBN']} />
                  <ListItemText primary={catalogItem['title']} />
                  <Button onClick={()=>this.handleRemoveBook(catalogItem['ISBN'])}> - </Button>
                  <ListItemText primary={catalogItem['quantity']} />
                  <Button onClick={()=>this.handleAddBook(catalogItem['ISBN'])}> + </Button>
                  <Button onClick={()=>this.navigateToDetailView(catalogItem['ISBN'])}> Detalles </Button>
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
const BookDetailsView = withStyles(styles, {
  withTheme: true
})(BookDetailsComponent)
