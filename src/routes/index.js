const express = require("express")
const routes = express.Router() 

const HomeController = require("../app/controllers/HomeController")

const products = require("./products")
const users = require("./users")

routes.use("/products", products)
routes.use("/users", users)//vai colocar um /users em todas as rotas dos usuários


//HOME
routes.get('/', HomeController.index)

//ALIAS
routes.get('/ads/create', function(req , res){
    return res.redirect("/products/create" )
})

routes.get('/accounts', function(req , res){
    return res.redirect("/users/register" )
})



module.exports = routes 