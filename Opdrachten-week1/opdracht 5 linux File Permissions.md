# Linux 5 file permissions


## Key-terms
 user en groups zijn te vinden in de etc folder.
 sudo adduser 'naam' (creert nieuwe gebruiker)
 sudo adduser 'naam' sudo (voegt gebruiker toe aan sudo group)
 sudo adduser 'naam' admin (voegt gebruiker toe aan admin group)


## Opdracht
●	Create a text file.
●	Make a long listing to view the file’s permissions. Who is the file’s owner and group? What kind of permissions does the file have?
●	Make the file executable by adding the execute permission (x).
●	Remove the read and write permissions (rw) from the file for the group and everyone else, but not for the owner. Can you still read it?
●	Change the owner of the file to a different user. If everything went well, you shouldn’t be able to read the file unless you assume root privileges with ‘sudo’.
●	Change the group ownership of the file to a different group.


### Gebruikte bronnen
https://linuxize.com/post/linux-chown-command/

### Ervaren problemen
Ik wist niet zeker of het toevoegen van de nieuwe gebruiker in de sudo groep hetzelfde is als admin group. Die uiteindelijk gevonden doordat ik naar de etc folder ging en daar cat group commando uitvoerde. 

### Resultaat

![owner and permissions](https://user-images.githubusercontent.com/123589199/230192318-c605764f-6ee6-41d1-a0a6-1cefdabc7506.png)
![permissions](https://user-images.githubusercontent.com/123589199/230192483-1b2e7a17-dec3-46f7-b5df-cb260b92ad5d.png)
![permission denied](https://user-images.githubusercontent.com/123589199/230192527-4fa63333-2265-4907-b258-1c9f7aded71f.png)
![group ownership](https://user-images.githubusercontent.com/123589199/230192565-282abb38-a055-42aa-844d-b7cc8f5782b3.png)
