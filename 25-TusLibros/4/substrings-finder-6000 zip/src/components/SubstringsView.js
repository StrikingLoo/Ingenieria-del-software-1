class SubstringsComponent extends React.Component {
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
	  getLocalAsJson(`addToCart?cartId=${cartId}&book=${ISBN}`)
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
	  this.reloadCatalog();
  }
  
  handleRemoveBook(ISBN){
	  const cartId = this.props.cartId
	  getLocalAsJson(`removeFromCart?cartId=${cartId}&book=${ISBN}`)
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
	  this.reloadCatalog();
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
                  <Button onClick={()=>this.handleAddBook(catalogItem['ISBN'])}> + </Button>
                  <ListItemText primary={catalogItem['quantity']} />
                  <Button onClick={()=>this.handleRemoveBook(catalogItem['ISBN'])}> - </Button>
                  <Button onClick={()=>alert("detalles!")}> Detalles </Button>
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
const SubstringsView = withStyles(styles, {
  withTheme: true
})(SubstringsComponent)
