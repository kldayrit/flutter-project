# CMSC 23 Project
### Karlos Denzel Dayrit
### 2020-04446
### X-4L

# Project Description
> The project requires us to create a social media app that has the following features
> - Register as new user
> - Login 
> - Logout
> - Update profile
> - Update password 
> - View a list of public posts (with pagination)
> - View a profile
> - Follow a person (only up to 8 people can be added)
> - List all you who follow
> - Unfollow a person  
> - Create a post (public or for-friends)
> - View a post
> - Comment on a post
> - Show all comments for a post
> - Remove your own comment
> - Show all of your or a friend’s posts (with pagination)
> - Update a post
> - Remove a post

# Naming your App
```
dayritkdl_project_x4l
```

# Documentation
![image](https://user-images.githubusercontent.com/101092279/172885628-0f3f5752-922b-4397-955d-fd4b132fc8a5.png)


### Code Creation/Testing

- Register as new user
- - Successful Registration
- ![image](https://user-images.githubusercontent.com/101092279/172885931-0deca74d-7ff4-4f17-91a1-589ef164d394.png)![image](https://user-images.githubusercontent.com/101092279/172885978-86c919e6-79ef-42ea-b3ef-49704ed514fd.png)
- - Failed Registraion
- ![image](https://user-images.githubusercontent.com/101092279/172886363-017f3843-ffbb-45a2-919e-cb2c8f0a8547.png)![image](https://user-images.githubusercontent.com/101092279/172886407-c2eac7de-f0c4-4296-b415-5fe0f6bd0af9.png)
- The registration page can be accessed in the front page clicking the text 'register'. The register function requires four parameters: first name, last name, username and password which will be needed to be inputted in the textfields matching each paramter. The parameters are then passed as a body to an http request through the api. The api also requires the given token in the project specification to be able to register the user.


- Login
- - Successful Login
- ![image](https://user-images.githubusercontent.com/101092279/172887372-720d17fa-3f42-4d98-bcff-01adcf2c41b3.png)![image](https://user-images.githubusercontent.com/101092279/172887426-ebec2c86-86b3-4635-8c18-9a363441e8c4.png)
- - Failed Login 
- ![image](https://user-images.githubusercontent.com/101092279/172887273-a12645c1-0114-4775-a5ff-e9c9de3fb4d3.png)![image](https://user-images.githubusercontent.com/101092279/172887296-a99da105-3b16-474b-8d11-f8ce6e4d2e35.png)
- The login page will be the first page shown when opening the app. The login page has 2 text fields : username and password that will be needed to be filled by the credentials of a registered user. The login() function takes the value of this 2 fields and be passed to they api in the request body. The api will check if such credentials is valid, if it is it returns a token that will be used as authorization for other features of the app.


- Logout
- Successful Logout
- ![image](https://user-images.githubusercontent.com/101092279/172888421-572aefa4-c7b6-4cb4-a34c-e60e5aeaa010.png)![image](https://user-images.githubusercontent.com/101092279/172888523-15f1934d-be47-4a2b-9bd4-fdc077c5d57e.png)
- Logout button can be accessed from the top right icon button in the post list. This will lead to the profile of the user and also the button for logout. Logout requires no paramater and just revokes the token given during the login. If logout is successful it will return to the login page

- Update profile/Update password
- - Succesful Update profile/password
- ![image](https://user-images.githubusercontent.com/101092279/172889077-9ae53cfa-cdf4-4459-8dcb-dd8786de8870.png)![image](https://user-images.githubusercontent.com/101092279/172889190-563f5069-9b31-4412-8b12-600e63016794.png)![image](https://user-images.githubusercontent.com/101092279/172889237-7947b5f3-33d2-4b5a-8808-d011052d28c8.png)![image](https://user-images.githubusercontent.com/101092279/172889349-c5f93e1d-6464-4cde-8b28-0db6b8a84b2b.png)
- - Failed Update profile/password
- ![image](https://user-images.githubusercontent.com/101092279/172889541-d50fde3b-58c6-49aa-b182-efcc5e5499a9.png)
- Updating the profile and password leads you to the same page. This page can be accessed the same way as the logout button (it is above the logout button). When edit profile is selected a form page will appear. The values of these fields  will be passed as a paramater to the updateUser() function which updates the profile of the user through the api. This parameters will be inputted in the request body.


- View a list of public posts (with pagination)
- Succesful view
- - ![image](https://user-images.githubusercontent.com/101092279/172890152-0efaf992-f45e-4e8d-b5a9-9d6e39eb8f11.png)
- To view list of post the function getallPost() is used. This function gets a list of post using the api, then will take the id of the last post in the list of posts it has gotten. The id will then be concatenated to the url of the api the next time the function is called to add the next list of posts to the local lists of posts in the app. The local lists of posts will then be shown and updated with pagination using the SmartRefresher() Package that takes care of it all. Each posts will be listed with the username as a clickable text, the text of the post, and a trailing icon button.

- View a profile
- Successful Viewing of Profile
- - ![image](https://user-images.githubusercontent.com/101092279/172891001-ea4cebde-5f94-4206-9528-759115d7f322.png)![image](https://user-images.githubusercontent.com/101092279/172891032-1500a13d-9df6-4ae7-8602-f38c8cde6fc1.png)
- When clicking the username of a user in the post list, it will call the getUser function that requires the username of the one you clicked as a parameter. This id will be concatenated to the url of the api for getting a user. The returned value will then be displayed. It will display them as username, first name + last name, button for follow, button for viewing of post.

- Follow a person (only up to 8 people can be added)
- Succesful Following a person
- - ![image](https://user-images.githubusercontent.com/101092279/172891857-0e1ccfe2-c4f3-4e4b-8f20-d8a6627b39ab.png)
- Failed Following a person
- - ![image](https://user-images.githubusercontent.com/101092279/172891908-2223dfe4-9377-4c98-9616-2d818a22fb23.png)
- From the page where a another user's profile is viewed, there is a button for follow. When clicked it will add the person to the list of people you follow. This is done by calling the followUser method that requires the username of the one you follow as a parameter. The function appends the username of the user to the end of the url of api and calls a post method using it. When followed, a person will be added to the local list of followers and also in the list in the api.

- List all you who follow
- Successful Viewing of followed
- - ![image](https://user-images.githubusercontent.com/101092279/172892654-7259c96b-09d8-475f-ae98-838fd0f958b6.png)![image](https://user-images.githubusercontent.com/101092279/172892767-53835b16-09d7-47b3-b103-966fbc0da2ba.png)
- Also in the page for viewing your own profile is a button for viewing those you follow. Upon clicking this button, user will be redirected to a page that lists the following of the user. This is done by calling the getFollowers() function which requires no parameter. This updates the local list of followers and then that list will be displayed. The username and a trailing eye and delete Icon will be displayed for each user you follow.

- Unfollow a person  
- Successful unfollow
- - ![image](https://user-images.githubusercontent.com/101092279/172893334-2a48bd97-864f-4e3c-8634-85bf61bb5179.png)![image](https://user-images.githubusercontent.com/101092279/172893381-0d799a5c-7558-4bf0-ab72-53f997728d26.png)![image](https://user-images.githubusercontent.com/101092279/172893407-856a4f75-0695-44dc-9791-3410244e735f.png)
- While viewing the list of following a delete icon will also be displayed beside each username, clicking this icon will call the removefollow function that removes your follow on the user through the api.

- Create a post (public or for-friends)
- Successful Creation of Post
- - ![image](https://user-images.githubusercontent.com/101092279/172894042-819685b3-b15f-491f-818f-f1641f8ab58d.png)
![image](https://user-images.githubusercontent.com/101092279/172893874-b4008a8b-1e9a-49aa-aee0-3c1143605916.png)![image](https://user-images.githubusercontent.com/101092279/172894096-a9b774da-a237-4689-b456-271cc71f9bb2.png)
- Clicking the floating button will lead you to a post creation page. Here you will pick if it is a private or public post then input the text of the post. After clicking the post button, it will call the createPost function that requires the values of the one you filled up as parameters. This function will append this values to the request body when processing the api. Refreshing the list post will show your public post if post creation is successful.

- View a Post/Show all comments for a post
- Succesful view
- - ![image](https://user-images.githubusercontent.com/101092279/172894762-d09b1eb8-4219-408d-9bea-817299cfae2f.png)![image](https://user-images.githubusercontent.com/101092279/172894789-1ce6fe1c-30b9-4c58-bc99-b22affa75002.png)
- Clicking the leading comment button in a post in the post list will redirect you to a page that shows both the post and all the comments in that post. The post wil just be re-displayed in the bottom of the page as a floating text. While the comments will be requested from the api using the getallPost function but with the api url for the get comments.

- Comment on a post
- Successful Comment
- - ![image](https://user-images.githubusercontent.com/101092279/172895636-6a926afb-fbbc-4d4f-b85f-d56fda7da93e.png)![image](https://user-images.githubusercontent.com/101092279/172895689-05ce81cb-3418-40de-aa3e-2e8de9f259e1.png)![image](https://user-images.githubusercontent.com/101092279/172895699-363e675b-0537-4f9c-a7f1-e4c7083ef752.png)
- When viewing a post/all comments a floating button will appear above the floating text of the post. Clicking this will redirect you to a page the adds comment. This page has a single text field for the comment and a button to post that comment. When a text is inputted, the createComment function will be called. This function requests the api url with the id of the post you commented, and the text you want to comment as a request body to that request.


- Remove Comment
- Successful Remove
- - ![image](https://user-images.githubusercontent.com/101092279/172896517-d807b691-bdef-4a42-a1f1-a491d9e39b9f.png)![image](https://user-images.githubusercontent.com/101092279/172896556-7d9720c7-64be-469e-9cd3-85d9cb233e84.png)
- A comment the user has created will have a trash icon beside it. Clicking this will call the deleteComment function that requires the id of the post that was commented and the id of the comment itself as a parameter to remove the comment via the api.

- Show all of your or a friend’s posts (with pagination)
- Successful Show
- - ![image](https://user-images.githubusercontent.com/101092279/172896988-3bb23207-164d-4629-89fb-d695b1977100.png)![image](https://user-images.githubusercontent.com/101092279/172897032-731d6e14-b26d-40f4-b07c-95a368b9dba7.png)
- Failed View
- - ![image](https://user-images.githubusercontent.com/101092279/172897150-1e8bdd5a-c542-4520-b778-f6a79e18fceb.png)
- Upon clicking the view posts button in a user's profile or the top left button in the post list, it will first check if that user exists in the list of users you follow.If it the posts you want to view is yours, it does not need to check, it just calls the getallPosts() function but your username will be added at url of the api. If it is not you, it will check in the list if that person is there. If it does not, you are not allowed to view the posts, if it is then the same function used in viewing your own posts, but the username of the person whose post you want to view will be the one added at the url of the api.



- Update a post/ Remove a post
- Successful Update
- ![image](https://user-images.githubusercontent.com/101092279/172898176-c241c611-e8c1-43ff-a965-1e0580aca05f.png)![image](https://user-images.githubusercontent.com/101092279/172898224-6d5e6c99-899c-4717-b275-ea6ced48218e.png)![image](https://user-images.githubusercontent.com/101092279/172898257-8cc2c4d9-b692-4fe1-aff4-5d46316732dc.png)
- Successful Delete
- ![image](https://user-images.githubusercontent.com/101092279/172898352-d7570bf2-fcf2-4794-b18c-5cb017cc4dbb.png)![image](https://user-images.githubusercontent.com/101092279/172898389-2de7fd6b-3208-45ec-ba90-673d722e899f.png)
- Upon viewing your own posts, there are 2 trailing buttons in each post. One for edit and delete. Pressing delete will redirect you to a page like the post creation page, difference is that pressing edit posts calls the updatePost function that requires the parameters for the post's text and the post's publicity. It also requires the id of post itself to be appended to url of the api. The text and publicity of the post will be sent with the body of the request to api. Upon Pressing delete, it will call the deletePost() function that just needs the id of the post to remove it using the api.

### Challenges 
- The greatest challenge in this would be the the pagination. Although the idea behind pagination is easy to understand, it was hard to implement. But upon managing to implement it, the others became easier. Originally I was just planning to do the required tasks due to time constraints, but upon finishing them I noticed that the optional functions are mostly the same. So after finishing the required features, I just copied mostly the code in the required features and changed it up a bit to suit which ever featuer. This resulted in many boilerplate codes and an overall messy and spaghetti like code, nonetheless, I managed to implement it and that is what really matters.




