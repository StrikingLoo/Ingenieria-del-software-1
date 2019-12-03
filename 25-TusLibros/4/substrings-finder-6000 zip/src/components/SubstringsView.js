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
  
  componentDidMount() {
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
          caca
          </Typography>
        <List component="nav" className={classes.rootList} aria-label="substrings">
          {
            catalogInfo.map((catalogItem, ix) => {
              return (
                <ListItem>
                  <ListItemText primary={catalogItem['ISBN']} />
                  <ListItemText primary={catalogItem['title']} />
                  <Button onClick={()=>alert("+")}> + </Button>
                  <ListItemText primary={catalogItem['quantity']} />
                  <Button onClick={()=>alert("-")}> - </Button> 
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
