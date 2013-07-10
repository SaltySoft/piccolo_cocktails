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
        $this->render = false;
        header("Content-type: application/json");
        $data = $this->getRequestData();
        if (isset($data["token"]) && $data["token"] == $_SESSION["token"] || 1)
        {
            $cocktail = new Cocktail();
            $cocktail->setName($data["name"]);
            $cocktail->setDifficulty($data["difficulty"]);
            $cocktail->setOriginality($data["originality"]);
            $cocktail->setDuration($data["duration"]);
            $cocktail->setDescription($data["description"]);
            $cocktail->setRecipe($data["recipe"]);
            $cocktail->setPictureUrl($data["picture_url"]);
            $cocktail->setAlchohol($data["alchohol"]);
            if (isset($data["author"])) {
                $author = User::find($data["author"]);
                $cocktail->setAuthor($author);
            }
            $ingredientsIds = $data["ingredients_ids"];
            foreach ($ingredientsIds as $ingId)
            {
                $ingredient = Ingredient::find($ingId);
                $cocktail->addIngredient($ingredient);
            }
            $cocktail->save();
            echo json_encode(array(
                    "cocktail" =>  $cocktail->toArray(),
                    "token" => $_SESSION["token"])
            );
        } else {
            header("HTTP/1.1 401 Unauthorized");
            echo json_encode(array(
                "error"=> "You are not authenticated"
            ));
        }
    }

    public function show($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");
        $cocktail = Cocktail::find($params["id"]);

        echo json_encode($cocktail->toArray());
    }

    public function addPicture($params = array())
    {
        $this->render = false;
        $url = ImageComponent::saveSentPicture("file");
        header("Content-type: application/json");
        echo json_encode(array( "url_picture" => $url));
    }

    public function filter($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");
        $em = Model::getEntityManager();
        $qb = $em->createQueryBuilder();
        $data = $this->getRequestData();

        $qb->select("c")
            ->from("Cocktail", "c")
            ->join("c.ingredients", "i");

        $i = 0;
        if (isset($data["ingredient_ids"])) {
            foreach ($data["ingredient_ids"] as $ingredient_id) {

                $qb->andWhere("i.id = :ingredient".$i)
                    ->setParameter("ingredient".$i, $ingredient_id);
                $i++;
            }
        }
        if (isset($data["name"])) {
            $qb->andWhere("c.name LIKE :name")
                ->setParameter("name", "%".$data["name"]."%");
        }

        if (isset($data["difficulty"])) {
            $qb->andWhere("c.difficulty = :difficulty")
                ->setParameter("difficulty", $data["difficulty"]);
        }

        if (isset($data["duration"])) {
            $qb->andWhere("c.duration <= :duration")
                ->setParameter("duration", $data["duration"]);
        }

        if (isset($data["originality"])) {
            $qb->andWhere("c.originality = :originality")
                ->setParameter("originality", $data["originality"]);
        }

        if (isset($data["alchohol"])) {
            $qb->andWhere("c.alchohol = :alchohol")
                ->setParameter("alchohol", $data["alchohol"]);
        }

        $cocktails = $qb->getQuery()->getResult();
        $result = array();
        foreach ($cocktails as $cocktail)
        {
            $result[] = $cocktail->toArray();
        }

        echo json_encode($result);

    }

    public function byIngredients($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");

        $em = Model::getEntityManager();

        $qb = $em->createQueryBuilder();
        $data = $this->getRequestData();

        $qb->select("c")
            ->from("Cocktail", "c")
            ->join("c.ingredients", "i");

        $i = 0;
        foreach ($data["ingredient_ids"] as $ingredient_id) {

            $qb->andWhere("i.id = :ingredient".$i)
                ->setParameter("ingredient".$i, $ingredient_id);
            $i++;
        }

        $cocktails = $qb->getQuery()->getResult();
        $result = array();
        foreach ($cocktails as $cocktail)
        {
            $result[] = $cocktail->toArray();
        }

        echo json_encode($result);
    }

    public function update()
    {

    }

    public function destroy()
    {
        $this->render = false;
        header("Content-type: application/json");
        $data = $this->getRequestData();
        if (isset($data["token"]) && $data["token"] == $_SESSION["token"] || 1)
        {
            if (isset($data["author_id"])) {
                $cocktail = Cocktail::find($data["author_id"]);
                $cocktail->delete();

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
        } else {
            header("HTTP/1.1 401 Unauthorized");
            echo json_encode(array(
                "error"=> "You are not authenticated"
            ));
        }
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
