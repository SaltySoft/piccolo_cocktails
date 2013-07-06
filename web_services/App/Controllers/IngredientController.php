<?php
/**
 * Created by JetBrains PhpStorm.
 * User: Irenicus
 * Date: 05/07/13
 * Time: 14:37
 * To change this template use File | Settings | File Templates.
 */

class IngredientController extends Controller
{
    public function index()
    {
        $this->render = false;

        header("Content-type: application/json");

        $em = Model::getEntityManager();

        $qb = $em->createQueryBuilder();

        $qb->select("i")
            ->from("Ingredient", "i");

        $ingredients = $qb->getQuery()->getResult();
        $response = array();
        foreach ($ingredients as $ingredient)
        {
            $response[] = $ingredient->toArray();
        }

        echo json_encode($response);
    }

    public function create()
    {
        $data = $this->getRequestData();

        $ingredient = new Ingredient();
        $ingredient->setName($data["name"]);
        $ingredient->save();
        $this->render = false;
        header("Content-type: application/json");

        echo json_encode($ingredient->toArray());
    }

    public function show($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");



        $ingredient = Ingredient::find($params["id"]);

        echo json_encode($ingredient->toArray());
    }

    public function update()
    {

    }

    public function destroy()
    {

    }
}