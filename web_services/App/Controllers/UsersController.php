<?php
/**
 * Copyright (C) 2013 Antoine Jackson
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 * OR OTHER DEALINGS IN THE SOFTWARE.
 */

class UsersController extends Controller
{
    function login($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");
        $success = false;
        $data = $this->getRequestData();
        if (isset($data["name"]) && isset($data["password"])) {
            $users = User::where(array("name" => $data["name"], "hash" => sha1($data["password"])));
            if (count($users) > 0) {
                $user = $users[0];
                $user->login();
                $success = true;
                $token = uniqid();
                $_SESSION["token"] = $token;
                echo json_encode(array(
                        "user" => $user->toArray(),
                        "token" => $token)
                );
            }
        }
        if (!$success)
        {
            header("HTTP/1.1 401 Unauthorized");
            echo json_encode(array(
                "error"=> "Your username / password is incorrect",
            ));
        }
    }


    function logout($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");
        $user = User::current_user();
        if ($user != null) {
            $user->logout();
            $_SESSION["token"] = null;
        }
        echo json_encode(array(
            "message"=> "Log out with success",
        ));
    }


    function login_form()
    {

    }

    function create($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");
        $data = $this->getRequestData();
        $user = new User();
        $usernames = User::where(array("name" => $data["name"]));
        $usermail = User::where(array("email" => $data["mail"]));
        if (count($usernames) == 0 && count($usermail) == 0)
        {
            $user->setName($data["name"]);
            $user->setMail($data["mail"]);
            $user->setNormal();
            $user->setHash($data["password"]);
            $user->save();
            $user->login();
            $token = uniqid();
            $_SESSION["token"] = $token;
            echo json_encode(array(
                "user" => $user->toArray(),
                "token" => $token)
            );
        }
        else
        {
            header("HTTP/1.1 405 Method Not Allowed");
            echo json_encode(array(
                    "error"=> "This username or mail already exists",
            ));
        }
    }


    public function favorites($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");
        $success = false;
        if (isset($_GET["id"]) && isset($_GET["token"]) && $_GET["token"] == $_SESSION["token"])
        {
            $user = User::find($_GET["id"]);
            if ($user != null) {
                $favorites = array();
                foreach ($user->getFavorites() as $favorite)
                {
                    $favorites[] = $favorite->toArray();
                }
                $success = true;
            }
            echo json_encode(array(
                    "favorites" =>  $favorites,
                    "token" => $_SESSION["token"])
            );
        }
        if (!$success)
        {
            header("HTTP/1.1 404 Not Found");
            echo json_encode(array(
                "error"=> "You are not authenticated or the user doesn't exist",
            ));
        }
    }

    public  function addFavorite($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");
        $data = $this->getRequestData();
        $success = false;
        if (isset($data["cocktail_id"])  && (isset($data["id"])
            && isset($data["token"]) && $data["token"] == $_SESSION["token"]))
        {
            $user = User::find($data["id"]);
            $cocktail = Cocktail::find($data["cocktail_id"]);
            if ($user != null && $cocktail != null) {
                $user->addFavorite($cocktail);
                $user->save();
                $favorites = array();
                foreach ($user->getFavorites() as $favorite)
                {
                    $favorites[] = $favorite->toArray();
                }
                $success = true;
            }
            echo json_encode(array(
                    "favorites" =>  $favorites,
                    "token" => $_SESSION["token"])
            );
        }
        if (!$success)
        {
            header("HTTP/1.1 401 Unauthorized");
            echo json_encode(array(
                "error"=> "You are not authenticated",
            ));
        }
    }

    public  function removeFavorite($params = array())
    {
        $this->render = false;
        header("Content-type: application/json");
        $data = $this->getRequestData();
        $success = false;
        if (isset($data["id"]) && isset($data["token"]) && $data["token"] == $_SESSION["token"])
        {
            $user = User::find($data["id"]);
            $cocktail = Cocktail::find($data["cocktail_id"]);
            if ($user != null && $cocktail != null) {
                $user->removeFavorite($cocktail);
                $user->save();
                $favorites = array();
                foreach ($user->getFavorites() as $favorite)
                {
                    $favorites[] = $favorite->toArray();
                }
                $success = true;
            }
            echo json_encode(array(
                    "favorites" =>  $favorites,
                    "token" => $_SESSION["token"])
            );
        }
        if (!$success)
        {
            header("HTTP/1.1 401 Unauthorized");
            echo json_encode(array(
                "error"=> "You are not authenticated",
            ));
        }
    }


    public function index()
    {
        $this->render = false;

        header("Content-type: application/json");

        $em = Model::getEntityManager();

        $qb = $em->createQueryBuilder();

        $qb->select("u")
            ->from("User", "u");

        $users = $qb->getQuery()->getResult();
        $response = array();
        foreach ($users as $user)
        {
            $response[] = $user->toArray();
        }

        echo json_encode($response);
    }


}
