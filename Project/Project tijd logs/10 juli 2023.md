# log  
11 juli 2023


## dagverslag
Vandaag de documentatie bijgewerkt. En verder gewerkt aan de vmss en application gateway. Ik heb verschillende instellingen geprobeerd maar het lukt niet. Ik krijg een vreemde foutmelding. ApplicationGatewayBackendAddressInvalidFormat","message":"Backend Address 10.10.10.128/25 present 
within Backend Address Pool myBackendPool does not meet the format requirements. The address must contain only digits, letters, hyphens and dots for separation. Moreover, it cannot have hyphens at the start, end or next to a dot." Ik heb alleen geen koppeltekens in de backend addresspool staan. 


## obstakels  
De opstakels zijn hetzelfde. Ik heb nog een aantal dingen die ik wil proberen. 



## oplossing  
Lukt het niet om het morgen goed te deployen dan zal ik alleen de vmss aanmaken met een loadbalancer en nsg. En die koppelen aan de admin server via peering. Op die manier kan ik ook nog proberen om andere vereisten te deployen op een (hopelijk) goede manier.  



## learnings
