<?php
/**
 * Created by JetBrains PhpStorm.
 * User: Irenicus
 * Date: 05/07/13
 * Time: 15:10
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
}