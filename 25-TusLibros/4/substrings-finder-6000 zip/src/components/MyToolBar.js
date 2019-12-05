class MyToolBarComponent extends React.Component {
  constructor(props) {
    super(props)
  }
  
  renderNavButtons(){
    const router = this.props.router
    return(
      <div>
        <Button
          color="inherit"
          onClick={()=>router.navigate("/list")}>
          Ver Catálogo
        </Button>
        <Button
          color="inherit"
          onClick={()=>router.navigate("/cart", {cartId: this.props.cartId})}>
          Ver Carrito
        </Button>
      </div>
    );
  }

  render() {
    const {
      router,
      title,
      classes,
    } = this.props

    const current_path = router.current()
    let onclick = () => {}
    let icon = ""

    if (current_path === "/") {
      icon = "home"
      onclick = () => {}
    } else if (current_path === "/list" || current_path === "/cart") {
      icon = "home"
      onclick = () => router.navigate("/")
    } else if (current_path === "/details") {
      icon = "keyboard_arrow_left"
      onclick = () => router.navigate("/list")
    } else {
      console.error("Not a valid current path!")
    }
    
    let navButtons = ""
    if(current_path != "/"){
      navButtons = this.renderNavButtons()
    }

    return (
      <div className={classes.rootToolBar}>
        <AppBar position="static">
          <Toolbar>
            <IconButton
              edge="start"
              className={classes.menuButton}
              color="inherit"
              onClick={onclick}
            >
              <Icon>{icon}</Icon>
            </IconButton>
            <Typography variant="h6" className={classes.title}>
              {title}
            </Typography>
            {navButtons}
          </Toolbar>
        </AppBar>
      </div>
    )
  }
}

// Add style
const MyToolBar = withStyles(styles, {
  withTheme: true
})(MyToolBarComponent)
