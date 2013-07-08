<?php
/**
 * Created by JetBrains PhpStorm.
 * User: Irenicus
 * Date: 04/07/13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
class CocktailsController extends Controller
{
    public function index()
    {
        $this->render = false;
        header("Content-type: application/json");

        $em = Model::getEntityManager();

        $qb = $em->createQueryBuilder();

        $qb->select("c")
            ->from("Cocktail", "c");

        $cocktails = $qb->getQuery()->getResult();
        $response = array();
        foreach ($cocktails as $cocktail)
        {
            $response[] = $cocktail->toArray();
        }

        echo json_encode($response);
    }

    public function create()
    {
        $data = $this->getRequestData();

        $cocktail = new Cocktail();
        $cocktail->setName($data["name"]);
        $cocktail->setDifficulty($data["difficulty"]);
        $cocktail->setOriginality($data["originality"]);
        $cocktail->setDuration($data["duration"]);
        $cocktail->setDescription($data["description"]);
        $cocktail->setRecipe($data["recipe"]);
        if (isset($data["author"])) {
            $cocktail->setAuthor($data["author"]);
        }
        $cocktail->save();
        $this->render = false;
        header("Content-type: application/json");

        echo json_encode($cocktail->toArray());
    }

    public function show($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");

        $cocktail = Cocktail::find($params["id"]);

        echo json_encode($cocktail->toArray());
    }

    public function byIngredients($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");

        echo json_encode($params);
        $em = Model::getEntityManager();

        $qb = $em->createQueryBuilder();
        $ingredient1 = Ingredients::find(1);
        $qb->andWhere("i = :ingredient1")
            ->setParameter("ingredient1", $ingredient1);
        $qb->select("c")
            ->from("Cocktail", "c")
            ->innerJoin("c.ingredients", "i")
            ->where("i = ingredient1");

        $cocktails = $qb->getQuery()->getResult();
        echo json_encode($cocktails->toArray());
    }

    public function update()
    {

    }

    public function destroy()
    {

    }

    public function random()
    {
        $this->render = false;

        header("Content-type: application/json");

        $em = Model::getEntityManager();

        $qb = $em->createQueryBuilder();

        $qb->select("c")
            ->from("Cocktail", "c");

        $cocktails = $qb->getQuery()->getResult();

        $len = count($cocktails) - 1;
        $resIndex = rand(0, $len);
        $response = $cocktails[$resIndex]->toArray();

        echo json_encode($response);
    }
}
