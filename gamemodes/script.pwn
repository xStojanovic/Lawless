#include 						 <a_samp> /* GAMEMODE - ASAMP GLOBAL FUNCTION/INCLUDE */
#include 						 <streamer> /* GAMEMODE - STREAMER FOR OBJECTS */
#include 						 <float> /* GAMEMODE - FLOATS */
#include 						 <time> /* GAMEMODE - TIME */
#include 						 <file> /* GAMEMODE - FILES */
#include 						 <YSI\y_ini> /* GAMEMODE - Y_LESS YINI REGISTER/LOGIN/SAVE/SYSTEM */
#include 						 <YSI\y_commands> /* GAMEMODE - Y_LESS YCOMMAND PROCESS */
#include 						 <YSI\y_bit> /* GAMEMODE - Y_LESS RBIT/BIT */
#include                         <YSI\y_timers> /* GAMEMODE - Y_LESS TIMERS */
#include 						 <sscanf2> /* GAMEMODE - SSCANF */
#include 						 <progress2> /* GAMEMODE - PROGRESS BARS */

/*============================================================================*/

#define DSP 			  		 DIALOG_STYLE_PASSWORD /* SCRIPT - DIALOG SA ZVEZDICAMA */
#define DSM               		 DIALOG_STYLE_MSGBOX /* SCRIPT - DIALOG ZA TEXT */
#define DSI 			  		 DIALOG_STYLE_INPUT /* SCRIPT - DIALOG ZA LOZINKU/INPUT BEZ ZVEZDICA */
#define DSL               		 DIALOG_STYLE_LIST /* SCRIPT - DIALOG ZA LISTU */
#define IPI               		 INVALID_PLAYER_ID /* SCRIPT - KONEKTOVAN IGRAC DA/NE */

/*============================================================================*/

#define lawless_SCMA             va_SendClientMessageToAll /* SCRIPT - MESSAGE ZA SVE IGRACE */
#define lawless_SCM              va_SendClientMessage /* SCRIPT - MESSAGE ZA JEDNOG IGRACA */
#define lawless_SPD              ShowPlayerDialog /* SCRIPT - DIALOZI */
#define lawless_C3D 			 CreateDynamic3DTextLabel /* SCRIPT - LABELOVI */
#define lawless_CDP 			 CreateDynamicPickup /* SCRIPT - PICKUPOVI */
#define lawless_CDO              CreateDynamicObject /* SCRIPT - GL OBJECT */
#define lawless_COB              CreateObject /* SCRIPT - CO OBJECT */
#define lawless_CDE              CreateDynamicObjectEx /* SCRIPT - EX OBJECT */
#define lawless_GTF              GameTextForPlayer /* SCRIPT - GAME TEXT */
#define lawless_PTDSS            PlayerTextDrawSetString /* SCRIPT - STRING ZA TEXTDRAWOWE */
#define lawless_PTDS             PlayerTextDrawShow /* SCRIPT - PRIKAZIVANJE TEXTDRAWOWA */
#define lawless_PTDH             PlayerTextDrawHide /* SCRIPT - GASENJE TEXTDRAWOWA */
#define lawless_SP		         SpawnPlayer /* SCRIPT - SPAWN IGRACA */
#define lawless_SKIN             SetPlayerSkin /* SCRIPT - POSTAVLJANJE SKINA */
#define lawless_LEVEL            SetPlayerScore /* SCRIPT - POSTAVLJANJE LEVELA/SCOREA */
#define lawless_FREEZE           TogglePlayerControllable /* SCRIPT - ZAMRZAVANJE IGRACA */
#define lawless_SPECC            TogglePlayerSpectating /* SCRIPT - SPECANJE */
#define lawless_COLOR            SetPlayerColor /* SCRIPT - PLAYER BOJA */
#define lawless_MAPA             CreateDynamicMapIcon /* SCRIPT - MAP ICON */
#define lawless_REMOVE           RemoveBuildingForPlayer /* SCRIPT - BRISANJE OBJEKATA */
#define lawless_ANIMATION        ApplyAnimation /* SCRIPT - POSTAVLJANJE ANIMACIJE */
#define lawless_POSITIONS        SetPlayerPos /* SCRIPT - POSTAVLJANJE POZICIJE IGRACA */
#define lawless_Vozilica(%0)     vozila_imena[(%0) - 400] /* SCRIPT - VOZILA IMENA */

/*============================================================================*/

#define ERROR(%0,%1)             lawless_SCM(%0,-1,"{F23A0D}Error:{FFFFFF} "%1) /* SCRIPT - ERROR MESSAGE */
#define USAGE(%0,%1)             lawless_SCM(%0,-1,"{5D9DB3}Usage:{FFFFFF} "%1) /* SCRIPT - KORISCENJE MESSAGE */
#define INFO(%0,%1)              lawless_SCM(%0,-1,"{5D9DB3}Info:{FFFFFF} "%1) /* SCRIPT - INFO MESSAGE */
#define CHEAT(%0,%1)             lawless_SCM(%0,-1,"{5B7E8A}Anti_Cheat:{FFFFFF} "%1) /* SCRIPT - CHEAT MESSAGE */

/*============================================================================*/

#define SERVER_COL               "{5D9DB3}" /* SCRIPT - COLOR FOR DIALOGS */
#define TABLIC_COL               "{FA2A2A}" /* SCRIPT - COLOR FOR VEHICLE TABLICE */

/*============================================================================*/

#define PRESSED(%0) 			 (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define HOLDING(%0) 			 ((newkeys & (%0)) == (%0))
#define RELEASED(%0) 			 (((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

/*============================================================================*/

#pragma tabsize 				 			  ( 0) /* SCRIPT - PRAGMA ZA WARNINGE */

/*============================================================================*/

#define 						 DRZAVNE_ORG  ( 1) /* SCRIPT - ID ZA DRZAVNE ORGANIZACIJE */
#define 						 MAFIA_ORG    ( 2) /* SCRIPT - ID ZA MAFIA ORGANIZACIJE */
#define 						 BANDA_ORG    ( 3) /* SCRIPT - ID ZA BANDA ORGANIZACIJE */

/*============================================================================*/

#undef 							 MAX_PLAYERS
#define 						 MAX_PLAYERS (500) /* SCRIPT - MAXIMALNO SLOTOVA IGRACA ZA KONEKTOVANJE - OPREZ SERVER.CFG */
#define                          MAX_LABEL   (500) /* SCRIPT - MAXIMALAN ID KORISCENJA ZA LABELE - EDIT AKO TREBA */
#define                          MAX_CARS    (500) /* SCRIPT - MAXIMALAN ID KORISCENJA ZA OWNABLE VOZILA - EDIT AKO TREBA */
#define                          MAX_HOUSES  (500) /* SCRIPT - MAXIMALAN ID KORISCENJA ZA KUCE - EDIT AKO TREBA */
#define                          MAX_SALONS  (500) /* SCRIPT - MAXIMALNO SALONA ZA KREIRANJE - EDIT AKO TREBA */
#define                          MAX_ASKQ    ( 51) /* SCRIPT - MAXIMALNO PITANJA ZA POSTAVLJANJE - EDIT AKO TREBA */
#define                          MAX_ORG     ( 10) /* SCRIPT - MAXIMALNO ORGANIZACIJA ZA KREIRANJE - EDIT AKO TREBA */
#define                          MAX_GPS     ( 10) /* SCRIPT - MAXIMALNO GPS LOKACIJA ZA KREIRANJE - EDIT AKO TREBA */

/*============================================================================*/

#define SERVER                   "[GAMING] Lawless [0.3.7 - client] - Comming Soon" /* GAMEMODE - SERVER NAME */
#define HHOURS                   "[GAMING] Lawless - HappyHours - [0.3.7 - client]" /* GAMEMODE - HAPPYHOURS AKTIVIRANI */
#define SDIALOG                  "{5D9DB3}Lawless {FFFFFF}- {5D9DB3}Gaming"
#define MAINTE                   "[GAMING] MAINTENANCE - www.lawless-hq.com" /* GAMEMODE - NAME U TOKU MAINTENANCE */
#define MAINTA                   "[GAMING] www.lawless-hq.com - UPDATING" /* GAMEMODE - UPDATE U TOKU */
#define MODE                     "Dzoni Script | v0.1" /* GAMEMODE - GAMEMODE NAME */
#define FORUM                    "www.lawless-hq.com" /* GAMEMODE - FORUM NAME */
#define PASSWORD                 "patakdacajecar" /* GAMEMODE - SIFRA U TOKU MAINTENANCE */
#define PASS                     "update_u_toku_" /* GAMEMODE - SIFRA U TOKU UPDATE-A */
#define UPDA                     "11.02.2016" /* GAMEMODE - ZADNJI UPDATE SERVERA */
#define TIME                     "14:31:42" /* GAMEMODE - TIME ZADNJEG UPDETE-A */
#define MAPA                     "Srpski" /* GAMEMODE - MAPNAME - BALKANIAN */
#define VERS                     "v0.1" /* GAMEMODE - VERSION */

/*============================================================================*/

#define DEVELOPER                "xStojanovic" /* DEVELOPER - GLAVNE KOMANDE SVE NA TO IME */
#define OWNER_1                  "xStojanovic" /* OWNER_1 - NEKE OD GLAVNI/SPOREDNE KOMANDE SVE NA TO IME */
#define OWNER_2                  "xStojanovic" /* OWNER_2 - NEKE OD GLAVNI/SPOREDNE KOMANDE SVE NA TO IME */
#define OWNER_3                  "xStojanovic" /* OWNER_3 - NEKE OD GLAVNI/SPOREDNE KOMANDE SVE NA TO IME */
#define OWNER_4                  "xStojanovic" /* OWNER_4 - NEKE OD GLAVNI/SPOREDNE KOMANDE SVE NA TO IME */
#define DIREKTOR                 "xStojanovic" /* DIREKTOR - NEKE OD GLAVNI/SPOREDNE KOMANDE SVE NA TO IME */
#define HEAD_ADMIN               "xStojanovic" /* HEAD_ADMIN - LIDERI/PROMOTERI/SUPPORTERI KOMANDE/ZADUZENJE */

#define HEAD_DEVELOPER           "xStojanovic"
#define CO_DEVELOPER             "xStojanovic"

/*============================================================================*/

#define UPDATE_1                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 1 */
#define UPDATE_2                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 2 */
#define UPDATE_3                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 3 */
#define UPDATE_4                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 4 */
#define UPDATE_5                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 5 */
#define UPDATE_6                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 6 */
#define UPDATE_7                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 7 */
#define UPDATE_8                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 8 */
#define UPDATE_9                 "Nista" /* SCRIPT - UPDATE LIST - SLOT 9 */
#define UPDATE_10                "Nista" /* SCRIPT - UPDATE LIST - SLOT 10 */

/*============================================================================*/

#define PATH 					 "/LAWLESS/KORISNICI/%s.ini" /* FILE - ZA KORISNICKE RACUNE */
#define ACATH                    "/LAWLESS/AC/AntiCheat.ini" /* FILE - ZA ANTICHEAT PROTEKCIJE */
#define SALON                    "/LAWLESS/SALONI/Salon_%d.ini" /* FILE - DYNAMICNO KREIRANJE SALONA */
#define LABS                     "/LAWLESS/LABELOVI/Label_%d.ini" /* FILE - DYNAMICNO KREIRANJE LABELOVA */
#define ORGS                     "/LAWLESS/ORGANIZACIJE/Org_%d.ini" /* FILE - DYNAMICNO KREIRANJE ORGANIZACIJA */
#define GPSS                     "/LAWLESS/GPS/Gps_%d.ini" /* FILE - DYNAMICNO KREIRANJE GPS-OVA */
#define VEHS                     "/LAWLESS/VOZILA/Vozilo_%i.ini" /* FILE - OWNABLE VOZILA */
#define HOUS                     "/LAWLESS/HOUSES/Kuca_%d.ini" /* FILE - HOUSES OWNABLE */

/*============================================================================*/

#define lawless_REGISTER         1 /* DIALOG - REGISTRACIJA SIFRA */
#define lawless_LOGINER          2 /* DIALOG - LOGIN SIFRA */
#define lawless_SECURITY         3 /* DIALOG - LOGIN SECURITY SIFRA */
#define lawless_EMAIL            4 /* DIALOG - EMAIL REGISTRACIJA */
#define lawless_GODINE           5 /* DIALOG - GODINE REGISTRACIJA */
#define lawless_POL              6 /* DIALOG - POL REGISTRACIJA */
#define lawless_DRZAVE           7 /* DIALOG - DRZAVA REGISTRACIJA */
#define lawless_PASSWORDER       8 /* DIALOG - SECURITY SIFRA */
#define lawless_SERVER           9 /* DIALOG - SERVER KONTROLISANJE */
#define lawless_ANTICHEAT       10 /* DIALOG - ANTICHEAT KONTROLISANJE */
#define lawless_COLOUR          11 /* DIALOG - STAVLJANJE BOJE */
#define lawless_CHECKING        12 /* DIALOG - PROVERA */
#define lawless_CODE            13 /* DIALOG - ADMIN CODE */
#define lawless_DYNAMIC         14 /* DIALOG - DINAMICNO KREIRANJE */
#define lawless_IMOVINA         15 /* DIALOG - IMOVINA KONTROLISANJE */
#define lawless_SALONS          16 /* DIALOG - KONTROLISANJE SALONA */
#define lawless_MODELE          17 /* DIALOG - DODAVANJE MODELA */
#define lawless_VOZILA          18 /* DIALOG - DODAVANJE VOZILA */
#define lawless_DELETE          19 /* DIALOG - DINAMICNO BRISANJE */
#define lawless_UPDATE          20 /* DIALOG - UPDATE LISTA */
#define lawless_UPDATING        21 /* DIALOG - IZVRSAVANJE UPDATE-A */
#define lawless_LABEL           22 /* DIALOG - KREIRANJE LABEL-A */
#define lawless_ORGANIZ         23 /* DIALOG - KREIRANJE ORGANIZACIJE */
#define lawless_OTIP            24 /* DIALOG - KREIRANJE TIP-A ORGANIZACIJE */
#define lawless_OMEMBERS        25 /* DIALOG - KREIRANJE RANKOVA ORGANIZACIJE */
#define lawless_OZSKIN          26 /* DIALOG - KREIRANJE SKINOVA ZENSKIH ORGANIZACIJE */
#define lawless_OMSKIN          27 /* DIALOG - KREIRANJE SKINOVA MUSKIH ORGANIZACIJE */
#define lawless_ORANKS          28 /* DIALOG - KREIRANJE RANK IMENA ORGANIZACIJE */
#define lawless_RANK1           29 /* DIALOG - KREIRANJE RANKOVA PO SLOTOVIMA ORGANIZACIJE */
#define lawless_RANK2           30 /* DIALOG - KREIRANJE RANKOVA PO SLOTOVIMA ORGANIZACIJE */
#define lawless_RANK3           31 /* DIALOG - KREIRANJE RANKOVA PO SLOTOVIMA ORGANIZACIJE */
#define lawless_RANK4           32 /* DIALOG - KREIRANJE RANKOVA PO SLOTOVIMA ORGANIZACIJE */
#define lawless_RANK5           33 /* DIALOG - KREIRANJE RANKOVA PO SLOTOVIMA ORGANIZACIJE */
#define lawless_RANK6           34 /* DIALOG - KREIRANJE RANKOVA PO SLOTOVIMA ORGANIZACIJE */
#define lawless_ASTS            35 /* DIALOG - PROVERAVANJE SERVER STATISTIKE, ORGANIZACIJE KREIRANE */
#define lawless_OCHECK          36 /* DIALOG - PROVERAVANJE ORGANIZACIJA STATISTIKE */
#define lawless_OINFO           37 /* DIALOG - PROVERAVANJE ORGANIZACIJA INFO */
#define lawless_OLEVEL          38 /* DIALOG - PROVERAVANJE/POSTAVLJANJE LEVELA ZA ORGANIZACIJE */
#define lawless_HLEVEL          49 /* DIALOG - PROVERAVANJE/POSTAVLJANJE LEVELA ZA ORGANIZACIJE */
#define lawless_OVEHICLE        40 /* DIALOG - PROVERAVANJE/POSTAVLJANJE VOZILA ZA ORGANIZACIJE */
#define lawless_CGPS            41 /* DIALOG - KREIRANJE GPS LOKACIJA */
#define lawless_GPS             42 /* DIALOG - PROVERAVANJE/POSTAVLJANJE GPS LOKACIJE NA RADARU */
#define lawless_ORINFO          43 /* DIALOG - LISTA KREIRANIH DYNAMICNIH ORGANIZACIJA */
#define lawless_OFFCHEC         44 /* DIALOG - PROVERAVANJE OFFLINE PODATAKA IGRACA */
#define lawless_OFFKEK          45 /* DIALOG - PROVERAVANJE OFFLINE PODATAKA IGRACA INFO */
#define lawless_OSEF            46 /* DIALOG - UPIT DA LI ORGANIZACIJA ZELI DA IMA SEF */
#define lawless_ASKLIST         47 /* DIALOG - LISTA PITANJA */
#define lawless_ASKLISTED       48 /* DIALOG - ODGOVARANJE NA PITANJA */
#define lawless_ASKSENDED       49 /* DIALOG - USPESNO ODGOVARANJE NA PITANJE */
#define lawless_ALLMEMBERS      50 /* DIALOG - LISTA SVIH CLANOVA U ORGANIZACIJI */

/*============================================================================*/

enum lawless_info
{
    info_password[24], /* USER - PASSWORD INGAME */
    info_pol, /* USER - POL INGAME */
    info_drzava[12], /* USER - DRZAVA RL */
    info_godine, /* USER - GODINE INGAME */
    info_skin, /* USER - SKIN INGAME */
	info_security[24], /* USER - SECURITY CODE INGAME PROTIV PROVALE */
	info_email[24], /* USER - EMAIL ADDRESS INGAME ZA RESETOVANJE SIFRE */
	info_registration, /* USER - POTVRDJIVANJE REGISTROVANOG NALOGA */
	info_level, /* USER - LEVEL INGAME */
	info_cash, /* USER - NOVAC INGAME */
	info_last[3], /* USER - LAST TIME VIDJEN NA SERVERU - ZADNJI PUT */
	info_stat, /* USER - STATISTIKA - ONLINE/OFFLINE ZA SIGNATURE */
	info_bank, /* USER - BANK INFO CASH */
	info_euro, /* USER - EURO INFO CASH */
	info_paypoen, /* USER - MINUTI DO PLATE */
	info_experiens, /* USER - EXP DO LEVELUP-A */
	info_hours, /* USER - SATI IGRANJA INGAME */
	info_colour, /* USER - DONATORSKA BOJA */
	info_admin, /* USER - ADMIN INGAME */
	info_acode, /* USER - ADMIN CODE INGAME */
	info_vehicles[4], /* USER - VEHICLES INGAME MAX 3 */
	info_vehsalon, /* USER - VEHICLE SALON INGAME MAX 1 */
	info_insurance, /* USER - OSIGURANJE ZA SMRT */
	info_hungry, /* USER - GLAD */
	info_tutorial, /* USER - GLEDANJE TUTORIALA */
	info_wantedlevel, /* USER - WANTED LEVEL/TRAZENJE IGRACA */
	info_upgrade, /* USER - UPGRADE FOR LEVEL */
	info_inteligenci, /* USER - INTELIGENCIJA ZA POSLOVE */
	info_school, /* USER - SKOLOVANJE ZA POSLOVE */
	info_power, /* USER - SNAGA ZA SKOLOVANJE */
	info_dexterity, /* USER - SPRETNOST ZA SKOLOVANJE */
	info_vehicles_double_key[4], /* USER - VEHICLES INGAME MAX 3 DOUBLE KEYS */
	info_leader, /* USER - LEADER IN ORGANISATION */
	info_member, /* USER - MEMBER IN ORGANISATION */
	info_rank[24], /* USER - RANK IN ORGANISATION */
	info_houses_key, /* USER - KLJUC KUCE */
	info_admin_hours, /* USER - SATI U ADMINISTRACIJI */
};
new P_E[MAX_PLAYERS][lawless_info];

/*============================================================================*/

enum lawless_offline
{
	offline_pol, /* OFFLINE - PROVERA POLA */
	offline_godine, /* OFFLINE - PROVERA GODINA */
	offline_drzava[12], /* OFFLINE - PROVERA DRZAVE */
	offline_password[24], /* OFFLINE - PROVERA LOZINKE */
	offline_email[24], /* OFFLINE - PROVERA E-MAIL ADRESE */
	offline_last[3], /* OFFLINE - PROVERA ZADNJE AKTIVNOSTI */
	offline_vehicles[4], /* OFFLINE - PROVERA SVIH SLOTOVA VOZILA */
};
new F_E[lawless_offline];

/*============================================================================*/

enum lawless_organisation
{
	org_id, /* ORGANISATION - GLOBALNI ID KOD KREIRANJA ORGANISATION */
	org_name[64], /* ORGANISATION - NAME ORGANISATION */
	org_tip, /* ORGANISATION - TIP ORGANISATION */
	org_maxmembers, /* ORGANISATION - UKUPNO CLANOVA ORGANISATION */
	org_invitemembers, /* ORGANISATION - UKUPNO INVITOVANIH CLANOVA */
	org_z_skin[6], /* ORGANISATION - ZENSKI SKINOVI 6 */
	org_m_skin[6], /* ORGANISATION - MUSKI SKINOVI 6 */
	org_leader_1[24], /* ORGANISATION - LIDER BROJ 1 */
	org_leader_2[24], /* ORGANISATION - LIDER BROJ 2 */
	org_member_1[24], /* ORGANISATION - MESTO BROJ 1 */
	org_member_2[24], /* ORGANISATION - MESTO BROJ 2 */
	org_member_3[24], /* ORGANISATION - MESTO BROJ 3 */
	org_member_4[24], /* ORGANISATION - MESTO BROJ 4 */
	org_member_5[24], /* ORGANISATION - MESTO BROJ 5 */
	org_member_6[24], /* ORGANISATION - MESTO BROJ 6 */
	org_member_7[24], /* ORGANISATION - MESTO BROJ 7 */
	org_member_8[24], /* ORGANISATION - MESTO BROJ 8 */
	org_member_9[24], /* ORGANISATION - MESTO BROJ 9 */
	org_member_10[24], /* ORGANISATION - MESTO BROJ 10 */
	org_member_11[24], /* ORGANISATION - MESTO BROJ 11 */
	org_member_12[24], /* ORGANISATION - MESTO BROJ 12 */
	org_member_13[24], /* ORGANISATION - MESTO BROJ 13 */
	org_member_14[24], /* ORGANISATION - MESTO BROJ 14 */
	org_member_15[24], /* ORGANISATION - MESTO BROJ 15 */
	Float:org_position_ext[3], /* ORGANISATION - KORDINATE EXTERIJERA */
	Float:org_position_int[3], /* ORGANISATION - KORDINATE INTERIJERA */
	org_int, /* ORGANISATION - INTERIJER */
	org_vw, /* ORGANISATION - VIRTUAL WORLD */
	org_rank_1[64], /* ORGANISATION - RANK 1 NAME */
	org_rank_2[64], /* ORGANISATION - RANK 2 NAME */
	org_rank_3[64], /* ORGANISATION - RANK 3 NAME */
	org_rank_4[64], /* ORGANISATION - RANK 4 NAME */
	org_rank_5[64], /* ORGANISATION - RANK 5 NAME */
	org_rank_6[64], /* ORGANISATION - RANK 6 NAME */
	org_level, /* ORGANISATION - LEVEL FOR INVITE */
	Float:org_vehicle_1[4], /* ORGANISATION - POSITION VEHICLE SLOT - 1 */
	Float:org_vehicle_2[4], /* ORGANISATION - POSITION VEHICLE SLOT - 2 */
	Float:org_vehicle_3[4], /* ORGANISATION - POSITION VEHICLE SLOT - 3 */
	Float:org_vehicle_4[4], /* ORGANISATION - POSITION VEHICLE SLOT - 4 */
	Float:org_vehicle_5[4], /* ORGANISATION - POSITION VEHICLE SLOT - 5 */
	Float:org_vehicle_6[4], /* ORGANISATION - POSITION VEHICLE SLOT - 6 */
	Float:org_vehicle_7[4], /* ORGANISATION - POSITION VEHICLE SLOT - 7 */
	Float:org_vehicle_8[4], /* ORGANISATION - POSITION VEHICLE SLOT - 8 */
	org_vehicle_slot_1, /* ORGANISATION - VEHICLE INGAME SLOT - 1 */
	org_vehicle_slot_2, /* ORGANISATION - VEHICLE INGAME SLOT - 2 */
	org_vehicle_slot_3, /* ORGANISATION - VEHICLE INGAME SLOT - 3 */
	org_vehicle_slot_4, /* ORGANISATION - VEHICLE INGAME SLOT - 4 */
	org_vehicle_slot_5, /* ORGANISATION - VEHICLE INGAME SLOT - 5 */
	org_vehicle_slot_6, /* ORGANISATION - VEHICLE INGAME SLOT - 6 */
	org_vehicle_slot_7, /* ORGANISATION - VEHICLE INGAME SLOT - 7 */
	org_vehicle_slot_8, /* ORGANISATION - VEHICLE INGAME SLOT - 8 */
	org_vehicles_all[8], /* ORGANISATION - GLOBAL VARIABLA FOR CREATE ALL CARS */
	org_vehicles_created[8], /* ORGANISATION - GLOBAL VARIABLA FOR LOAD ALL CARS */
	org_cash, /* ORGANISATION - NOVAC U SEFU */
	org_drugs, /* ORGANISATION - DROGA U SEFU */
	org_materials, /* ORGANISATION - MATERIJALI U SEFU */
	Float:org_sef_position[3], /* ORGANISATION - SEF POSITION */
	org_sef, /* ORGANISATION - SEF CREATED */
	org_ranks_created[6], /* ORGANISATION - KREIRANJE RANKOVA */
	org_tablice_slot_1[10], /* ORGANISATION - TABLICE INGAME SLOT - 1 */
	org_tablice_slot_2[10], /* ORGANISATION - TABLICE INGAME SLOT - 2 */
	org_tablice_slot_3[10], /* ORGANISATION - TABLICE INGAME SLOT - 3 */
	org_tablice_slot_4[10], /* ORGANISATION - TABLICE INGAME SLOT - 4 */
	org_tablice_slot_5[10], /* ORGANISATION - TABLICE INGAME SLOT - 5 */
	org_tablice_slot_6[10], /* ORGANISATION - TABLICE INGAME SLOT - 6 */
	org_tablice_slot_7[10], /* ORGANISATION - TABLICE INGAME SLOT - 7 */
	org_tablice_slot_8[10], /* ORGANISATION - TABLICE INGAME SLOT - 8 */
};
new O_E[MAX_ORG][lawless_organisation];
new lawless_organisation_pickup[sizeof(O_E)]; /* ORGANISATION - PICKUP ZA ORGANISATION */
new lawless_organisation_sef_pickup[sizeof(O_E)]; /* ORGANISATION - PICKUP ZA ORGANISATION SEF */
new Text3D:lawless_organisation_label[sizeof(O_E)]; /* ORGANISATION - LABEL ZA ORGANISATION */
new Text3D:lawless_organisation_sef_label[sizeof(O_E)]; /* ORGANISATION - LABEL ZA ORGANISATION LABEL */
new lawless_createdynamic_map_org[sizeof(O_E)]; /* ORGANISATION - MAPA GLAVNA */
new lawless_maxorganisation = 0; /* ORGANISATION - LOAD */

/*============================================================================*/

enum lawless_gps
{
	gps_id, /* GPS LOCATION - GLOBALNI ID KOD KREIRANJA GPS-OVA */
	gps_name_location[64], /* GPS LOCATION - IME LOKACIJA ZA KREIRANJE */
	Float:gps_position_location[3], /* GPS LOCATION - POZICIJE LOKACIJA KOD KREIRANJA */
};
new G_E[MAX_GPS][lawless_gps];
new lawless_maxgpsovs = 0; /* GPS LOCATION - LOAD */

/*============================================================================*/

enum lawless_label
{
	Float:label_position[3], /* LABEL - POZICIJA KREIRANJA */
	label_created, /* LABEL - PROVERA ZA LOAD */
	label_text[128], /* LABEL - TEXT ZA PISANJE INGAME */
};
new L_E[MAX_LABEL][lawless_label];
new Text3D:lawless_labeli_label[sizeof(L_E)]; /* LABEL - LABEL ZA PISANJE */
new lawless_maxlabela = 0; /* LABEL - LOAD */

/*============================================================================*/

enum lawless_ac
{
	anticheat_save, /* ANTICHEAT - SAVE REZIM RADA DA/NE */
	anticheat_money, /* ANTICHEAT - MONEYHACK */
	anticheat_health, /* ANTICHEAT - HEALTHACK */
	anticheat_armour, /* ANTICHEAT - ARMOURHACK */
	anticheat_rcon, /* ANTICHEAT - RCONHACK */
	anticheat_chat, /* ANTICHEAT - SPAMANJE CHAT */
	anticheat_say, /* ANTICHEAT - ONEMOGUCEN/OMOGUCEN 'T' CHAT */
	anticheat_bunnyhop, /* ANTICHEAT - REZIM BUNNYHOP DA/NE */
	anticheat_joypad, /* ANTICHEAT - REZIM JOYPAD */
	anticheat_weaponcrash, /* ANTICHEAT - WEAPON CRASHER */
	anticheat_register, /* ANTICHEAT - REGISTRACIJA NA SERVERU */
};
new A_C[lawless_ac];

/*============================================================================*/

enum lawless_vozila
{
	vehicle_id, /* VOZILA - PROVERA ZA LOAD */
	vehicle_owned, /* VOZILA - PROVERA ZA CREATE/LOAD */
	vehicle_price, /* VOZILA - CENA VOZILA */
	vehicle_owner[MAX_PLAYER_NAME], /* VOZILO - OWNER POSEDOVANJA VOZILA */
	vehicle_locked, /* VOZILO - BRAVA */
	Float:vehicle_positions[4], /* VOZILA - POZICIJA VOZILA */
	vehicle_colors[2], /* VOZILA - BOJE 1 I 2 */
	vehicle_model, /* VOZILA - MODEL VOZILA */
};
new V_E[MAX_CARS][lawless_vozila];
new lawless_maxcars = 0; /* VOZILA - LOAD */

/*============================================================================*/

enum lawless_salon
{
	salon_vehicle[5], /* AUTOSALON - SLOTOVI ZA VOZILA MAX 5 */
	salon_modelprice[5], /* AUTOSALON - SLOTOVI ZA MODELE VOZILA MAX 5 */
	salon_owner[MAX_PLAYER_NAME], /* AUTOSALON - VLASNIK */
	salon_owned, /* AUTOSALON - PROVERA ZA KUPOVINU */
	Float:salon_position[3], /* AUTOSALON - POZICIJA KOD KREIRANJA PICKUP-A */
	Float:salon_vehicleposition[4], /* AUTOSALON - VOZILO ZA SPAWN POSLE KUPOVINE */
	salon_name[24], /* AUTOSALON - IME MAX 35 RANDOM */
	salon_maxmodels[5], /* AUTOSALON - SLOTOVI ZA MAXIMALNU KUPOVINU VOZILA MAX 5 */
	salon_buy, /* AUTOSALON - PROVERA ZA KUPOVINU */
	salon_created, /* AUTOSALON - PROVERA ZA LOAD */
	salon_level, /* AUTOSALON - PROVERA ZA KUPOVINU */
	salon_money, /* AUTOSALON - PROVERA ZA KUPOVINU */
	salon_cash, /* AUTOSALON - PROVERA ZA NOVAC U AUTOSALONU */
};
new A_E[MAX_SALONS][lawless_salon];
new lawless_salon_pickup[sizeof(A_E)]; /* AUTOSALON - PICKUP GLAVNI */
new lawless_createdynamic_map_salon[sizeof(A_E)]; /* AUTOSALON - MAPA GLAVNA */
new Text3D:lawless_salon_label[sizeof(A_E)]; /* AUTOSALON - LABEL GLAVNI */
new lawless_maxsalon = 0; /* AUTOSALON - LOAD */

/*============================================================================*/

enum lawless_askq
{
    bool:askq_poslat, /* ASKQ - POSLATO PITANJE */
    askq_postavljac[MAX_PLAYER_NAME], /* ASKQ - POSTAVLJAC PITANJA */
    askq_id, /* ASKQ - ID PITANJA ZA ODGOVOR */
	askq_pitanje[128], /* ASKQ - STRING PITANJA */
};
new AS_E[MAX_ASKQ][lawless_askq];

/*============================================================================*/

enum lawless_info_askq
{
	bool:askq_poslato, /* ASKQ - PLAYER POSLATO PITANJE */
    bool:askq_odgovoreno, /* ASKQ - PLAYER ODGOVORENO PITANJE */
    askq_odgovor_admin[MAX_PLAYER_NAME], /* ASKQ - ODGOVOR ADMINA */
	askq_odgovor[128], /* ASKQ - STRING ODGOVORA */
};
new AS_IE[MAX_PLAYERS][lawless_info_askq];

/*============================================================================*/

enum lawless_houses
{
	house_created, /* HOUSE - VARIJABLA ZA KREIRANJE */
	house_owned, /* HOUSE - VARIJABLA ZA KORISCENJE KUCE DA LI JE NEKO IMA */
	house_owner[MAX_PLAYER_NAME], /* HOUSE - VARIJABLA ZA KUPCA KO JE POSEDUJE */
	house_price, /* HOUSE - CENA KUCE */
	house_level, /* HOUSE - LEVEL KUCE */
	house_type, /* HOUSE - TYPE KUCE - VELIKA,MALA,SREDNJA */
	house_locked, /* HOUSE - BRAVA KUCE */
	house_interior, /* HOUSE - INTERIOR */
	house_vw, /* HOUSE - VIRTUALWORLD */
	Float:house_inside[3], /* HOUSE - POZICIJA INTERIJER */
	Float:house_outside[3], /* HOUSE - POZICIJA NAPOLJU */
	house_furniture_slots[15], /* HOUSE - SLOTOVI ZA FURNITURE ZA SADA SAMO 15 */
	Float:house_furniture_slot_1[4], /* HOUSE - SLOT ZA FURNITURE - 1 */
	Float:house_furniture_slot_2[4], /* HOUSE - SLOT ZA FURNITURE - 2 */
	Float:house_furniture_slot_3[4], /* HOUSE - SLOT ZA FURNITURE - 3 */
	Float:house_furniture_slot_4[4], /* HOUSE - SLOT ZA FURNITURE - 4 */
	Float:house_furniture_slot_5[4], /* HOUSE - SLOT ZA FURNITURE - 5 */
	Float:house_furniture_slot_6[4], /* HOUSE - SLOT ZA FURNITURE - 6 */
	Float:house_furniture_slot_7[4], /* HOUSE - SLOT ZA FURNITURE - 7 */
	Float:house_furniture_slot_8[4], /* HOUSE - SLOT ZA FURNITURE - 8 */
	Float:house_furniture_slot_9[4], /* HOUSE - SLOT ZA FURNITURE - 9 */
	Float:house_furniture_slot_10[4], /* HOUSE - SLOT ZA FURNITURE - 10 */
	Float:house_furniture_slot_11[4], /* HOUSE - SLOT ZA FURNITURE - 11 */
	Float:house_furniture_slot_12[4], /* HOUSE - SLOT ZA FURNITURE - 12 */
	Float:house_furniture_slot_13[4], /* HOUSE - SLOT ZA FURNITURE - 13 */
	Float:house_furniture_slot_14[4], /* HOUSE - SLOT ZA FURNITURE - 14 */
	Float:house_furniture_slot_15[4], /* HOUSE - SLOT ZA FURNITURE - 15 */
	house_furniture_objects[15], /* HOUSE - SLOTOVI ZA FURNITURE OBJEKTI ZA SADA SAMO 15 */
};
new H_E[MAX_HOUSES][lawless_houses];
new lawless_houses_pickup[sizeof(H_E)]; /* HOUSE - PICKUP ZA HOUSE */
new lawless_createdynamic_map_house[sizeof(H_E)]; /* HOUSE - MAPA GLAVNA */
new Text3D:lawless_houses_label[sizeof(H_E)]; /* HOUSE - LABEL ZA HOUSE */
new lawless_maxhouses = 0; /* HOUSE - LOAD */

/*============================================================================*/

new PlayerText:registering_Data[31][MAX_PLAYERS]; /* REGISTER - TEXTDRAWOWI CLICKABLE */
new PlayerText:registering_Bleeding[5][MAX_PLAYERS]; /* REGISTER - ZATAMLJIVANJE */
new PlayerText:bank_Data[1][MAX_PLAYERS]; /* BANK - MONEY TEXTDRAW */
new PlayerText:euro_Data[1][MAX_PLAYERS]; /* EURO - MONEY TEXTDRAW */
new PlayerText:tutorial_Data[17][MAX_PLAYERS]; /* REGISTER - TUTORIAL TEXTDRAWOWI */
new PlayerText:wanted_Data[1][MAX_PLAYERS]; /* GLOBAL - WANTED TEXTDRAWOWI */
new PlayerText:death_Data[8][MAX_PLAYERS]; /* GLOBAL - DEATH TEXTDRAWOWI */
new PlayerText:speedo_Data[10][MAX_PLAYERS]; /* GLOBAL - SPEEDO TEXTDRAWOWI */

/*============================================================================*/

new PlayerBar:lawless_Glad[MAX_PLAYERS] = {INVALID_PLAYER_BAR_ID,...}; /* GLOBAL - PROGRESS BAR ZA GLAD */

/*============================================================================*/

new lawless_Login[MAX_PLAYERS]; /* LOGIN - PRAVO NA POGRESIVANJE SIFRE */
new lawless_Logo[MAX_PLAYERS]; /* LOGIN - ULOGOVAN NA SERVER */
new lawless_Loadinger[MAX_PLAYERS]; /* LOGIN - ULAZAK U INTERIJER/EXTERIJERE */
new lawless_Tutorial_False[MAX_PLAYERS]; /* LOGIN - PONISTAVANJE TUTORIALA */

/*============================================================================*/

new bool:lawless_Drzava[MAX_PLAYERS]; /* REGISTER - BOOL ZA CLICKABLE */
new bool:lawless_Pol[MAX_PLAYERS]; /* REGISTER - BOOL ZA CLICKABLE */
new bool:lawless_Godine[MAX_PLAYERS]; /* REGISTER - BOOL ZA CLICKABLE */
new bool:lawless_Email[MAX_PLAYERS]; /* REGISTER - BOOL ZA CLICKABLE */
new bool:lawless_Security[MAX_PLAYERS]; /* REGISTER - BOOL ZA CLICKABLE */
new bool:lawless_Password[MAX_PLAYERS]; /* REGISTER - BOOL ZA CLICKABLE */

/*============================================================================*/

new lawless_Stepens[MAX_PLAYERS]; /* LOGIN/REGISTER - BLEEDING */
new lawless_Bleeding[MAX_PLAYERS]; /* LOGIN/REGISTER - BLEEDING */
new lawless_Hospital[MAX_PLAYERS]; /* LOGIN/REGISTER - HOSPITAL DEATH/SPAWN */
new lawless_Chatined[MAX_PLAYERS]; /* LOGIN/REGISTER - KORISCENJE CHATA */
new lawless_BH[MAX_PLAYERS]; /* LOGIN/REGISTER - ANTI BUNNYHOP */
new lawless_CREATE_ORG[MAX_PLAYERS]; /* LOGIN/REGISTER - KREIRANJE ORGANIZACIJE */
new lawless_CREATE_RANKS[MAX_PLAYERS]; /* LOGIN/REGISTER - KREIRANJE RANKOVA ORGANIZACIJE */
new lawless_ANTI_BH[MAX_PLAYERS]; /* LOGIN/REGISTER - ANTI BUNNYHOP */
new lawless_EDIT_LEVEL[MAX_PLAYERS]; /* LOGIN/REGISTER - KREIRANJE LEVELA ORGANIZACIJE */
new lawless_GPS_USAGE[999][999]; /* LOGIN/REGISTER - PROVERA ZA LOKACIJE NA GPS UREDJAJU */
new lawless_GPS_HAVEN[MAX_PLAYERS]; /* LOGIN/REGISTER - PROVERA ZA VEC KORISCENJE GPS LOKACIJA UREDJAJA */
new lawless_SALON[MAX_PLAYERS]; /* LOGIN/REGISTER - PROVERA ZA KUPOVINU VOZILA U SALONIMA */
new lawless_ORG_PICKUP[MAX_PLAYERS]; /* LOGIN/REGISTER - PROVERA ZA KREIRANJE PICKUPA ZA SEF */
new lawless_ORG_SEF[MAX_PLAYERS]; /* LOGIN/REGISTER - PROVERA ZA KREIRANJE PICKUPA ZA SEF */
new lawless_ASKQ_ANSWER[MAX_PLAYERS]; /* LOGIN/REGISTER - ODGOVARANJE NA ASKQ-OVE */
new lawless_CREATE_VEHS[MAX_PLAYERS]; /* LOGIN/REGISTER - KREIRANJE ORGANIZACIJSKIH VOZILA */
new lawless_JOIN_INTERIOR[MAX_PLAYERS]; /* LOGIN/REGISTER - ULAZENJE U KUCE/FIRME */

/*============================================================================*/

new lawless_Chating = 1; /* LOGIN/REGISTER - REALCHAT TEXT */

/*============================================================================*/

new lawless_string_ex[2048]; /* LOGIN/REGISTER - GLOBALNI STRING */

/*============================================================================*/

new Float:RandomCitySpawn[6][3] =
{
 	{1948.7676,-1667.3427,13.3430}, /* SPAWN - 1 - RANDOM SPAWN - ANTONIO */
 	{1948.4835,-1669.7416,13.3430}, /* SPAWN - 1 - RANDOM SPAWN - ANTONIO */
 	{1948.1453,-1672.4739,13.3430}, /* SPAWN - 1 - RANDOM SPAWN - ANTONIO */
	{1948.9751,-1692.5360,13.3430}, /* SPAWN - 1 - RANDOM SPAWN - ANTONIO */
	{1948.3464,-1695.3689,13.3430}, /* SPAWN - 1 - RANDOM SPAWN - ANTONIO */
	{1948.9094,-1698.2329,13.3430} /* SPAWN - 1 - RANDOM SPAWN - ANTONIO */
};

/*============================================================================*/

new Float:RandomMedicSpawn[6][3] =
{
	{1199.2208,-1322.7012,12.9139}, /* HOSPITAL - RANDOM SPAWN - LEVU */
	{1197.9097,-1323.1395,12.9139}, /* HOSPITAL - RANDOM SPAWN - LEVU */
	{1196.1047,-1322.7223,12.9139}, /* HOSPITAL - RANDOM SPAWN - LEVU */
	{1194.6041,-1323.2542,12.9139}, /* HOSPITAL - RANDOM SPAWN - LEVU */
	{1201.0532,-1322.6865,12.9139}, /* HOSPITAL - RANDOM SPAWN - LEVU */
	{1203.0114,-1323.0652,12.9139} /* HOSPITAL - RANDOM SPAWN - LEVU */
};

/*============================================================================*/

new vozila_imena[][] =
{
    "Landstalker", "Bravura", "Buffalo",
	"Linerunner", "Perrenial", "Sentinel",
    "Dumper", "Firetruck", "Trashmaster",
	"Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule",
	"Cheetah", "Ambulance", "Leviathan",
	"Moonbeam", "Esperanto", "Taxi",
	"Washington", "Bobcat", "Whoopee",
	"BF Injection", "Hunter", "Premier",
    "Enforcer", "Securicar", "Banshee",
	"Predator", "Bus", "Rhino", "Barracks",
    "Hotknife", "Trailer 1", "Previon",
	"Coach", "Cabbie", "Stallion",
	"Rumpo", "RC Bandit", "Romero",
	"Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy",
	"Tram", "Trailer 2", "Turismo",
	"Speeder", "Reefer", "Tropic",
	"Flatbed", "Yankee", "Caddy",
	"Solair", "Berkley's RC Van", "Skimmer",
	"PCJ-600", "Faggio", "Freeway",
	"RC Baron", "RC Raider", "Glendale",
	"Oceanic", "Sanchez", "Sparrow",
    "Patriot", "Quad", "Coastguard",
	"Dinghy", "Hermes", "Sabre",
	"Rustler", "ZR-350", "Walton",
	"Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis",
	"Baggage", "Dozer", "Maverick",
	"Chopper", "Rancher", "FBI Rancher",
	"Virgo", "Greenwood", "Jetmax",
	"Hotring", "Sandking", "Blista Compact",
	"Police Maverick", "Boxvillde", "Benson",
	"Mesa", "RC Goblin", "Hotring Racer A",
	"Hotring Racer B", "Bloodring Banger", "Rancher",
	"Super GT", "Elegant", "Journey",
	"Bike", "Mountain Bike", "Beagle",
    "Cropduster", "Stunt", "Tanker",
	"Roadtrain", "Nebula", "Majestic",
	"Buccaneer", "Shamal", "Hydra",
	"FCR-900", "NRG-500", "HPV1000",
	"Cement Truck", "Tow Truck", "Fortune",
	"Cadrona", "FBI Truck", "Willard",
	"Forklift", "Tractor", "Combine",
    "Feltzer", "Remington", "Slamvan",
	"Blade", "Freight", "Streak",
	"Vortex", "Vincent", "Bullet",
	"Clover", "Sadler", "Firetruck",
	"Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise",
	"Merit", "Utility", "Nevada",
	"Yosemite", "Windsor", "Monster",
    "Monster", "Uranus", "Jester",
	"Sultan", "Stratum", "Elegy",
	"Raindance", "RC Tiger", "Flash",
	"Tahoma", "Savanna", "Bandito",
	"Freight Flat", "Streak Carriage",
    "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400",
	"DFT-30", "Huntley", "Stafford",
	"BF-400", "News Van", "Tug",
	"Trailer 3", "Emperor", "Wayfarer",
	"Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada",
	"Dodo", "RC Cam", "Launch",
    "LSPD Car", "SFPD Car", "LVPD Car",
	"Police Ranger", "Picador", "S.W.A.T Tank",
	"Alpha", "Phoenix", "Glendale",
	"Sadler", "Luggage Trailer 1", "Luggage Trailer 2",
	"Stairs Trailer", "Boxville",
	"Utility Trailer 1", "Utility Trailer 2", "Kart"
};

/*============================================================================*/

public OnGameModeInit()
{
	SetGameModeText(MODE); /* SCRIPT - GAMEMODE NAME */
	SendRconCommand("mapname "MAPA""); /* SCRIPT - MAPNAME IME */
	SendRconCommand("hostname "SERVER""); /* SCRIPT - HOSTNAME IME */
	DisableInteriorEnterExits(); /* SCRIPT - INTERIJERI/EXTERIJERI IZLAZ MARKER */
	EnableStuntBonusForAll(false); /* SCRIPT - GASENJE BONUSA ZA SKAKANJE */
	ShowPlayerMarkers(2); /* SCRIPT - MARKERI NA MAPI */
	SetNameTagDrawDistance(5); /* SCRIPT - NAME TAG NA 5 METARA */
	AllowInteriorWeapons(1); /* SCRIPT - DOZVOLJENO KORISCENJE ORUZIJA U INTERIJERU */
	ManualVehicleEngineAndLights(); /* SCRIPT - MANUELNO PALJENJE MOTORA I SVETALA NAD VOZILIMA */
	lawless_loading_SCRIPT_FILES(); /* SCRIPT - LOADING ALL SYSTEMS */
	lawless_loading_MAPS(); /* SCRIPT - LOADING ALL MAPS */
	lawless_loading_LAPI(); /* SCRIPT - LOADING ALL LABELS AND PICKUPS */
	
	/*                        		AC - LOAD                           	  */

	if(fexist(ACATH))
	{
        INI_ParseFile(ACATH, "loadAntiCheat");
        printf(""VERS"_SCRIPT - loading lawless_anticheat - completed!");
    }
    else
    {
        lawless_restarting_anticheat();
        printf(""VERS"_SCRIPT - loading lawless_anticheat - is not completed!");
    }

	/*                        	AC - LOAD - END                               */

	lawless_antiSTEAL(); /* SCRIPT - ANTIDEAMX SCRIPT */
	return true;
}

/*============================================================================*/

public OnGameModeExit()
{
	return true;
}

/*============================================================================*/

public OnPlayerRequestClass(playerid, classid)
{
	return true;
}

/*============================================================================*/

public OnPlayerConnect(playerid)
{
    lawless_Reset(playerid);
    lawless_Chat(playerid,20);
    lawless_SPECC(playerid,true);
    lawless_COLOR(playerid,0xAFAFAFAA);

	CreateBank_data(playerid);
	CreateEuro_data(playerid);
	CreateWanted_data(playerid);
	CreateDeath_data(playerid);
	CreateSpeedo_data(playerid);
	CreateRegister_data(playerid);
	CreateBleeding_data(playerid);
	CreateTutorial_data(playerid);
	CreateProgress_data(playerid);

    if(fexist(lawless_UserPath(playerid)))
	{
	    defer lawless_Interpolate(playerid);
	    INI_ParseFile(lawless_UserPath(playerid),"loadAccounts", .bExtra = true, .extra = playerid);
	}
	else
	{
	    if(A_C[anticheat_register] == 1)
	    {
	        lawless_Chat(playerid,20);

	        ERROR(playerid,"Kikovani ste zbog onemogucene registracije!");
	        ERROR(playerid,"Trenutno je onemogucena registracija na serveru,dodjite kasnije!");

	        defer lawless_Kick(playerid);
	    }
	    
        lawless_Stepens[playerid] = 0;
        lawless_Bleeding[playerid] = 0;
        
        defer lawless_Camere(playerid);
	}

    if(P_E[playerid][info_registration] == 1)
    {
	    defer lawless_CameraLogin(playerid);
    }

    if(!lawless_Validname(lawless_Nick(playerid)))
	{
	    lawless_Chat(playerid,20);
	    
	    ERROR(playerid,"Kikovani ste zbog ne propisnog imena!");
		ERROR(playerid,"Format vaseg imena mora biti obavezno u sledecem formatu - 'Ime_Prezime'!");
		ERROR(playerid,"Primer formata imena u sledecem formatu - 'Stefan_Stojanovic'!");
		
		defer lawless_Kick(playerid);
		return true;
	}

	/*                	MAP - KOMERCIJALNA - AXA - AUTO SALON 				  */

	lawless_REMOVE(playerid, 5134, 2045.4922, -1903.6172, 16.1875, 0.25);
	lawless_REMOVE(playerid, 1525, 2065.4375, -1897.2344, 13.6094, 0.25);
	lawless_REMOVE(playerid, 5321, 2045.4922, -1903.6172, 16.1875, 0.25);
	lawless_REMOVE(playerid, 1308, 2044.0938, -1923.3359, 11.5156, 0.25);
	lawless_REMOVE(playerid, 1308, 2071.9844, -1922.1250, 11.6016, 0.25);
	lawless_REMOVE(playerid, 5231, 2085.2813, -1909.7109, 23.0000, 0.25);
	lawless_REMOVE(playerid, 5374, 2085.2813, -1909.7109, 23.0000, 0.25);
	lawless_REMOVE(playerid, 955, 2060.1172, -1897.6406, 12.9297, 0.25);
	lawless_REMOVE(playerid, 1307, 2071.8828, -1879.5625, 12.6875, 0.25);
	lawless_REMOVE(playerid, 1438, 1015.5313, -1337.1719, 12.5547, 0.25);
	lawless_REMOVE(playerid, 4062, 1529.5000, -1470.5313, 32.4531, 0.25);
	lawless_REMOVE(playerid, 4222, 1575.9375, -1516.5781, 36.6797, 0.25);
	lawless_REMOVE(playerid, 1283, 1469.5625, -1441.5391, 15.6250, 0.25);
	lawless_REMOVE(playerid, 4180, 1502.6094, -1467.1250, 24.0156, 0.25);
	lawless_REMOVE(playerid, 1294, 1507.9375, -1444.8984, 17.0234, 0.25);
	lawless_REMOVE(playerid, 4058, 1529.5000, -1470.5313, 32.4531, 0.25);

	/*				MAP - KOMERCIJALNA - AXA - AUTO SALON - END				  */

    /* 							MAP - BANK DIAMOND 							  */

    lawless_REMOVE(playerid, 5597, 2011.4688, -1300.8984, 28.6953, 0.25);
	lawless_REMOVE(playerid, 5636, 2042.1797, -1346.8047, 24.0078, 0.25);
	lawless_REMOVE(playerid, 1525, 1969.5938, -1289.6953, 24.5625, 0.25);
	lawless_REMOVE(playerid, 5464, 1902.4297, -1309.5391, 29.9141, 0.25);
	lawless_REMOVE(playerid, 1308, 1967.0859, -1331.0469, 23.1641, 0.25);
	lawless_REMOVE(playerid, 700, 1970.5078, -1328.3203, 23.3359, 0.25);
	lawless_REMOVE(playerid, 1308, 2007.3438, -1330.9609, 23.1641, 0.25);
	lawless_REMOVE(playerid, 700, 2003.4375, -1328.3203, 23.2344, 0.25);
	lawless_REMOVE(playerid, 620, 1989.6641, -1328.0859, 22.5703, 0.25);
	lawless_REMOVE(playerid, 5461, 2011.4688, -1300.8984, 28.6953, 0.25);
	lawless_REMOVE(playerid, 5631, 2011.4063, -1302.9453, 28.2734, 0.25);
	lawless_REMOVE(playerid, 620, 2039.1094, -1327.9766, 22.6016, 0.25);
	lawless_REMOVE(playerid, 1308, 2057.1328, -1311.2891, 23.1641, 0.25);
	lawless_REMOVE(playerid, 700, 2055.0938, -1311.7813, 23.2344, 0.25);
	lawless_REMOVE(playerid, 1308, 2057.1094, -1302.3906, 23.2422, 0.25);
	lawless_REMOVE(playerid, 5465, 1993.2969, -1284.9375, 26.7344, 0.25);
	lawless_REMOVE(playerid, 1308, 2008.6328, -1271.3125, 23.1641, 0.25);
	lawless_REMOVE(playerid, 673, 2054.6797, -1281.5781, 22.9453, 0.25);
	lawless_REMOVE(playerid, 1308, 2056.7578, -1270.7656, 23.2422, 0.25);
	
	lawless_REMOVE(playerid, 4070, 1719.7422, -1770.7813, 23.4297, 0.25);
	lawless_REMOVE(playerid, 4071, 1722.5000, -1775.3984, 14.5156, 0.25);
	lawless_REMOVE(playerid, 1531, 1724.7344, -1741.5000, 14.1016, 0.25);
	lawless_REMOVE(playerid, 620, 1700.8516, -1778.3984, 12.4922, 0.25);
	lawless_REMOVE(playerid, 620, 1701.3047, -1794.4297, 12.5469, 0.25);
	lawless_REMOVE(playerid, 620, 1701.1484, -1753.2266, 12.3516, 0.25);
	lawless_REMOVE(playerid, 620, 1701.2578, -1764.4844, 12.4375, 0.25);
	lawless_REMOVE(playerid, 620, 1700.8984, -1743.9844, 12.4531, 0.25);
	lawless_REMOVE(playerid, 3983, 1722.5000, -1775.3984, 14.5156, 0.25);
	
	lawless_REMOVE(playerid, 6069, 1093.8750, -1630.0156, 20.3281, 0.25);
	lawless_REMOVE(playerid, 6070, 1093.6406, -1619.1641, 15.3594, 0.25);
	lawless_REMOVE(playerid, 6071, 1087.9844, -1682.3281, 19.4375, 0.25);
	lawless_REMOVE(playerid, 6194, 1116.6250, -1542.9063, 22.4688, 0.25);
	lawless_REMOVE(playerid, 647, 1051.8750, -1680.5156, 14.4609, 0.25);
	lawless_REMOVE(playerid, 615, 1051.2500, -1678.0234, 13.2891, 0.25);
	lawless_REMOVE(playerid, 647, 1055.6172, -1692.6484, 14.4609, 0.25);
	lawless_REMOVE(playerid, 647, 1058.3125, -1695.7656, 14.6875, 0.25);
	lawless_REMOVE(playerid, 6063, 1087.9844, -1682.3281, 19.4375, 0.25);
	lawless_REMOVE(playerid, 647, 1097.4297, -1699.4219, 14.6875, 0.25);
	lawless_REMOVE(playerid, 647, 1101.6563, -1699.5625, 14.6875, 0.25);
	lawless_REMOVE(playerid, 1297, 1130.5391, -1684.3203, 15.8906, 0.25);
	lawless_REMOVE(playerid, 792, 1057.4297, -1630.2813, 19.7031, 0.25);
	lawless_REMOVE(playerid, 792, 1075.6328, -1630.2813, 19.7031, 0.25);
	lawless_REMOVE(playerid, 620, 1065.4609, -1620.7891, 19.3672, 0.25);
	lawless_REMOVE(playerid, 620, 1061.5313, -1617.5234, 19.6094, 0.25);
	lawless_REMOVE(playerid, 792, 1075.6328, -1607.9609, 19.7031, 0.25);
	lawless_REMOVE(playerid, 792, 1093.2734, -1630.2813, 19.7031, 0.25);
	lawless_REMOVE(playerid, 6060, 1093.8750, -1630.0156, 20.3281, 0.25);
	lawless_REMOVE(playerid, 6110, 1093.8750, -1630.0156, 20.3281, 0.25);
	lawless_REMOVE(playerid, 792, 1112.2422, -1630.2813, 19.7031, 0.25);
	lawless_REMOVE(playerid, 6061, 1093.6406, -1619.1641, 15.3594, 0.25);
	lawless_REMOVE(playerid, 3586, 1106.7734, -1619.2578, 15.9375, 0.25);
	lawless_REMOVE(playerid, 792, 1093.2734, -1607.9609, 19.7031, 0.25);
	lawless_REMOVE(playerid, 792, 1112.2422, -1607.9609, 19.7031, 0.25);
	lawless_REMOVE(playerid, 6062, 1137.1484, -1631.2891, 14.4844, 0.25);

    /*         				MAP - BANK DIAMOND - END 						  */

    /*                        	MAP - BIG CENTAR                              */

    lawless_REMOVE(playerid, 17910, 2916.765, -1877.648, 0.070, 0.250);
	lawless_REMOVE(playerid, 17953, 2916.765, -1877.648, 0.070, 0.250);

    /*                        	MAP - BIG CENTAR - END	                      */

	/*                        	MAP - SPAWN                                   */

	lawless_REMOVE(playerid, 5543, 1941.656, -1682.570, 12.476, 0.250);
	lawless_REMOVE(playerid, 5544, 1873.742, -1682.476, 34.796, 0.250);
	lawless_REMOVE(playerid, 1524, 1837.664, -1640.382, 13.757, 0.250);
	lawless_REMOVE(playerid, 620, 1855.718, -1741.539, 10.804, 0.250);
	lawless_REMOVE(playerid, 620, 1879.507, -1741.484, 10.804, 0.250);
	lawless_REMOVE(playerid, 620, 1908.218, -1741.484, 10.804, 0.250);
	lawless_REMOVE(playerid, 1283, 1940.906, -1741.148, 15.601, 0.250);
	lawless_REMOVE(playerid, 712, 1929.578, -1736.906, 21.390, 0.250);
	lawless_REMOVE(playerid, 620, 1931.039, -1726.328, 10.804, 0.250);
	lawless_REMOVE(playerid, 1226, 1945.765, -1716.359, 16.390, 0.250);
	lawless_REMOVE(playerid, 1226, 1825.929, -1697.562, 16.343, 0.250);
	lawless_REMOVE(playerid, 620, 1832.382, -1694.312, 9.718, 0.250);
	lawless_REMOVE(playerid, 1537, 1837.437, -1683.968, 12.304, 0.250);
	lawless_REMOVE(playerid, 1533, 1837.437, -1683.953, 12.304, 0.250);
	lawless_REMOVE(playerid, 1537, 1837.437, -1686.984, 12.312, 0.250);
	lawless_REMOVE(playerid, 1226, 1825.851, -1667.078, 16.343, 0.250);
	lawless_REMOVE(playerid, 620, 1832.898, -1670.765, 9.718, 0.250);
	lawless_REMOVE(playerid, 1533, 1837.437, -1677.921, 12.296, 0.250);
	lawless_REMOVE(playerid, 1537, 1837.437, -1680.953, 12.296, 0.250);
	lawless_REMOVE(playerid, 1533, 1837.437, -1680.937, 12.296, 0.250);
	lawless_REMOVE(playerid, 5408, 1873.742, -1682.476, 34.796, 0.250);
	lawless_REMOVE(playerid, 620, 1931.039, -1702.289, 10.804, 0.250);
	lawless_REMOVE(playerid, 712, 1929.578, -1694.460, 21.390, 0.250);
	lawless_REMOVE(playerid, 620, 1931.039, -1667.031, 10.804, 0.250);
	lawless_REMOVE(playerid, 1226, 1937.554, -1669.890, 16.390, 0.250);
	lawless_REMOVE(playerid, 5441, 1941.656, -1682.570, 12.476, 0.250);
	lawless_REMOVE(playerid, 620, 1931.039, -1637.898, 10.804, 0.250);
	lawless_REMOVE(playerid, 1226, 1945.765, -1635.773, 16.390, 0.250);
	lawless_REMOVE(playerid, 620, 1855.718, -1623.281, 10.804, 0.250);
	lawless_REMOVE(playerid, 620, 1879.507, -1623.101, 10.804, 0.250);
	lawless_REMOVE(playerid, 620, 1908.218, -1622.984, 10.804, 0.250);
	lawless_REMOVE(playerid, 712, 1929.578, -1627.625, 21.390, 0.250);

	lawless_REMOVE(playerid, 5543, 1941.656, -1682.570, 12.476, 0.250);
	lawless_REMOVE(playerid, 5544, 1873.742, -1682.476, 34.796, 0.250);
	lawless_REMOVE(playerid, 1524, 1837.664, -1640.382, 13.757, 0.250);
	lawless_REMOVE(playerid, 620, 1855.718, -1741.539, 10.804, 0.250);
	lawless_REMOVE(playerid, 620, 1879.507, -1741.484, 10.804, 0.250);
	lawless_REMOVE(playerid, 620, 1908.218, -1741.484, 10.804, 0.250);
	lawless_REMOVE(playerid, 1283, 1940.906, -1741.148, 15.601, 0.250);
	lawless_REMOVE(playerid, 712, 1929.578, -1736.906, 21.390, 0.250);
	lawless_REMOVE(playerid, 620, 1931.039, -1726.328, 10.804, 0.250);
	lawless_REMOVE(playerid, 1226, 1945.765, -1716.359, 16.390, 0.250);
	lawless_REMOVE(playerid, 1226, 1825.929, -1697.562, 16.343, 0.250);
	lawless_REMOVE(playerid, 620, 1832.382, -1694.312, 9.718, 0.250);
	lawless_REMOVE(playerid, 1537, 1837.437, -1683.968, 12.304, 0.250);
	lawless_REMOVE(playerid, 1533, 1837.437, -1683.953, 12.304, 0.250);
	lawless_REMOVE(playerid, 1537, 1837.437, -1686.984, 12.312, 0.250);
	lawless_REMOVE(playerid, 1226, 1825.851, -1667.078, 16.343, 0.250);
	lawless_REMOVE(playerid, 620, 1832.898, -1670.765, 9.718, 0.250);
	lawless_REMOVE(playerid, 1533, 1837.437, -1677.921, 12.296, 0.250);
	lawless_REMOVE(playerid, 1537, 1837.437, -1680.953, 12.296, 0.250);
	lawless_REMOVE(playerid, 1533, 1837.437, -1680.937, 12.296, 0.250);
	lawless_REMOVE(playerid, 5408, 1873.742, -1682.476, 34.796, 0.250);
	lawless_REMOVE(playerid, 620, 1931.039, -1702.289, 10.804, 0.250);
	lawless_REMOVE(playerid, 712, 1929.578, -1694.460, 21.390, 0.250);
	lawless_REMOVE(playerid, 620, 1931.039, -1667.031, 10.804, 0.250);
	lawless_REMOVE(playerid, 1226, 1937.554, -1669.890, 16.390, 0.250);
	lawless_REMOVE(playerid, 5441, 1941.656, -1682.570, 12.476, 0.250);
	lawless_REMOVE(playerid, 620, 1931.039, -1637.898, 10.804, 0.250);
	lawless_REMOVE(playerid, 1226, 1945.765, -1635.773, 16.390, 0.250);
	lawless_REMOVE(playerid, 620, 1855.718, -1623.281, 10.804, 0.250);
	lawless_REMOVE(playerid, 620, 1879.507, -1623.101, 10.804, 0.250);
	lawless_REMOVE(playerid, 620, 1908.218, -1622.984, 10.804, 0.250);
	lawless_REMOVE(playerid, 712, 1929.578, -1627.625, 21.390, 0.250);

	/*                        	MAP - SPAWN - END                             */

    /*                        	MAP - BOLNICA                                 */

    lawless_REMOVE(playerid, 5919, 1200.9063, -1337.9922, 12.3984, 0.25);
	lawless_REMOVE(playerid, 5929, 1230.8906, -1337.9844, 12.5391, 0.25);
	lawless_REMOVE(playerid, 5930, 1134.2500, -1338.0781, 23.1563, 0.25);
	lawless_REMOVE(playerid, 739, 1231.1406, -1341.8516, 12.7344, 0.25);
	lawless_REMOVE(playerid, 739, 1231.1406, -1328.0938, 12.7344, 0.25);
	lawless_REMOVE(playerid, 739, 1231.1406, -1356.2109, 12.7344, 0.25);
	lawless_REMOVE(playerid, 5708, 1134.2500, -1338.0781, 23.1563, 0.25);
	lawless_REMOVE(playerid, 617, 1178.6016, -1332.0703, 12.8906, 0.25);
	lawless_REMOVE(playerid, 620, 1184.0078, -1353.5000, 12.5781, 0.25);
	lawless_REMOVE(playerid, 620, 1184.0078, -1343.2656, 12.5781, 0.25);
	lawless_REMOVE(playerid, 618, 1177.7344, -1315.6641, 13.2969, 0.25);
	lawless_REMOVE(playerid, 620, 1184.8125, -1292.9141, 12.5781, 0.25);
	lawless_REMOVE(playerid, 620, 1184.8125, -1303.1484, 12.5781, 0.25);
	lawless_REMOVE(playerid, 1283, 1190.3047, -1389.8047, 15.5000, 0.25);
	lawless_REMOVE(playerid, 1297, 1190.7734, -1383.2734, 15.9453, 0.25);
	lawless_REMOVE(playerid, 1297, 1190.7734, -1350.4141, 15.9453, 0.25);
	lawless_REMOVE(playerid, 1297, 1210.8047, -1367.3828, 15.7734, 0.25);
	lawless_REMOVE(playerid, 620, 1222.6641, -1374.6094, 12.2969, 0.25);
	lawless_REMOVE(playerid, 620, 1222.6641, -1356.5547, 12.2969, 0.25);
	lawless_REMOVE(playerid, 620, 1240.9219, -1374.6094, 12.2969, 0.25);
	lawless_REMOVE(playerid, 620, 1240.9219, -1356.5547, 12.2969, 0.25);
	lawless_REMOVE(playerid, 1297, 1190.7734, -1320.8594, 15.9453, 0.25);
	lawless_REMOVE(playerid, 5794, 1200.9063, -1337.9922, 12.3984, 0.25);
	lawless_REMOVE(playerid, 1297, 1210.8047, -1337.8359, 15.7734, 0.25);
	lawless_REMOVE(playerid, 1297, 1190.7734, -1299.7422, 15.9453, 0.25);
	lawless_REMOVE(playerid, 1283, 1194.7969, -1290.8516, 15.7109, 0.25);
	lawless_REMOVE(playerid, 1297, 1210.8047, -1304.9688, 15.7734, 0.25);
	lawless_REMOVE(playerid, 620, 1222.6641, -1335.0547, 12.2969, 0.25);
	lawless_REMOVE(playerid, 620, 1222.6641, -1317.7422, 12.2969, 0.25);
	lawless_REMOVE(playerid, 5812, 1230.8906, -1337.9844, 12.5391, 0.25);
	lawless_REMOVE(playerid, 620, 1240.9219, -1335.0547, 12.2969, 0.25);
	lawless_REMOVE(playerid, 620, 1240.9219, -1317.7422, 12.2969, 0.25);
	lawless_REMOVE(playerid, 620, 1222.6641, -1300.9219, 12.2969, 0.25);
	lawless_REMOVE(playerid, 620, 1240.9219, -1300.9219, 12.2969, 0.25);

	/*                        	MAP - BOLNICA - END                           */

	/*                        	MAP - AUTO SALON                              */

	lawless_REMOVE(playerid, 4563, 1567.6016, -1248.6953, 102.5234, 0.25);
	lawless_REMOVE(playerid, 4566, 1567.6016, -1248.6953, 102.5234, 0.25);
	lawless_REMOVE(playerid, 4715, 1567.7188, -1248.6953, 102.5234, 0.25);
	lawless_REMOVE(playerid, 4720, 1567.7188, -1248.6953, 102.5234, 0.25);
	lawless_REMOVE(playerid, 1215, 1545.0781, -1284.9844, 16.9531, 0.25);
	lawless_REMOVE(playerid, 1280, 1548.2813, -1284.9766, 16.7891, 0.25);
	lawless_REMOVE(playerid, 1280, 1555.4453, -1284.9141, 16.7891, 0.25);
	lawless_REMOVE(playerid, 1215, 1564.1641, -1284.9297, 16.9531, 0.25);
	lawless_REMOVE(playerid, 1280, 1561.6172, -1284.8359, 16.7891, 0.25);

	lawless_REMOVE(playerid, 5948, 897.6641, -1346.7031, 14.5313, 0.25);
	lawless_REMOVE(playerid, 1297, 895.3047, -1331.8828, 15.6406, 0.25);
	lawless_REMOVE(playerid, 5782, 897.6641, -1346.7031, 14.5313, 0.25);

	/*                        	MAP - AUTO SALON - END                        */
	return true;
}

/*============================================================================*/

public OnPlayerDisconnect(playerid, reason)
{
    if(P_E[playerid][info_registration] == 1)
    {
        new datum[3];
		getdate(datum[0],datum[1],datum[2]);
		
	    P_E[playerid][info_last][0] = datum[0];
	    P_E[playerid][info_last][1] = datum[1];
	    P_E[playerid][info_last][2] = datum[2];
	    P_E[playerid][info_stat] = 0;
	    
	    lawless_saveUser(playerid);
    }
	return true;
}

/*============================================================================*/

public OnPlayerSpawn(playerid)
{
	if(lawless_Hospital[playerid] == 1)
	{
	    lawless_SKIN(playerid,P_E[playerid][info_skin]);
		lawless_LEVEL(playerid,P_E[playerid][info_level]);

		if(P_E[playerid][info_insurance] == 0)
		{
			P_E[playerid][info_cash] -= 100;
			lawless_saveUser(playerid);

			INFO(playerid,"Bili ste na bolnickom lecenju,uspesno ste izleceni i platili ste bolnicke troskove u iznosu od.");
			INFO(playerid,"Troskove lecenja snosite vi posto nemate osiguranje! - (( - $100 ))!");
		}
		else if(P_E[playerid][info_insurance] != 0)
		{
		    P_E[playerid][info_insurance]--;
		    lawless_saveUser(playerid);

            INFO(playerid,"Troskove lecenja snosi vase osiguranje - (( - $100 ))!");
		    INFO(playerid,"Bili ste na bolnickom lecenju,uspesno ste izleceni i platili ste bolnicke troskove u iznosu od.");
			INFO(playerid,"Zbog placanja troskova od strane osiguranja.");
			INFO(playerid,"Oduzeto vam je '1' osiguranje - a preostalo - ['%d']!",P_E[playerid][info_insurance]);
		}

		new rand = random(sizeof(RandomMedicSpawn));
		
		lawless_POSITIONS(playerid,RandomMedicSpawn[rand][0],RandomMedicSpawn[rand][1],RandomMedicSpawn[rand][2]);
		lawless_SKIN(playerid,P_E[playerid][info_skin]);
		SetPlayerFacingAngle(playerid,90);

		lawless_BankMoney(playerid);
		lawless_EuroMoney(playerid);
		
		lawless_COLOR(playerid,0xFFFFFFFF);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		lawless_Hospital[playerid] = 0;
		SetCameraBehindPlayer(playerid);

		lawless_GivePlayerMoney(playerid,P_E[playerid][info_cash]);
    	lawless_SetPlayerWantedLevel(playerid);
    	
    	lawless_PTDH(playerid,death_Data[0][playerid]);
	   	lawless_PTDH(playerid,death_Data[1][playerid]);
	   	lawless_PTDH(playerid,death_Data[2][playerid]);
	   	lawless_PTDH(playerid,death_Data[3][playerid]);
	   	lawless_PTDH(playerid,death_Data[4][playerid]);
	   	lawless_PTDH(playerid,death_Data[5][playerid]);
	   	lawless_PTDH(playerid,death_Data[6][playerid]);
	   	lawless_PTDH(playerid,death_Data[7][playerid]);
	}
	return true;
}

/*============================================================================*/

public OnPlayerDeath(playerid, killerid, reason)
{
    lawless_Hospital[playerid] = 1;
    lawless_BH[playerid] = 0;
    lawless_ANTI_BH[playerid] = 0;
   	
   	lawless_PTDH(playerid,wanted_Data[playerid][1]);
   	lawless_PTDS(playerid,death_Data[0][playerid]);
   	lawless_PTDS(playerid,death_Data[1][playerid]);
   	lawless_PTDS(playerid,death_Data[2][playerid]);
   	lawless_PTDS(playerid,death_Data[3][playerid]);
   	lawless_PTDS(playerid,death_Data[4][playerid]);
   	lawless_PTDS(playerid,death_Data[5][playerid]);
   	lawless_PTDS(playerid,death_Data[6][playerid]);
   	lawless_PTDS(playerid,death_Data[7][playerid]);
   	
   	if(killerid == IPI)
	{
	    if(P_E[playerid][info_wantedlevel] > 0)
	    {
	        new lawless_zlonamere = P_E[playerid][info_wantedlevel] * 1350;
	        
	        P_E[playerid][info_cash] -= lawless_zlonamere;
	        P_E[playerid][info_wantedlevel] = 0;
	        lawless_saveUser(playerid);
	        
	        lawless_GivePlayerMoney(playerid,P_E[playerid][info_cash]);
	        
	        lawless_SetPlayerWantedLevel(playerid);
	        INFO(playerid,"Izvrsili ste samoubistvo,zbog takvog zlonamernog koraka izgubili ste - (( - $%d )).",lawless_zlonamere);
	        INFO(playerid,"Zato sto ste posedovali policijsku poternicu.");
	    }
	}
	return true;
}

/*============================================================================*/

public OnVehicleSpawn(vehicleid)
{
	return true;
}

/*============================================================================*/

public OnVehicleDeath(vehicleid, killerid)
{
	return true;
}

/*============================================================================*/

public OnPlayerText(playerid, text[])
{
    new string[512];
    if(lawless_Logo[playerid] == 0)
    {
		return false;
	}

	if(A_C[anticheat_say] == 0)
	{
		ERROR(playerid,"Onemoguceno je koriscenje 'T' chata!");
		return false;
	}

	if(A_C[anticheat_chat] == 1)
	{
	    if(P_E[playerid][info_admin] == 0)
		{
			if(lawless_Chatined[playerid] == 1)
			{
			    ERROR(playerid,"Chat mozete koristiti svakih '5' sekundi!");
			    return false;
			}
			defer lawless_Chatinineg(playerid);
			lawless_Chatined[playerid] = 1;
		}
	}
	else if(A_C[anticheat_chat] == 0)
	{
		lawless_Chatined[playerid] = 0;
	}

	if(lawless_Chating)
    {
		if(strlen(text) > 80)
	   	{
			new result2[256];
			new string2[128];
			
		   	strmid(result2,text,80,strlen(text));
		   	strdel(text,80,strlen(text));
		   	
			format(string,sizeof(string),"{FFFFFF}%s {FFFFFF}kaze: %s ...",lawless_Nick(playerid),text);
            format(string2,sizeof(string2),"{FFFFFF}... %s",result2);
            
			ProxDetector(10.0,playerid,string,-1,-1,-1,-1,-1);
			ProxDetector(10.0,playerid,string2,-1,-1,-1,-1,-1);
		}
		else
		{
		    format(string,sizeof(string),"{FFFFFF}%s {FFFFFF}kaze: %s",lawless_Nick(playerid),text);
			ProxDetector(10.0,playerid,string,-1,-1,-1,-1,-1);
		}
	}
	return false;
}

/*============================================================================*/

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	/* ORGANISATION - PROVERA ZA ULAZAK U VOZILO */
	return true;
}

/*============================================================================*/

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return true;
}

/*============================================================================*/

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(!lawless_Bicikle(GetVehicleModel(GetPlayerVehicleID(playerid))))
	{
	    if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[0][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[0][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[1][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[1][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[2][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[2][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[3][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[3][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[4][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[4][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[5][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[5][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[6][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[6][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[7][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[7][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[8][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[8][playerid]);
		if(oldstate-1 && newstate) lawless_PTDH(playerid,speedo_Data[9][playerid]);
		else if(newstate == PLAYER_STATE_DRIVER) lawless_PTDS(playerid,speedo_Data[9][playerid]);
		if(newstate == PLAYER_STATE_DRIVER)
		{
		    
		}
	}
	return true;
}

/*============================================================================*/

public OnPlayerEnterCheckpoint(playerid)
{
    if(lawless_GPS_HAVEN[playerid] == 1)
    {
        lawless_GPS_HAVEN[playerid] = 0;
    	DisablePlayerCheckpoint(playerid);

    	INFO(playerid,"Uspesno ste stigli na odabranu lokaciju!");
    	INFO(playerid,"Uspesno vam je ugasen automatski vas gps uredjaj!");
    }
	return true;
}

/*============================================================================*/

public OnPlayerLeaveCheckpoint(playerid)
{
	return true;
}

/*============================================================================*/

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return true;
}

/*============================================================================*/

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return true;
}

/*============================================================================*/

public OnRconCommand(cmd[])
{
	return true;
}

/*============================================================================*/

public OnPlayerRequestSpawn(playerid)
{
	return true;
}

/*============================================================================*/

public OnObjectMoved(objectid)
{
	return true;
}

/*============================================================================*/

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return true;
}

/*============================================================================*/

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return true;
}

/*============================================================================*/

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return true;
}

/*============================================================================*/

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    new string[300];
    
	if((newkeys & KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
    {
    	if(!IsPlayerInRangeOfPoint(playerid,50,1.8366,29.3315,1199.5938))
    	{
			if(lawless_BH[playerid] > 2)
			{
			    if(P_E[playerid][info_admin] == 0)
			    {
				    if(GetPlayerWeapon(playerid) != 34 && GetPlayerWeapon(playerid) != 43)
				    {
	       				if(GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_USEJETPACK)
			        	{
			        	    if(lawless_ANTI_BH[playerid] == 0)
			        	    {
								lawless_ANIMATION(playerid,"GYMNASIUM","gym_jog_falloff",4.1,0,1,1,0,0);
								ERROR(playerid,"Na ovom serveru je zabranjen bunny hop,ne mozete se kretati '3' sekunde!");

								defer lawless_ClearAntiBunnyHop(playerid);
								lawless_FREEZE(playerid,false);
								lawless_ANTI_BH[playerid] = 1;
								return true;
							}
						}
					}
				}
			}
			if(A_C[anticheat_bunnyhop] == 1)
			{
				lawless_BH[playerid]++;
			}
			else if(A_C[anticheat_bunnyhop] == 0)
			{
				lawless_BH[playerid] = 0;
				lawless_ANTI_BH[playerid] = 0;
			}
    	}
    }
    if(newkeys & KEY_JUMP && !(oldkeys & KEY_JUMP) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
	{
		lawless_ANIMATION(playerid,"GYMNASIUM","gym_jog_falloff",4.1,0,1,1,0,0);
	}
    if(newkeys & KEY_SPRINT && !(oldkeys & KEY_SPRINT) && GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_CUFFED)
	{
		lawless_ANIMATION(playerid,"GYMNASIUM","gym_jog_falloff",4.1,0,1,1,0,0);
	}
	if(newkeys == KEY_SECONDARY_ATTACK)
	{
        if(GetPlayerState(playerid) == 1)
		{
			lawless_INTEXT(playerid);
		}
	}
	if(newkeys == KEY_YES)
	{
        if(lawless_ORG_SEF[playerid] == 1)
		{
		    new Float:player_position[3];
		    new orga_id = lawless_ORG_PICKUP[playerid];
			INFO(playerid,"Uspesno ste kreirali sef za organizaciju - [ID - %d].",orga_id);
			
			O_E[orga_id][org_sef] = 1;
			O_E[orga_id][org_sef_position][0] = player_position[0];
   			O_E[orga_id][org_sef_position][1] = player_position[1];
		    O_E[orga_id][org_sef_position][2] = player_position[2];
		    lawless_saveORG(orga_id);
		    
		    format(string,sizeof(string),"{E5FF00}[ORGANISATION - %d - SEF]\n\
			{FFFFFF}ORGANISATION NAME - {FFFFFF}'{E5FF00}%s{FFFFFF}'.\n\
			{E5FF00}'{FFFFFF}Y{E5FF00}'",orga_id,O_E[orga_id][org_name]);
			lawless_organisation_sef_label[orga_id] = lawless_C3D(string,-1,O_E[orga_id][org_sef_position][0],O_E[orga_id][org_sef_position][1],O_E[orga_id][org_sef_position][2],5);
			lawless_organisation_sef_pickup[orga_id] = lawless_CDP(1276,1,O_E[orga_id][org_sef_position][0],O_E[orga_id][org_sef_position][1],O_E[orga_id][org_sef_position][2]);
		 	
            lawless_ORG_SEF[playerid] = 0;
            lawless_ORG_PICKUP[playerid] = -1;
		}
	}
	if(newkeys & KEY_ACTION)
    {
	    if(IsPlayerInAnyVehicle(playerid))
	    {
		    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 481 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 510)
		    {
		    	if(P_E[playerid][info_admin] == 0)
    			{
    			    new Float:player_pos[3];
    			    GetPlayerPos(playerid,player_pos[0],player_pos[1],player_pos[2]);
    			    
			    	ERROR(playerid,"Na ovom serveru je zabranjen bunny hop sa biciklom!");
				    lawless_POSITIONS(playerid,player_pos[0],player_pos[1],player_pos[2]+2);
    			}
		    }
	    }
    }
    if(newkeys & KEY_NO)
    {
	    if(!IsPlayerInAnyVehicle(playerid)) /* AKO NECE OVO JE PROBLEM */
	    {
    		if(lawless_CREATE_VEHS[playerid] == 1)
    		{
    		    new Float:player_position[4];
    		    new id = lawless_CREATE_ORG[playerid];
    		    GetPlayerFacingAngle(playerid,player_position[3]);
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);
				
				O_E[id][org_vehicle_1][0] = player_position[0];
				O_E[id][org_vehicle_1][1] = player_position[1];
				O_E[id][org_vehicle_1][2] = player_position[2];
				O_E[id][org_vehicle_1][3] = player_position[3];
				lawless_saveORG(id);
				
				INFO(playerid,"Nastavite dalje!");
				INFO(playerid,"Uspesno ste dodali vozilo slot '1'!");
				INFO(playerid,"Uradjen je load/save kreiranog vozila - ukoliko dodje do nekog problema!");
				
				O_E[id][org_vehicles_all][0] = CreateVehicle(O_E[id][org_vehicle_slot_1],O_E[id][org_vehicle_1][0],O_E[id][org_vehicle_1][1],O_E[id][org_vehicle_1][2],O_E[id][org_vehicle_1][3],0,0,30000);
				
				format(O_E[id][org_tablice_slot_1],10,""TABLIC_COL"org_%d",id);
				lawless_saveORG(id);
				
				SetVehicleNumberPlate(O_E[id][org_vehicle_slot_1],O_E[id][org_tablice_slot_1]);
				
				lawless_CREATE_VEHS[playerid] = 2;
    		}
    		else if(lawless_CREATE_VEHS[playerid] == 2)
    		{
    		    new Float:player_position[4];
    		    new id = lawless_CREATE_ORG[playerid];
    		    GetPlayerFacingAngle(playerid,player_position[3]);
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);

				O_E[id][org_vehicle_2][0] = player_position[0];
				O_E[id][org_vehicle_2][1] = player_position[1];
				O_E[id][org_vehicle_2][2] = player_position[2];
				O_E[id][org_vehicle_2][3] = player_position[3];
				lawless_saveORG(id);

                INFO(playerid,"Nastavite dalje!");
				INFO(playerid,"Uspesno ste dodali vozilo slot '2'!");
				INFO(playerid,"Uradjen je load/save kreiranog vozila - ukoliko dodje do nekog problema!");

				O_E[id][org_vehicles_all][1] = CreateVehicle(O_E[id][org_vehicle_slot_2],O_E[id][org_vehicle_2][0],O_E[id][org_vehicle_2][1],O_E[id][org_vehicle_2][2],O_E[id][org_vehicle_2][3],0,0,30000);
				
				format(O_E[id][org_tablice_slot_2],10,""TABLIC_COL"org_%d",id);
				lawless_saveORG(id);

				SetVehicleNumberPlate(O_E[id][org_vehicle_slot_2],O_E[id][org_tablice_slot_2]);

				lawless_CREATE_VEHS[playerid] = 3;
    		}
    		else if(lawless_CREATE_VEHS[playerid] == 3)
    		{
    		    new Float:player_position[4];
    		    new id = lawless_CREATE_ORG[playerid];
    		    GetPlayerFacingAngle(playerid,player_position[3]);
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);

				O_E[id][org_vehicle_3][0] = player_position[0];
				O_E[id][org_vehicle_3][1] = player_position[1];
				O_E[id][org_vehicle_3][2] = player_position[2];
				O_E[id][org_vehicle_3][3] = player_position[3];
				lawless_saveORG(id);

                INFO(playerid,"Nastavite dalje!");
				INFO(playerid,"Uspesno ste dodali vozilo slot '3'!");
				INFO(playerid,"Uradjen je load/save kreiranog vozila - ukoliko dodje do nekog problema!");

				O_E[id][org_vehicles_all][2] = CreateVehicle(O_E[id][org_vehicle_slot_3],O_E[id][org_vehicle_3][0],O_E[id][org_vehicle_3][1],O_E[id][org_vehicle_3][2],O_E[id][org_vehicle_3][3],0,0,30000);
				
				format(O_E[id][org_tablice_slot_3],10,""TABLIC_COL"org_%d",id);
				lawless_saveORG(id);

				SetVehicleNumberPlate(O_E[id][org_vehicle_slot_3],O_E[id][org_tablice_slot_3]);

				lawless_CREATE_VEHS[playerid] = 4;
    		}
    		else if(lawless_CREATE_VEHS[playerid] == 4)
    		{
    		    new Float:player_position[4];
    		    new id = lawless_CREATE_ORG[playerid];
    		    GetPlayerFacingAngle(playerid,player_position[3]);
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);

				O_E[id][org_vehicle_4][0] = player_position[0];
				O_E[id][org_vehicle_4][1] = player_position[1];
				O_E[id][org_vehicle_4][2] = player_position[2];
				O_E[id][org_vehicle_4][3] = player_position[3];
				lawless_saveORG(id);

                INFO(playerid,"Nastavite dalje!");
				INFO(playerid,"Uspesno ste dodali vozilo slot '4'!");
				INFO(playerid,"Uradjen je load/save kreiranog vozila - ukoliko dodje do nekog problema!");

				O_E[id][org_vehicles_all][3] = CreateVehicle(O_E[id][org_vehicle_slot_4],O_E[id][org_vehicle_4][0],O_E[id][org_vehicle_4][1],O_E[id][org_vehicle_4][2],O_E[id][org_vehicle_4][3],0,0,30000);
				
				format(O_E[id][org_tablice_slot_4],10,""TABLIC_COL"org_%d",id);
				lawless_saveORG(id);

				SetVehicleNumberPlate(O_E[id][org_vehicle_slot_4],O_E[id][org_tablice_slot_4]);

				lawless_CREATE_VEHS[playerid] = 5;
    		}
    		else if(lawless_CREATE_VEHS[playerid] == 5)
    		{
    		    new Float:player_position[4];
    		    new id = lawless_CREATE_ORG[playerid];
    		    GetPlayerFacingAngle(playerid,player_position[3]);
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);

				O_E[id][org_vehicle_5][0] = player_position[0];
				O_E[id][org_vehicle_5][1] = player_position[1];
				O_E[id][org_vehicle_5][2] = player_position[2];
				O_E[id][org_vehicle_5][3] = player_position[3];
				lawless_saveORG(id);

                INFO(playerid,"Nastavite dalje!");
				INFO(playerid,"Uspesno ste dodali vozilo slot '5'!");
				INFO(playerid,"Uradjen je load/save kreiranog vozila - ukoliko dodje do nekog problema!");

				O_E[id][org_vehicles_all][4] = CreateVehicle(O_E[id][org_vehicle_slot_5],O_E[id][org_vehicle_5][0],O_E[id][org_vehicle_5][1],O_E[id][org_vehicle_5][2],O_E[id][org_vehicle_5][3],0,0,30000);
				
				format(O_E[id][org_tablice_slot_5],10,""TABLIC_COL"org_%d",id);
				lawless_saveORG(id);

				SetVehicleNumberPlate(O_E[id][org_vehicle_slot_5],O_E[id][org_tablice_slot_5]);

				lawless_CREATE_VEHS[playerid] = 6;
    		}
    		else if(lawless_CREATE_VEHS[playerid] == 6)
    		{
    		    new Float:player_position[4];
    		    new id = lawless_CREATE_ORG[playerid];
    		    GetPlayerFacingAngle(playerid,player_position[3]);
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);

				O_E[id][org_vehicle_6][0] = player_position[0];
				O_E[id][org_vehicle_6][1] = player_position[1];
				O_E[id][org_vehicle_6][2] = player_position[2];
				O_E[id][org_vehicle_6][3] = player_position[3];
				lawless_saveORG(id);

                INFO(playerid,"Nastavite dalje!");
				INFO(playerid,"Uspesno ste dodali vozilo slot '6'!");
				INFO(playerid,"Uradjen je load/save kreiranog vozila - ukoliko dodje do nekog problema!");

				O_E[id][org_vehicles_all][5] = CreateVehicle(O_E[id][org_vehicle_slot_6],O_E[id][org_vehicle_6][0],O_E[id][org_vehicle_6][1],O_E[id][org_vehicle_6][2],O_E[id][org_vehicle_6][3],0,0,30000);
				
				format(O_E[id][org_tablice_slot_6],10,""TABLIC_COL"org_%d",id);
				lawless_saveORG(id);

				SetVehicleNumberPlate(O_E[id][org_vehicle_slot_6],O_E[id][org_tablice_slot_6]);

				lawless_CREATE_VEHS[playerid] = 7;
    		}
    		else if(lawless_CREATE_VEHS[playerid] == 7)
    		{
    		    new Float:player_position[4];
    		    new id = lawless_CREATE_ORG[playerid];
    		    GetPlayerFacingAngle(playerid,player_position[3]);
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);

				O_E[id][org_vehicle_7][0] = player_position[0];
				O_E[id][org_vehicle_7][1] = player_position[1];
				O_E[id][org_vehicle_7][2] = player_position[2];
				O_E[id][org_vehicle_7][3] = player_position[3];
				lawless_saveORG(id);

                INFO(playerid,"Nastavite dalje!");
				INFO(playerid,"Uspesno ste dodali vozilo slot '7'!");
				INFO(playerid,"Uradjen je load/save kreiranog vozila - ukoliko dodje do nekog problema!");

				O_E[id][org_vehicles_all][6] = CreateVehicle(O_E[id][org_vehicle_slot_7],O_E[id][org_vehicle_7][0],O_E[id][org_vehicle_7][1],O_E[id][org_vehicle_7][2],O_E[id][org_vehicle_7][3],0,0,30000);
				
				format(O_E[id][org_tablice_slot_7],10,""TABLIC_COL"org_%d",id);
				lawless_saveORG(id);

				SetVehicleNumberPlate(O_E[id][org_vehicle_slot_7],O_E[id][org_tablice_slot_7]);

				lawless_CREATE_VEHS[playerid] = 8;
    		}
    		else if(lawless_CREATE_VEHS[playerid] == 8)
    		{
    		    new Float:player_position[4];
    		    new id = lawless_CREATE_ORG[playerid];
    		    GetPlayerFacingAngle(playerid,player_position[3]);
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);

				O_E[id][org_vehicle_8][0] = player_position[0];
				O_E[id][org_vehicle_8][1] = player_position[1];
				O_E[id][org_vehicle_8][2] = player_position[2];
				O_E[id][org_vehicle_8][3] = player_position[3];
				lawless_saveORG(id);

                INFO(playerid,"Zavrsili ste!");
				INFO(playerid,"Uspesno ste dodali vozilo slot '8'!");
				INFO(playerid,"Uradjen je load/save kreiranog vozila - ukoliko dodje do nekog problema!");

				O_E[id][org_vehicles_all][7] = CreateVehicle(O_E[id][org_vehicle_slot_8],O_E[id][org_vehicle_8][0],O_E[id][org_vehicle_8][1],O_E[id][org_vehicle_8][2],O_E[id][org_vehicle_8][3],0,0,30000);
				
				format(O_E[id][org_tablice_slot_8],10,""TABLIC_COL"org_%d",id);
				lawless_saveORG(id);

				SetVehicleNumberPlate(O_E[id][org_vehicle_slot_8],O_E[id][org_tablice_slot_8]);

				lawless_CREATE_VEHS[playerid] = 0;
				lawless_CREATE_ORG[playerid] = -1;
    			lawless_CREATE_RANKS[playerid] = 0;
			    lawless_EDIT_LEVEL[playerid] = 0;

				lawless_SPD(playerid, lawless_OSEF, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}Kreiraj sef.\n\
				{5D9DB3}>> {FFFFFF}Odustani od kreiranja sefa.",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
    		}
    	}
    }
	return true;
}

/*============================================================================*/

public OnRconLoginAttempt(ip[], password[], success)
{
	if(strfind(password, "%", true) != -1)
    {
        return true;
    }
    if(!success)
	{
	    for(new playerid; playerid < MAX_PLAYERS; playerid++)
   		{
		    if(A_C[anticheat_rcon] == 1)
		    {
		        lawless_Chat(playerid,20);
		        CHEAT(playerid,"Kikovani ste sa servera od strane 'lawless_ANTICHEAT' - Razlog: 'Rcon provala' - code[0].");
		        defer lawless_Kick(playerid);
		        /* LOG IP - NICK */
			}
			else
			{
			    /* IZBACI DA JE POKUSAO DA SE ULOGUJE U RCON PANEL */
			    /* LOG IP - NICK */
			}
		}
	}
	else if(success)
	{
	    /* IZBACI DA JE USPESNO ULOGOVAN U RCON PANEL */
	    /* LOG IP - NICK */
	}
	return true;
}

/*============================================================================*/

public OnPlayerUpdate(playerid)
{
	if(lawless_Logo[playerid] == 1)
	{
		if(A_C[anticheat_joypad] == 1)
		{
		    new ud;
			new lr;
		    new keys;
			GetPlayerKeys(playerid,keys,ud,lr);
			if((ud != 128 && ud != 0 && ud != -128) || (lr != 128 && lr != 0 && lr != -128))
			{
                lawless_Chat(playerid,20);
		        CHEAT(playerid,"Kikovani ste sa servera od strane 'lawless_ANTICHEAT' - Razlog: 'Joypad Hack' - code[1].");
		        defer lawless_Kick(playerid);
				return false;
			}
		}
		if(GetPlayerCameraMode(playerid) == 53)
		{
 			new Float:kLibPos[3];
   			GetPlayerCameraPos(playerid,kLibPos[0],kLibPos[1],kLibPos[2]);
	    	if(kLibPos[2] < -50000.0 || kLibPos[2] > 50000.0)
	    	{
     			lawless_Chat(playerid,20);
      			CHEAT(playerid,"Kikovani ste sa servera od strane 'lawless_ANTICHEAT' - Razlog: 'Weapon Crasher' - code[2].");
      			defer lawless_Kick(playerid);
     			return false;
	    	}
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
			new Float:vec[3];
			new bool:possible_crasher = false;
			GetPlayerCameraFrontVector(playerid,vec[0],vec[1],vec[2]);
			for(new i = 0; !possible_crasher && i < sizeof(vec); i++)
			if(floatabs(vec[i]) > 10.0) possible_crasher = true;
			if(possible_crasher) return false;
		}
	}
	return true;
}

/*============================================================================*/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new string[800];
   	if(dialogid == lawless_REGISTER)
    {
    	if(!response)
    	{
                lawless_Chat(playerid,20);
                defer lawless_Kick(playerid);
                ERROR(playerid,"Kikovani ste zbog odbijanja 'REGISTER'-a.");
            }
            if(response)
            {
                lawless_Chat(playerid,20);
                lawless_COLOR(playerid,0xAFAFAFAA);
				format(string,sizeof(string),"{FFFFFF}Dobrodosli '%s' na {5D9DB3}Lawless {FFFFFF}- {5D9DB3}Gaming {FFFFFF}server.\n\
				{FFFFFF}Posto vam je ovo prvi put na serveru,morate se registrovati.\n\
				{FFFFFF}Registracija se sastoji iz nekoliko klasicnih koraka.\n\
				{FFFFFF}Da zapocnete sa registracijom i zaigrate,{FFFFFF}upisite '{5D9DB3}PASSWORD{FFFFFF}'.",lawless_Nick(playerid));

                if(strlen(inputtext) < 6 || strlen(inputtext) > 14) return lawless_SPD(playerid, lawless_REGISTER, DSP, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
				lawless_String(P_E[playerid][info_password],inputtext);
				INFO(playerid,"Uspesno ste registrovali vas 'password' - '%s'.",inputtext);
				lawless_Password[playerid] = true;
				
				lawless_PTDSS(playerid,registering_Data[18][playerid],inputtext);
			}
		}
		if(dialogid == lawless_SECURITY)
        {
            if(!response)
            {
                lawless_Chat(playerid,20);
                defer lawless_Kick(playerid);
                ERROR(playerid,"Kikovani ste zbog odbijanja 'LOGIN'-a.");
            }
            if(response)
            {
                lawless_Chat(playerid,20);
                lawless_COLOR(playerid,0xAFAFAFAA);
				format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' uspesno ste resili prethodni korak,sada je potrebno sledeci.\n\
				{FFFFFF}Security kod vam sluzi da povratite vas nalog.\n\
				{FFFFFF}Pazite sta upisujete,i slikajte '{5D9DB3}F8{FFFFFF}' kada ukucate.",lawless_Nick(playerid));

                if(strlen(inputtext) < 3 || strlen(inputtext) > 14) return lawless_SPD(playerid, lawless_SECURITY, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz"),ERROR(playerid,"Najmanje mozete koristiti 3, a najvise 14 znakova za security kode!");
				lawless_String(P_E[playerid][info_security],inputtext);
				INFO(playerid,"Uspesno ste registrovali vas 'security' - '%s'.",inputtext);
				lawless_Security[playerid] = true;
				
				lawless_PTDSS(playerid,registering_Data[20][playerid],inputtext);
			}
		}
		if(dialogid == lawless_LOGINER)
        {
            if(!response)
            {
                lawless_Chat(playerid,20);
                defer lawless_Kick(playerid);
                ERROR(playerid,"Kikovani ste zbog odbijanja 'LOGIN'-a.");
            }
            if(response)
            {
                if(!strcmp(inputtext,P_E[playerid][info_password],false))
	  			{
	  			    INI_ParseFile(lawless_UserPath(playerid),"loadAccounts", .bExtra = true, .extra = playerid);

		  		    lawless_Logo[playerid] = 1;
		  		    lawless_BH[playerid] = 0;
		  		    lawless_ANTI_BH[playerid] = 0;
		  		    lawless_COLOR(playerid,0xFFFFFFFF);
		  		    lawless_SPECC(playerid,false);
		  		    lawless_SpawnUser(playerid);

		  		    lawless_Stepens[playerid] = 1;
    				lawless_Bleeding[playerid] = 0;
 		  		}
 		  		else
 		  		{
 		  		    lawless_Chat(playerid,20);
 		  		    lawless_Login[playerid]++;
 		  		    lawless_COLOR(playerid,0xAFAFAFAA);
					format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' dobrodosli nazad na {5D9DB3}Lawless {FFFFFF}- {5D9DB3}Gaming {FFFFFF}server.\n\
					{FFFFFF}Vi posedujete account na nasem serveru.\n\
					{FFFFFF}Sada je potrebno da upisete sifru kako bi se ulogovali.\n\
					{FFFFFF}Za ukucavanje sifre imate '{5D9DB3}30{FFFFFF}' sekundi ili ce te biti kikovani.",lawless_Nick(playerid));
					lawless_SPD(playerid, lawless_LOGINER, DSP, SDIALOG,string,""SERVER_COL"Login",""SERVER_COL"Izlaz");
					ERROR(playerid,"Lozinka koju pokusavate da upisete se ne poklapa sa username - '%s'.",lawless_Nick(playerid));

					if(lawless_Login[playerid] == 3)
					{
                        lawless_Chat(playerid,20);
                        INFO(playerid,"Posto imate postavljen security code,morate ga upisati ako ste zaboravili lozinku kako bi ste pristupili accountu!");
                        INFO(playerid,"Ako pogresite security code,dobijate 'KICK'!");

                        format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' dobrodosli nazad na {5D9DB3}Lawless {FFFFFF}- {5D9DB3}Gaming {FFFFFF}server.\n\
						{FFFFFF}Vi posedujete account na nasem serveru.\n\
						{FFFFFF}Sada je potrebno da upisete security code kako bi se ulogovali.\n\
						{FFFFFF}Za ukucavanje security code imate '{5D9DB3}30{FFFFFF}' sekundi ili ce te biti kikovani.",lawless_Nick(playerid));
						lawless_SPD(playerid, lawless_PASSWORDER, DSP, SDIALOG,string,""SERVER_COL"Login",""SERVER_COL"Izlaz");
					}
 		  		}
			}
		}
		if(dialogid == lawless_GPS)
		{
		    new location_gps;
  			if(!response)
	 		{
				return true;
	 		}
			for(new d; d < 9; d++)
			{
				if(listitem == d)
				{
					location_gps = d;
					break;
				}
			}
			lawless_GPS_HAVEN[playerid] = 1;

			new i = lawless_GPS_USAGE[playerid][location_gps];
			SetPlayerCheckpoint(playerid,G_E[i][gps_position_location][0],G_E[i][gps_position_location][1],G_E[i][gps_position_location][2],3.0);

			INFO(playerid,"Uspesno ste aktivirali vas gps uredjaj!");
			INFO(playerid,"Postavljena vam je lokacija gps uredjaja na radaru - '%s'.",G_E[i][gps_name_location]);
		}
		if(dialogid == lawless_PASSWORDER)
        {
            if(!response)
            {
                lawless_Chat(playerid,20);
                defer lawless_Kick(playerid);
                ERROR(playerid,"Kikovani ste zbog odbijanja 'LOGIN'-a.");
            }
            if(response)
            {
                if(!strcmp(inputtext,P_E[playerid][info_security],false))
	  			{
		  		    lawless_Logo[playerid] = 1;
		  		    lawless_BH[playerid] = 0;
		  		    lawless_ANTI_BH[playerid] = 0;
		  		    lawless_COLOR(playerid,0xFFFFFFFF);
		  		    lawless_SPECC(playerid,false);
		  		    lawless_SpawnUser(playerid);
 		  		}
 		  		else
 		  		{
 		  		    lawless_Chat(playerid,20);
 		  		    ERROR(playerid,"Kikovani ste zbog pogresnog security code-a i pogresne lozinke!");
                    defer lawless_Kick(playerid);
 		  		}
			}
		}
		if(dialogid == lawless_ANTICHEAT)
        {
            if(!response) return true;
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
					    if(A_C[anticheat_save] == 0)
					    {
                            A_C[anticheat_save] = 1;
                            A_C[anticheat_money] = 1;
                            A_C[anticheat_health] = 1;
                            A_C[anticheat_armour] = 1;
                            A_C[anticheat_rcon] = 1;
                            A_C[anticheat_chat] = 1;
                            A_C[anticheat_say] = 1;
                            A_C[anticheat_bunnyhop] = 1;
                            A_C[anticheat_joypad] = 1;
                            A_C[anticheat_weaponcrash] = 1;
                            INFO(playerid,"Uspesno ste upalili 'lawless_ANTICHEAT'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_save] == 1)
						{
						    A_C[anticheat_save] = 0;
						    A_C[anticheat_money] = 0;
                            A_C[anticheat_health] = 0;
                            A_C[anticheat_armour] = 0;
                            A_C[anticheat_rcon] = 0;
                            A_C[anticheat_chat] = 0;
                            A_C[anticheat_say] = 0;
                            A_C[anticheat_bunnyhop] = 0;
                            A_C[anticheat_joypad] = 0;
                            A_C[anticheat_weaponcrash] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'lawless_ANTICHEAT'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 1:
					{
					    if(A_C[anticheat_money] == 0)
					    {
                            A_C[anticheat_money] = 1;
                            INFO(playerid,"Uspesno ste upalili 'lawless_ANTICHEAT_MONEY'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_money] == 1)
						{
						    A_C[anticheat_money] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'lawless_ANTICHEAT_MONEY'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 2:
					{
                        if(A_C[anticheat_health] == 0)
					    {
                            A_C[anticheat_health] = 1;
                            INFO(playerid,"Uspesno ste upalili 'lawless_ANTICHEAT_HEALTH'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_health] == 1)
						{
						    A_C[anticheat_health] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'lawless_ANTICHEAT_HEALTH'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 3:
					{
                        if(A_C[anticheat_armour] == 0)
					    {
                            A_C[anticheat_armour] = 1;
                            INFO(playerid,"Uspesno ste upalili 'lawless_ANTICHEAT_ARMOUR'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_armour] == 1)
						{
						    A_C[anticheat_armour] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'lawless_ANTICHEAT_ARMOUR'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 4:
					{
					    if(A_C[anticheat_rcon] == 0)
					    {
                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_rcon] == 1)
						{
						    A_C[anticheat_rcon] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'lawless_ANTICHEAT_RCON'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 5:
					{
					    if(A_C[anticheat_chat] == 0)
					    {
                            A_C[anticheat_chat] = 1;
                            INFO(playerid,"Uspesno ste upalili 'lawless_ANTICHEAT_CHAT'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_chat] == 1)
						{
						    A_C[anticheat_chat] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'lawless_ANTICHEAT_CHAT'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 6:
					{
					    if(A_C[anticheat_say] == 0)
					    {
                            A_C[anticheat_say] = 1;
                            INFO(playerid,"Uspesno ste upalili 'lawless_SAY'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_say] == 1)
						{
						    A_C[anticheat_say] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'lawless_SAY'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 7:
					{
					    if(A_C[anticheat_bunnyhop] == 0)
					    {
                            A_C[anticheat_bunnyhop] = 1;
                            INFO(playerid,"Uspesno ste upalili 'lawless_BunnyHop'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_bunnyhop] == 1)
						{
						    A_C[anticheat_bunnyhop] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'lawless_BunnyHop'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 8:
					{
					    if(A_C[anticheat_joypad] == 0)
					    {
                            A_C[anticheat_joypad] = 1;
                            INFO(playerid,"Uspesno ste upalili 'anticheat_joypad'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_joypad] == 1)
						{
						    A_C[anticheat_joypad] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'anticheat_joypad'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
					case 9:
					{
					    if(A_C[anticheat_weaponcrash] == 0)
					    {
                            A_C[anticheat_weaponcrash] = 1;
                            INFO(playerid,"Uspesno ste upalili 'anticheat_weaponcrash'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					    }
					    else if(A_C[anticheat_weaponcrash] == 1)
						{
						    A_C[anticheat_weaponcrash] = 0;
                            INFO(playerid,"Uspesno ste ugasili 'anticheat_weaponcrash'.");
                            lawless_saveAC();

                            new protekcija[40];
						    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija1[40];
						    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija2[40];
						    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija3[40];
						    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija4[40];
						    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija5[40];
						    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija6[40];
						    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija7[40];
						    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija8[40];
						    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
						    new protekcija9[40];
						    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

							format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
							{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
							{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
							protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
							lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
						}
					}
				}
			}
		}
		if(dialogid == lawless_CODE)
        {
            if(!response)
            {
                lawless_Chat(playerid,20);
                defer lawless_Kick(playerid);
                ERROR(playerid,"Kikovani ste zbog odbijanja 'law_adm' - login'-a.");
            }
            if(response)
            {
                if(strval(inputtext) == P_E[playerid][info_acode])
	  			{
		  		    INFO(playerid,"Uspesno ste se ulogovali u 'law_adm' system!");
 		  		}
 		  		else
 		  		{
 		  		    lawless_Chat(playerid,20);
 		  		    ERROR(playerid,"Kikovani ste zbog pogresnog 'law_adm' code-a!");
 		  		    /* OBAVESTENJE DEVELOPERIMA/OWNERIMA I LOG FILE */
                    defer lawless_Kick(playerid);
 		  		}
			}
		}
		if(dialogid == lawless_GODINE)
        {
            if(!response) return lawless_Chat(playerid,20),defer lawless_Kick(playerid),ERROR(playerid,"Kikovani ste zbog odbijanja 'REGISTER'-a.");

            new year;
			year = strval(inputtext);

            if(year < 7 || year > 60)
			{
				lawless_Chat(playerid,20);
				format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' uspesno ste resili prethodni korak,sada je potrebno sledeci.\n\
				{FFFFFF}Morate upisati '{5D9DB3}GODINE{FFFFFF}' za vaseg lika.\n\
				{FFFFFF}Pazite kada ukucavate godine,gledajte sto realnije.",lawless_Nick(playerid));
				lawless_SPD(playerid, lawless_GODINE, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
				ERROR(playerid,"Najmanje mozete imati 7,a najvise 60 godina!");
				return true;
			}
  		 	lawless_Chat(playerid,20);
			P_E[playerid][info_godine] = year;
			INFO(playerid,"Uspesno ste registrovali vase 'godine' - '%d'.",strval(inputtext));
			lawless_Godine[playerid] = true;
			
			format(string,sizeof(string),"%d",strval(inputtext));
			lawless_PTDSS(playerid,registering_Data[22][playerid],string);
			return true;
		}
		if(dialogid == lawless_POL)
        {
            if(!response)
            {
                lawless_Chat(playerid,20);
                defer lawless_Kick(playerid);
                ERROR(playerid,"Kikovani ste zbog odbijanja 'REGISTER'-a.");
            }
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
					    P_E[playerid][info_skin] = 2;
					    P_E[playerid][info_pol] = 1;
					    INFO(playerid,"Uspesno ste registrovali vas 'pol' - 'Musko'.");
					    lawless_Pol[playerid] = true;
					    
					    lawless_PTDSS(playerid,registering_Data[23][playerid],"Musko");
					}
					case 1:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
					    P_E[playerid][info_skin] = 12;
					    P_E[playerid][info_pol] = 2;
					    INFO(playerid,"Uspesno ste registrovali vas 'pol' - 'Zensko'.");
					    lawless_Pol[playerid] = true;
					    
					    lawless_PTDSS(playerid,registering_Data[23][playerid],"Zensko");
					}
				}
			}
		}
		if(dialogid == lawless_IMOVINA)
        {
            if(!response) return true;
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
                        lawless_SPD(playerid, lawless_SALONS, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}Postavi vozila na prodaju.\n\
						{5D9DB3}>> {FFFFFF}Skini vozila sa prodaje.\n\
						{5D9DB3}>> {FFFFFF}Proveri vozila na prodaju.\n\
						{5D9DB3}>> {FFFFFF}Kupovina vozila u salonu.",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
					}
				}
			}
		}
		if(dialogid == lawless_ASTS)
        {
            if(!response) return true;
            if(response)
            {
            	switch(listitem)
  				{
					case 0:
					{
					    lawless_SPD(playerid, lawless_OCHECK, DSI, SDIALOG,"{FFFFFF}Ukucajte 'ID',kako bi ste proverili organizaciju!",""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
					}
					case 1:
					{
					    lawless_SPD(playerid, lawless_OLEVEL, DSI, SDIALOG,"{FFFFFF}Ukucajte 'ID',kako bi ste postavili level organizacije!",""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
					}
					case 2:
					{
					    strdel(string,0,sizeof(string));

					    for(new i = 1; i < MAX_ORG; i++)
						{
						    new org_string[712];
							new org_filess[40];
							format(org_filess,sizeof(org_filess),ORGS,i);
							if(fexist(org_filess))
							{
		                        format(org_string,sizeof(org_string),"{5D9DB3}>> {FFFFFF}[ID - %d] - '%s'.\n",O_E[i][org_id],O_E[i][org_name]);
			                	strcat(string,org_string);
							}
						}
					    lawless_SPD(playerid, lawless_ORINFO, DSL, SDIALOG,string,""SERVER_COL"Izlaz","");
					    strdel(string,0,sizeof(string));
					}
					case 3:
					{
					    foreach(Player,i)
						{
						    if(lawless_Logo[i] == 1)
						    {
						        lawless_saveUser(i);
						    }
						}
						INFO(playerid,"Svi korisnicki racuni su uspesno primorano sacuvani!");
					}
					case 4:
					{
						format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' upisite 'ID/Ime_Prezime' igraca,\n\
						{FFFFFF}kojeg zelite proveriti '{5D9DB3}OFFLINE{FFFFFF}'.",lawless_Nick(playerid));
                		lawless_SPD(playerid, lawless_OFFCHEC, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
					}
					case 5:
					{
						if(A_C[anticheat_register] == 0)
					    {
                            A_C[anticheat_register] = 1;
                            INFO(playerid,"Uspesno ste ugasili registraciju na server.");
                            lawless_saveAC();
                        }
                        else if(A_C[anticheat_register] == 1)
					    {
                            A_C[anticheat_register] = 0;
                            INFO(playerid,"Uspesno ste upalili registraciju na server.");
                            lawless_saveAC();
                        }
					}
				}
			}
		}
 		if(dialogid == lawless_OFFCHEC)
        {
            if(!response) return true;
            if(response)
            {
                new lawless_acc_file[64];
                new lawless_offline_name[24];
                new lawless_name[MAX_PLAYER_NAME];

                format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' upisite 'ID/Ime_Prezime' igraca,\n\
				{FFFFFF}kojeg zelite proveriti '{5D9DB3}OFFLINE{FFFFFF}'.",lawless_Nick(playerid));

                if(sscanf(inputtext,"s[24]",lawless_offline_name)) return lawless_SPD(playerid, lawless_OFFCHEC, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
                format(lawless_acc_file,sizeof(lawless_acc_file),PATH,lawless_offline_name);
				if(!fexist(lawless_acc_file)) return ERROR(playerid,"Korisnicki racun '%s' ne postoji u bazi podataka!",lawless_offline_name);

				for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    if(lawless_Logo[i] == 1)
				    {
				        GetPlayerName(i,lawless_name,sizeof(lawless_name));
				        if(!strcmp(lawless_name,lawless_offline_name,true))
				        {
				            return ERROR(playerid,"Taj igrac je online - kikuj/banuj ga prvo!");
				        }
				    }
				}

				INI_ParseFile(lawless_acc_file,"loadOffline");

				format(string,sizeof(string),"{FFFFFF}Ime_Prezime - '{5D9DB3}%s{FFFFFF}'.\n{FFFFFF}Pol - '{5D9DB3}%d{FFFFFF}'.\n\
				{FFFFFF}Godine - '{5D9DB3}%d{FFFFFF}'.\n{FFFFFF}Drzava - '{5D9DB3}%d{FFFFFF}'.\n{FFFFFF}Lozinka - '{5D9DB3}%s{FFFFFF}'.\n\
				{FFFFFF}E-mail - '{5D9DB3}%s{FFFFFF}'.\n{FFFFFF}Konekcija - '{5D9DB3}%d/%d/%d{FFFFFF}'.\n{FFFFFF}[1]Vozilo - '{5D9DB3}%d{FFFFFF}'.\n\
				{FFFFFF}[2]Vozilo - '{5D9DB3}%d{FFFFFF}'.\n{FFFFFF}[3]Vozilo - '{5D9DB3}%d{FFFFFF}'.\n{FFFFFF}[4]Vozilo - '{5D9DB3}%d{FFFFFF}'.",
				lawless_offline_name,F_E[offline_pol],F_E[offline_godine],F_E[offline_drzava],
				F_E[offline_password],F_E[offline_drzava][0],F_E[offline_drzava][1],F_E[offline_drzava][2],F_E[offline_vehicles][0],F_E[offline_vehicles][1],F_E[offline_vehicles][2],F_E[offline_vehicles][3]);
                lawless_SPD(playerid, lawless_OFFKEK, DSM, SDIALOG,string,""SERVER_COL"Izlaz","");
            }
        }
		if(dialogid == lawless_OLEVEL)
        {
            if(!response) return true;
            if(response)
            {
                new id_org;
                new haved_file[40];
                if(sscanf(inputtext,"i",id_org)) return lawless_SPD(playerid, lawless_OLEVEL, DSI, SDIALOG,"{FFFFFF}Ukucajte 'ID',kako bi ste postavili level organizacije!",""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");

	    		format(haved_file,sizeof(haved_file),ORGS,id_org);
	    		if(!fexist(haved_file)) return ERROR(playerid,"Organizacija sa tim 'ID-om' ne postoji!");

                lawless_EDIT_LEVEL[playerid] = id_org;
	    		lawless_SPD(playerid, lawless_HLEVEL, DSI, SDIALOG,"{FFFFFF}Ukucajte 'LEVEL',kako bi ste postavili level organizacije!",""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
            }
        }
        if(dialogid == lawless_HLEVEL)
        {
            if(!response) return true;
            if(response)
            {
                new level;
                new id = lawless_EDIT_LEVEL[playerid];
                if(sscanf(inputtext,"i",level)) return lawless_SPD(playerid, lawless_HLEVEL, DSI, SDIALOG,"{FFFFFF}Ukucajte 'LEVEL',kako bi ste postavili level organizacije!",""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
                if(level < 1 || level > 10) return ERROR(playerid,"Organizacioni level ne moze biti manji od - '1lvl' niti veci od - '10lvl'.");

                O_E[id][org_level] = level;
                lawless_saveORG(id);

                INFO(playerid,"Uspesno ste postavili level organizacije!");
			}
        }
		if(dialogid == lawless_SALONS)
        {
            if(!response) return true;
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
					    new salon = P_E[playerid][info_vehsalon];
					    if(IsPlayerInRangeOfPoint(playerid,1.0,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2]))
					    {
					        if(A_E[salon][salon_vehicle][0] != 9999 && A_E[salon][salon_vehicle][1] != 9999 && A_E[salon][salon_vehicle][2] != 9999 && A_E[salon][salon_vehicle][3] != 9999 && A_E[salon][salon_vehicle][4] != 9999) return ERROR(playerid,"Auto salon vam je popunjen sa vozilima!");

        					lawless_SPD(playerid, lawless_MODELE, DSI, SDIALOG,"{FFFFFF}Ukucajte 'ID' modela, i koliko modela zelite da bude na prodaju!",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
						}
						else return ERROR(playerid,"Morate biti blizu vaseg auto salona!");
					}
					case 1:
					{
					    new salon = P_E[playerid][info_vehsalon];
					    if(IsPlayerInRangeOfPoint(playerid,1.0,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2]))
					    {
						    lawless_SPD(playerid, lawless_VOZILA, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}SLOT - 1.\n\
							{5D9DB3}>> {FFFFFF}SLOT - 2.\n\
							{5D9DB3}>> {FFFFFF}SLOT - 3.\n\
							{5D9DB3}>> {FFFFFF}SLOT - 4.\n\
							{5D9DB3}>> {FFFFFF}SLOT - 5.",""SERVER_COL"Skini",""SERVER_COL"Izlaz");
						}
						else return ERROR(playerid,"Morate biti blizu vaseg auto salona!");
					}
					case 2:
					{
					    new salon = P_E[playerid][info_vehsalon];
					    if(IsPlayerInRangeOfPoint(playerid,1.0,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2]))
					    {
	                        new lawless_sellvehicles[300];
	                        new lawless_sellvehicless[300];
	                        new lawless_sellvehiclesss[300];
	                        new lawless_sellvehiclessss[300];
	                        new lawless_sellvehiclesssss[300];

	                        new slotina_1[20];
	                        new salon_vehicle1 = A_E[salon][salon_vehicle][0];
	                        if(salon_vehicle1 != 9999)
							{
							    lawless_String(slotina_1,lawless_Vozilica(A_E[salon][salon_vehicle][0]));
							}
							else if(salon_vehicle1 == 9999)
							{
								lawless_String(slotina_1,"Nema");
							}

							new slotina_2[20];
	                        new salon_vehicle2 = A_E[salon][salon_vehicle][1];
	                        if(salon_vehicle2 != 9999)
							{
							    lawless_String(slotina_2,lawless_Vozilica(A_E[salon][salon_vehicle][1]));
							}
							else if(salon_vehicle2 == 9999)
							{
								lawless_String(slotina_2,"Nema");
							}

							new slotina_3[20];
	                        new salon_vehicle3 = A_E[salon][salon_vehicle][2];
	                        if(salon_vehicle3 != 9999)
							{
							    lawless_String(slotina_3,lawless_Vozilica(A_E[salon][salon_vehicle][2]));
							}
							else if(salon_vehicle3 == 9999)
							{
								lawless_String(slotina_3,"Nema");
							}

							new slotina_4[20];
	                        new salon_vehicle4 = A_E[salon][salon_vehicle][3];
	                        if(salon_vehicle4 != 9999)
							{
							    lawless_String(slotina_4,lawless_Vozilica(A_E[salon][salon_vehicle][3]));
							}
							else if(salon_vehicle4 == 9999)
							{
								lawless_String(slotina_4,"Nema");
							}

							new slotina_5[20];
	                        new salon_vehicle5 = A_E[salon][salon_vehicle][4];
	                        if(salon_vehicle5 != 9999)
							{
							    lawless_String(slotina_5,lawless_Vozilica(A_E[salon][salon_vehicle][4]));
							}
							else if(salon_vehicle5 == 9999)
							{
								lawless_String(slotina_5,"Nema");
							}

					        format(lawless_sellvehicles,sizeof(lawless_sellvehicles),"{5D9DB3}[%s_SLOT_1]: {FFFFFF}Vozilo - %s - Cena vozila - $%d - Kolicina na prodaju - %d.",A_E[salon][salon_name],slotina_1,A_E[salon][salon_modelprice][0],A_E[salon][salon_maxmodels][0]);
                            lawless_SCM(playerid,-1,lawless_sellvehicles);
							format(lawless_sellvehicless,sizeof(lawless_sellvehicless),"{5D9DB3}[%s_SLOT_2]: {FFFFFF}Vozilo - %s - Cena vozila - $%d - Kolicina na prodaju - %d.",A_E[salon][salon_name],slotina_2,A_E[salon][salon_modelprice][1],A_E[salon][salon_maxmodels][1]);
                            lawless_SCM(playerid,-1,lawless_sellvehicless);
							format(lawless_sellvehiclesss,sizeof(lawless_sellvehiclesss),"{5D9DB3}[%s_SLOT_3]: {FFFFFF}Vozilo - %s - Cena vozila - $%d - Kolicina na prodaju - %d.",A_E[salon][salon_name],slotina_3,A_E[salon][salon_modelprice][2],A_E[salon][salon_maxmodels][2]);
                            lawless_SCM(playerid,-1,lawless_sellvehiclesss);
							format(lawless_sellvehiclessss,sizeof(lawless_sellvehiclessss),"{5D9DB3}[%s_SLOT_4]: {FFFFFF}Vozilo - %s - Cena vozila - $%d - Kolicina na prodaju - %d.",A_E[salon][salon_name],slotina_4,A_E[salon][salon_modelprice][3],A_E[salon][salon_maxmodels][3]);
                            lawless_SCM(playerid,-1,lawless_sellvehiclessss);
							format(lawless_sellvehiclesssss,sizeof(lawless_sellvehiclesssss),"{5D9DB3}[%s_SLOT_5]: {FFFFFF}Vozilo - %s - Cena vozila - $%d - Kolicina na prodaju - %d.",A_E[salon][salon_name],slotina_5,A_E[salon][salon_modelprice][4],A_E[salon][salon_maxmodels][4]);
                            lawless_SCM(playerid,-1,lawless_sellvehiclesssss);
						}
						else return ERROR(playerid,"Morate biti blizu vaseg auto salona!");
					}
					case 3:
					{
					    new salon = P_E[playerid][info_vehsalon];
					    if(A_E[salon][salon_buy] == 0)
						{
						    A_E[salon][salon_buy] = 1;
						    lawless_saveSALON(salon);
						    lawless_updateSALON(salon);

						    INFO(playerid,"Uspesno ste omogucili kupovinu vozila u vasem auto salonu!");
						}
					    else if(A_E[salon][salon_buy] == 1)
						{
						    A_E[salon][salon_buy] = 0;
						    lawless_saveSALON(salon);
						    lawless_updateSALON(salon);

						    INFO(playerid,"Uspesno ste onemogucili kupovinu vozila u vasem auto salonu!");
						}
					}
				}
			}
		}
		if(dialogid == lawless_OSEF)
        {
            if(!response) return true;
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
						INFO(playerid,"Vi zelite da kreirate sef za organizaciju - [ID - %d].",lawless_ORG_PICKUP[playerid]);
						INFO(playerid,"Da kreirate sef,otidjite na mesto koje zelite i pritisnite dugme na tastaturi - 'Y'!");
						lawless_ORG_SEF[playerid] = 1;
					}
					case 1:
					{
					    O_E[lawless_ORG_SEF[playerid]][org_cash] = 0;
					    O_E[lawless_ORG_SEF[playerid]][org_sef] = 0;
					    O_E[lawless_ORG_SEF[playerid]][org_drugs] = 0;
					    O_E[lawless_ORG_SEF[playerid]][org_materials] = 0;
					    O_E[lawless_ORG_SEF[playerid]][org_sef_position][0] = 0.0;
					    O_E[lawless_ORG_SEF[playerid]][org_sef_position][1] = 0.0;
					    O_E[lawless_ORG_SEF[playerid]][org_sef_position][2] = 0.0;
					    lawless_saveORG(lawless_ORG_SEF[playerid]);
					    
					    INFO(playerid,"Odustali ste od kreiranja organizacijskog sefa!");
					}
				}
			}
		}
		if(dialogid == lawless_VOZILA)
        {
            if(!response) return true;
            if(response)
            {
                new salon = P_E[playerid][info_vehsalon];
            	switch(listitem)
  				{
				    case 0:
					{
					    if(A_E[salon][salon_vehicle][0] == 9999) return ERROR(playerid,"Ovaj slot je vec prazan!");
					    A_E[salon][salon_vehicle][0] = 9999;
						A_E[salon][salon_modelprice][0] = 0;
						A_E[salon][salon_maxmodels][0] = 0;

					    INFO(playerid,"Uspesno je uklonjeno vozilo iz prodaje sa 'SLOT - 1'.");
					    INFO(playerid,"Sada vam je 'SLOT - 1' slobodan da dodate vozilo!");
					    lawless_saveSALON(salon);
					}
					case 1:
					{
					    if(A_E[salon][salon_vehicle][1] == 9999) return ERROR(playerid,"Ovaj slot je vec prazan!");
                        A_E[salon][salon_vehicle][1] = 9999;
						A_E[salon][salon_modelprice][1] = 0;
						A_E[salon][salon_maxmodels][1] = 0;

					    INFO(playerid,"Uspesno je uklonjeno vozilo iz prodaje sa 'SLOT - 2'.");
					    INFO(playerid,"Sada vam je 'SLOT - 2' slobodan da dodate vozilo!");
					    lawless_saveSALON(salon);
					}
					case 2:
					{
					    if(A_E[salon][salon_vehicle][2] == 9999) return ERROR(playerid,"Ovaj slot je vec prazan!");
                        A_E[salon][salon_vehicle][2] = 9999;
						A_E[salon][salon_modelprice][2] = 0;
						A_E[salon][salon_maxmodels][2] = 0;

					    INFO(playerid,"Uspesno je uklonjeno vozilo iz prodaje sa 'SLOT - 3'.");
					    INFO(playerid,"Sada vam je 'SLOT - 3' slobodan da dodate vozilo!");
					    lawless_saveSALON(salon);
					}
					case 3:
					{
					    if(A_E[salon][salon_vehicle][3] == 9999) return ERROR(playerid,"Ovaj slot je vec prazan!");
                        A_E[salon][salon_vehicle][3] = 9999;
						A_E[salon][salon_modelprice][3] = 0;
						A_E[salon][salon_maxmodels][3] = 0;

					    INFO(playerid,"Uspesno je uklonjeno vozilo iz prodaje sa 'SLOT - 4'.");
					    INFO(playerid,"Sada vam je 'SLOT - 4' slobodan da dodate vozilo!");
					    lawless_saveSALON(salon);
					}
					case 4:
					{
						if(A_E[salon][salon_vehicle][4] == 9999) return ERROR(playerid,"Ovaj slot je vec prazan!");
                        A_E[salon][salon_vehicle][4] = 9999;
						A_E[salon][salon_modelprice][4] = 0;
						A_E[salon][salon_maxmodels][4] = 0;

					    INFO(playerid,"Uspesno je uklonjeno vozilo iz prodaje sa 'SLOT - 5'.");
					    INFO(playerid,"Sada vam je 'SLOT - 5' slobodan da dodate vozilo!");
					    lawless_saveSALON(salon);
					}
				}
			}
		}
		if(dialogid == lawless_MODELE)
        {
            if(!response) return true;
            if(response)
            {
                new model;
                new price;
                new salon = P_E[playerid][info_vehsalon];
                new rand = 500000 + random(50000);
                if(sscanf(inputtext,"ii",model,price)) return lawless_SPD(playerid, lawless_MODELE, DSI, SDIALOG,"{FFFFFF}Ukucajte 'ID' modela, i koliko modela zelite da bude na prodaju!",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
                if(model < 400 || model > 611) return ERROR(playerid,"Ne mozes to!");
				if(price < 1 || price > 10) return ERROR(playerid,"Ne mozes to!");

				if(model == 406) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 407) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 408) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 416) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 417) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 425) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 427) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 430) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 432) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 435) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 444) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 446) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 447) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 449) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 450) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 452) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 453) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 454) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 460) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 464) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 465) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 469) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 472) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 473) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 476) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 484) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 485) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 486) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 487) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 488) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 490) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 493) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 497) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 501) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 511) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 512) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 513) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 519) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 520) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 523) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 524) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 525) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 528) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 530) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 532) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 537) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 538) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 539) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 544) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 548) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 553) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 556) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 557) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 563) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 564) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 569) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 570) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 572) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 574) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 577) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 583) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 584) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 590) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 591) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 592) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 593) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 594) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 595) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 596) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 597) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 598) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 599) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 601) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 606) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 607) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 608) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 610) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");
				if(model == 611) return ERROR(playerid,"Taj model vozila ne mozete prodavati!");

				if(A_E[salon][salon_vehicle][0] == 9999)
				{
					A_E[salon][salon_vehicle][0] = model;
					A_E[salon][salon_modelprice][0] = rand;
					A_E[salon][salon_maxmodels][0] = price;

					INFO(playerid,"Uspesno ste popunili slot - 'ID: 1' - info.");
					INFO(playerid,"Uspesno ste dodali model u auto salon - '%d':('%s') - '$%d' - 'maxmodels: %d'.",model,lawless_Vozilica(model),rand,price);
					lawless_saveSALON(salon);
				}
                else if(A_E[salon][salon_vehicle][1] == 9999)
				{
					A_E[salon][salon_vehicle][1] = model;
					A_E[salon][salon_modelprice][1] = rand;
					A_E[salon][salon_maxmodels][1] = price;

					INFO(playerid,"Uspesno ste popunili slot - 'ID: 2' - info.");
					INFO(playerid,"Uspesno ste dodali model u auto salon - '%d':('%s') - '$%d' - 'maxmodels: %d'.",model,lawless_Vozilica(model),rand,price);
					lawless_saveSALON(salon);
				}
                else if(A_E[salon][salon_vehicle][2] == 9999)
                {
					A_E[salon][salon_vehicle][2] = model;
					A_E[salon][salon_modelprice][2] = rand;
					A_E[salon][salon_maxmodels][2] = price;

					INFO(playerid,"Uspesno ste popunili slot - 'ID: 3' - info.");
					INFO(playerid,"Uspesno ste dodali model u auto salon - '%d':('%s') - '$%d' - 'maxmodels: %d'.",model,lawless_Vozilica(model),rand,price);
					lawless_saveSALON(salon);
				}
                else if(A_E[salon][salon_vehicle][3] == 9999)
				{
					A_E[salon][salon_vehicle][3] = model;
					A_E[salon][salon_modelprice][3] = rand;
					A_E[salon][salon_maxmodels][3] = price;

					INFO(playerid,"Uspesno ste popunili slot - 'ID: 4' - info.");
					INFO(playerid,"Uspesno ste dodali model u auto salon - '%d':('%s') - '$%d' - 'maxmodels: %d'.",model,lawless_Vozilica(model),rand,price);
					lawless_saveSALON(salon);
				}
                else if(A_E[salon][salon_vehicle][4] == 9999)
				{
					A_E[salon][salon_vehicle][4] = model;
					A_E[salon][salon_modelprice][4] = rand;
					A_E[salon][salon_maxmodels][4] = price;

					INFO(playerid,"Uspesno ste popunili slot - 'ID: 5' - info.");
					INFO(playerid,"Uspesno ste dodali model u auto salon - '%d':('%s') - '$%d' - 'maxmodels: %d'.",model,lawless_Vozilica(model),rand,price);
					lawless_saveSALON(salon);
				}
			}
        }
        if(dialogid == lawless_OVEHICLE)
        {
            if(!response) return true;
            if(response)
            {
                new model;
    			new id = lawless_CREATE_ORG[playerid];

                if(sscanf(inputtext,"ii",model)) return lawless_SPD(playerid, lawless_OVEHICLE, DSI, SDIALOG,"{FFFFFF}Ukucajte 'ID' modela za organizacijska vozila!",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
                if(model < 400 || model > 611) return ERROR(playerid,"Ne mozes to!");

				if(model == 606) return ERROR(playerid,"Taj model vozila ne mozete koristiti kao organizacijsko vozilo!");
				if(model == 607) return ERROR(playerid,"Taj model vozila ne mozete koristiti kao organizacijsko vozilo!");
				if(model == 608) return ERROR(playerid,"Taj model vozila ne mozete koristiti kao organizacijsko vozilo!");
				if(model == 610) return ERROR(playerid,"Taj model vozila ne mozete koristiti kao organizacijsko vozilo!");
				if(model == 611) return ERROR(playerid,"Taj model vozila ne mozete koristiti kao organizacijsko vozilo!");

				O_E[id][org_vehicle_slot_1] = model;
				O_E[id][org_vehicle_slot_2] = model;
				O_E[id][org_vehicle_slot_3] = model;
				O_E[id][org_vehicle_slot_4] = model;
				O_E[id][org_vehicle_slot_5] = model;
				O_E[id][org_vehicle_slot_6] = model;
				O_E[id][org_vehicle_slot_7] = model;
				O_E[id][org_vehicle_slot_8] = model;

				O_E[id][org_vehicles_created][0] = 1;
				O_E[id][org_vehicles_created][1] = 1;
				O_E[id][org_vehicles_created][2] = 1;
				O_E[id][org_vehicles_created][3] = 1;
				O_E[id][org_vehicles_created][4] = 1;
				O_E[id][org_vehicles_created][5] = 1;
				O_E[id][org_vehicles_created][6] = 1;
				O_E[id][org_vehicles_created][7] = 1;
				
				lawless_saveORG(id);
				
				lawless_CREATE_VEHS[playerid] = 1;
			    
			    INFO(playerid,"Model '%d' - ce se koristiti za kreiranje!",model);
			    INFO(playerid,"Posto ste upisali model vozila sada idite da postavljate vozila!");
			    INFO(playerid,"Otidjite na odredjeno mesto gde zelite da postavite i stisnite gumb 'N'!");
			}
        }
        if(dialogid == lawless_OCHECK)
        {
            if(!response) return true;
            if(response)
            {
                new id_org;
                new haved_file[40];
                if(sscanf(inputtext,"i",id_org)) return lawless_SPD(playerid, lawless_OCHECK, DSI, SDIALOG,"{FFFFFF}Ukucajte 'ID',kako bi ste proverili organizaciju!",""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");

	    		format(haved_file,sizeof(haved_file),ORGS,id_org);
	    		if(!fexist(haved_file)) return ERROR(playerid,"Organizacija sa tim 'ID-om' ne postoji!");

	    		format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}[ID - %d] || {5D9DB3}%s{FFFFFF}.\n\
	    		{5D9DB3}>> {FFFFFF}Maximalno dozvoljenih clanova - '{5D9DB3}%d{FFFFFF}'.\n\
	    		{5D9DB3}>> {FFFFFF}Potreban level za ulazak - '{5D9DB3}%d{FFFFFF}'.\n\
				{5D9DB3}>> {FFFFFF}Ubacenih clanova u organizaciju - '{5D9DB3}%d{FFFFFF}'.\n\n\
				{5D9DB3}_ | LEADER - LIST | _\n{5D9DB3}>> {FFFFFF}%s. || %s.",O_E[id_org][org_id],O_E[id_org][org_name],O_E[id_org][org_maxmembers],O_E[id_org][org_level],
				O_E[id_org][org_invitemembers],O_E[id_org][org_leader_1],O_E[id_org][org_leader_2]);
	    		lawless_SPD(playerid, lawless_OINFO, DSM, SDIALOG,string,""SERVER_COL"Izlaz","");
            }
        }
        if(dialogid == lawless_CGPS)
        {
            if(!response) return true;
            if(response)
            {
                new Float:player_position[3];
				new id_gps = lawless_createGPS();

				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);
				if(strlen(inputtext) > 0)
	        	{
	        	    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Dok ste u vozilu ne mozete kreirati!");

					if(id_gps > MAX_GPS) return ERROR(playerid,"Vec je kreirano '%d' gps lokacija!",MAX_GPS);

                    G_E[id_gps][gps_id] = id_gps;
                    G_E[id_gps][gps_position_location][0] = player_position[0];
                    G_E[id_gps][gps_position_location][1] = player_position[1];
                    G_E[id_gps][gps_position_location][2] = player_position[2];
                    lawless_String(G_E[id_gps][gps_name_location],inputtext);

                    lawless_maxgpsovs++;
					lawless_saveGPS(id_gps);

					INFO(playerid,"Uspesno ste kreirali 'GPS lokaciju'.");
					INFO(playerid,"GPS lokacija info - '%s' - ('ID - %d').",G_E[id_gps][gps_name_location],id_gps);
	        	}
			}
        }
        if(dialogid == lawless_LABEL)
        {
            if(!response) return true;
            if(response)
            {
                new Float:player_position[3];
				new label_id = lawless_createLABEL();

				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);
				if(strlen(inputtext) > 0)
	        	{
					if(label_id > MAX_LABEL) return ERROR(playerid,"Vec je kreirano '%d' labela!",MAX_LABEL);

					L_E[label_id][label_created] = 1;
					L_E[label_id][label_position][0] = player_position[0];
					L_E[label_id][label_position][1] = player_position[1];
					L_E[label_id][label_position][2] = player_position[2];
					lawless_String(L_E[label_id][label_text],inputtext);

					new string_label[128];
					format(string_label,sizeof(string_label),"{FFFFFF}%s",inputtext);
					strmid(L_E[label_id][label_text],string_label,0,strlen(string_label),255);

					INFO(playerid,"Uspesno ste napravili label '%s'.",inputtext);
					INFO(playerid,"Uspesno napravljen label pod - 'ID:%d'.",label_id);

					lawless_maxlabela++;
					lawless_saveLABEL(label_id);

					format(string_label,sizeof(string_label),L_E[label_id][label_text]);
					lawless_labeli_label[label_id] = lawless_C3D(string_label,-1,L_E[label_id][label_position][0],L_E[label_id][label_position][1],L_E[label_id][label_position][2],5);
	        	}
			}
        }
        if(dialogid == lawless_ORGANIZ)
        {
            if(!response) return true;
            if(response)
            {
                new org_names[64];
                new Float:player_position[3];
				GetPlayerPos(playerid,player_position[0],player_position[1],player_position[2]);
				if(sscanf(inputtext,"s[64]",org_names)) return lawless_SPD(playerid, lawless_ORGANIZ, DSI, SDIALOG,"{FFFFFF}Ukucajte 'Name',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

				new id = lawless_createORG();
				if(id > MAX_ORG) return ERROR(playerid,"Vec je kreirano '%d' organizacija!",MAX_ORG);

    			strmid(O_E[id][org_name],org_names,0,strlen(org_names),64);
				O_E[id][org_id] = id;

				strmid(O_E[id][org_leader_1],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_leader_2],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_1],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_2],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_3],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_4],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_5],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_6],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_7],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_8],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_9],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_10],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_11],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_12],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_13],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_14],"Niko",0,strlen("Niko"),24);
				strmid(O_E[id][org_member_15],"Niko",0,strlen("Niko"),24);
				
				O_E[id][org_ranks_created][0] = -1;
				O_E[id][org_ranks_created][1] = -1;
				O_E[id][org_ranks_created][2] = -1;
				O_E[id][org_ranks_created][3] = -1;
				O_E[id][org_ranks_created][4] = -1;
				O_E[id][org_ranks_created][5] = -1;

                O_E[id][org_sef] = 0;
				O_E[id][org_cash] = 0;
				O_E[id][org_drugs] = 0;
				O_E[id][org_materials] = 0;

				O_E[id][org_position_ext][0] = player_position[0];
				O_E[id][org_position_ext][1] = player_position[1];
				O_E[id][org_position_ext][2] = player_position[2];

				O_E[id][org_vw] = random(300);

				lawless_maxorganisation++;
				lawless_CREATE_RANKS[playerid] = 0;
				lawless_EDIT_LEVEL[playerid] = 0;
				lawless_CREATE_VEHS[playerid] = 0;
				lawless_CREATE_ORG[playerid] = id;
				lawless_saveORG(id);

				lawless_Chat(playerid,20);

				format(string,sizeof(string),"{5D9DB3}[ORGANISATION - %d]\n\
 				{FFFFFF}ORGANISATION NAME - {5D9DB3}%s{FFFFFF}.\n\n\
				{FFFFFF}KORISTITE '{5D9DB3}F{FFFFFF}' ZA ULAZAK.",id,O_E[id][org_name]);
				lawless_organisation_label[id] = lawless_C3D(string,-1,O_E[id][org_position_ext][0],O_E[id][org_position_ext][1],O_E[id][org_position_ext][2],5);
				lawless_organisation_pickup[id] = lawless_CDP(1277,1,O_E[id][org_position_ext][0],O_E[id][org_position_ext][1],O_E[id][org_position_ext][2]);
                lawless_createdynamic_map_org[id] = lawless_MAPA(O_E[id][org_position_ext][0],O_E[id][org_position_ext][1],O_E[id][org_position_ext][2],61,-1,-1,-1,-1,100);
                
				INFO(playerid,"Uspesno ste kreirali organizaciju - '%s' - 'ID: %d'.",O_E[id][org_name],id);
				INFO(playerid,"Interijer organizacije je postavljen na default!");
				INFO(playerid,"Nastavite sa kreiranjem organizacije,kada zavrsite sve se automatski cuva u fajlovima!");

				lawless_SPD(playerid, lawless_OTIP, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}Drzavna organizacija.\n\
				{5D9DB3}>> {FFFFFF}Mafia organizacija.\n\
				{5D9DB3}>> {FFFFFF}Banda organizacija.",""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
			}
        }
        if(dialogid == lawless_OTIP)
        {
            if(!response)
            {
                lawless_SPD(playerid, lawless_OTIP, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}Drzavna organizacija.\n\
				{5D9DB3}>> {FFFFFF}Mafia organizacija.\n\
				{5D9DB3}>> {FFFFFF}Banda organizacija.",""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
            }
            if(response)
            {
                new id = lawless_CREATE_ORG[playerid];
            	switch(listitem)
  				{
				    case 0:
					{
					    O_E[id][org_tip] = DRZAVNE_ORG;

                        INFO(playerid,"Tip organizacije postavljen na - drzavne organizacije tip!");
                        lawless_SPD(playerid, lawless_OMSKIN, DSI, SDIALOG,"{FFFFFF}Ukucajte 'SKINOVE MUSKE 1-6',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
                        
                        if(O_E[id][org_tip] == DRZAVNE_ORG)
						{
							O_E[id][org_position_int][0] = 246.7840;
							O_E[id][org_position_int][1] = 63.9002;
							O_E[id][org_position_int][2] = 1003.6406;
							O_E[id][org_int] = 6;
						}
						lawless_saveORG(id);
					}
					case 1:
					{
					    O_E[id][org_tip] = MAFIA_ORG;

                        INFO(playerid,"Tip organizacije postavljen na - mafia organizacije tip!");
                        lawless_SPD(playerid, lawless_OMSKIN, DSI, SDIALOG,"{FFFFFF}Ukucajte 'SKINOVE MUSKE 1-6',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
                        
                        if(O_E[id][org_tip] == MAFIA_ORG)
						{
                            O_E[id][org_position_int][0] = 2324.4199;
							O_E[id][org_position_int][1] = -1145.5683;
							O_E[id][org_position_int][2] = 1050.7100;
							O_E[id][org_int] = 12;
						}
						lawless_saveORG(id);
					}
					case 2:
					{
					    O_E[id][org_tip] = BANDA_ORG;

                        INFO(playerid,"Tip organizacije postavljen na - bande organizacije tip!");
                        lawless_SPD(playerid, lawless_OMSKIN, DSI, SDIALOG,"{FFFFFF}Ukucajte 'SKINOVE MUSKE 1-6',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
                        
                        if(O_E[id][org_tip] == BANDA_ORG)
						{
                            O_E[id][org_position_int][0] = 318.5649;
							O_E[id][org_position_int][1] = 1118.2099;
							O_E[id][org_position_int][2] = 1083.8828;
							O_E[id][org_int] = 5;
						}
						lawless_saveORG(id);
					}
				}
			}
		}
		if(dialogid == lawless_OMSKIN)
        {
            if(!response) return true;
            if(response)
            {
                new m_skin_1;
                new m_skin_2;
                new m_skin_3;
                new m_skin_4;
                new m_skin_5;
                new m_skin_6;

                new id = lawless_CREATE_ORG[playerid];
                if(sscanf(inputtext,"iiiiii",m_skin_1,m_skin_2,m_skin_3,m_skin_4,m_skin_5,m_skin_6)) return lawless_SPD(playerid, lawless_OMSKIN, DSI, SDIALOG,"{FFFFFF}Ukucajte 'SKINOVE MUSKE 1-6',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

                O_E[id][org_m_skin][0] = m_skin_1;
                O_E[id][org_m_skin][1] = m_skin_2;
                O_E[id][org_m_skin][2] = m_skin_3;
                O_E[id][org_m_skin][3] = m_skin_4;
                O_E[id][org_m_skin][4] = m_skin_5;
                O_E[id][org_m_skin][5] = m_skin_6;
                lawless_saveORG(id);

                INFO(playerid,"Uspesno ste kreirali muske skinove za organizaciju!");
                INFO(playerid,"[S_M_1] - '%d'.",m_skin_1);
                INFO(playerid,"[S_M_2] - '%d'.",m_skin_2);
                INFO(playerid,"[S_M_3] - '%d'.",m_skin_3);
                INFO(playerid,"[S_M_4] - '%d'.",m_skin_4);
                INFO(playerid,"[S_M_5] - '%d'.",m_skin_5);
                INFO(playerid,"[S_M_6] - '%d'.",m_skin_6);

                lawless_SPD(playerid, lawless_OZSKIN, DSI, SDIALOG,"{FFFFFF}Ukucajte 'SKINOVE ZENSKE 1-6',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
			}
        }
        if(dialogid == lawless_OZSKIN)
        {
            if(!response) return true;
            if(response)
            {
                new z_skin_1;
                new z_skin_2;
                new z_skin_3;
                new z_skin_4;
                new z_skin_5;
                new z_skin_6;

                new id = lawless_CREATE_ORG[playerid];
                if(sscanf(inputtext,"iiiiii",z_skin_1,z_skin_2,z_skin_3,z_skin_4,z_skin_5,z_skin_6)) return lawless_SPD(playerid, lawless_OZSKIN, DSI, SDIALOG,"{FFFFFF}Ukucajte 'SKINOVE MUSKE 1-6',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

                O_E[id][org_z_skin][0] = z_skin_1;
                O_E[id][org_z_skin][1] = z_skin_2;
                O_E[id][org_z_skin][2] = z_skin_3;
                O_E[id][org_z_skin][3] = z_skin_4;
                O_E[id][org_z_skin][4] = z_skin_5;
                O_E[id][org_z_skin][5] = z_skin_6;
                lawless_saveORG(id);

                INFO(playerid,"Uspesno ste kreirali zenske skinove za organizaciju!");
                INFO(playerid,"[S_Z_1] - '%d'.",z_skin_1);
                INFO(playerid,"[S_Z_2] - '%d'.",z_skin_2);
                INFO(playerid,"[S_Z_3] - '%d'.",z_skin_3);
                INFO(playerid,"[S_Z_4] - '%d'.",z_skin_4);
                INFO(playerid,"[S_Z_5] - '%d'.",z_skin_5);
                INFO(playerid,"[S_Z_6] - '%d'.",z_skin_6);

                lawless_SPD(playerid, lawless_OMEMBERS, DSI, SDIALOG,"{FFFFFF}Ukucajte 'MAXIMALNO CLANOVA',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
			}
        }
        if(dialogid == lawless_OMEMBERS)
        {
            if(!response) return true;
            if(response)
            {
                new lawless_max_members;
                new id = lawless_CREATE_ORG[playerid];
				if(sscanf(inputtext,"i",lawless_max_members)) return lawless_SPD(playerid, lawless_OMEMBERS, DSI, SDIALOG,"{FFFFFF}Ukucajte 'MAXIMALNO CLANOVA',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
                if(lawless_max_members < 1 || lawless_max_members > 15) return lawless_SPD(playerid, lawless_OMEMBERS, DSI, SDIALOG,"{FFFFFF}Ukucajte 'MAXIMALNO CLANOVA',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz"),
                ERROR(playerid,"Minimalno moze 1 a maximalno 15 clanova po organizaciji!");

                O_E[id][org_maxmembers] = lawless_max_members;
                lawless_saveORG(id);

                strmid(O_E[id][org_rank_1],"Nista",0,strlen("Nista"),64);
				strmid(O_E[id][org_rank_2],"Nista",0,strlen("Nista"),64);
				strmid(O_E[id][org_rank_3],"Nista",0,strlen("Nista"),64);
				strmid(O_E[id][org_rank_4],"Nista",0,strlen("Nista"),64);
				strmid(O_E[id][org_rank_5],"Nista",0,strlen("Nista"),64);
				strmid(O_E[id][org_rank_6],"Nista",0,strlen("Nista"),64);

                format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
				O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
                lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");

                INFO(playerid,"Uspesno ste kreirali maximalan broj clanova organizacije - '%d'.",lawless_max_members);
			}
        }
        if(dialogid == lawless_ORANKS)
        {
            new id = lawless_CREATE_ORG[playerid];
            if(!response)
            {
                format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
                {5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
				O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
                lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
            }
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
						lawless_SPD(playerid, lawless_RANK1, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 1',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
					case 1:
					{
                        if(O_E[id][org_ranks_created][0] == -1) return ERROR(playerid,"Niste upisali prethodan rank,morate sve po redu!"),
                        format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
						O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
		                lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
                        
                        lawless_SPD(playerid, lawless_RANK2, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 2',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
					case 2:
					{
					    if(O_E[id][org_ranks_created][1] == -1) return ERROR(playerid,"Niste upisali prethodan rank,morate sve po redu!"),
                        format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
						O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
		                lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
					    
                        lawless_SPD(playerid, lawless_RANK3, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 3',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
					case 3:
					{
					    if(O_E[id][org_ranks_created][2] == -1) return ERROR(playerid,"Niste upisali prethodan rank,morate sve po redu!"),
                        format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
						O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
		                lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
					    
                        lawless_SPD(playerid, lawless_RANK4, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 4',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
					case 4:
					{
					    if(O_E[id][org_ranks_created][3] == -1) return ERROR(playerid,"Niste upisali prethodan rank,morate sve po redu!"),
                        format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
						O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
		                lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
					    
                        lawless_SPD(playerid, lawless_RANK5, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 5',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
					case 5:
					{
					    if(O_E[id][org_ranks_created][4] == -1) return ERROR(playerid,"Niste upisali prethodan rank,morate sve po redu!"),
                        format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
		                {5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
						O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
		                lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");
					    
                        lawless_SPD(playerid, lawless_RANK6, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 6',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
				}
			}
		}
		if(dialogid == lawless_RANK1)
        {
            if(!response) return true;
            if(response)
            {
				new rank_name_1[64];
    			new id = lawless_CREATE_ORG[playerid];

				if(sscanf(inputtext,"s[64]",rank_name_1)) return lawless_SPD(playerid, lawless_RANK1, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 1',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

                strmid(O_E[id][org_rank_1],rank_name_1,0,strlen(rank_name_1),64);
    			lawless_saveORG(id);

    			lawless_CREATE_RANKS[playerid]++;
    			
    			O_E[id][org_ranks_created][0] = 1;

				format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
             	{5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
				O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
				lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");

				INFO(playerid,"Uspesno ste zavrsili sa pisanjem rank imena - slot 1 '%s'.",rank_name_1);
				lawless_saveORG(id);
			}
        }
        if(dialogid == lawless_RANK2)
        {
            if(!response) return true;
            if(response)
            {
				new rank_name_2[64];
    			new id = lawless_CREATE_ORG[playerid];

				if(sscanf(inputtext,"s[64]",rank_name_2)) return lawless_SPD(playerid, lawless_RANK2, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 2',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

                strmid(O_E[id][org_rank_2],rank_name_2,0,strlen(rank_name_2),64);
    			lawless_saveORG(id);

    			lawless_CREATE_RANKS[playerid]++;
    			
    			O_E[id][org_ranks_created][1] = 1;

				format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
             	{5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
				O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
				lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");

				INFO(playerid,"Uspesno ste zavrsili sa pisanjem rank imena - slot 2 '%s'.",rank_name_2);
				lawless_saveORG(id);
			}
        }
        if(dialogid == lawless_RANK3)
        {
            if(!response) return true;
            if(response)
            {
				new rank_name_3[64];
    			new id = lawless_CREATE_ORG[playerid];

				if(sscanf(inputtext,"s[64]",rank_name_3)) return lawless_SPD(playerid, lawless_RANK3, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 3',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

                strmid(O_E[id][org_rank_3],rank_name_3,0,strlen(rank_name_3),64);
    			lawless_saveORG(id);

    			lawless_CREATE_RANKS[playerid]++;
    			
    			O_E[id][org_ranks_created][2] = 1;

				format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
             	{5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
				O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
				lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");

				INFO(playerid,"Uspesno ste zavrsili sa pisanjem rank imena - slot 3 '%s'.",rank_name_3);
				lawless_saveORG(id);
			}
        }
        if(dialogid == lawless_RANK4)
        {
            if(!response) return true;
            if(response)
            {
				new rank_name_4[64];
    			new id = lawless_CREATE_ORG[playerid];

				if(sscanf(inputtext,"s[64]",rank_name_4)) return lawless_SPD(playerid, lawless_RANK1, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 4',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

                strmid(O_E[id][org_rank_4],rank_name_4,0,strlen(rank_name_4),64);
    			lawless_saveORG(id);

    			lawless_CREATE_RANKS[playerid]++;
    			
    			O_E[id][org_ranks_created][3] = 1;

				format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
             	{5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
				O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
				lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");

				INFO(playerid,"Uspesno ste zavrsili sa pisanjem rank imena - slot 4 '%s'.",rank_name_4);
				lawless_saveORG(id);
			}
        }
        if(dialogid == lawless_RANK5)
        {
            if(!response) return true;
            if(response)
            {
				new rank_name_5[64];
    			new id = lawless_CREATE_ORG[playerid];
				if(sscanf(inputtext,"s[64]",rank_name_5)) return lawless_SPD(playerid, lawless_RANK5, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 5',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

                strmid(O_E[id][org_rank_5],rank_name_5,0,strlen(rank_name_5),64);
    			lawless_saveORG(id);

    			lawless_CREATE_RANKS[playerid]++;
    			
    			O_E[id][org_ranks_created][4] = 1;

				format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}RANK SLOT - 1 - [%s]\n\
             	{5D9DB3}>> {FFFFFF}RANK SLOT - 2 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 3 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 4 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 5 - [%s]\n\
              	{5D9DB3}>> {FFFFFF}RANK SLOT - 6 - [%s]",O_E[id][org_rank_1],O_E[id][org_rank_2],O_E[id][org_rank_3],
				O_E[id][org_rank_4],O_E[id][org_rank_5],O_E[id][org_rank_6]);
				lawless_SPD(playerid, lawless_ORANKS, DSL, SDIALOG,string,""SERVER_COL"Nastavi",""SERVER_COL"Izlaz");

				INFO(playerid,"Uspesno ste zavrsili sa pisanjem rank imena - slot 5 '%s'.",rank_name_5);
				lawless_saveORG(id);
			}
        }
        if(dialogid == lawless_RANK6)
        {
            if(!response) return true;
            if(response)
            {
				new rank_name_6[64];
				new id = lawless_CREATE_ORG[playerid];
				if(sscanf(inputtext,"s[64]",rank_name_6)) return lawless_SPD(playerid, lawless_RANK6, DSI, SDIALOG,"{FFFFFF}Ukucajte 'NAME RANK 6',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");

                strmid(O_E[id][org_rank_6],rank_name_6,0,strlen(rank_name_6),64);
				lawless_saveORG(id);

				lawless_SPD(playerid, lawless_OVEHICLE, DSI, SDIALOG,"{FFFFFF}Ukucajte 'ID' modela za organizacijska vozila!",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");

                O_E[id][org_ranks_created][5] = 1;
                lawless_ORG_PICKUP[playerid] = lawless_CREATE_ORG[playerid];
                
    			if(lawless_CREATE_RANKS[playerid] == 5)
    			{
					INFO(playerid,"Uspesno ste zavrsili sa pisanjem rank imena - slot 6 '%s'.",rank_name_6);
					INFO(playerid,"Uspesno ste ujedno i zavrsili sa kreiranjem organizacije!");
					INFO(playerid,"Sada je samo potreban zavrsni korak da upisete model vozila za svih - '8' slotova!");
					lawless_saveORG(id);
				}
			}
        }
		if(dialogid == lawless_DRZAVE)
        {
            if(!response)
            {
                lawless_Chat(playerid,20);
                defer lawless_Kick(playerid);
                ERROR(playerid,"Kikovani ste zbog odbijanja 'REGISTER'-a.");
            }
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
                        lawless_String(P_E[playerid][info_drzava],"Srbija");

						INFO(playerid,"Uspesno ste registrovali vasu 'drzavu' - 'Srbija'.");

						lawless_Drzava[playerid] = true;
						
						lawless_PTDSS(playerid,registering_Data[21][playerid],"Srbija");
					}
					case 1:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
					    lawless_String(P_E[playerid][info_drzava],"Bosna i Hercegovina");

						INFO(playerid,"Uspesno ste registrovali vasu 'drzavu' - 'Bosna i Hercegovina'.");

						lawless_Drzava[playerid] = true;
						
						lawless_PTDSS(playerid,registering_Data[21][playerid],"Bosna i Hercegovina");
					}
					case 2:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
                        lawless_String(P_E[playerid][info_drzava],"Hrvatska");

						INFO(playerid,"Uspesno ste registrovali vasu 'drzavu' - 'Hrvatska'.");

						lawless_Drzava[playerid] = true;
						
						lawless_PTDSS(playerid,registering_Data[21][playerid],"Hrvatska");
					}
					case 3:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
                        lawless_String(P_E[playerid][info_drzava],"Makedonija");

						INFO(playerid,"Uspesno ste registrovali vasu 'drzavu' - 'Makedonija'.");

						lawless_Drzava[playerid] = true;
						
						lawless_PTDSS(playerid,registering_Data[21][playerid],"Makedonija");
					}
					case 4:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
                        lawless_String(P_E[playerid][info_drzava],"Crna Gora");

						INFO(playerid,"Uspesno ste registrovali vasu 'drzavu' - 'Crna Gora'.");

						lawless_Drzava[playerid] = true;
						
						lawless_PTDSS(playerid,registering_Data[21][playerid],"Crna Gora");
					}
					case 5:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
                        lawless_String(P_E[playerid][info_drzava],"Slovenija");

						INFO(playerid,"Uspesno ste registrovali vasu 'drzavu' - 'Slovenija'.");

						lawless_Drzava[playerid] = true;
						
						lawless_PTDSS(playerid,registering_Data[21][playerid],"Slovenija");
					}
					case 6:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
                        lawless_String(P_E[playerid][info_drzava],"Albanija");

						INFO(playerid,"Uspesno ste registrovali vasu 'drzavu' - 'Albanija'.");

						lawless_Drzava[playerid] = true;

						lawless_PTDSS(playerid,registering_Data[21][playerid],"Albanija");
					}
					case 7:
					{
					    lawless_Chat(playerid,20);
					    lawless_COLOR(playerid,0xAFAFAFAA);
                        lawless_String(P_E[playerid][info_drzava],"Ostalo");

						INFO(playerid,"Uspesno ste registrovali vasu 'drzavu' - 'Ostalo'.");

						lawless_Drzava[playerid] = true;
						
						lawless_PTDSS(playerid,registering_Data[21][playerid],"Ostalo");
					}
				}
			}
		}
  		if(dialogid == lawless_SERVER)
        {
            if(!response) return true;
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
					    new protekcija[40];
					    if(A_C[anticheat_save]) { protekcija = "{01912D}Upaljen{FFFFFF}"; } else { protekcija = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija1[40];
					    if(A_C[anticheat_money]) { protekcija1 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija1 = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija2[40];
					    if(A_C[anticheat_health]) { protekcija2 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija2 = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija3[40];
					    if(A_C[anticheat_armour]) { protekcija3 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija3 = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija4[40];
					    if(A_C[anticheat_rcon]) { protekcija4 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija4 = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija5[40];
					    if(A_C[anticheat_chat]) { protekcija5 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija5 = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija6[40];
					    if(A_C[anticheat_say]) { protekcija6 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija6 = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija7[40];
					    if(A_C[anticheat_bunnyhop]) { protekcija7 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija7 = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija8[40];
					    if(A_C[anticheat_joypad]) { protekcija8 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija8 = "{FF3030}Ugasen{FFFFFF}"; }
					    new protekcija9[40];
					    if(A_C[anticheat_weaponcrash]) { protekcija9 = "{01912D}Upaljen{FFFFFF}"; } else { protekcija9 = "{FF3030}Ugasen{FFFFFF}"; }

						format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}lawless_ANTICHEAT[%s].\n{5D9DB3}>> {FFFFFF}lawless_money[%s].\n{5D9DB3}>> {FFFFFF}lawless_health[%s] - [98.0 max.hp]\n\
						{5D9DB3}>> {FFFFFF}lawless_armour[%s] - [98.0 max.arm]\n{5D9DB3}>> {FFFFFF}lawless_rcon[%s]\n{5D9DB3}>> {FFFFFF}lawless_chat[%s] - [5sec chat]\n{5D9DB3}>> {FFFFFF}lawless_say[%s]\n\
						{5D9DB3}>> {FFFFFF}lawless_bunnyhop[%s]\n{5D9DB3}>> {FFFFFF}lawless_joypad[%s]\n{5D9DB3}>> {FFFFFF}anticheat_weaponcrash[%s]",
						protekcija,protekcija1,protekcija2,protekcija3,protekcija4,protekcija5,protekcija6,protekcija7,protekcija8,protekcija9);
						lawless_SPD(playerid, lawless_ANTICHEAT, DSL, SDIALOG,string,""SERVER_COL"Izmeni",""SERVER_COL"Izlaz");
					}
					case 1:
					{
					    format(string,sizeof(string),"{F23A0D}[lawless_ADM]: {FFFFFF}Svi igraci su kikovani sa servera od strane 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
					    lawless_SCMA(-1,string);

					    SendRconCommand("hostname "MAINTE"");
					    SendRconCommand("password "PASSWORD"");

					    for(new i = 0; i < MAX_PLAYERS; i++)
						{
							if(lawless_Logo[i] == 1 && lawless_Logo[i] == 0)
							{
							    if(playerid != i)
		    					{
							    	defer lawless_Kick(i);
							    }
							}
						}
					}
					case 2:
					{
					    format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' upisite 'ID/Ime_Prezime' igraca,\n\
						{FFFFFF}kojem zelite dodeliti '{5D9DB3}DONATOSKU BOJU{FFFFFF}'.",lawless_Nick(playerid));
                		lawless_SPD(playerid, lawless_COLOUR, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
					}
					case 3:
					{
					    for(new j; j < 20; j++)
						{
							lawless_SCMA(-1, "");
						}

						lawless_SCMA(-1,"{5D9DB3}[GAMING]:{FFFFFF} Chat je uspesno ociscen od strane 'law_adm'.");
						lawless_SCMA(-1,"===== || www.lawless-hq.com || =====");
						INFO(playerid,"Uspesno ste ocistili 'chat' svima!");
					}
					case 4:
					{
					    lawless_SPD(playerid, lawless_ASTS, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}Provera dynamic organizacija.\n{5D9DB3}>> {FFFFFF}Level za ulazak u organizacije.\n\
						{5D9DB3}>> {FFFFFF}Provera kreiranih dynamic organizacija.\n{5D9DB3}>> {FFFFFF}Sacuvavanje svih korisnickih racuna.\n\
						{5D9DB3}>> {FFFFFF}Proveravanje offline korisnickog racuna.\n{5D9DB3}>> {FFFFFF}Registracija na serveru.",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
					}
					case 5:
					{
					    format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}[COS] - AUTO SALON - [{5D9DB3}%d{FFFFFF}].\n\
						{5D9DB3}>> {FFFFFF}[LABS] - LABELOVI - [{5D9DB3}%d{FFFFFF}].\n\
						{5D9DB3}>> {FFFFFF}[ORGS] - ORGANISATION - [{5D9DB3}%d{FFFFFF}].\n\
						{5D9DB3}>> {FFFFFF}[GPS] - LOCATIONS - [{5D9DB3}%d{FFFFFF}].\n\
						{5D9DB3}>> {FFFFFF}[HOUSES] - KUCE - [{5D9DB3}%d{FFFFFF}].",lawless_maxsalon,lawless_maxlabela,lawless_maxorganisation,lawless_maxgpsovs,lawless_maxhouses);
					    lawless_SPD(playerid, lawless_DYNAMIC, DSL, SDIALOG,string,""SERVER_COL"Kreiraj",""SERVER_COL"Izlaz");
					}
					case 6:
					{
					    format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}[COS] - AUTO SALON - [{5D9DB3}%d{FFFFFF}].\n\
						{5D9DB3}>> {FFFFFF}[LABS] - LABELOVI - [{5D9DB3}%d{FFFFFF}].\n\
						{5D9DB3}>> {FFFFFF}[HOUSES] - KUCE - [{5D9DB3}%d{FFFFFF}].",lawless_maxsalon,lawless_maxlabela,lawless_maxhouses);
					    lawless_SPD(playerid, lawless_DELETE, DSL, SDIALOG,string,""SERVER_COL"Obrisi",""SERVER_COL"Izlaz");
					}
					case 7:
					{
                        SendRconCommand("hostname "SERVER"");
					    SendRconCommand("password 0");

					    INFO(playerid,"Uspesno ste otkljucali - '"SERVER"'.");
					}
					case 8:
					{
                        lawless_SPD(playerid, lawless_UPDATE, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}Lista update-a.\n\
						{5D9DB3}>> {FFFFFF}Izvrsi update.",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
					}
				}
			}
		}
		if(dialogid == lawless_UPDATE)
        {
            if(!response) return true;
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
					    format(string,sizeof(string),"{5D9DB3}>> {FFFFFF}Lista dodatih novih stvari - update:\n\
					    {5D9DB3}01: {FFFFFF}"UPDATE_1"\n{5D9DB3}02: {FFFFFF}"UPDATE_2"\n{5D9DB3}03: {FFFFFF}"UPDATE_3"\n{5D9DB3}04: {FFFFFF}"UPDATE_4"\n{5D9DB3}05: {FFFFFF}"UPDATE_5"\n\
						{5D9DB3}06: {FFFFFF}"UPDATE_6"\n{5D9DB3}07: {FFFFFF}"UPDATE_7"\n{5D9DB3}08: {FFFFFF}"UPDATE_8"\n{5D9DB3}09: {FFFFFF}"UPDATE_9"\n{5D9DB3}10: {FFFFFF}"UPDATE_10"\n\
						{5D9DB3}>> {FFFFFF}Update izvrsen || [{5D9DB3}"UPDA" - "TIME"{FFFFFF}]");
                        lawless_SPD(playerid, lawless_UPDATING, DSM, SDIALOG,string,""SERVER_COL"Uredu","");
					}
					case 1:
					{
						SendRconCommand("hostname "MAINTA"");
					    SendRconCommand("password "PASSWORD"");

					    for(new i = 0; i < MAX_PLAYERS; i++)
						{
							if(lawless_Logo[i] == 1 && lawless_Logo[i] == 0)
							{
							    if(playerid != i)
		    					{
							    	defer lawless_Kick(i);
							    }
							}
						}

						INFO(playerid,"Svi igraci su kikovani,server zakljucan zbog izvrsavanja/testiranja update-a!");

                        format(string,sizeof(string),"{F23A0D}[lawless_ADM]: {FFFFFF}Svi igraci su kikovani sa servera od strane 'DEVELOPER' - '%s' - 'UPDATE'.",lawless_Nick(playerid));
					    lawless_SCMA(-1,string);
					}
				}
			}
		}
		if(dialogid == lawless_DYNAMIC)
        {
            if(!response) return true;
            if(response)
            {
                new Float:lawless_player[4];
            	switch(listitem)
  				{
				    case 0:
					{
					    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Ne mozes iz vozila!");
					    
						GetPlayerPos(playerid,lawless_player[0],lawless_player[1],lawless_player[2]);
						GetPlayerFacingAngle(playerid,lawless_player[3]);
						
						new autosalon = lawless_createSALON();
						if(autosalon > MAX_SALONS) return ERROR(playerid,"Vec je kreirano '%d' auto salona!",MAX_SALONS);

                        new lawless_ime[30];
                        new ime = random(35);
						new level = 10+random(10);
						new novac = 555555+random(555555);

						if(ime == 1) { lawless_ime = "BMW"; }
						else if(ime == 2) { lawless_ime = "MERCEDES"; }
						else if(ime == 3) { lawless_ime = "AUDI"; }
						else if(ime == 4) { lawless_ime = "RENAULT"; }
						else if(ime == 5) { lawless_ime = "FIAT"; }
						else if(ime == 6) { lawless_ime = "FERRARI"; }
						else if(ime == 7) { lawless_ime = "MASERATI"; }
						else if(ime == 8) { lawless_ime = "OPEL"; }
						else if(ime == 9) { lawless_ime = "PEUGEOT"; }
						else if(ime == 10) { lawless_ime = "VW"; }
						else if(ime == 11) { lawless_ime = "TOYOTA"; }
						else if(ime == 12) { lawless_ime = "FORD"; }
						else if(ime == 13) { lawless_ime = "SKODA"; }
						else if(ime == 14) { lawless_ime = "MAZDA"; }
						else if(ime == 15) { lawless_ime = "CITROEN"; }
						else if(ime == 16) { lawless_ime = "SUZUKI"; }
						else if(ime == 17) { lawless_ime = "HYUNDAI"; }
						else if(ime == 18) { lawless_ime = "ALFA"; }
						else if(ime == 19) { lawless_ime = "SUBARU"; }
						else if(ime == 20) { lawless_ime = "HONDA"; }
						else if(ime == 21) { lawless_ime = "NISSAN"; }
						else if(ime == 22) { lawless_ime = "LAND ROVER"; }
						else if(ime == 23) { lawless_ime = "MITSUBISHI"; }
						else if(ime == 24) { lawless_ime = "VOLVO"; }
						else if(ime == 25) { lawless_ime = "LOTUS"; }
						else if(ime == 26) { lawless_ime = "DODGE"; }
						else if(ime == 27) { lawless_ime = "BENTLEY"; }
						else if(ime == 28) { lawless_ime = "JEEP"; }
						else if(ime == 29) { lawless_ime = "ROVER"; }
						else if(ime == 30) { lawless_ime = "MINI"; }
						else if(ime == 31) { lawless_ime = "DAEWOO"; }
						else if(ime == 32) { lawless_ime = "CHRYSLER"; }
						else if(ime == 33) { lawless_ime = "ASTON MARTIN"; }
						else if(ime == 34) { lawless_ime = "JAGUAR"; }
						else if(ime == 35) { lawless_ime = "LEXUS"; }

						lawless_String(A_E[autosalon][salon_name],lawless_ime);
						A_E[autosalon][salon_position][0] = lawless_player[0];
						A_E[autosalon][salon_position][1] = lawless_player[1];
						A_E[autosalon][salon_position][2] = lawless_player[2];
						A_E[autosalon][salon_owned] = 0;
						A_E[autosalon][salon_buy] = 0;
						A_E[autosalon][salon_maxmodels][0] = 0;
						A_E[autosalon][salon_maxmodels][1] = 0;
						A_E[autosalon][salon_maxmodels][2] = 0;
						A_E[autosalon][salon_maxmodels][3] = 0;
						A_E[autosalon][salon_maxmodels][4] = 0;
						A_E[autosalon][salon_created] = 1;
						A_E[autosalon][salon_vehicle][0] = 9999;
						A_E[autosalon][salon_vehicle][1] = 9999;
						A_E[autosalon][salon_vehicle][2] = 9999;
						A_E[autosalon][salon_vehicle][3] = 9999;
						A_E[autosalon][salon_vehicle][4] = 9999;
						A_E[autosalon][salon_modelprice][0] = 0;
						A_E[autosalon][salon_modelprice][1] = 0;
						A_E[autosalon][salon_modelprice][2] = 0;
						A_E[autosalon][salon_modelprice][3] = 0;
						A_E[autosalon][salon_modelprice][4] = 0;
						A_E[autosalon][salon_cash] = 0;
						A_E[autosalon][salon_money] = novac;
						A_E[autosalon][salon_level] = level;
						A_E[autosalon][salon_vehicleposition][0] = lawless_player[0]+10;
						A_E[autosalon][salon_vehicleposition][1] = lawless_player[1]+10;
						A_E[autosalon][salon_vehicleposition][2] = lawless_player[2];
						A_E[autosalon][salon_vehicleposition][3] = lawless_player[3];
						strmid(A_E[autosalon][salon_owner],"Niko",0,strlen("Niko"),255);

						lawless_saveSALON(autosalon);
						lawless_updateSALON(autosalon);

						INFO(playerid,"Uspesno ste napravili auto salon - '%s('ID - %d')' - '%dlvl' - '$%d'.",lawless_ime,autosalon,level,novac);
						INFO(playerid,"Uradjen save/update kreiranog auto salona - completed!");
						
						lawless_maxsalon++;
					}
					case 1:
					{
					    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Ne mozes iz vozila!");
					    
						lawless_SPD(playerid, lawless_LABEL, DSI, SDIALOG,"{FFFFFF}Ukucajte 'Text',kako bi ste napravili label!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
					case 2:
					{
					    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Ne mozes iz vozila!");
					    
					    lawless_CREATE_ORG[playerid] = -1;
					    lawless_CREATE_RANKS[playerid] = 0;
					    lawless_CREATE_VEHS[playerid] = 0;
					    lawless_EDIT_LEVEL[playerid] = 0;

						lawless_SPD(playerid, lawless_ORGANIZ, DSI, SDIALOG,"{FFFFFF}Ukucajte 'Name',kako bi ste napravili organizaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
					case 3:
					{
					    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Ne mozes iz vozila!");
					    
						lawless_SPD(playerid, lawless_CGPS, DSI, SDIALOG,"{FFFFFF}Ukucajte 'Name',kako bi ste napravili gps lokaciju!",""SERVER_COL"Napravi",""SERVER_COL"Izlaz");
					}
					case 4:
					{
					    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Ne mozes iz vozila!");
						GetPlayerPos(playerid,lawless_player[0],lawless_player[1],lawless_player[2]);
						
					    new houses = lawless_createHOUSE();
						if(houses > MAX_HOUSES) return ERROR(playerid,"Vec je kreirano '%d' kuca!",MAX_HOUSES);
						
						new level = random(10);
						new novac = 5000000+random(2000000);
						
						H_E[houses][house_type] = random(3);
						H_E[houses][house_created] = 1;
						H_E[houses][house_owned] = 0;
						H_E[houses][house_price] = novac;
						H_E[houses][house_level] = level;
						H_E[houses][house_locked] = 0;
						H_E[houses][house_interior] = 0;
						H_E[houses][house_vw] = houses;
						
						H_E[houses][house_outside][0] = lawless_player[0];
						H_E[houses][house_outside][1] = lawless_player[1];
						H_E[houses][house_outside][2] = lawless_player[2];
						
						H_E[houses][house_inside][0] = 0.0; /* EDIT - KADA DODJU ENTERIJERI */
						H_E[houses][house_inside][1] = 0.0; /* EDIT - KADA DODJU ENTERIJERI */
						H_E[houses][house_inside][2] = 0.0; /* EDIT - KADA DODJU ENTERIJERI */
						
						H_E[houses][house_furniture_slots][0] = 0;
						H_E[houses][house_furniture_slots][1] = 0;
						H_E[houses][house_furniture_slots][2] = 0;
						H_E[houses][house_furniture_slots][3] = 0;
						H_E[houses][house_furniture_slots][4] = 0;
						H_E[houses][house_furniture_slots][5] = 0;
						H_E[houses][house_furniture_slots][6] = 0;
						H_E[houses][house_furniture_slots][7] = 0;
						H_E[houses][house_furniture_slots][8] = 0;
						H_E[houses][house_furniture_slots][9] = 0;
						H_E[houses][house_furniture_slots][10] = 0;
						H_E[houses][house_furniture_slots][11] = 0;
						H_E[houses][house_furniture_slots][12] = 0;
						H_E[houses][house_furniture_slots][13] = 0;
						H_E[houses][house_furniture_slots][14] = 0;
						
						H_E[houses][house_furniture_objects][0] = -1;
						H_E[houses][house_furniture_objects][1] = -1;
						H_E[houses][house_furniture_objects][2] = -1;
						H_E[houses][house_furniture_objects][3] = -1;
						H_E[houses][house_furniture_objects][4] = -1;
						H_E[houses][house_furniture_objects][5] = -1;
						H_E[houses][house_furniture_objects][6] = -1;
						H_E[houses][house_furniture_objects][7] = -1;
						H_E[houses][house_furniture_objects][8] = -1;
						H_E[houses][house_furniture_objects][9] = -1;
						H_E[houses][house_furniture_objects][10] = -1;
						H_E[houses][house_furniture_objects][11] = -1;
						H_E[houses][house_furniture_objects][12] = -1;
						H_E[houses][house_furniture_objects][13] = -1;
						H_E[houses][house_furniture_objects][14] = -1;
						
						H_E[houses][house_furniture_slot_1][0] = 0.0;
						H_E[houses][house_furniture_slot_1][1] = 0.0;
						H_E[houses][house_furniture_slot_1][2] = 0.0;
						H_E[houses][house_furniture_slot_1][3] = 0.0;
						
						H_E[houses][house_furniture_slot_2][0] = 0.0;
						H_E[houses][house_furniture_slot_2][1] = 0.0;
						H_E[houses][house_furniture_slot_2][2] = 0.0;
						H_E[houses][house_furniture_slot_2][3] = 0.0;
						
						H_E[houses][house_furniture_slot_3][0] = 0.0;
						H_E[houses][house_furniture_slot_3][1] = 0.0;
						H_E[houses][house_furniture_slot_3][2] = 0.0;
						H_E[houses][house_furniture_slot_3][3] = 0.0;
						
						H_E[houses][house_furniture_slot_4][0] = 0.0;
						H_E[houses][house_furniture_slot_4][1] = 0.0;
						H_E[houses][house_furniture_slot_4][2] = 0.0;
						H_E[houses][house_furniture_slot_4][3] = 0.0;
						
						H_E[houses][house_furniture_slot_5][0] = 0.0;
						H_E[houses][house_furniture_slot_5][1] = 0.0;
						H_E[houses][house_furniture_slot_5][2] = 0.0;
						H_E[houses][house_furniture_slot_5][3] = 0.0;
						
						H_E[houses][house_furniture_slot_6][0] = 0.0;
						H_E[houses][house_furniture_slot_6][1] = 0.0;
						H_E[houses][house_furniture_slot_6][2] = 0.0;
						H_E[houses][house_furniture_slot_6][3] = 0.0;
						
						H_E[houses][house_furniture_slot_7][0] = 0.0;
						H_E[houses][house_furniture_slot_7][1] = 0.0;
						H_E[houses][house_furniture_slot_7][2] = 0.0;
						H_E[houses][house_furniture_slot_7][3] = 0.0;
						
						H_E[houses][house_furniture_slot_8][0] = 0.0;
						H_E[houses][house_furniture_slot_8][1] = 0.0;
						H_E[houses][house_furniture_slot_8][2] = 0.0;
						H_E[houses][house_furniture_slot_8][3] = 0.0;
						
						H_E[houses][house_furniture_slot_9][0] = 0.0;
						H_E[houses][house_furniture_slot_9][1] = 0.0;
						H_E[houses][house_furniture_slot_9][2] = 0.0;
						H_E[houses][house_furniture_slot_9][3] = 0.0;
						
						H_E[houses][house_furniture_slot_10][0] = 0.0;
						H_E[houses][house_furniture_slot_10][1] = 0.0;
						H_E[houses][house_furniture_slot_10][2] = 0.0;
						H_E[houses][house_furniture_slot_10][3] = 0.0;
						
						H_E[houses][house_furniture_slot_11][0] = 0.0;
						H_E[houses][house_furniture_slot_11][1] = 0.0;
						H_E[houses][house_furniture_slot_11][2] = 0.0;
						H_E[houses][house_furniture_slot_11][3] = 0.0;
						
						H_E[houses][house_furniture_slot_12][0] = 0.0;
						H_E[houses][house_furniture_slot_12][1] = 0.0;
						H_E[houses][house_furniture_slot_12][2] = 0.0;
						H_E[houses][house_furniture_slot_12][3] = 0.0;
						
						H_E[houses][house_furniture_slot_13][0] = 0.0;
						H_E[houses][house_furniture_slot_13][1] = 0.0;
						H_E[houses][house_furniture_slot_13][2] = 0.0;
						H_E[houses][house_furniture_slot_13][3] = 0.0;
						
						H_E[houses][house_furniture_slot_14][0] = 0.0;
						H_E[houses][house_furniture_slot_14][1] = 0.0;
						H_E[houses][house_furniture_slot_14][2] = 0.0;
						H_E[houses][house_furniture_slot_14][3] = 0.0;
						
						H_E[houses][house_furniture_slot_15][0] = 0.0;
						H_E[houses][house_furniture_slot_15][1] = 0.0;
						H_E[houses][house_furniture_slot_15][2] = 0.0;
						H_E[houses][house_furniture_slot_15][3] = 0.0;
						
						strmid(H_E[houses][house_owner],"Niko",0,strlen("Niko"),255);
						
						lawless_saveHOUSE(houses);
						lawless_updateHOUSE(houses);
						
						INFO(playerid,"Uspesno ste napravili kucu - 'ID - %d' - '%dlvl' - '$%d'.",houses,level,novac);
						INFO(playerid,"Koriscen house type - '%d'.",H_E[houses][house_type]);
						INFO(playerid,"Uradjen save/update kreirane kuce - completed!");
						lawless_maxhouses++;
					}
				}
			}
		}
		if(dialogid == lawless_DELETE)
        {
            if(!response) return true;
            if(response)
            {
            	switch(listitem)
  				{
				    case 0:
					{
					    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Ne mozes iz vozila!");
					    for(new salon; salon < MAX_SALONS; salon++)
						{
						    if(IsPlayerInRangeOfPoint(playerid,2.5,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2]))
							{
							    if(A_E[salon][salon_created] == 1)
							    {
							        DestroyDynamic3DTextLabel(lawless_salon_label[salon]);
    								DestroyDynamicPickup(lawless_salon_pickup[salon]);

    								A_E[salon][salon_created] = 0;
    								A_E[salon][salon_position][0] = 0.0;
    								A_E[salon][salon_position][1] = 0.0;
    								A_E[salon][salon_position][2] = 0.0;

    								DestroyDynamicMapIcon(lawless_createdynamic_map_salon[salon]);

    								new lawless_file[128];
									format(lawless_file,sizeof(lawless_file),SALON,salon);
									fremove(lawless_file);

    								INFO(playerid,"Uspesno ste obrisali auto salon '%s' - '('ID - %d')'.",A_E[salon][salon_name],salon);
    								INFO(playerid,"Vlasnik koji je bio na auto salonu je - '%s'.",A_E[salon][salon_owner]);
    								
    								strmid(A_E[salon][salon_owner],"Niko",0,strlen("Niko"),255);
    								lawless_saveSALON(salon);
    								
    								lawless_maxsalon--;
							    }
							}
						}
					}
					case 1:
					{
					    for(new label; label < MAX_LABEL; label++)
						{
						    if(IsPlayerInRangeOfPoint(playerid,1.5,L_E[label][label_position][0],L_E[label][label_position][1],L_E[label][label_position][2]))
							{
							    if(L_E[label][label_created] == 1)
								{
								    DestroyDynamic3DTextLabel(lawless_labeli_label[label]);

								    L_E[label][label_position][0] = 0.0;
								    L_E[label][label_position][1] = 0.0;
								    L_E[label][label_position][2] = 0.0;
								    L_E[label][label_created] = 0;
								    strmid(L_E[label][label_text],"Nista",0,strlen("Nista"),255);
								    lawless_saveLABEL(label);

								    new lawless_file[128];
									format(lawless_file,sizeof(lawless_file),LABS,label);
									fremove(lawless_file);

									lawless_maxlabela--;
									INFO(playerid,"Uspesno ste obrisali label - 'ID: %d'.",label);
								}
							}
						}
					}
					case 2:
					{
					    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Ne mozes iz vozila!");
					    for(new kuca; kuca < MAX_HOUSES; kuca++)
						{
						    if(IsPlayerInRangeOfPoint(playerid,2.5,H_E[kuca][house_outside][0],H_E[kuca][house_outside][1],H_E[kuca][house_outside][2]))
							{
							    if(H_E[kuca][house_created] == 1)
							    {
							        DestroyDynamic3DTextLabel(lawless_houses_label[kuca]);
    								DestroyDynamicPickup(lawless_houses_pickup[kuca]);

    								H_E[kuca][house_created] = 0;
    								H_E[kuca][house_outside][0] = 0.0;
    								H_E[kuca][house_outside][1] = 0.0;
    								H_E[kuca][house_outside][2] = 0.0;
    								H_E[kuca][house_inside][0] = 0.0;
    								H_E[kuca][house_inside][1] = 0.0;
    								H_E[kuca][house_inside][2] = 0.0;
    								
    								H_E[kuca][house_furniture_slots][0] = 0;
									H_E[kuca][house_furniture_slots][1] = 0;
									H_E[kuca][house_furniture_slots][2] = 0;
									H_E[kuca][house_furniture_slots][3] = 0;
									H_E[kuca][house_furniture_slots][4] = 0;
									H_E[kuca][house_furniture_slots][5] = 0;
									H_E[kuca][house_furniture_slots][6] = 0;
									H_E[kuca][house_furniture_slots][7] = 0;
									H_E[kuca][house_furniture_slots][8] = 0;
									H_E[kuca][house_furniture_slots][9] = 0;
									H_E[kuca][house_furniture_slots][10] = 0;
									H_E[kuca][house_furniture_slots][11] = 0;
									H_E[kuca][house_furniture_slots][12] = 0;
									H_E[kuca][house_furniture_slots][13] = 0;
									H_E[kuca][house_furniture_slots][14] = 0;

									H_E[kuca][house_furniture_objects][0] = -1;
									H_E[kuca][house_furniture_objects][1] = -1;
									H_E[kuca][house_furniture_objects][2] = -1;
									H_E[kuca][house_furniture_objects][3] = -1;
									H_E[kuca][house_furniture_objects][4] = -1;
									H_E[kuca][house_furniture_objects][5] = -1;
									H_E[kuca][house_furniture_objects][6] = -1;
									H_E[kuca][house_furniture_objects][7] = -1;
									H_E[kuca][house_furniture_objects][8] = -1;
									H_E[kuca][house_furniture_objects][9] = -1;
									H_E[kuca][house_furniture_objects][10] = -1;
									H_E[kuca][house_furniture_objects][11] = -1;
									H_E[kuca][house_furniture_objects][12] = -1;
									H_E[kuca][house_furniture_objects][13] = -1;
									H_E[kuca][house_furniture_objects][14] = -1;

									H_E[kuca][house_furniture_slot_1][0] = 0.0;
									H_E[kuca][house_furniture_slot_1][1] = 0.0;
									H_E[kuca][house_furniture_slot_1][2] = 0.0;
									H_E[kuca][house_furniture_slot_1][3] = 0.0;

									H_E[kuca][house_furniture_slot_2][0] = 0.0;
									H_E[kuca][house_furniture_slot_2][1] = 0.0;
									H_E[kuca][house_furniture_slot_2][2] = 0.0;
									H_E[kuca][house_furniture_slot_2][3] = 0.0;

									H_E[kuca][house_furniture_slot_3][0] = 0.0;
									H_E[kuca][house_furniture_slot_3][1] = 0.0;
									H_E[kuca][house_furniture_slot_3][2] = 0.0;
									H_E[kuca][house_furniture_slot_3][3] = 0.0;

									H_E[kuca][house_furniture_slot_4][0] = 0.0;
									H_E[kuca][house_furniture_slot_4][1] = 0.0;
									H_E[kuca][house_furniture_slot_4][2] = 0.0;
									H_E[kuca][house_furniture_slot_4][3] = 0.0;

									H_E[kuca][house_furniture_slot_5][0] = 0.0;
									H_E[kuca][house_furniture_slot_5][1] = 0.0;
									H_E[kuca][house_furniture_slot_5][2] = 0.0;
									H_E[kuca][house_furniture_slot_5][3] = 0.0;

									H_E[kuca][house_furniture_slot_6][0] = 0.0;
									H_E[kuca][house_furniture_slot_6][1] = 0.0;
									H_E[kuca][house_furniture_slot_6][2] = 0.0;
									H_E[kuca][house_furniture_slot_6][3] = 0.0;

									H_E[kuca][house_furniture_slot_7][0] = 0.0;
									H_E[kuca][house_furniture_slot_7][1] = 0.0;
									H_E[kuca][house_furniture_slot_7][2] = 0.0;
									H_E[kuca][house_furniture_slot_7][3] = 0.0;

									H_E[kuca][house_furniture_slot_8][0] = 0.0;
									H_E[kuca][house_furniture_slot_8][1] = 0.0;
									H_E[kuca][house_furniture_slot_8][2] = 0.0;
									H_E[kuca][house_furniture_slot_8][3] = 0.0;

									H_E[kuca][house_furniture_slot_9][0] = 0.0;
									H_E[kuca][house_furniture_slot_9][1] = 0.0;
									H_E[kuca][house_furniture_slot_9][2] = 0.0;
									H_E[kuca][house_furniture_slot_9][3] = 0.0;

									H_E[kuca][house_furniture_slot_10][0] = 0.0;
									H_E[kuca][house_furniture_slot_10][1] = 0.0;
									H_E[kuca][house_furniture_slot_10][2] = 0.0;
									H_E[kuca][house_furniture_slot_10][3] = 0.0;

									H_E[kuca][house_furniture_slot_11][0] = 0.0;
									H_E[kuca][house_furniture_slot_11][1] = 0.0;
									H_E[kuca][house_furniture_slot_11][2] = 0.0;
									H_E[kuca][house_furniture_slot_11][3] = 0.0;

									H_E[kuca][house_furniture_slot_12][0] = 0.0;
									H_E[kuca][house_furniture_slot_12][1] = 0.0;
									H_E[kuca][house_furniture_slot_12][2] = 0.0;
									H_E[kuca][house_furniture_slot_12][3] = 0.0;

									H_E[kuca][house_furniture_slot_13][0] = 0.0;
									H_E[kuca][house_furniture_slot_13][1] = 0.0;
									H_E[kuca][house_furniture_slot_13][2] = 0.0;
									H_E[kuca][house_furniture_slot_13][3] = 0.0;

									H_E[kuca][house_furniture_slot_14][0] = 0.0;
									H_E[kuca][house_furniture_slot_14][1] = 0.0;
									H_E[kuca][house_furniture_slot_14][2] = 0.0;
									H_E[kuca][house_furniture_slot_14][3] = 0.0;

									H_E[kuca][house_furniture_slot_15][0] = 0.0;
									H_E[kuca][house_furniture_slot_15][1] = 0.0;
									H_E[kuca][house_furniture_slot_15][2] = 0.0;
									H_E[kuca][house_furniture_slot_15][3] = 0.0;
    								
    								strmid(H_E[kuca][house_owner],"Niko",0,strlen("Niko"),255);

    								DestroyDynamicMapIcon(lawless_createdynamic_map_house[kuca]);
    								
    								INFO(playerid,"Uspesno ste obrisali house ownership '('ID - %d')'.",kuca);
    								INFO(playerid,"Vlasnik koji je bio na kuci je - '%s'.",H_E[kuca][house_owner]);

    								new lawless_file[128];
									format(lawless_file,sizeof(lawless_file),HOUS,kuca);
									fremove(lawless_file);
									
									lawless_maxhouses--;
							    }
							}
						}
					}
				}
			}
		}
		if(dialogid == lawless_COLOUR)
        {
            if(!response) return true;
            if(response)
            {
                new idigraca;
                if(sscanf(inputtext,"u",idigraca)) return format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' upisite 'ID/Ime_Prezime' igraca,\n\
				{FFFFFF}kojem zelite dodeliti '{5D9DB3}DONATOSKU BOJU{FFFFFF}'.",lawless_Nick(playerid)),lawless_SPD(playerid, lawless_COLOUR, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
                if(idigraca == IPI) return ERROR(playerid,"Ne mozes to!");
                if(P_E[idigraca][info_colour] == 0)
                {
					INFO(idigraca,"Uspesno ste dobili donatorsku boju od strane 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
					INFO(playerid,"Uspesno ste setovali donatorsku boju igracu - '%s'.",lawless_Nick(idigraca));
					P_E[idigraca][info_colour] = 1;
					lawless_saveUser(idigraca);
                }
                else if(P_E[idigraca][info_colour] == 1)
                {
					INFO(idigraca,"Uspesno ste dobili donatorsku boju od strane 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
					INFO(playerid,"Uspesno ste setovali donatorsku boju igracu - '%s'.",lawless_Nick(idigraca));
					P_E[idigraca][info_colour] = 2;
					lawless_saveUser(idigraca);
                }
                else if(P_E[idigraca][info_colour] == 2)
                {
					INFO(idigraca,"Uspesno ste dobili donatorsku boju od strane 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
					INFO(playerid,"Uspesno ste setovali donatorsku boju igracu - '%s'.",lawless_Nick(idigraca));
					P_E[idigraca][info_colour] = 3;
					lawless_saveUser(idigraca);
                }
                else if(P_E[idigraca][info_colour] == 3)
                {
					INFO(idigraca,"Uspesno ste dobili donatorsku boju od strane 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
					INFO(playerid,"Uspesno ste setovali donatorsku boju igracu - '%s'.",lawless_Nick(idigraca));
					P_E[idigraca][info_colour] = 4;
					lawless_saveUser(idigraca);
                }
                else if(P_E[idigraca][info_colour] == 4)
                {
					INFO(idigraca,"Uspesno ste dobili donatorsku boju od strane 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
					INFO(playerid,"Uspesno ste setovali donatorsku boju igracu - '%s'.",lawless_Nick(idigraca));
					P_E[idigraca][info_colour] = 5;
					lawless_saveUser(idigraca);
                }

				if(P_E[idigraca][info_colour] == 1)
				{
				    lawless_COLOR(idigraca,0xFF9900FF);
				}
				else if(P_E[idigraca][info_colour] == 2)
				{
			        lawless_COLOR(idigraca,0x800000FF);
				}
				else if(P_E[idigraca][info_colour] == 3)
				{
			        lawless_COLOR(idigraca,0x008080FF);
				}
				else if(P_E[idigraca][info_colour] == 4)
				{
			        lawless_COLOR(idigraca,0xFFC0CBFF);
				}
				else if(P_E[idigraca][info_colour] == 5)
				{
			        lawless_COLOR(idigraca,0xFF9900FF);
				}
			}
        }
		if(dialogid == lawless_ASKLIST)
        {
            if(!response)
            {
                for(new i = 1; i < MAX_ASKQ; i++)
				{
					format(lawless_string_ex,sizeof(lawless_string_ex),"%sASKQ[ID - %d] - %s\n",lawless_string_ex,i,AS_E[i][askq_postavljac]);
				}
				lawless_SPD(playerid, lawless_ASKLIST, DSL, SDIALOG,lawless_string_ex,""SERVER_COL"Odgovori",""SERVER_COL"Izlaz");

				ERROR(playerid,"Ne mozete izaci,dok ne odgovorite bar na jedno od postavljenih pitanja!");
            }
            if(response)
            {
                listitem++;
                if(AS_E[listitem][askq_poslat] == false) return ERROR(playerid,"Ovaj slot je prazan!");
                
                lawless_ASKQ_ANSWER[playerid] = listitem;
                
                format(string,sizeof(string),"{FFFFFF}Postavljeno pitanje od strane igraca.\n\
                {5D9DB3}IGRAC: {FFFFFF}'{5D9DB3}%s{FFFFFF}'.\n\
				{5D9DB3}PITANJE: {FFFFFF}'{5D9DB3}%s{FFFFFF}'",AS_E[listitem][askq_postavljac],AS_E[listitem][askq_pitanje]);
                lawless_SPD(playerid, lawless_ASKLISTED, DSI, SDIALOG,string,""SERVER_COL"Odgovori",""SERVER_COL"Izlaz");
			}
		}
		if(dialogid == lawless_ASKLISTED)
        {
            if(!response) return true;
            if(response)
            {
                new lawless_text[128];
                new askid = lawless_ASKQ_ANSWER[playerid];
                new id = AS_E[askid][askq_id];
                
		    	if(sscanf(inputtext,"s[128]",lawless_text)) return true;
		    	if(AS_E[askid][askq_poslat] == false) return ERROR(playerid,"Ovaj slot je prazan!");
		    	
		    	AS_E[askid][askq_poslat] = false;
				lawless_ASKQ_ANSWER[playerid] = -1;
				
				if(strcmp(lawless_Nick(id),AS_E[askid][askq_postavljac],true) == 0)
				{
				    AS_IE[id][askq_poslato] = true;
					strmid(AS_IE[id][askq_odgovor_admin],lawless_Nick(playerid),0,strlen(lawless_Nick(playerid)),32);
	            	strmid(AS_IE[id][askq_odgovor],lawless_text,0,strlen(lawless_text),128);
	            	
	            	INFO(playerid,"Uspesno ste odgovorili na pitanje,odgovor glasi - '%s'.",lawless_text);
	            	INFO(id,"Uspesno su vam odredjena lica odgovorila na vase pitanje,automatski prikazan odgovor!");
	            	
	            	format(string,sizeof(string),"                 {5D9DB3}[ASKQ - ODGOVOR]\n\n\
					{FFFFFF}ODGOVOR NAPISAO/LA - '{5D9DB3}%s{FFFFFF}'.\n\
					{FFFFFF}ODGOVOR - '{5D9DB3}%s{FFFFFF}'.",AS_IE[id][askq_odgovor_admin],AS_IE[id][askq_odgovor]);
	            	lawless_SPD(id, lawless_ASKSENDED, DSM, SDIALOG,string,""SERVER_COL"Izlaz","");
	            	
	            	strmid(AS_E[askid][askq_postavljac],"Nista",0,strlen("Nista"),32);
                	AS_E[askid][askq_id] = -1;
                	
                	AS_E[id][askq_poslat] = false;
					AS_IE[id][askq_odgovoreno] = false;
					AS_IE[playerid][askq_poslato] = false;
					strmid(AS_IE[id][askq_odgovor_admin],"Nista",0,strlen("Nista"),32);
					strmid(AS_IE[id][askq_odgovor],"Nista",0,strlen("Nista"),128);
				}
			}
		}
		if(dialogid == lawless_EMAIL)
        {
            if(!response)
            {
                lawless_Chat(playerid,20);
                defer lawless_Kick(playerid);
                ERROR(playerid,"Kikovani ste zbog odbijanja 'REGISTER'-a.");
            }
            if(response)
            {
                lawless_Chat(playerid,20);
                lawless_COLOR(playerid,0xAFAFAFAA);
				format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' uspesno ste resili prethodni korak,sada je potrebno sledeci.\n\
				{FFFFFF}Morate upisati '{5D9DB3}E-MAIL{FFFFFF}' zbog povracaja accounta.\n\
				{FFFFFF}Pazite da ukucate pravi i tacan e-mail.",lawless_Nick(playerid));

                if(strlen(inputtext) < 6 || strlen(inputtext) > 40) return lawless_SPD(playerid, lawless_EMAIL, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
                new namestring = strfind(inputtext, "@", true);

                if(namestring == -1)
				{
				    format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' uspesno ste resili prethodni korak,sada je potrebno sledeci.\n\
					{FFFFFF}Morate upisati '{5D9DB3}E-MAIL{FFFFFF}' zbog povracaja accounta.\n\
					{FFFFFF}Pazite da ukucate pravi i tacan e-mail.",lawless_Nick(playerid));
				    lawless_SPD(playerid, lawless_EMAIL, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
				    ERROR(playerid,"Niste lepo upisali vas 'E-MAIL'.");
				    return true;
				}

				new namestringse = strfind(inputtext, ".", true);

				if(namestringse == -1)
				{
				    format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' uspesno ste resili prethodni korak,sada je potrebno zadnji.\n\
					{FFFFFF}Morate upisati '{5D9DB3}E-MAIL{FFFFFF}' zbog povracaja accounta.\n\
					{FFFFFF}Pazite da ukucate pravi i tacan e-mail.",lawless_Nick(playerid));
				    lawless_SPD(playerid, lawless_EMAIL, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
				    ERROR(playerid,"Niste lepo upisali vas 'E-MAIL'.");
				    return true;
				}

				lawless_Chat(playerid,20);
				lawless_String(P_E[playerid][info_email],inputtext);
				lawless_String(P_E[playerid][info_rank],"Nista");
				
				INFO(playerid,"Uspesno ste registrovali vas 'e-mail' - '%s'.",inputtext);
				lawless_Email[playerid] = true;
				
				lawless_PTDSS(playerid,registering_Data[19][playerid],"E-MAIL - ~g~DA");
			}
	}
	return true;
}

/*============================================================================*/

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return true;
}

/*============================================================================*/

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(lawless_Logo[playerid] == 0)
	{
	    ERROR(playerid,"Da bi ste koristili komande,morate se ulogovati!");
	}
	if(A_C[anticheat_chat] == 1)
	{
	    if(P_E[playerid][info_admin] == 0)
		{
			if(lawless_Chatined[playerid] == 1)
			{
			    ERROR(playerid,"Komande mozete koristiti svakih '5' sekundi!");
			    return false;
			}
			defer lawless_Chatinineg(playerid);
			lawless_Chatined[playerid] = 1;
		}
	}
	else if(A_C[anticheat_chat] == 0)
	{
		lawless_Chatined[playerid] = 0;
	}
	return true;
}

/*============================================================================*/

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		ERROR(playerid,"Komanda koju ste upisali nije pronadjena u bazi podataka!");
		return true;
	}
    return true;
}

/*============================================================================*/

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	new string[512];
    if(playertextid == registering_Data[17][playerid])
	{
	    if(lawless_Drzava[playerid] == false || lawless_Password[playerid] == false || lawless_Godine[playerid] == false || lawless_Pol[playerid] == false || lawless_Email[playerid] == false || lawless_Security[playerid] == false) return lawless_Chat(playerid,19),ERROR(playerid,"Niste zavrsili sve korake!");

		lawless_PTDH(playerid,registering_Data[0][playerid]);
		lawless_PTDH(playerid,registering_Data[1][playerid]);
		lawless_PTDH(playerid,registering_Data[2][playerid]);
		lawless_PTDH(playerid,registering_Data[3][playerid]);
		lawless_PTDH(playerid,registering_Data[4][playerid]);
		lawless_PTDH(playerid,registering_Data[5][playerid]);
		lawless_PTDH(playerid,registering_Data[6][playerid]);
		lawless_PTDH(playerid,registering_Data[7][playerid]);
		lawless_PTDH(playerid,registering_Data[8][playerid]);
		lawless_PTDH(playerid,registering_Data[9][playerid]);
		lawless_PTDH(playerid,registering_Data[10][playerid]);
		lawless_PTDH(playerid,registering_Data[11][playerid]);
		lawless_PTDH(playerid,registering_Data[12][playerid]);
		lawless_PTDH(playerid,registering_Data[13][playerid]);
		lawless_PTDH(playerid,registering_Data[14][playerid]);
		lawless_PTDH(playerid,registering_Data[15][playerid]);
		lawless_PTDH(playerid,registering_Data[16][playerid]);
		lawless_PTDH(playerid,registering_Data[17][playerid]);
		lawless_PTDH(playerid,registering_Data[18][playerid]);
		lawless_PTDH(playerid,registering_Data[19][playerid]);
		lawless_PTDH(playerid,registering_Data[20][playerid]);
		lawless_PTDH(playerid,registering_Data[21][playerid]);
		lawless_PTDH(playerid,registering_Data[22][playerid]);
		lawless_PTDH(playerid,registering_Data[23][playerid]);
		lawless_PTDH(playerid,registering_Data[24][playerid]);
		lawless_PTDH(playerid,registering_Data[25][playerid]);
		lawless_PTDH(playerid,registering_Data[26][playerid]);
		CancelSelectTextDraw(playerid);

		lawless_Password[playerid] = false;
		lawless_Drzava[playerid] = false;
		lawless_Pol[playerid] = false;
		lawless_Godine[playerid] = false;
		lawless_Email[playerid] = false;
		lawless_Security[playerid] = false;

		lawless_Chat(playerid,30);

		InterpolateCameraPos(playerid,350.108337,-2624.405273,64.378433,1048.482421,-2006.849365,28.495578,20000);
		InterpolateCameraLookAt(playerid,354.091461,-2621.391113,64.155853,1050.146850,-2002.349243,27.089042,20000);

		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,1);
		lawless_POSITIONS(playerid,1463.7633,-1041.4501,26.8281);

		lawless_PTDS(playerid,tutorial_Data[0][playerid]);
        lawless_PTDS(playerid,tutorial_Data[1][playerid]);
        lawless_PTDS(playerid,tutorial_Data[2][playerid]);
        lawless_PTDS(playerid,tutorial_Data[3][playerid]);
        lawless_PTDS(playerid,tutorial_Data[4][playerid]);
        lawless_PTDS(playerid,tutorial_Data[5][playerid]);
        lawless_PTDS(playerid,tutorial_Data[6][playerid]);
        lawless_PTDS(playerid,tutorial_Data[7][playerid]);
        lawless_PTDS(playerid,tutorial_Data[8][playerid]);
        lawless_PTDS(playerid,tutorial_Data[9][playerid]);
        lawless_PTDS(playerid,tutorial_Data[10][playerid]);
        lawless_PTDS(playerid,tutorial_Data[11][playerid]);
        lawless_PTDS(playerid,tutorial_Data[12][playerid]);
        lawless_PTDS(playerid,tutorial_Data[13][playerid]);
        lawless_PTDS(playerid,tutorial_Data[14][playerid]);
        lawless_PTDS(playerid,tutorial_Data[15][playerid]);
        lawless_PTDS(playerid,tutorial_Data[16][playerid]);
        defer lawless_CameraTutorial(playerid);

	}
	else if(playertextid == registering_Data[18][playerid])
	{
 		lawless_COLOR(playerid,0xAFAFAFAA);

		format(string,sizeof(string),"{FFFFFF}Dobrodosli '%s' na {5D9DB3}Lawless {FFFFFF}- {5D9DB3}Gaming {FFFFFF}server.\n\
		{FFFFFF}Posto vam je ovo prvi put na serveru,morate se registrovati.\n\
		{FFFFFF}Registracija se sastoji iz nekoliko klasicnih koraka.\n\
		{FFFFFF}Da zapocnete sa registracijom i zaigrate,{FFFFFF}upisite '{5D9DB3}PASSWORD{FFFFFF}'.",lawless_Nick(playerid));
		lawless_SPD(playerid, lawless_REGISTER, DSP, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
	}
	else if(playertextid == registering_Data[19][playerid])
	{
	    lawless_COLOR(playerid,0xAFAFAFAA);

	    format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' uspesno ste resili prethodni korak,sada je potrebno sledeci.\n\
		{FFFFFF}Morate upisati '{5D9DB3}E-MAIL{FFFFFF}' zbog povracaja accounta.\n\
		{FFFFFF}Pazite da ukucate pravi i tacan e-mail.",lawless_Nick(playerid));
		lawless_SPD(playerid, lawless_EMAIL, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
	}
	else if(playertextid == registering_Data[20][playerid])
	{
	    lawless_COLOR(playerid,0xAFAFAFAA);

		format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' uspesno ste resili prethodni korak,sada je potrebno sledeci.\n\
		{FFFFFF}Security kod vam sluzi da povratite vas nalog.\n\
		{FFFFFF}Pazite sta upisujete,i slikajte '{5D9DB3}F8{FFFFFF}' kada ukucate.",lawless_Nick(playerid));
        lawless_SPD(playerid, lawless_SECURITY, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
	}
	else if(playertextid == registering_Data[21][playerid])
	{
	    lawless_COLOR(playerid,0xAFAFAFAA);

	    lawless_SPD(playerid, lawless_DRZAVE, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}Srbija.\n{5D9DB3}>> {FFFFFF}Bosna i Hercegovina.\n{5D9DB3}>> {FFFFFF}Hrvatska.\n{5D9DB3}>> {FFFFFF}Makedonija.\n\
		{5D9DB3}>> {FFFFFF}Crna Gora.\n{5D9DB3}>> {FFFFFF}Slovenija.\n{5D9DB3}>> {FFFFFF}Albanija.\n{5D9DB3}>> {FFFFFF}Ostalo.",""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
	}
	else if(playertextid == registering_Data[23][playerid])
	{
	    lawless_COLOR(playerid,0xAFAFAFAA);

		lawless_SPD(playerid, lawless_POL, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}Musko.\n\
		{5D9DB3}>> {FFFFFF}Zensko.",""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
	}
	else if(playertextid == registering_Data[22][playerid])
	{
	    lawless_COLOR(playerid,0xAFAFAFAA);

		format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' uspesno ste resili prethodni korak,sada je potrebno sledeci.\n\
		{FFFFFF}Morate upisati '{5D9DB3}GODINE{FFFFFF}' za vaseg lika.\n\
		{FFFFFF}Pazite kada ukucavate godine,gledajte sto realnije.",lawless_Nick(playerid));
        lawless_SPD(playerid, lawless_GODINE, DSI, SDIALOG,string,""SERVER_COL"Dalje",""SERVER_COL"Izlaz");
	}
	return true;
}

/*============================================================================*/

forward loadAccounts(playerid,name[],value[]);
public loadAccounts(playerid,name[],value[])
{
	INI_String("INFO_PASSWORD",P_E[playerid][info_password],24);
	INI_Int("INFO_POL",P_E[playerid][info_pol]);
	INI_String("INFO_DRZAVA",P_E[playerid][info_drzava],12);
	INI_Int("INFO_GODINE",P_E[playerid][info_godine]);
    INI_Int("INFO_SKIN",P_E[playerid][info_skin]);
    INI_String("INFO_SECURITY",P_E[playerid][info_security],24);
    INI_String("INFO_EMAIL",P_E[playerid][info_email],24);
    INI_Int("INFO_REGISTRATION",P_E[playerid][info_registration]);
    INI_Int("INFO_LEVEL",P_E[playerid][info_level]);
    INI_Int("INFO_CASH",P_E[playerid][info_cash]);
    INI_Int("INFO_LAST_1",P_E[playerid][info_last][0]);
    INI_Int("INFO_LAST_2",P_E[playerid][info_last][1]);
    INI_Int("INFO_LAST_3",P_E[playerid][info_last][2]);
    INI_Int("INFO_STAT",P_E[playerid][info_stat]);
    INI_Int("INFO_BANK",P_E[playerid][info_bank]);
    INI_Int("INFO_EURO",P_E[playerid][info_euro]);
    INI_Int("INFO_PAYPOEN",P_E[playerid][info_paypoen]);
    INI_Int("INFO_EXPERIENS",P_E[playerid][info_experiens]);
    INI_Int("INFO_HOURS",P_E[playerid][info_hours]);
    INI_Int("INFO_COLOUR",P_E[playerid][info_colour]);
    INI_Int("INFO_ADMIN",P_E[playerid][info_admin]);
    INI_Int("INFO_ACODE",P_E[playerid][info_acode]);
    INI_Int("INFO_VEHICLES_1",P_E[playerid][info_vehicles][0]);
    INI_Int("INFO_VEHICLES_2",P_E[playerid][info_vehicles][1]);
    INI_Int("INFO_VEHICLES_3",P_E[playerid][info_vehicles][2]);
    INI_Int("INFO_VEHICLES_4",P_E[playerid][info_vehicles][3]);
    INI_Int("INFO_VEHSALON",P_E[playerid][info_vehsalon]);
    INI_Int("INFO_INSURANCE",P_E[playerid][info_insurance]);
   	INI_Int("INFO_HUNGRY",P_E[playerid][info_hungry]);
   	INI_Int("INFO_TUTORIAL",P_E[playerid][info_tutorial]);
   	INI_Int("INFO_WANTEDLEVEL",P_E[playerid][info_wantedlevel]);
    INI_Int("INFO_UPGRADE",P_E[playerid][info_upgrade]);
	INI_Int("INFO_INTELIGENCI",P_E[playerid][info_inteligenci]);
	INI_Int("INFO_SCHOOL",P_E[playerid][info_school]);
	INI_Int("INFO_POWER",P_E[playerid][info_power]);
	INI_Int("INFO_DEXTERITY",P_E[playerid][info_dexterity]);
	INI_Int("INFO_VEHICLES_DOUBLE_KEY_1",P_E[playerid][info_vehicles_double_key][0]);
	INI_Int("INFO_VEHICLES_DOUBLE_KEY_2",P_E[playerid][info_vehicles_double_key][1]);
	INI_Int("INFO_VEHICLES_DOUBLE_KEY_3",P_E[playerid][info_vehicles_double_key][2]);
	INI_Int("INFO_VEHICLES_DOUBLE_KEY_4",P_E[playerid][info_vehicles_double_key][3]);
	INI_Int("INFO_LEADER",P_E[playerid][info_leader]);
	INI_Int("INFO_MEMBER",P_E[playerid][info_member]);
	INI_String("INFO_RANK",P_E[playerid][info_rank],24);
	INI_Int("INFO_HOUSES_KEY",P_E[playerid][info_houses_key]);
	INI_Int("INFO_ADMIN_HOURS",P_E[playerid][info_admin_hours]);
 	return true;
}

/*============================================================================*/

forward loadOffline(playerid,name[],value[]);
public loadOffline(playerid,name[],value[])
{
	INI_Int("INFO_POL",F_E[offline_pol]);
	INI_Int("INFO_GODINE",F_E[offline_godine]);
	INI_String("INFO_DRZAVA",F_E[offline_drzava],12);
	INI_String("INFO_PASSWORD",F_E[offline_password],24);
	INI_String("INFO_EMAIL",F_E[offline_email],24);
	INI_Int("INFO_LAST_1",F_E[offline_drzava][0]);
	INI_Int("INFO_LAST_2",F_E[offline_drzava][1]);
	INI_Int("INFO_LAST_3",F_E[offline_drzava][2]);
	INI_Int("INFO_VEHICLES_1",F_E[offline_vehicles][0]);
	INI_Int("INFO_VEHICLES_2",F_E[offline_vehicles][1]);
	INI_Int("INFO_VEHICLES_3",F_E[offline_vehicles][2]);
	INI_Int("INFO_VEHICLES_4",F_E[offline_vehicles][3]);
	return true;
}

/*============================================================================*/

forward loadAntiCheat(name[],value[]);
public loadAntiCheat(name[],value[])
{
    INI_Int("ANTICHEAT_ON",A_C[anticheat_save]);
	INI_Int("ANTICHEAT_MONEY",A_C[anticheat_money]);
	INI_Int("ANTICHEAT_HEALTH",A_C[anticheat_health]);
	INI_Int("ANTICHEAT_ARMOUR",A_C[anticheat_armour]);
	INI_Int("ANTICHEAT_RCON",A_C[anticheat_rcon]);
	INI_Int("ANTICHEAT_CHAT",A_C[anticheat_chat]);
	INI_Int("ANTICHEAT_SAY",A_C[anticheat_say]);
	INI_Int("ANTICHEAT_BUNNYHOP",A_C[anticheat_bunnyhop]);
	INI_Int("ANTICHEAT_JOYPAD",A_C[anticheat_joypad]);
	INI_Int("ANTICHEAT_WEAPONCRASH",A_C[anticheat_weaponcrash]);
	INI_Int("ANTICHEAT_REGISTER",A_C[anticheat_register]);
	return true;
}

/*============================================================================*/

forward loadLabels(lab,name[],value[]);
public loadLabels(lab,name[],value[])
{
	INI_Float("LABEL_POSITION_1",L_E[lab][label_position][0]);
	INI_Float("LABEL_POSITION_2",L_E[lab][label_position][1]);
	INI_Float("LABEL_POSITION_3",L_E[lab][label_position][2]);
	INI_String("LABEL_TEXT",L_E[lab][label_text],128);
	INI_Int("LABEL_CREATED",L_E[lab][label_created]);
	return true;
}

/*============================================================================*/

forward loadGPS(idgps,name[],value[]);
public loadGPS(idgps,name[],value[])
{
	INI_Int("GPS_LOCATION_ID",G_E[idgps][gps_id]);
	INI_String("GPS_LOCATION_NAME",G_E[idgps][gps_name_location],64);
	INI_Float("GPS_LOCATION_POSITION_1",G_E[idgps][gps_position_location][0]);
	INI_Float("GPS_LOCATION_POSITION_2",G_E[idgps][gps_position_location][1]);
	INI_Float("GPS_LOCATION_POSITION_3",G_E[idgps][gps_position_location][2]);
	return true;
}

/*============================================================================*/

forward loadHouses(idkuce,name[],value[]);
public loadHouses(idkuce,name[],value[])
{
    INI_Int("HOUSE_CREATED",H_E[idkuce][house_created]);
    INI_Int("HOUSE_OWNED",H_E[idkuce][house_owned]);
    INI_String("HOUSE_OWNER",H_E[idkuce][house_owner],MAX_PLAYER_NAME);
    INI_Int("HOUSE_PRICE",H_E[idkuce][house_price]);
    INI_Int("HOUSE_LEVEL",H_E[idkuce][house_level]);
    INI_Int("HOUSE_TYPE",H_E[idkuce][house_type]);
    INI_Int("HOUSE_LOCKED",H_E[idkuce][house_locked]);
    INI_Int("HOUSE_INTERIOR",H_E[idkuce][house_interior]);
    INI_Int("HOUSE_VIRTUALWORLD",H_E[idkuce][house_vw]);
    INI_Float("HOUSE_INSIDE_POSITION_1",H_E[idkuce][house_inside][0]);
    INI_Float("HOUSE_INSIDE_POSITION_2",H_E[idkuce][house_inside][1]);
    INI_Float("HOUSE_INSIDE_POSITION_3",H_E[idkuce][house_inside][2]);
    INI_Float("HOUSE_OUTSIDE_POSITION_1",H_E[idkuce][house_outside][0]);
    INI_Float("HOUSE_OUTSIDE_POSITION_2",H_E[idkuce][house_outside][1]);
    INI_Float("HOUSE_OUTSIDE_POSITION_3",H_E[idkuce][house_outside][2]);
    INI_Int("HOUSE_FURNITURE_SLOT_1",H_E[idkuce][house_furniture_slots][0]);
    INI_Int("HOUSE_FURNITURE_SLOT_2",H_E[idkuce][house_furniture_slots][1]);
    INI_Int("HOUSE_FURNITURE_SLOT_3",H_E[idkuce][house_furniture_slots][2]);
    INI_Int("HOUSE_FURNITURE_SLOT_4",H_E[idkuce][house_furniture_slots][3]);
    INI_Int("HOUSE_FURNITURE_SLOT_5",H_E[idkuce][house_furniture_slots][4]);
    INI_Int("HOUSE_FURNITURE_SLOT_6",H_E[idkuce][house_furniture_slots][5]);
    INI_Int("HOUSE_FURNITURE_SLOT_7",H_E[idkuce][house_furniture_slots][6]);
    INI_Int("HOUSE_FURNITURE_SLOT_8",H_E[idkuce][house_furniture_slots][7]);
    INI_Int("HOUSE_FURNITURE_SLOT_9",H_E[idkuce][house_furniture_slots][8]);
    INI_Int("HOUSE_FURNITURE_SLOT_10",H_E[idkuce][house_furniture_slots][9]);
    INI_Int("HOUSE_FURNITURE_SLOT_11",H_E[idkuce][house_furniture_slots][10]);
    INI_Int("HOUSE_FURNITURE_SLOT_12",H_E[idkuce][house_furniture_slots][11]);
    INI_Int("HOUSE_FURNITURE_SLOT_13",H_E[idkuce][house_furniture_slots][12]);
    INI_Int("HOUSE_FURNITURE_SLOT_14",H_E[idkuce][house_furniture_slots][13]);
    INI_Int("HOUSE_FURNITURE_SLOT_15",H_E[idkuce][house_furniture_slots][14]);
    INI_Float("HOUSE_FURNITURE_POSITION_1",H_E[idkuce][house_furniture_slot_1][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_1",H_E[idkuce][house_furniture_slot_1][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_1",H_E[idkuce][house_furniture_slot_1][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_1",H_E[idkuce][house_furniture_slot_1][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_2",H_E[idkuce][house_furniture_slot_2][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_2",H_E[idkuce][house_furniture_slot_2][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_2",H_E[idkuce][house_furniture_slot_2][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_2",H_E[idkuce][house_furniture_slot_2][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_3",H_E[idkuce][house_furniture_slot_3][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_3",H_E[idkuce][house_furniture_slot_3][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_3",H_E[idkuce][house_furniture_slot_3][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_3",H_E[idkuce][house_furniture_slot_3][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_4",H_E[idkuce][house_furniture_slot_4][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_4",H_E[idkuce][house_furniture_slot_4][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_4",H_E[idkuce][house_furniture_slot_4][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_4",H_E[idkuce][house_furniture_slot_4][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_5",H_E[idkuce][house_furniture_slot_5][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_5",H_E[idkuce][house_furniture_slot_5][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_5",H_E[idkuce][house_furniture_slot_5][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_5",H_E[idkuce][house_furniture_slot_5][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_6",H_E[idkuce][house_furniture_slot_6][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_6",H_E[idkuce][house_furniture_slot_6][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_6",H_E[idkuce][house_furniture_slot_6][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_6",H_E[idkuce][house_furniture_slot_6][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_7",H_E[idkuce][house_furniture_slot_7][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_7",H_E[idkuce][house_furniture_slot_7][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_7",H_E[idkuce][house_furniture_slot_7][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_7",H_E[idkuce][house_furniture_slot_7][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_8",H_E[idkuce][house_furniture_slot_8][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_8",H_E[idkuce][house_furniture_slot_8][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_8",H_E[idkuce][house_furniture_slot_8][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_8",H_E[idkuce][house_furniture_slot_8][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_9",H_E[idkuce][house_furniture_slot_9][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_9",H_E[idkuce][house_furniture_slot_9][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_9",H_E[idkuce][house_furniture_slot_9][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_9",H_E[idkuce][house_furniture_slot_9][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_10",H_E[idkuce][house_furniture_slot_10][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_10",H_E[idkuce][house_furniture_slot_10][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_10",H_E[idkuce][house_furniture_slot_10][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_10",H_E[idkuce][house_furniture_slot_10][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_11",H_E[idkuce][house_furniture_slot_11][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_11",H_E[idkuce][house_furniture_slot_11][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_11",H_E[idkuce][house_furniture_slot_11][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_11",H_E[idkuce][house_furniture_slot_11][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_12",H_E[idkuce][house_furniture_slot_12][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_12",H_E[idkuce][house_furniture_slot_12][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_12",H_E[idkuce][house_furniture_slot_12][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_12",H_E[idkuce][house_furniture_slot_12][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_13",H_E[idkuce][house_furniture_slot_13][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_13",H_E[idkuce][house_furniture_slot_13][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_13",H_E[idkuce][house_furniture_slot_13][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_13",H_E[idkuce][house_furniture_slot_13][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_14",H_E[idkuce][house_furniture_slot_14][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_14",H_E[idkuce][house_furniture_slot_14][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_14",H_E[idkuce][house_furniture_slot_14][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_14",H_E[idkuce][house_furniture_slot_14][3]);
    INI_Float("HOUSE_FURNITURE_POSITION_15",H_E[idkuce][house_furniture_slot_15][0]);
    INI_Float("HOUSE_FURNITURE_POSITION_15",H_E[idkuce][house_furniture_slot_15][1]);
    INI_Float("HOUSE_FURNITURE_POSITION_15",H_E[idkuce][house_furniture_slot_15][2]);
    INI_Float("HOUSE_FURNITURE_POSITION_15",H_E[idkuce][house_furniture_slot_15][3]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_1",H_E[idkuce][house_furniture_objects][0]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_2",H_E[idkuce][house_furniture_objects][1]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_3",H_E[idkuce][house_furniture_objects][2]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_4",H_E[idkuce][house_furniture_objects][3]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_5",H_E[idkuce][house_furniture_objects][4]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_6",H_E[idkuce][house_furniture_objects][5]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_7",H_E[idkuce][house_furniture_objects][6]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_8",H_E[idkuce][house_furniture_objects][7]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_9",H_E[idkuce][house_furniture_objects][8]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_10",H_E[idkuce][house_furniture_objects][9]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_11",H_E[idkuce][house_furniture_objects][10]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_12",H_E[idkuce][house_furniture_objects][11]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_13",H_E[idkuce][house_furniture_objects][12]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_14",H_E[idkuce][house_furniture_objects][13]);
    INI_Int("HOUSE_FURNITURE_OBJECTS_15",H_E[idkuce][house_furniture_objects][14]);
	return true;
}

/*============================================================================*/

forward loadOrganisation(idorga,name[],value[]);
public loadOrganisation(idorga,name[],value[])
{
	INI_Int("ORGANISATION_ID",O_E[idorga][org_id]);
	INI_String("ORGANISATION_NAME",O_E[idorga][org_name],64);
	INI_Int("ORGANISATION_TIP",O_E[idorga][org_tip]);
	INI_Int("ORGANISATION_MAXMEMBERS",O_E[idorga][org_maxmembers]);
	INI_Int("ORGANISATION_INVITED",O_E[idorga][org_invitemembers]);
	INI_Int("ORGANISATION_Z_SKIN_1",O_E[idorga][org_z_skin][0]);
	INI_Int("ORGANISATION_Z_SKIN_2",O_E[idorga][org_z_skin][1]);
	INI_Int("ORGANISATION_Z_SKIN_3",O_E[idorga][org_z_skin][2]);
	INI_Int("ORGANISATION_Z_SKIN_4",O_E[idorga][org_z_skin][3]);
	INI_Int("ORGANISATION_Z_SKIN_5",O_E[idorga][org_z_skin][4]);
	INI_Int("ORGANISATION_Z_SKIN_6",O_E[idorga][org_z_skin][5]);
	INI_Int("ORGANISATION_M_SKIN_1",O_E[idorga][org_m_skin][0]);
	INI_Int("ORGANISATION_M_SKIN_2",O_E[idorga][org_m_skin][1]);
	INI_Int("ORGANISATION_M_SKIN_3",O_E[idorga][org_m_skin][2]);
	INI_Int("ORGANISATION_M_SKIN_4",O_E[idorga][org_m_skin][3]);
	INI_Int("ORGANISATION_M_SKIN_5",O_E[idorga][org_m_skin][4]);
	INI_Int("ORGANISATION_M_SKIN_6",O_E[idorga][org_m_skin][5]);
	INI_String("ORGANISATION_LEADER_1",O_E[idorga][org_leader_1],24);
	INI_String("ORGANISATION_LEADER_2",O_E[idorga][org_leader_2],24);
	INI_String("ORGANISATION_MEMBER_1",O_E[idorga][org_member_1],24);
	INI_String("ORGANISATION_MEMBER_2",O_E[idorga][org_member_2],24);
	INI_String("ORGANISATION_MEMBER_3",O_E[idorga][org_member_3],24);
	INI_String("ORGANISATION_MEMBER_4",O_E[idorga][org_member_4],24);
	INI_String("ORGANISATION_MEMBER_5",O_E[idorga][org_member_5],24);
	INI_String("ORGANISATION_MEMBER_6",O_E[idorga][org_member_6],24);
	INI_String("ORGANISATION_MEMBER_7",O_E[idorga][org_member_7],24);
	INI_String("ORGANISATION_MEMBER_8",O_E[idorga][org_member_8],24);
	INI_String("ORGANISATION_MEMBER_9",O_E[idorga][org_member_9],24);
	INI_String("ORGANISATION_MEMBER_10",O_E[idorga][org_member_10],24);
	INI_String("ORGANISATION_MEMBER_11",O_E[idorga][org_member_11],24);
	INI_String("ORGANISATION_MEMBER_12",O_E[idorga][org_member_12],24);
	INI_String("ORGANISATION_MEMBER_13",O_E[idorga][org_member_13],24);
	INI_String("ORGANISATION_MEMBER_14",O_E[idorga][org_member_14],24);
	INI_String("ORGANISATION_MEMBER_15",O_E[idorga][org_member_15],24);
	INI_Float("ORGANISATION_POSITION_EXT_1",O_E[idorga][org_position_ext][0]);
	INI_Float("ORGANISATION_POSITION_EXT_2",O_E[idorga][org_position_ext][1]);
	INI_Float("ORGANISATION_POSITION_EXT_3",O_E[idorga][org_position_ext][2]);
	INI_Float("ORGANISATION_POSITION_INT_1",O_E[idorga][org_position_int][0]);
	INI_Float("ORGANISATION_POSITION_INT_2",O_E[idorga][org_position_int][1]);
	INI_Float("ORGANISATION_POSITION_INT_3",O_E[idorga][org_position_int][2]);
	INI_Int("ORGANISATION_INTERIOR",O_E[idorga][org_int]);
	INI_Int("ORGANISATION_VW",O_E[idorga][org_vw]);
	INI_String("ORGANISATION_RANK_1",O_E[idorga][org_rank_1],64);
	INI_String("ORGANISATION_RANK_2",O_E[idorga][org_rank_2],64);
	INI_String("ORGANISATION_RANK_3",O_E[idorga][org_rank_3],64);
	INI_String("ORGANISATION_RANK_4",O_E[idorga][org_rank_4],64);
	INI_String("ORGANISATION_RANK_5",O_E[idorga][org_rank_5],64);
	INI_String("ORGANISATION_RANK_6",O_E[idorga][org_rank_6],64);
	INI_Int("ORGANISATION_LEVEL",O_E[idorga][org_level]);
	INI_Float("ORGANISATION_VEHICLE_1_1",O_E[idorga][org_vehicle_1][0]);
	INI_Float("ORGANISATION_VEHICLE_1_2",O_E[idorga][org_vehicle_1][1]);
	INI_Float("ORGANISATION_VEHICLE_1_3",O_E[idorga][org_vehicle_1][2]);
	INI_Float("ORGANISATION_VEHICLE_1_4",O_E[idorga][org_vehicle_1][3]);
    INI_Float("ORGANISATION_VEHICLE_2_1",O_E[idorga][org_vehicle_2][0]);
	INI_Float("ORGANISATION_VEHICLE_2_2",O_E[idorga][org_vehicle_2][1]);
	INI_Float("ORGANISATION_VEHICLE_2_3",O_E[idorga][org_vehicle_2][2]);
	INI_Float("ORGANISATION_VEHICLE_2_4",O_E[idorga][org_vehicle_2][3]);
	INI_Float("ORGANISATION_VEHICLE_3_1",O_E[idorga][org_vehicle_3][0]);
	INI_Float("ORGANISATION_VEHICLE_3_2",O_E[idorga][org_vehicle_3][1]);
	INI_Float("ORGANISATION_VEHICLE_3_3",O_E[idorga][org_vehicle_3][2]);
	INI_Float("ORGANISATION_VEHICLE_3_4",O_E[idorga][org_vehicle_3][3]);
	INI_Float("ORGANISATION_VEHICLE_4_1",O_E[idorga][org_vehicle_4][0]);
	INI_Float("ORGANISATION_VEHICLE_4_2",O_E[idorga][org_vehicle_4][1]);
	INI_Float("ORGANISATION_VEHICLE_4_3",O_E[idorga][org_vehicle_4][2]);
	INI_Float("ORGANISATION_VEHICLE_4_4",O_E[idorga][org_vehicle_4][3]);
	INI_Float("ORGANISATION_VEHICLE_5_1",O_E[idorga][org_vehicle_5][0]);
	INI_Float("ORGANISATION_VEHICLE_5_2",O_E[idorga][org_vehicle_5][1]);
	INI_Float("ORGANISATION_VEHICLE_5_3",O_E[idorga][org_vehicle_5][2]);
	INI_Float("ORGANISATION_VEHICLE_5_4",O_E[idorga][org_vehicle_5][3]);
	INI_Float("ORGANISATION_VEHICLE_6_1",O_E[idorga][org_vehicle_6][0]);
	INI_Float("ORGANISATION_VEHICLE_6_2",O_E[idorga][org_vehicle_6][1]);
	INI_Float("ORGANISATION_VEHICLE_6_3",O_E[idorga][org_vehicle_6][2]);
	INI_Float("ORGANISATION_VEHICLE_6_4",O_E[idorga][org_vehicle_6][3]);
	INI_Float("ORGANISATION_VEHICLE_7_1",O_E[idorga][org_vehicle_7][0]);
	INI_Float("ORGANISATION_VEHICLE_7_2",O_E[idorga][org_vehicle_7][1]);
	INI_Float("ORGANISATION_VEHICLE_7_3",O_E[idorga][org_vehicle_7][2]);
	INI_Float("ORGANISATION_VEHICLE_7_4",O_E[idorga][org_vehicle_7][3]);
	INI_Float("ORGANISATION_VEHICLE_8_1",O_E[idorga][org_vehicle_8][0]);
	INI_Float("ORGANISATION_VEHICLE_8_2",O_E[idorga][org_vehicle_8][1]);
	INI_Float("ORGANISATION_VEHICLE_8_3",O_E[idorga][org_vehicle_8][2]);
	INI_Float("ORGANISATION_VEHICLE_8_4",O_E[idorga][org_vehicle_8][3]);
	INI_Int("ORGANISATION_VEHICLE_SLOT_1",O_E[idorga][org_vehicle_slot_1]);
	INI_Int("ORGANISATION_VEHICLE_SLOT_2",O_E[idorga][org_vehicle_slot_2]);
	INI_Int("ORGANISATION_VEHICLE_SLOT_3",O_E[idorga][org_vehicle_slot_3]);
	INI_Int("ORGANISATION_VEHICLE_SLOT_4",O_E[idorga][org_vehicle_slot_4]);
	INI_Int("ORGANISATION_VEHICLE_SLOT_5",O_E[idorga][org_vehicle_slot_5]);
	INI_Int("ORGANISATION_VEHICLE_SLOT_6",O_E[idorga][org_vehicle_slot_6]);
	INI_Int("ORGANISATION_VEHICLE_SLOT_7",O_E[idorga][org_vehicle_slot_7]);
	INI_Int("ORGANISATION_VEHICLE_SLOT_8",O_E[idorga][org_vehicle_slot_8]);
	INI_Int("ORGANISATION_VEHICLE_1_CREATED",O_E[idorga][org_vehicles_created][0]);
	INI_Int("ORGANISATION_VEHICLE_2_CREATED",O_E[idorga][org_vehicles_created][1]);
	INI_Int("ORGANISATION_VEHICLE_3_CREATED",O_E[idorga][org_vehicles_created][2]);
	INI_Int("ORGANISATION_VEHICLE_4_CREATED",O_E[idorga][org_vehicles_created][3]);
	INI_Int("ORGANISATION_VEHICLE_5_CREATED",O_E[idorga][org_vehicles_created][4]);
	INI_Int("ORGANISATION_VEHICLE_6_CREATED",O_E[idorga][org_vehicles_created][5]);
	INI_Int("ORGANISATION_VEHICLE_7_CREATED",O_E[idorga][org_vehicles_created][6]);
	INI_Int("ORGANISATION_VEHICLE_8_CREATED",O_E[idorga][org_vehicles_created][7]);
	INI_Int("ORGANISATION_SEF_CASH",O_E[idorga][org_cash]);
	INI_Int("OGANISATION_SEF_DRUGS",O_E[idorga][org_drugs]);
	INI_Int("ORGANISATION_SEF_MATERIALS",O_E[idorga][org_materials]);
	INI_Float("ORGANISATION_SEF_POSITION_1",O_E[idorga][org_sef_position][0]);
	INI_Float("ORGANISATION_SEF_POSITION_2",O_E[idorga][org_sef_position][1]);
	INI_Float("ORGANISATION_SEF_POSITION_3",O_E[idorga][org_sef_position][2]);
	INI_Int("ORGANISATION_SEF",O_E[idorga][org_sef]);
	INI_Int("ORGANISATION_CREATED_1",O_E[idorga][org_ranks_created][0]);
	INI_Int("ORGANISATION_CREATED_2",O_E[idorga][org_ranks_created][1]);
	INI_Int("ORGANISATION_CREATED_3",O_E[idorga][org_ranks_created][2]);
	INI_Int("ORGANISATION_CREATED_4",O_E[idorga][org_ranks_created][3]);
	INI_Int("ORGANISATION_CREATED_5",O_E[idorga][org_ranks_created][4]);
	INI_Int("ORGANISATION_CREATED_6",O_E[idorga][org_ranks_created][5]);
	INI_String("ORG_TABLICE_SLOT_1",O_E[idorga][org_tablice_slot_1],10);
	INI_String("ORG_TABLICE_SLOT_2",O_E[idorga][org_tablice_slot_2],10);
	INI_String("ORG_TABLICE_SLOT_3",O_E[idorga][org_tablice_slot_3],10);
	INI_String("ORG_TABLICE_SLOT_4",O_E[idorga][org_tablice_slot_4],10);
	INI_String("ORG_TABLICE_SLOT_5",O_E[idorga][org_tablice_slot_5],10);
	INI_String("ORG_TABLICE_SLOT_6",O_E[idorga][org_tablice_slot_6],10);
	INI_String("ORG_TABLICE_SLOT_7",O_E[idorga][org_tablice_slot_7],10);
	INI_String("ORG_TABLICE_SLOT_8",O_E[idorga][org_tablice_slot_8],10);
	return true;
}

/*============================================================================*/

forward loadVehicles(idvehicles,name[],value[]);
public loadVehicles(idvehicles,name[],value[])
{
    INI_Int("VEHICLE_ID",V_E[idvehicles][vehicle_id]);
    INI_Int("VEHICLE_OWNED",V_E[idvehicles][vehicle_owned]);
    INI_Int("VEHICLE_PRICE",V_E[idvehicles][vehicle_price]);
    INI_String("VEHICLE_OWNER",V_E[idvehicles][vehicle_owner],MAX_PLAYER_NAME);
    INI_Int("VEHICLE_LOCKED",V_E[idvehicles][vehicle_locked]);
    INI_Float("VEHICLE_POSITIONS_1",V_E[idvehicles][vehicle_positions][0]);
    INI_Float("VEHICLE_POSITIONS_2",V_E[idvehicles][vehicle_positions][0]);
    INI_Float("VEHICLE_POSITIONS_3",V_E[idvehicles][vehicle_positions][0]);
    INI_Float("VEHICLE_POSITIONS_4",V_E[idvehicles][vehicle_positions][0]);
    INI_Int("VEHICLE_COLOR_1",V_E[idvehicles][vehicle_colors][0]);
    INI_Int("VEHICLE_COLOR_2",V_E[idvehicles][vehicle_colors][0]);
    INI_Int("VEHICLE_MODEL",V_E[idvehicles][vehicle_model]);
	return true;
}

/*============================================================================*/

forward loadSalons(idsalona,name[],value[]);
public loadSalons(idsalona,name[],value[])
{
	INI_Int("SALON_VEHICLE_1",A_E[idsalona][salon_vehicle][0]);
	INI_Int("SALON_VEHICLE_2",A_E[idsalona][salon_vehicle][1]);
	INI_Int("SALON_VEHICLE_3",A_E[idsalona][salon_vehicle][2]);
	INI_Int("SALON_VEHICLE_4",A_E[idsalona][salon_vehicle][3]);
	INI_Int("SALON_VEHICLE_5",A_E[idsalona][salon_vehicle][4]);
	INI_Int("SALON_MODELPRICE_1",A_E[idsalona][salon_modelprice][0]);
	INI_Int("SALON_MODELPRICE_2",A_E[idsalona][salon_modelprice][1]);
	INI_Int("SALON_MODELPRICE_3",A_E[idsalona][salon_modelprice][2]);
	INI_Int("SALON_MODELPRICE_4",A_E[idsalona][salon_modelprice][3]);
	INI_Int("SALON_MODELPRICE_5",A_E[idsalona][salon_modelprice][4]);
	INI_String("SALON_OWNER",A_E[idsalona][salon_owner],MAX_PLAYER_NAME);
	INI_Int("SALON_OWNED",A_E[idsalona][salon_owned]);
	INI_Float("SALON_POSITION_1",A_E[idsalona][salon_position][0]);
	INI_Float("SALON_POSITION_2",A_E[idsalona][salon_position][1]);
	INI_Float("SALON_POSITION_3",A_E[idsalona][salon_position][2]);
	INI_Float("SALON_VEHICLEPOSITION_1",A_E[idsalona][salon_vehicleposition][0]);
	INI_Float("SALON_VEHICLEPOSITION_2",A_E[idsalona][salon_vehicleposition][1]);
	INI_Float("SALON_VEHICLEPOSITION_3",A_E[idsalona][salon_vehicleposition][2]);
	INI_Float("SALON_VEHICLEPOSITION_4",A_E[idsalona][salon_vehicleposition][3]);
	INI_String("SALON_NAME",A_E[idsalona][salon_name],24);
	INI_Int("SALON_MAXMODELS_1",A_E[idsalona][salon_maxmodels][0]);
	INI_Int("SALON_MAXMODELS_2",A_E[idsalona][salon_maxmodels][1]);
	INI_Int("SALON_MAXMODELS_3",A_E[idsalona][salon_maxmodels][2]);
	INI_Int("SALON_MAXMODELS_4",A_E[idsalona][salon_maxmodels][3]);
	INI_Int("SALON_MAXMODELS_5",A_E[idsalona][salon_maxmodels][4]);
	INI_Int("SALON_BUY",A_E[idsalona][salon_buy]);
	INI_Int("SALON_CREATED",A_E[idsalona][salon_created]);
	INI_Int("SALON_LEVEL",A_E[idsalona][salon_level]);
	INI_Int("SALON_MONEY",A_E[idsalona][salon_money]);
    INI_Int("SALON_CASH",A_E[idsalona][salon_cash]);
	return true;
}

/*============================================================================*/

forward lawless_PayDay(playerid);
public lawless_PayDay(playerid)
{
	if(lawless_Logo[playerid] == 1)
	{
	    if(P_E[playerid][info_level] > 0)
	    {
	        new levelexp = 3;
		    new nxtlevel = P_E[playerid][info_level]+1;
			new expamount = nxtlevel*levelexp;

			P_E[playerid][info_hours] += 1;
			P_E[playerid][info_paypoen] = 0;
			P_E[playerid][info_experiens]++;
			
			/* STAVITI KADA BUDE RADIO DA MU DAJE PLATU I ONDA SVE NA RACUN,AKO JE OTVOREN */
			
			INFO(playerid,"Uspesno ste dobili platu!");
			
			if(P_E[playerid][info_admin] != 0)
			{
                P_E[playerid][info_admin_hours]++;
                lawless_saveUser(playerid);
                
                /* STAVITI KADA BUDE BIO AFK DA NE DOBIJA ADMIN HOURS */
                
                INFO(playerid,"Vi kao clan 'law_adm' ste dobili '+1h' u 'law_adm'!");
                INFO(playerid,"(( Sada ukupno imate '%dh' u 'law_adm' timu - Hvala sto se trudite! ))",P_E[playerid][info_admin_hours]);
            }
            
			if(P_E[playerid][info_experiens] >= expamount)
			{
			    P_E[playerid][info_level] += 1;
			    P_E[playerid][info_paypoen] = 0;
			    P_E[playerid][info_upgrade] += random(2);
				P_E[playerid][info_experiens] = 0;
                lawless_saveUser(playerid);
                
                /* STAVITI KADA BUDE BIO AFK DA NE DOBIJA UPGRADE POENE */
                
				INFO(playerid,"(( Sada ste level '%d'. Cestitamo - ukupno imate '%dh' igre. ))",nxtlevel,P_E[playerid][info_hours]);
				
				INFO(playerid,"Mozete iskoristiti,upgrade poene za neke stvari koje ce vam biti potrebne.");
				INFO(playerid,"Trenutno imate '%d' - neiskoriscenih upgrade poena!",P_E[playerid][info_upgrade]);
				INFO(playerid,"Da iskoristite,neiskoriscene upgrade poene - '/accountupgrade'!");
			}
            lawless_saveUser(playerid);
		}
	}
	return true;
}

/*============================================================================*/

forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx;
		new Float:posy;
		new Float:posz;
		new Float:oldposx;
		new Float:oldposy;
		new Float:oldposz;
		new Float:tempposx;
		new Float:tempposy;
		new Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		 	if(IsPlayerConnected(i))
			{
				if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
				{
				 	if(lawless_Logo[i] == 1)
				 	{
						GetPlayerPos(i,posx,posy,posz);
						tempposx = (oldposx-posx);
						tempposy = (oldposy-posy);
						tempposz = (oldposz-posz);
						if(((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						{
							lawless_SCM(i,col1,string);
						}
						else if(((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						{
							lawless_SCM(i,col2,string);
						}
						else if(((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						{
							lawless_SCM(i,col3,string);
						}
						else if(((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						{
							lawless_SCM(i,col4,string);
						}
						else if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						{
							lawless_SCM(i,col5,string);
						}
					}
				}
			}
		}
	}
	return true;
}

/*============================================================================*/

forward lawless_INTEXT(playerid);
public lawless_INTEXT(playerid)
{
    for(new i = 1; i < MAX_ORG; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid,2.0,O_E[i][org_position_ext][0],O_E[i][org_position_ext][1],O_E[i][org_position_ext][2]))
		{
			lawless_Loadinger[playerid] = i;
				
			lawless_FREEZE(playerid,false);
			SetCameraBehindPlayer(playerid);
			defer lawless_SpawnConfirmed(playerid);
			SetPlayerInterior(playerid,O_E[i][org_int]);
			SetPlayerVirtualWorld(playerid,O_E[i][org_vw]);
			lawless_POSITIONS(playerid,O_E[i][org_position_int][0],O_E[i][org_position_int][1],O_E[i][org_position_int][2]);
		}
		else if(IsPlayerInRangeOfPoint(playerid,2.0,O_E[i][org_position_int][0],O_E[i][org_position_int][1],O_E[i][org_position_int][2]))
		{
			lawless_Loadinger[playerid] = -1;
			
			lawless_FREEZE(playerid,false);
			SetCameraBehindPlayer(playerid);
			defer lawless_SpawnConfirmed(playerid);
  			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,0);
			lawless_POSITIONS(playerid,O_E[i][org_position_ext][0],O_E[i][org_position_ext][1],O_E[i][org_position_ext][2]);
		}
	}
	for(new i; i < MAX_HOUSES; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid,3.0,H_E[i][house_outside][0],H_E[i][house_outside][1],H_E[i][house_outside][2]))
		{
		 	if(P_E[playerid][info_houses_key] == i || H_E[i][house_locked] == 1)
			{
			 	if(lawless_JOIN_INTERIOR[playerid] == 1) return true;
			 	lawless_JOIN_INTERIOR[playerid] = 1;
			 	SetPlayerVirtualWorld(playerid,H_E[i][house_vw]);
			 	
			 	lawless_FREEZE(playerid,false);
				SetCameraBehindPlayer(playerid);
			
				SetPlayerInterior(playerid,H_E[i][house_interior]);
				SetPlayerPos(playerid,H_E[i][house_inside][0],H_E[i][house_inside][1],H_E[i][house_inside][2]);
                defer lawless_SpawnConfirmed(playerid);
				break;
			}
			else
			{
				ERROR(playerid,"Kuca je zakljucana!");
				break;
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,3.0,H_E[i][house_inside][0],H_E[i][house_inside][1],H_E[i][house_inside][2]))
		{
			if(P_E[playerid][info_houses_key] == i || H_E[i][house_locked] == 1)
			{
				if(lawless_JOIN_INTERIOR[playerid] == 1) return true;
				lawless_JOIN_INTERIOR[playerid] = 1;
				SetPlayerVirtualWorld(playerid,0);
				
				lawless_FREEZE(playerid,false);
				SetCameraBehindPlayer(playerid);
				
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,H_E[i][house_outside][0],H_E[i][house_outside][1],H_E[i][house_outside][2]);
                defer lawless_SpawnConfirmed(playerid);
				break;
			}
			else
			{
			    ERROR(playerid,"Kuca je zakljucana!");
			    break;
			}
		}
	}
	return true;
}

/*============================================================================*/

stock lawless_UserPath(playerid)
{
	new string[128];
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	format(string,sizeof(string),PATH,playername);
	return string;
}

/*============================================================================*/

stock lawless_Nick(playerid)
{
	new name[MAX_PLAYER_NAME];
 	GetPlayerName(playerid,name,sizeof(name));
  	return name;
}

/*============================================================================*/

stock lawless_NickEx(playerid)
{
	new name[24];
	GetPlayerName(playerid,name,24);
	return name;
}

/*============================================================================*/

stock lawless_String(obj[], string[])
{
    strmid(obj,string,0,strlen(string),255);
    return true;
}

/*============================================================================*/

stock lawless_Chat(playerid, lines)
{
	if(IsPlayerConnected(playerid))
	{
		for(new i = 0; i < lines; i++)
		{
			lawless_SCM(playerid,-1," ");
		}
	}
	return true;
}

/*============================================================================*/

stock lawless_SetPlayerArmour(playerid, Float:armor)
{
	if(armor > 98.0)
	{
		armor = 98.0;
	}
	SetPlayerArmour(playerid,armor);
	return true;
}

/*============================================================================*/

stock lawless_SetPlayerHealth(playerid, Float:health)
{
	if(health < 0.0)
	{
		health = 0.0;
	}
	if(health > 98.0)
	{
		health = 98.0;
	}
	SetPlayerHealth(playerid,health);
	return true;
}

/*============================================================================*/

stock lawless_GivePlayerMoney(playerid, kolicina)
{
	GivePlayerMoney(playerid,kolicina);
	lawless_saveUser(playerid);
 	return true;
}

/*============================================================================*/

stock lawless_saveUser(playerid)
{
    if(lawless_Logo[playerid] == 1)
    {
	    new INI:File = INI_Open(lawless_UserPath(playerid));

	    INI_SetTag(File,"LAWLESS_GAMING_INFO_DATA:");
	    INI_WriteString(File,"INFO_PASSWORD",P_E[playerid][info_password]);
		INI_WriteInt(File,"INFO_POL",P_E[playerid][info_pol]);
		INI_WriteString(File,"INFO_DRZAVA",P_E[playerid][info_drzava]);
		INI_WriteInt(File,"INFO_GODINE",P_E[playerid][info_godine]);
	    INI_WriteInt(File,"INFO_SKIN",P_E[playerid][info_skin]);
	    INI_WriteString(File,"INFO_SECURITY",P_E[playerid][info_security]);
	    INI_WriteString(File,"INFO_EMAIL",P_E[playerid][info_email]);
	    INI_WriteInt(File,"INFO_REGISTRATION",P_E[playerid][info_registration]);
	    INI_WriteInt(File,"INFO_LEVEL",P_E[playerid][info_level]);
	    INI_WriteInt(File,"INFO_CASH",P_E[playerid][info_cash]);
	    INI_WriteInt(File,"INFO_LAST_1",P_E[playerid][info_last][0]);
	    INI_WriteInt(File,"INFO_LAST_2",P_E[playerid][info_last][1]);
	    INI_WriteInt(File,"INFO_LAST_3",P_E[playerid][info_last][2]);
	    INI_WriteInt(File,"INFO_STAT",P_E[playerid][info_stat]);
	    INI_WriteInt(File,"INFO_BANK",P_E[playerid][info_bank]);
	    INI_WriteInt(File,"INFO_EURO",P_E[playerid][info_euro]);
	    INI_WriteInt(File,"INFO_PAYPOEN",P_E[playerid][info_paypoen]);
    	INI_WriteInt(File,"INFO_EXPERIENS",P_E[playerid][info_experiens]);
    	INI_WriteInt(File,"INFO_HOURS",P_E[playerid][info_hours]);
    	INI_WriteInt(File,"INFO_COLOUR",P_E[playerid][info_colour]);
    	INI_WriteInt(File,"INFO_ADMIN",P_E[playerid][info_admin]);
    	INI_WriteInt(File,"INFO_ACODE",P_E[playerid][info_acode]);
    	INI_WriteInt(File,"INFO_VEHICLES_1",P_E[playerid][info_vehicles][0]);
	    INI_WriteInt(File,"INFO_VEHICLES_2",P_E[playerid][info_vehicles][1]);
	    INI_WriteInt(File,"INFO_VEHICLES_3",P_E[playerid][info_vehicles][2]);
	    INI_WriteInt(File,"INFO_VEHICLES_4",P_E[playerid][info_vehicles][3]);
	    INI_WriteInt(File,"INFO_VEHSALON",P_E[playerid][info_vehsalon]);
	    INI_WriteInt(File,"INFO_INSURANCE",P_E[playerid][info_insurance]);
	    INI_WriteInt(File,"INFO_HUNGRY",P_E[playerid][info_hungry]);
	    INI_WriteInt(File,"INFO_TUTORIAL",P_E[playerid][info_tutorial]);
	    INI_WriteInt(File,"INFO_WANTEDLEVEL",P_E[playerid][info_wantedlevel]);
	    INI_WriteInt(File,"INFO_UPGRADE",P_E[playerid][info_upgrade]);
		INI_WriteInt(File,"INFO_INTELIGENCI",P_E[playerid][info_inteligenci]);
		INI_WriteInt(File,"INFO_SCHOOL",P_E[playerid][info_school]);
		INI_WriteInt(File,"INFO_POWER",P_E[playerid][info_power]);
		INI_WriteInt(File,"INFO_DEXTERITY",P_E[playerid][info_dexterity]);
		INI_WriteInt(File,"INFO_VEHICLES_DOUBLE_KEY_1",P_E[playerid][info_vehicles_double_key][0]);
		INI_WriteInt(File,"INFO_VEHICLES_DOUBLE_KEY_2",P_E[playerid][info_vehicles_double_key][1]);
		INI_WriteInt(File,"INFO_VEHICLES_DOUBLE_KEY_3",P_E[playerid][info_vehicles_double_key][2]);
		INI_WriteInt(File,"INFO_VEHICLES_DOUBLE_KEY_4",P_E[playerid][info_vehicles_double_key][3]);
		INI_WriteInt(File,"INFO_LEADER",P_E[playerid][info_leader]);
		INI_WriteInt(File,"INFO_MEMBER",P_E[playerid][info_member]);
		INI_WriteString(File,"INFO_RANK",P_E[playerid][info_rank]);
		INI_WriteInt(File,"INFO_HOUSES_KEY",P_E[playerid][info_houses_key]);
		INI_WriteInt(File,"INFO_ADMIN_HOURS",P_E[playerid][info_admin_hours]);
		INI_Close(File);
    }
	return true;
}

/*============================================================================*/

stock lawless_saveAC()
{
	new INI:File = INI_Open(ACATH);

	INI_SetTag(File,"LAWLESS_GAMING_ANTICHEAT_DATA:");
	INI_WriteInt(File,"ANTICHEAT_ON",A_C[anticheat_save]);
	INI_WriteInt(File,"ANTICHEAT_MONEY",A_C[anticheat_money]);
	INI_WriteInt(File,"ANTICHEAT_HEALTH",A_C[anticheat_health]);
	INI_WriteInt(File,"ANTICHEAT_ARMOUR",A_C[anticheat_armour]);
	INI_WriteInt(File,"ANTICHEAT_RCON",A_C[anticheat_rcon]);
	INI_WriteInt(File,"ANTICHEAT_CHAT",A_C[anticheat_chat]);
	INI_WriteInt(File,"ANTICHEAT_SAY",A_C[anticheat_say]);
    INI_WriteInt(File,"ANTICHEAT_BUNNYHOP",A_C[anticheat_bunnyhop]);
    INI_WriteInt(File,"ANTICHEAT_JOYPAD",A_C[anticheat_joypad]);
    INI_WriteInt(File,"ANTICHEAT_WEAPONCRASH",A_C[anticheat_weaponcrash]);
    INI_WriteInt(File,"ANTICHEAT_REGISTER",A_C[anticheat_register]);
	INI_Close(File);
	return true;
}

/*============================================================================*/

stock lawless_saveGPS(gpsid)
{
	new lawless_gpsov[50];
	format(lawless_gpsov,sizeof(lawless_gpsov),GPSS,gpsid);
	new INI:File = INI_Open(lawless_gpsov);

	INI_WriteInt(File,"GPS_LOCATION_ID",G_E[gpsid][gps_id]);
	INI_WriteString(File,"GPS_LOCATION_NAME",G_E[gpsid][gps_name_location]);
	INI_WriteFloat(File,"GPS_LOCATION_POSITION_1",G_E[gpsid][gps_position_location][0]);
	INI_WriteFloat(File,"GPS_LOCATION_POSITION_2",G_E[gpsid][gps_position_location][1]);
	INI_WriteFloat(File,"GPS_LOCATION_POSITION_3",G_E[gpsid][gps_position_location][2]);
	INI_Close(File);
	return true;
}

/*============================================================================*/

stock lawless_saveLABEL(labelid)
{
	new lawless_labels[50];
	format(lawless_labels,sizeof(lawless_labels),LABS,labelid);
	new INI:File = INI_Open(lawless_labels);

	INI_SetTag(File,"LAWLESS_GAMING_LABEL_DATA:");
	INI_WriteFloat(File,"LABEL_POSITION_1",L_E[labelid][label_position][0]);
	INI_WriteFloat(File,"LABEL_POSITION_2",L_E[labelid][label_position][1]);
	INI_WriteFloat(File,"LABEL_POSITION_3",L_E[labelid][label_position][2]);
	INI_WriteString(File,"LABEL_TEXT",L_E[labelid][label_text]);
	INI_WriteInt(File,"LABEL_CREATED",L_E[labelid][label_created]);
	INI_Close(File);
	return true;
}

/*============================================================================*/

stock lawless_saveHOUSE(idkuce)
{
	new lawless_h_f[50];
	format(lawless_h_f,sizeof(lawless_h_f),HOUS,idkuce);
	new INI:File = INI_Open(lawless_h_f);
	
	INI_SetTag(File,"LAWLESS_GAMING_HOUSE_DATA:");
	INI_WriteInt(File,"HOUSE_CREATED",H_E[idkuce][house_created]);
	INI_WriteInt(File,"HOUSE_OWNED",H_E[idkuce][house_owned]);
    INI_WriteString(File,"HOUSE_OWNER",H_E[idkuce][house_owner]);
    INI_WriteInt(File,"HOUSE_PRICE",H_E[idkuce][house_price]);
    INI_WriteInt(File,"HOUSE_LEVEL",H_E[idkuce][house_level]);
    INI_WriteInt(File,"HOUSE_TYPE",H_E[idkuce][house_type]);
    INI_WriteInt(File,"HOUSE_LOCKED",H_E[idkuce][house_locked]);
    INI_WriteInt(File,"HOUSE_INTERIOR",H_E[idkuce][house_interior]);
    INI_WriteInt(File,"HOUSE_VIRTUALWORLD",H_E[idkuce][house_vw]);
    INI_WriteFloat(File,"HOUSE_INSIDE_POSITION_1",H_E[idkuce][house_inside][0]);
    INI_WriteFloat(File,"HOUSE_INSIDE_POSITION_2",H_E[idkuce][house_inside][1]);
    INI_WriteFloat(File,"HOUSE_INSIDE_POSITION_3",H_E[idkuce][house_inside][2]);
    INI_WriteFloat(File,"HOUSE_OUTSIDE_POSITION_1",H_E[idkuce][house_outside][0]);
    INI_WriteFloat(File,"HOUSE_OUTSIDE_POSITION_2",H_E[idkuce][house_outside][1]);
    INI_WriteFloat(File,"HOUSE_OUTSIDE_POSITION_3",H_E[idkuce][house_outside][2]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_1",H_E[idkuce][house_furniture_slots][0]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_2",H_E[idkuce][house_furniture_slots][1]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_3",H_E[idkuce][house_furniture_slots][2]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_4",H_E[idkuce][house_furniture_slots][3]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_5",H_E[idkuce][house_furniture_slots][4]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_6",H_E[idkuce][house_furniture_slots][5]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_7",H_E[idkuce][house_furniture_slots][6]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_8",H_E[idkuce][house_furniture_slots][7]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_9",H_E[idkuce][house_furniture_slots][8]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_10",H_E[idkuce][house_furniture_slots][9]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_11",H_E[idkuce][house_furniture_slots][10]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_12",H_E[idkuce][house_furniture_slots][11]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_13",H_E[idkuce][house_furniture_slots][12]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_14",H_E[idkuce][house_furniture_slots][13]);
    INI_WriteInt(File,"HOUSE_FURNITURE_SLOT_15",H_E[idkuce][house_furniture_slots][14]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_1",H_E[idkuce][house_furniture_slot_1][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_1",H_E[idkuce][house_furniture_slot_1][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_1",H_E[idkuce][house_furniture_slot_1][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_1",H_E[idkuce][house_furniture_slot_1][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_2",H_E[idkuce][house_furniture_slot_2][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_2",H_E[idkuce][house_furniture_slot_2][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_2",H_E[idkuce][house_furniture_slot_2][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_2",H_E[idkuce][house_furniture_slot_2][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_3",H_E[idkuce][house_furniture_slot_3][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_3",H_E[idkuce][house_furniture_slot_3][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_3",H_E[idkuce][house_furniture_slot_3][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_3",H_E[idkuce][house_furniture_slot_3][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_4",H_E[idkuce][house_furniture_slot_4][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_4",H_E[idkuce][house_furniture_slot_4][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_4",H_E[idkuce][house_furniture_slot_4][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_4",H_E[idkuce][house_furniture_slot_4][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_5",H_E[idkuce][house_furniture_slot_5][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_5",H_E[idkuce][house_furniture_slot_5][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_5",H_E[idkuce][house_furniture_slot_5][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_5",H_E[idkuce][house_furniture_slot_5][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_6",H_E[idkuce][house_furniture_slot_6][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_6",H_E[idkuce][house_furniture_slot_6][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_6",H_E[idkuce][house_furniture_slot_6][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_6",H_E[idkuce][house_furniture_slot_6][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_7",H_E[idkuce][house_furniture_slot_7][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_7",H_E[idkuce][house_furniture_slot_7][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_7",H_E[idkuce][house_furniture_slot_7][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_7",H_E[idkuce][house_furniture_slot_7][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_8",H_E[idkuce][house_furniture_slot_8][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_8",H_E[idkuce][house_furniture_slot_8][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_8",H_E[idkuce][house_furniture_slot_8][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_8",H_E[idkuce][house_furniture_slot_8][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_9",H_E[idkuce][house_furniture_slot_9][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_9",H_E[idkuce][house_furniture_slot_9][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_9",H_E[idkuce][house_furniture_slot_9][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_9",H_E[idkuce][house_furniture_slot_9][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_10",H_E[idkuce][house_furniture_slot_10][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_10",H_E[idkuce][house_furniture_slot_10][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_10",H_E[idkuce][house_furniture_slot_10][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_10",H_E[idkuce][house_furniture_slot_10][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_11",H_E[idkuce][house_furniture_slot_11][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_11",H_E[idkuce][house_furniture_slot_11][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_11",H_E[idkuce][house_furniture_slot_11][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_11",H_E[idkuce][house_furniture_slot_11][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_12",H_E[idkuce][house_furniture_slot_12][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_12",H_E[idkuce][house_furniture_slot_12][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_12",H_E[idkuce][house_furniture_slot_12][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_12",H_E[idkuce][house_furniture_slot_12][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_13",H_E[idkuce][house_furniture_slot_13][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_13",H_E[idkuce][house_furniture_slot_13][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_13",H_E[idkuce][house_furniture_slot_13][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_13",H_E[idkuce][house_furniture_slot_13][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_14",H_E[idkuce][house_furniture_slot_14][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_14",H_E[idkuce][house_furniture_slot_14][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_14",H_E[idkuce][house_furniture_slot_14][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_14",H_E[idkuce][house_furniture_slot_14][3]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_15",H_E[idkuce][house_furniture_slot_15][0]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_15",H_E[idkuce][house_furniture_slot_15][1]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_15",H_E[idkuce][house_furniture_slot_15][2]);
    INI_WriteFloat(File,"HOUSE_FURNITURE_POSITION_15",H_E[idkuce][house_furniture_slot_15][3]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_1",H_E[idkuce][house_furniture_objects][0]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_2",H_E[idkuce][house_furniture_objects][1]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_3",H_E[idkuce][house_furniture_objects][2]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_4",H_E[idkuce][house_furniture_objects][3]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_5",H_E[idkuce][house_furniture_objects][4]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_6",H_E[idkuce][house_furniture_objects][5]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_7",H_E[idkuce][house_furniture_objects][6]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_8",H_E[idkuce][house_furniture_objects][7]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_9",H_E[idkuce][house_furniture_objects][8]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_10",H_E[idkuce][house_furniture_objects][9]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_11",H_E[idkuce][house_furniture_objects][10]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_12",H_E[idkuce][house_furniture_objects][11]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_13",H_E[idkuce][house_furniture_objects][12]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_14",H_E[idkuce][house_furniture_objects][13]);
    INI_WriteInt(File,"HOUSE_FURNITURE_OBJECTS_15",H_E[idkuce][house_furniture_objects][14]);
	INI_Close(File);
	return true;
}

/*============================================================================*/

stock lawless_saveORG(idorga)
{
	new lawless_orga[50];
	format(lawless_orga,sizeof(lawless_orga),ORGS,idorga);
	new INI:File = INI_Open(lawless_orga);

	INI_SetTag(File,"LAWLESS_GAMING_ORG_DATA:");
	INI_WriteInt(File,"ORGANISATION_ID",O_E[idorga][org_id]);
	INI_WriteString(File,"ORGANISATION_NAME",O_E[idorga][org_name]);
	INI_WriteInt(File,"ORGANISATION_TIP",O_E[idorga][org_tip]);
	INI_WriteInt(File,"ORGANISATION_MAXMEMBERS",O_E[idorga][org_maxmembers]);
	INI_WriteInt(File,"ORGANISATION_INVITED",O_E[idorga][org_invitemembers]);
	INI_WriteInt(File,"ORGANISATION_Z_SKIN_1",O_E[idorga][org_z_skin][0]);
	INI_WriteInt(File,"ORGANISATION_Z_SKIN_2",O_E[idorga][org_z_skin][1]);
	INI_WriteInt(File,"ORGANISATION_Z_SKIN_3",O_E[idorga][org_z_skin][2]);
	INI_WriteInt(File,"ORGANISATION_Z_SKIN_4",O_E[idorga][org_z_skin][3]);
	INI_WriteInt(File,"ORGANISATION_Z_SKIN_5",O_E[idorga][org_z_skin][4]);
	INI_WriteInt(File,"ORGANISATION_Z_SKIN_6",O_E[idorga][org_z_skin][5]);
	INI_WriteInt(File,"ORGANISATION_M_SKIN_1",O_E[idorga][org_m_skin][0]);
	INI_WriteInt(File,"ORGANISATION_M_SKIN_2",O_E[idorga][org_m_skin][1]);
	INI_WriteInt(File,"ORGANISATION_M_SKIN_3",O_E[idorga][org_m_skin][2]);
	INI_WriteInt(File,"ORGANISATION_M_SKIN_4",O_E[idorga][org_m_skin][3]);
	INI_WriteInt(File,"ORGANISATION_M_SKIN_5",O_E[idorga][org_m_skin][4]);
	INI_WriteInt(File,"ORGANISATION_M_SKIN_6",O_E[idorga][org_m_skin][5]);
	INI_WriteString(File,"ORGANISATION_LEADER_1",O_E[idorga][org_leader_1]);
	INI_WriteString(File,"ORGANISATION_LEADER_2",O_E[idorga][org_leader_2]);
	INI_WriteString(File,"ORGANISATION_MEMBER_1",O_E[idorga][org_member_1]);
	INI_WriteString(File,"ORGANISATION_MEMBER_2",O_E[idorga][org_member_2]);
	INI_WriteString(File,"ORGANISATION_MEMBER_3",O_E[idorga][org_member_3]);
	INI_WriteString(File,"ORGANISATION_MEMBER_4",O_E[idorga][org_member_4]);
	INI_WriteString(File,"ORGANISATION_MEMBER_5",O_E[idorga][org_member_5]);
	INI_WriteString(File,"ORGANISATION_MEMBER_6",O_E[idorga][org_member_6]);
	INI_WriteString(File,"ORGANISATION_MEMBER_7",O_E[idorga][org_member_7]);
	INI_WriteString(File,"ORGANISATION_MEMBER_8",O_E[idorga][org_member_8]);
	INI_WriteString(File,"ORGANISATION_MEMBER_9",O_E[idorga][org_member_9]);
	INI_WriteString(File,"ORGANISATION_MEMBER_10",O_E[idorga][org_member_10]);
	INI_WriteString(File,"ORGANISATION_MEMBER_11",O_E[idorga][org_member_11]);
	INI_WriteString(File,"ORGANISATION_MEMBER_12",O_E[idorga][org_member_12]);
	INI_WriteString(File,"ORGANISATION_MEMBER_13",O_E[idorga][org_member_13]);
	INI_WriteString(File,"ORGANISATION_MEMBER_14",O_E[idorga][org_member_14]);
	INI_WriteString(File,"ORGANISATION_MEMBER_15",O_E[idorga][org_member_15]);
	INI_WriteFloat(File,"ORGANISATION_POSITION_EXT_1",O_E[idorga][org_position_ext][0]);
	INI_WriteFloat(File,"ORGANISATION_POSITION_EXT_2",O_E[idorga][org_position_ext][1]);
	INI_WriteFloat(File,"ORGANISATION_POSITION_EXT_3",O_E[idorga][org_position_ext][2]);
	INI_WriteFloat(File,"ORGANISATION_POSITION_INT_1",O_E[idorga][org_position_int][0]);
	INI_WriteFloat(File,"ORGANISATION_POSITION_INT_2",O_E[idorga][org_position_int][1]);
	INI_WriteFloat(File,"ORGANISATION_POSITION_INT_3",O_E[idorga][org_position_int][2]);
	INI_WriteInt(File,"ORGANISATION_INTERIOR",O_E[idorga][org_int]);
	INI_WriteInt(File,"ORGANISATION_VW",O_E[idorga][org_vw]);
	INI_WriteString(File,"ORGANISATION_RANK_1",O_E[idorga][org_rank_1]);
	INI_WriteString(File,"ORGANISATION_RANK_2",O_E[idorga][org_rank_2]);
	INI_WriteString(File,"ORGANISATION_RANK_3",O_E[idorga][org_rank_3]);
	INI_WriteString(File,"ORGANISATION_RANK_4",O_E[idorga][org_rank_4]);
	INI_WriteString(File,"ORGANISATION_RANK_5",O_E[idorga][org_rank_5]);
	INI_WriteString(File,"ORGANISATION_RANK_6",O_E[idorga][org_rank_6]);
	INI_WriteInt(File,"ORGANISATION_LEVEL",O_E[idorga][org_level]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_1_1",O_E[idorga][org_vehicle_1][0]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_1_2",O_E[idorga][org_vehicle_1][1]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_1_3",O_E[idorga][org_vehicle_1][2]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_1_4",O_E[idorga][org_vehicle_1][3]);
    INI_WriteFloat(File,"ORGANISATION_VEHICLE_2_1",O_E[idorga][org_vehicle_2][0]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_2_2",O_E[idorga][org_vehicle_2][1]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_2_3",O_E[idorga][org_vehicle_2][2]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_2_4",O_E[idorga][org_vehicle_2][3]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_3_1",O_E[idorga][org_vehicle_3][0]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_3_2",O_E[idorga][org_vehicle_3][1]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_3_3",O_E[idorga][org_vehicle_3][2]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_3_4",O_E[idorga][org_vehicle_3][3]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_4_1",O_E[idorga][org_vehicle_4][0]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_4_2",O_E[idorga][org_vehicle_4][1]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_4_3",O_E[idorga][org_vehicle_4][2]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_4_4",O_E[idorga][org_vehicle_4][3]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_5_1",O_E[idorga][org_vehicle_5][0]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_5_2",O_E[idorga][org_vehicle_5][1]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_5_3",O_E[idorga][org_vehicle_5][2]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_5_4",O_E[idorga][org_vehicle_5][3]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_6_1",O_E[idorga][org_vehicle_6][0]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_6_2",O_E[idorga][org_vehicle_6][1]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_6_3",O_E[idorga][org_vehicle_6][2]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_6_4",O_E[idorga][org_vehicle_6][3]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_7_1",O_E[idorga][org_vehicle_7][0]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_7_2",O_E[idorga][org_vehicle_7][1]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_7_3",O_E[idorga][org_vehicle_7][2]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_7_4",O_E[idorga][org_vehicle_7][3]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_8_1",O_E[idorga][org_vehicle_8][0]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_8_2",O_E[idorga][org_vehicle_8][1]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_8_3",O_E[idorga][org_vehicle_8][2]);
	INI_WriteFloat(File,"ORGANISATION_VEHICLE_8_4",O_E[idorga][org_vehicle_8][3]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_SLOT_1",O_E[idorga][org_vehicle_slot_1]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_SLOT_2",O_E[idorga][org_vehicle_slot_2]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_SLOT_3",O_E[idorga][org_vehicle_slot_3]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_SLOT_4",O_E[idorga][org_vehicle_slot_4]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_SLOT_5",O_E[idorga][org_vehicle_slot_5]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_SLOT_6",O_E[idorga][org_vehicle_slot_6]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_SLOT_7",O_E[idorga][org_vehicle_slot_7]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_SLOT_8",O_E[idorga][org_vehicle_slot_8]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_1_CREATED",O_E[idorga][org_vehicles_created][0]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_2_CREATED",O_E[idorga][org_vehicles_created][1]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_3_CREATED",O_E[idorga][org_vehicles_created][2]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_4_CREATED",O_E[idorga][org_vehicles_created][3]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_5_CREATED",O_E[idorga][org_vehicles_created][4]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_6_CREATED",O_E[idorga][org_vehicles_created][5]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_7_CREATED",O_E[idorga][org_vehicles_created][6]);
	INI_WriteInt(File,"ORGANISATION_VEHICLE_8_CREATED",O_E[idorga][org_vehicles_created][7]);
	INI_WriteInt(File,"ORGANISATION_SEF_CASH",O_E[idorga][org_cash]);
	INI_WriteInt(File,"OGANISATION_SEF_DRUGS",O_E[idorga][org_drugs]);
	INI_WriteInt(File,"ORGANISATION_SEF_MATERIALS",O_E[idorga][org_materials]);
	INI_WriteFloat(File,"ORGANISATION_SEF_POSITION_1",O_E[idorga][org_sef_position][0]);
	INI_WriteFloat(File,"ORGANISATION_SEF_POSITION_2",O_E[idorga][org_sef_position][1]);
	INI_WriteFloat(File,"ORGANISATION_SEF_POSITION_3",O_E[idorga][org_sef_position][2]);
	INI_WriteInt(File,"ORGANISATION_SEF",O_E[idorga][org_sef]);
	INI_WriteInt(File,"ORGANISATION_CREATED_1",O_E[idorga][org_ranks_created][0]);
	INI_WriteInt(File,"ORGANISATION_CREATED_2",O_E[idorga][org_ranks_created][1]);
	INI_WriteInt(File,"ORGANISATION_CREATED_3",O_E[idorga][org_ranks_created][2]);
	INI_WriteInt(File,"ORGANISATION_CREATED_4",O_E[idorga][org_ranks_created][3]);
	INI_WriteInt(File,"ORGANISATION_CREATED_5",O_E[idorga][org_ranks_created][4]);
	INI_WriteInt(File,"ORGANISATION_CREATED_6",O_E[idorga][org_ranks_created][5]);
	INI_WriteInt(File,"ORG_TABLICE_SLOT_1",O_E[idorga][org_tablice_slot_1]);
	INI_WriteInt(File,"ORG_TABLICE_SLOT_2",O_E[idorga][org_tablice_slot_2]);
	INI_WriteInt(File,"ORG_TABLICE_SLOT_3",O_E[idorga][org_tablice_slot_3]);
	INI_WriteInt(File,"ORG_TABLICE_SLOT_4",O_E[idorga][org_tablice_slot_4]);
	INI_WriteInt(File,"ORG_TABLICE_SLOT_5",O_E[idorga][org_tablice_slot_5]);
	INI_WriteInt(File,"ORG_TABLICE_SLOT_6",O_E[idorga][org_tablice_slot_6]);
	INI_WriteInt(File,"ORG_TABLICE_SLOT_7",O_E[idorga][org_tablice_slot_7]);
	INI_WriteInt(File,"ORG_TABLICE_SLOT_8",O_E[idorga][org_tablice_slot_8]);
	INI_Close(File);
	return true;
}

/*============================================================================*/

stock lawless_saveSALON(salonid)
{
	new lawless_salons[80];
	format(lawless_salons,sizeof(lawless_salons),SALON,salonid);
	new INI:File = INI_Open(lawless_salons);

	INI_SetTag(File,"LAWLESS_GAMING_SALON_DATA:");
	INI_WriteInt(File,"SALON_VEHICLE_1",A_E[salonid][salon_vehicle][0]);
	INI_WriteInt(File,"SALON_VEHICLE_2",A_E[salonid][salon_vehicle][1]);
	INI_WriteInt(File,"SALON_VEHICLE_3",A_E[salonid][salon_vehicle][2]);
	INI_WriteInt(File,"SALON_VEHICLE_4",A_E[salonid][salon_vehicle][3]);
	INI_WriteInt(File,"SALON_VEHICLE_5",A_E[salonid][salon_vehicle][4]);
	INI_WriteInt(File,"SALON_MODELPRICE_1",A_E[salonid][salon_modelprice][0]);
	INI_WriteInt(File,"SALON_MODELPRICE_2",A_E[salonid][salon_modelprice][1]);
	INI_WriteInt(File,"SALON_MODELPRICE_3",A_E[salonid][salon_modelprice][2]);
	INI_WriteInt(File,"SALON_MODELPRICE_4",A_E[salonid][salon_modelprice][3]);
	INI_WriteInt(File,"SALON_MODELPRICE_5",A_E[salonid][salon_modelprice][4]);
	INI_WriteString(File,"SALON_OWNER",A_E[salonid][salon_owner]);
	INI_WriteInt(File,"SALON_OWNED",A_E[salonid][salon_owned]);
	INI_WriteFloat(File,"SALON_POSITION_1",A_E[salonid][salon_position][0]);
	INI_WriteFloat(File,"SALON_POSITION_2",A_E[salonid][salon_position][1]);
	INI_WriteFloat(File,"SALON_POSITION_3",A_E[salonid][salon_position][2]);
	INI_WriteFloat(File,"SALON_VEHICLEPOSITION_1",A_E[salonid][salon_vehicleposition][0]);
	INI_WriteFloat(File,"SALON_VEHICLEPOSITION_2",A_E[salonid][salon_vehicleposition][1]);
	INI_WriteFloat(File,"SALON_VEHICLEPOSITION_3",A_E[salonid][salon_vehicleposition][2]);
	INI_WriteFloat(File,"SALON_VEHICLEPOSITION_4",A_E[salonid][salon_vehicleposition][3]);
	INI_WriteString(File,"SALON_NAME",A_E[salonid][salon_name]);
	INI_WriteInt(File,"SALON_MAXMODELS_1",A_E[salonid][salon_maxmodels][0]);
	INI_WriteInt(File,"SALON_MAXMODELS_2",A_E[salonid][salon_maxmodels][1]);
	INI_WriteInt(File,"SALON_MAXMODELS_3",A_E[salonid][salon_maxmodels][2]);
	INI_WriteInt(File,"SALON_MAXMODELS_4",A_E[salonid][salon_maxmodels][3]);
	INI_WriteInt(File,"SALON_MAXMODELS_5",A_E[salonid][salon_maxmodels][4]);
	INI_WriteInt(File,"SALON_BUY",A_E[salonid][salon_buy]);
	INI_WriteInt(File,"SALON_CREATED",A_E[salonid][salon_created]);
	INI_WriteInt(File,"SALON_LEVEL",A_E[salonid][salon_level]);
	INI_WriteInt(File,"SALON_MONEY",A_E[salonid][salon_money]);
	INI_WriteInt(File,"SALON_CASH",A_E[salonid][salon_cash]);
	INI_Close(File);
	return true;
}

/*============================================================================*/

stock lawless_saveVEHICLES(idvehicles)
{
    new lawless_vehi[80];
	format(lawless_vehi,sizeof(lawless_vehi),VEHS,idvehicles);
	new INI:File = INI_Open(lawless_vehi);
	
    INI_WriteInt(File,"VEHICLE_ID",V_E[idvehicles][vehicle_id]);
    INI_WriteInt(File,"VEHICLE_OWNED",V_E[idvehicles][vehicle_owned]);
    INI_WriteInt(File,"VEHICLE_PRICE",V_E[idvehicles][vehicle_price]);
    INI_WriteString(File,"VEHICLE_OWNER",V_E[idvehicles][vehicle_owner]);
    INI_WriteInt(File,"VEHICLE_LOCKED",V_E[idvehicles][vehicle_locked]);
    INI_WriteFloat(File,"VEHICLE_POSITIONS_1",V_E[idvehicles][vehicle_positions][0]);
    INI_WriteFloat(File,"VEHICLE_POSITIONS_2",V_E[idvehicles][vehicle_positions][0]);
    INI_WriteFloat(File,"VEHICLE_POSITIONS_3",V_E[idvehicles][vehicle_positions][0]);
    INI_WriteFloat(File,"VEHICLE_POSITIONS_4",V_E[idvehicles][vehicle_positions][0]);
    INI_WriteInt(File,"VEHICLE_COLOR_1",V_E[idvehicles][vehicle_colors][0]);
    INI_WriteInt(File,"VEHICLE_COLOR_2",V_E[idvehicles][vehicle_colors][0]);
    INI_WriteInt(File,"VEHICLE_MODEL",V_E[idvehicles][vehicle_model]);
    INI_Close(File);
	return true;
}

/*============================================================================*/

stock CreateSpeedo_data(playerid)
{
    speedo_Data[0][playerid] = CreatePlayerTextDraw(playerid,507.000000, 340.000000, "autoprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[0][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[0][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[0][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[0][playerid], 255);
	PlayerTextDrawSetOutline(playerid,speedo_Data[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[0][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[0][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[0][playerid], 130.000000, 150.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[0][playerid], 560);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[0][playerid], 0.000000, 0.000000, 90.000000, 1.000000);

	speedo_Data[1][playerid] = CreatePlayerTextDraw(playerid,573.000000, 425.000000, "0km/h");
	PlayerTextDrawAlignment(playerid,speedo_Data[1][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[1][playerid], 255);
	PlayerTextDrawFont(playerid,speedo_Data[1][playerid], 2);
	PlayerTextDrawLetterSize(playerid,speedo_Data[1][playerid], 0.210000, 1.300000);
	PlayerTextDrawColor(playerid,speedo_Data[1][playerid], 1570616319);
	PlayerTextDrawSetOutline(playerid,speedo_Data[1][playerid], 1);
	PlayerTextDrawSetProportional(playerid,speedo_Data[1][playerid], 1);

	speedo_Data[2][playerid] = CreatePlayerTextDraw(playerid,525.000000, 408.000000, "gorivoprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[2][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[2][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[2][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[2][playerid], 16711935);
	PlayerTextDrawSetOutline(playerid,speedo_Data[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[2][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[2][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[2][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[2][playerid], 15.000000, 14.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[2][playerid], 1650);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[2][playerid], 0.000000, 0.000000, 0.000000, 1.000000);

	speedo_Data[3][playerid] = CreatePlayerTextDraw(playerid,587.000000, 403.000000, "motorprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[3][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[3][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[3][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[3][playerid], 16711935);
	PlayerTextDrawSetOutline(playerid,speedo_Data[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[3][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[3][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[3][playerid], 33.000000, 21.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[3][playerid], 19917);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[3][playerid], -30.000000, 0.000000, 90.000000, 1.000000);
	
	speedo_Data[4][playerid] = CreatePlayerTextDraw(playerid,507.000000, 340.000000, "autoprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[4][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[4][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[4][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[4][playerid], 255);
	PlayerTextDrawSetOutline(playerid,speedo_Data[4][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[4][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[4][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[4][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[4][playerid], 130.000000, 150.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[4][playerid], 560);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[4][playerid], 0.000000, 0.000000, 90.000000, 1.000000);

	speedo_Data[5][playerid] = CreatePlayerTextDraw(playerid,525.000000, 408.000000, "gorivoprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[5][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[5][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[5][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[5][playerid], -65281);
	PlayerTextDrawSetOutline(playerid,speedo_Data[5][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[5][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[5][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[5][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[5][playerid], 15.000000, 14.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[5][playerid], 1650);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[5][playerid], 0.000000, 0.000000, 0.000000, 1.000000);

	speedo_Data[6][playerid] = CreatePlayerTextDraw(playerid,587.000000, 403.000000, "motorprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[6][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[6][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[6][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[6][playerid], -65281);
	PlayerTextDrawSetOutline(playerid,speedo_Data[6][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[6][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[6][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[6][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[6][playerid], 33.000000, 21.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[6][playerid], 19917);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[6][playerid], -30.000000, 0.000000, 90.000000, 1.000000);
	
	speedo_Data[7][playerid] = CreatePlayerTextDraw(playerid,507.000000, 340.000000, "autoprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[7][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[7][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[7][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[7][playerid], 255);
	PlayerTextDrawSetOutline(playerid,speedo_Data[7][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[7][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[7][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[7][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[7][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[7][playerid], 130.000000, 150.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[7][playerid], 560);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[7][playerid], 0.000000, 0.000000, 90.000000, 1.000000);

	speedo_Data[8][playerid] = CreatePlayerTextDraw(playerid,525.000000, 408.000000, "gorivoprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[8][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[8][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[8][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[8][playerid], -16776961);
	PlayerTextDrawSetOutline(playerid,speedo_Data[8][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[8][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[8][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[8][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[8][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[8][playerid], 15.000000, 14.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[8][playerid], 1650);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[8][playerid], 0.000000, 0.000000, 0.000000, 1.000000);

	speedo_Data[9][playerid] = CreatePlayerTextDraw(playerid,587.000000, 403.000000, "motorprev");
	PlayerTextDrawBackgroundColor(playerid,speedo_Data[9][playerid], 0);
	PlayerTextDrawFont(playerid,speedo_Data[9][playerid], 5);
	PlayerTextDrawLetterSize(playerid,speedo_Data[9][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,speedo_Data[9][playerid], -16776961);
	PlayerTextDrawSetOutline(playerid,speedo_Data[9][playerid], 0);
	PlayerTextDrawSetProportional(playerid,speedo_Data[9][playerid], 1);
	PlayerTextDrawSetShadow(playerid,speedo_Data[9][playerid], 0);
	PlayerTextDrawUseBox(playerid,speedo_Data[9][playerid], 1);
	PlayerTextDrawBoxColor(playerid,speedo_Data[9][playerid], 0);
	PlayerTextDrawTextSize(playerid,speedo_Data[9][playerid], 33.000000, 21.000000);
	PlayerTextDrawSetPreviewModel(playerid, speedo_Data[9][playerid], 19917);
	PlayerTextDrawSetPreviewRot(playerid, speedo_Data[9][playerid], -30.000000, 0.000000, 90.000000, 1.000000);
	return true;
}

/*============================================================================*/

stock CreateDeath_data(playerid)
{
	death_Data[0][playerid] = CreatePlayerTextDraw(playerid,660.000000, 199.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,death_Data[0][playerid], 255);
	PlayerTextDrawFont(playerid,death_Data[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid,death_Data[0][playerid], 0.500000, 2.500000);
	PlayerTextDrawColor(playerid,death_Data[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,death_Data[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid,death_Data[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid,death_Data[0][playerid], 1);
	PlayerTextDrawUseBox(playerid,death_Data[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid,death_Data[0][playerid], 128);
	PlayerTextDrawTextSize(playerid,death_Data[0][playerid], -6.000000, 0.000000);

	death_Data[1][playerid] = CreatePlayerTextDraw(playerid,660.000000, 190.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,death_Data[1][playerid], 255);
	PlayerTextDrawFont(playerid,death_Data[1][playerid], 1);
	PlayerTextDrawLetterSize(playerid,death_Data[1][playerid], 0.500000, 2.500000);
	PlayerTextDrawColor(playerid,death_Data[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid,death_Data[1][playerid], 0);
	PlayerTextDrawSetProportional(playerid,death_Data[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid,death_Data[1][playerid], 1);
	PlayerTextDrawUseBox(playerid,death_Data[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid,death_Data[1][playerid], 128);
	PlayerTextDrawTextSize(playerid,death_Data[1][playerid], -6.000000, 0.000000);

	death_Data[2][playerid] = CreatePlayerTextDraw(playerid,320.000000, 206.000000, "WASTED");
	PlayerTextDrawAlignment(playerid,death_Data[2][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,death_Data[2][playerid], 255);
	PlayerTextDrawFont(playerid,death_Data[2][playerid], 3);
	PlayerTextDrawLetterSize(playerid,death_Data[2][playerid], 0.449999, 1.200000);
	PlayerTextDrawColor(playerid,death_Data[2][playerid], 1970632191);
	PlayerTextDrawSetOutline(playerid,death_Data[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid,death_Data[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid,death_Data[2][playerid], 1);

	death_Data[3][playerid] = CreatePlayerTextDraw(playerid,228.000000, 216.000000, "do not worry there is no new life is yet to come");
	PlayerTextDrawBackgroundColor(playerid,death_Data[3][playerid], 255);
	PlayerTextDrawFont(playerid,death_Data[3][playerid], 2);
	PlayerTextDrawLetterSize(playerid,death_Data[3][playerid], 0.180000, 0.799998);
	PlayerTextDrawColor(playerid,death_Data[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid,death_Data[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid,death_Data[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,death_Data[3][playerid], 1);

	death_Data[4][playerid] = CreatePlayerTextDraw(playerid,249.000000, 237.000000, "followed by a process of revival");
	PlayerTextDrawBackgroundColor(playerid,death_Data[4][playerid], 255);
	PlayerTextDrawFont(playerid,death_Data[4][playerid], 2);
	PlayerTextDrawLetterSize(playerid,death_Data[4][playerid], 0.180000, 0.799998);
	PlayerTextDrawColor(playerid,death_Data[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid,death_Data[4][playerid], 0);
	PlayerTextDrawSetProportional(playerid,death_Data[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid,death_Data[4][playerid], 1);

	death_Data[5][playerid] = CreatePlayerTextDraw(playerid,317.000000, 189.000000, "LOS SANTOS - HOSPITAL");
	PlayerTextDrawAlignment(playerid,death_Data[5][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,death_Data[5][playerid], 255);
	PlayerTextDrawFont(playerid,death_Data[5][playerid], 2);
	PlayerTextDrawLetterSize(playerid,death_Data[5][playerid], 0.180000, 0.799998);
	PlayerTextDrawColor(playerid,death_Data[5][playerid], -16769281);
	PlayerTextDrawSetOutline(playerid,death_Data[5][playerid], 0);
	PlayerTextDrawSetProportional(playerid,death_Data[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid,death_Data[5][playerid], 1);

	death_Data[6][playerid] = CreatePlayerTextDraw(playerid,223.000000, 216.000000, "]");
	PlayerTextDrawAlignment(playerid,death_Data[6][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,death_Data[6][playerid], 255);
	PlayerTextDrawFont(playerid,death_Data[6][playerid], 2);
	PlayerTextDrawLetterSize(playerid,death_Data[6][playerid], 0.200000, 0.699998);
	PlayerTextDrawColor(playerid,death_Data[6][playerid], 1970632191);
	PlayerTextDrawSetOutline(playerid,death_Data[6][playerid], 0);
	PlayerTextDrawSetProportional(playerid,death_Data[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid,death_Data[6][playerid], 1);

	death_Data[7][playerid] = CreatePlayerTextDraw(playerid,427.000000, 216.000000, "]");
	PlayerTextDrawAlignment(playerid,death_Data[7][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,death_Data[7][playerid], 255);
	PlayerTextDrawFont(playerid,death_Data[7][playerid], 2);
	PlayerTextDrawLetterSize(playerid,death_Data[7][playerid], 0.200000, 0.699998);
	PlayerTextDrawColor(playerid,death_Data[7][playerid], 1970632191);
	PlayerTextDrawSetOutline(playerid,death_Data[7][playerid], 0);
	PlayerTextDrawSetProportional(playerid,death_Data[7][playerid], 1);
	PlayerTextDrawSetShadow(playerid,death_Data[7][playerid], 1);
	return true;
}

/*============================================================================*/

stock CreateWanted_data(playerid)
{
    wanted_Data[0][playerid] = CreatePlayerTextDraw(playerid,553.000000, 138.000000, "~r~]]]]]]]]]]]]]]]");
	PlayerTextDrawAlignment(playerid,wanted_Data[0][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,wanted_Data[0][playerid], 255);
	PlayerTextDrawFont(playerid,wanted_Data[0][playerid], 2);
	PlayerTextDrawLetterSize(playerid,wanted_Data[0][playerid], 0.210000, 0.899999);
	PlayerTextDrawColor(playerid,wanted_Data[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,wanted_Data[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid,wanted_Data[0][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,wanted_Data[0][playerid], 0);
	return true;
}

/*============================================================================*/

stock CreateBleeding_data(playerid)
{
    registering_Bleeding[0][playerid] = CreatePlayerTextDraw(playerid,-1.000000, 0.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,registering_Bleeding[0][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Bleeding[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Bleeding[0][playerid], 0.000000, 53.099998);
	PlayerTextDrawColor(playerid,registering_Bleeding[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Bleeding[0][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Bleeding[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Bleeding[0][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Bleeding[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Bleeding[0][playerid], 255);
	PlayerTextDrawTextSize(playerid,registering_Bleeding[0][playerid], 653.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Bleeding[0][playerid], 0);

	registering_Bleeding[1][playerid] = CreatePlayerTextDraw(playerid,-1.000000, 0.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,registering_Bleeding[1][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Bleeding[1][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Bleeding[1][playerid], 0.000000, 53.099998);
	PlayerTextDrawColor(playerid,registering_Bleeding[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Bleeding[1][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Bleeding[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Bleeding[1][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Bleeding[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Bleeding[1][playerid], 200);
	PlayerTextDrawTextSize(playerid,registering_Bleeding[1][playerid], 653.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Bleeding[1][playerid], 0);

	registering_Bleeding[2][playerid] = CreatePlayerTextDraw(playerid,-1.000000, 0.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,registering_Bleeding[2][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Bleeding[2][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Bleeding[2][playerid], 0.000000, 53.099998);
	PlayerTextDrawColor(playerid,registering_Bleeding[2][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Bleeding[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Bleeding[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Bleeding[2][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Bleeding[2][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Bleeding[2][playerid], 150);
	PlayerTextDrawTextSize(playerid,registering_Bleeding[2][playerid], 653.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Bleeding[2][playerid], 0);

	registering_Bleeding[3][playerid] = CreatePlayerTextDraw(playerid,-1.000000, 0.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,registering_Bleeding[3][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Bleeding[3][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Bleeding[3][playerid], 0.000000, 53.099998);
	PlayerTextDrawColor(playerid,registering_Bleeding[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Bleeding[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Bleeding[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Bleeding[3][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Bleeding[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Bleeding[3][playerid], 100);
	PlayerTextDrawTextSize(playerid,registering_Bleeding[3][playerid], 653.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Bleeding[3][playerid], 0);

	registering_Bleeding[4][playerid] = CreatePlayerTextDraw(playerid,-1.000000, 0.000000, "New Textdraw");
	PlayerTextDrawBackgroundColor(playerid,registering_Bleeding[4][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Bleeding[4][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Bleeding[4][playerid], 0.000000, 53.099998);
	PlayerTextDrawColor(playerid,registering_Bleeding[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Bleeding[4][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Bleeding[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Bleeding[4][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Bleeding[4][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Bleeding[4][playerid], 50);
	PlayerTextDrawTextSize(playerid,registering_Bleeding[4][playerid], 653.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Bleeding[4][playerid], 0);
	return true;
}

/*============================================================================*/

stock CreateBank_data(playerid)
{
    bank_Data[0][playerid] = CreatePlayerTextDraw(playerid, 553.500000, 97.000000, "$00000000");
	PlayerTextDrawAlignment(playerid,bank_Data[0][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,bank_Data[0][playerid], 255);
	PlayerTextDrawFont(playerid,bank_Data[0][playerid], 3);
	PlayerTextDrawLetterSize(playerid,bank_Data[0][playerid], 0.550000, 2.199999);
	PlayerTextDrawColor(playerid,bank_Data[0][playerid], 2072151551);
	PlayerTextDrawSetOutline(playerid,bank_Data[0][playerid], 2);
	PlayerTextDrawSetProportional(playerid,bank_Data[0][playerid], 1);
	return true;
}

/*============================================================================*/

stock CreateEuro_data(playerid)
{
    euro_Data[0][playerid] = CreatePlayerTextDraw(playerid, 608.000000, 117.000000, "~y~e00000000");
	PlayerTextDrawAlignment(playerid,euro_Data[0][playerid], 3);
	PlayerTextDrawBackgroundColor(playerid,euro_Data[0][playerid], 255);
	PlayerTextDrawFont(playerid,euro_Data[0][playerid], 3);
	PlayerTextDrawLetterSize(playerid,euro_Data[0][playerid], 0.550000, 2.199999);
	PlayerTextDrawColor(playerid,euro_Data[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,euro_Data[0][playerid], 2);
	PlayerTextDrawSetProportional(playerid,euro_Data[0][playerid], 1);
	return true;
}

/*============================================================================*/

stock CreateTutorial_data(playerid)
{
    tutorial_Data[0][playerid] = CreatePlayerTextDraw(playerid, 602.000000, 295.188903, "usebox");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[0][playerid], 0.000000, 7.315925);
	PlayerTextDrawTextSize(playerid, tutorial_Data[0][playerid], 396.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, tutorial_Data[0][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[0][playerid], 0);
	PlayerTextDrawUseBox(playerid, tutorial_Data[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, tutorial_Data[0][playerid], 102);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[0][playerid], 0);
	PlayerTextDrawFont(playerid, tutorial_Data[0][playerid], 0);

	tutorial_Data[1][playerid] = CreatePlayerTextDraw(playerid, 601.599914, 307.633361, "usebox");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[1][playerid], 0.000000, 4.517409);
	PlayerTextDrawTextSize(playerid, tutorial_Data[1][playerid], 395.999877, 0.000000);
	PlayerTextDrawAlignment(playerid, tutorial_Data[1][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[1][playerid], 0);
	PlayerTextDrawUseBox(playerid, tutorial_Data[1][playerid], true);
	PlayerTextDrawBoxColor(playerid, tutorial_Data[1][playerid], 102);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[1][playerid], 0);
	PlayerTextDrawFont(playerid, tutorial_Data[1][playerid], 0);

	tutorial_Data[2][playerid] = CreatePlayerTextDraw(playerid, 397.599700, 275.271087, "LD_BEAT:CHIT");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[2][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, tutorial_Data[2][playerid], 46.000030, 49.279983);
	PlayerTextDrawAlignment(playerid, tutorial_Data[2][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[2][playerid], 1570616319);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[2][playerid], 0);
	PlayerTextDrawFont(playerid, tutorial_Data[2][playerid], 4);

	tutorial_Data[3][playerid] = CreatePlayerTextDraw(playerid, 401.399841, 279.755584, "LD_BEAT:CHIT");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[3][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, tutorial_Data[3][playerid], 38.000015, 40.319995);
	PlayerTextDrawAlignment(playerid, tutorial_Data[3][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[3][playerid], 255);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[3][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[3][playerid], -2139062017);
	PlayerTextDrawFont(playerid, tutorial_Data[3][playerid], 4);

	tutorial_Data[4][playerid] = CreatePlayerTextDraw(playerid, 406.199615, 284.733245, "LD_BEAT:CHIT");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[4][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, tutorial_Data[4][playerid], 28.800033, 29.866657);
	PlayerTextDrawAlignment(playerid, tutorial_Data[4][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[4][playerid], 1570616319);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[4][playerid], 0);
	PlayerTextDrawFont(playerid, tutorial_Data[4][playerid], 4);

	tutorial_Data[5][playerid] = CreatePlayerTextDraw(playerid, 407.599853, 296.675506, "]");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[5][playerid], 0.113599, 0.435200);
	PlayerTextDrawAlignment(playerid, tutorial_Data[5][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[5][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[5][playerid], 51);
	PlayerTextDrawFont(playerid, tutorial_Data[5][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[5][playerid], 1);

	tutorial_Data[6][playerid] = CreatePlayerTextDraw(playerid, 408.599853, 302.155456, "]");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[6][playerid], 0.113599, 0.435200);
	PlayerTextDrawAlignment(playerid, tutorial_Data[6][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[6][playerid], -1);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[6][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[6][playerid], 51);
	PlayerTextDrawFont(playerid, tutorial_Data[6][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[6][playerid], 1);

	tutorial_Data[7][playerid] = CreatePlayerTextDraw(playerid, 409.199798, 291.208801, "]");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[7][playerid], 0.113599, 0.435200);
	PlayerTextDrawAlignment(playerid, tutorial_Data[7][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[7][playerid], -1);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[7][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[7][playerid], 51);
	PlayerTextDrawFont(playerid, tutorial_Data[7][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[7][playerid], 1);

	tutorial_Data[8][playerid] = CreatePlayerTextDraw(playerid, 428.999725, 293.204345, "]");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[8][playerid], 0.113599, 0.435200);
	PlayerTextDrawAlignment(playerid, tutorial_Data[8][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[8][playerid], -1);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[8][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[8][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[8][playerid], 51);
	PlayerTextDrawFont(playerid, tutorial_Data[8][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[8][playerid], 1);

	tutorial_Data[9][playerid] = CreatePlayerTextDraw(playerid, 429.599731, 299.182159, "]");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[9][playerid], 0.113599, 0.435200);
	PlayerTextDrawAlignment(playerid, tutorial_Data[9][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[9][playerid], -1);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[9][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[9][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[9][playerid], 51);
	PlayerTextDrawFont(playerid, tutorial_Data[9][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[9][playerid], 1);

	tutorial_Data[10][playerid] = CreatePlayerTextDraw(playerid, 427.799743, 304.662109, "]");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[10][playerid], 0.113599, 0.435200);
	PlayerTextDrawAlignment(playerid, tutorial_Data[10][playerid], 1);
	PlayerTextDrawColor(playerid, tutorial_Data[10][playerid], -1);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[10][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[10][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[10][playerid], 51);
	PlayerTextDrawFont(playerid, tutorial_Data[10][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[10][playerid], 1);

	tutorial_Data[11][playerid] = CreatePlayerTextDraw(playerid, 421.199798, 290.702301, "LW");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[11][playerid], 0.195600, 1.903644);
	PlayerTextDrawAlignment(playerid, tutorial_Data[11][playerid], 2);
	PlayerTextDrawColor(playerid, tutorial_Data[11][playerid], -1);
	PlayerTextDrawUseBox(playerid, tutorial_Data[11][playerid], true);
	PlayerTextDrawBoxColor(playerid, tutorial_Data[11][playerid], 0);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[11][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[11][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[11][playerid], 255);
	PlayerTextDrawFont(playerid, tutorial_Data[11][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[11][playerid], 1);

	tutorial_Data[12][playerid] = CreatePlayerTextDraw(playerid, 552.399902, 293.688873, "Lawless");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[12][playerid], 0.237599, 1.186843);
	PlayerTextDrawAlignment(playerid, tutorial_Data[12][playerid], 2);
	PlayerTextDrawColor(playerid, tutorial_Data[12][playerid], 1570616319);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[12][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[12][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[12][playerid], 255);
	PlayerTextDrawFont(playerid, tutorial_Data[12][playerid], 3);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[12][playerid], 1);

	tutorial_Data[13][playerid] = CreatePlayerTextDraw(playerid, 582.200256, 351.435516, "1/4");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[13][playerid], 0.133199, 1.047466);
	PlayerTextDrawAlignment(playerid, tutorial_Data[13][playerid], 2);
	PlayerTextDrawColor(playerid, tutorial_Data[13][playerid], 1570616319);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[13][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[13][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[13][playerid], 255);
	PlayerTextDrawFont(playerid, tutorial_Data[13][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[13][playerid], 1);

	tutorial_Data[14][playerid] = CreatePlayerTextDraw(playerid, 510.000030, 313.608917, "Dobrodosli na Lawless Gaming server. Sada ce vam biti prikazan kratak tutorial,");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[14][playerid], 0.087999, 1.231643);
	PlayerTextDrawAlignment(playerid, tutorial_Data[14][playerid], 2);
	PlayerTextDrawColor(playerid, tutorial_Data[14][playerid], -1);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[14][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[14][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[14][playerid], 255);
	PlayerTextDrawFont(playerid, tutorial_Data[14][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[14][playerid], 1);

	tutorial_Data[15][playerid] = CreatePlayerTextDraw(playerid, 511.800018, 323.071044, "kako bi se snasli lakse na nasem serveru.");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[15][playerid], 0.087999, 1.231643);
	PlayerTextDrawAlignment(playerid, tutorial_Data[15][playerid], 2);
	PlayerTextDrawColor(playerid, tutorial_Data[15][playerid], -1);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[15][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[15][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[15][playerid], 255);
	PlayerTextDrawFont(playerid, tutorial_Data[15][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[15][playerid], 1);

	tutorial_Data[16][playerid] = CreatePlayerTextDraw(playerid, 512.399963, 334.026580, "Srecno.");
	PlayerTextDrawLetterSize(playerid, tutorial_Data[16][playerid], 0.087999, 1.231643);
	PlayerTextDrawAlignment(playerid, tutorial_Data[16][playerid], 2);
	PlayerTextDrawColor(playerid, tutorial_Data[16][playerid], -1);
	PlayerTextDrawUseBox(playerid, tutorial_Data[16][playerid], true);
	PlayerTextDrawBoxColor(playerid, tutorial_Data[16][playerid], 0);
	PlayerTextDrawSetShadow(playerid, tutorial_Data[16][playerid], 0);
	PlayerTextDrawSetOutline(playerid, tutorial_Data[16][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, tutorial_Data[16][playerid], 255);
	PlayerTextDrawFont(playerid, tutorial_Data[16][playerid], 2);
	PlayerTextDrawSetProportional(playerid, tutorial_Data[16][playerid], 1);
	return true;
}

/*============================================================================*/

stock CreateProgress_data(playerid)
{
    lawless_Glad[playerid] = CreatePlayerProgressBar(playerid,549.00,58.00,60.00,3.70,2072151551,100.0,BAR_DIRECTION_RIGHT);
	return true;
}

/*============================================================================*/

stock CreateRegister_data(playerid)
{

	registering_Data[5][playerid] = CreatePlayerTextDraw(playerid,489.000000, 150.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[5][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[5][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[5][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[5][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[5][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[5][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[5][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[5][playerid], 255);
	PlayerTextDrawTextSize(playerid,registering_Data[5][playerid], 793.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[5][playerid], 0);

	registering_Data[6][playerid] = CreatePlayerTextDraw(playerid,489.000000, 236.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[6][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[6][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[6][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[6][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[6][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[6][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[6][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[6][playerid], 255);
	PlayerTextDrawTextSize(playerid,registering_Data[6][playerid], 793.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[6][playerid], 0);

	registering_Data[7][playerid] = CreatePlayerTextDraw(playerid,489.000000, 279.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[7][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[7][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[7][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[7][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[7][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[7][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[7][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[7][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[7][playerid], 255);
	PlayerTextDrawTextSize(playerid,registering_Data[7][playerid], 793.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[7][playerid], 0);

	registering_Data[8][playerid] = CreatePlayerTextDraw(playerid,489.000000, 107.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[8][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[8][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[8][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[8][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[8][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[8][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[8][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[8][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[8][playerid], 255);
	PlayerTextDrawTextSize(playerid,registering_Data[8][playerid], 793.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[8][playerid], 0);

	registering_Data[9][playerid] = CreatePlayerTextDraw(playerid,489.000000, 319.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[9][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[9][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[9][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[9][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[9][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[9][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[9][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[9][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[9][playerid], 255);
	PlayerTextDrawTextSize(playerid,registering_Data[9][playerid], 793.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[9][playerid], 0);

	registering_Data[10][playerid] = CreatePlayerTextDraw(playerid,489.000000, 193.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[10][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[10][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[10][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[10][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[10][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[10][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[10][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[10][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[10][playerid], 255);
	PlayerTextDrawTextSize(playerid,registering_Data[10][playerid], 793.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[10][playerid], 0);

	registering_Data[12][playerid] = CreatePlayerTextDraw(playerid,489.000000, 107.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[12][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[12][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[12][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[12][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[12][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[12][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[12][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[12][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[12][playerid], 1570616319);
	PlayerTextDrawTextSize(playerid,registering_Data[12][playerid], 508.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[12][playerid], 0);

	registering_Data[13][playerid] = CreatePlayerTextDraw(playerid,489.000000, 193.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[13][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[13][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[13][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[13][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[13][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[13][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[13][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[13][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[13][playerid], 1570616319);
	PlayerTextDrawTextSize(playerid,registering_Data[13][playerid], 508.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[13][playerid], 0);

	registering_Data[14][playerid] = CreatePlayerTextDraw(playerid,489.000000, 236.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[14][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[14][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[14][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[14][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[14][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[14][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[14][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[14][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[14][playerid], 1570616319);
	PlayerTextDrawTextSize(playerid,registering_Data[14][playerid], 508.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[14][playerid], 0);

	registering_Data[15][playerid] = CreatePlayerTextDraw(playerid,489.000000, 279.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[15][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[15][playerid], 1);
	PlayerTextDrawLetterSize(playerid,registering_Data[15][playerid], 0.500000, 2.199999);
	PlayerTextDrawColor(playerid,registering_Data[15][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[15][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[15][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[15][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[15][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[15][playerid], 1570616319);
	PlayerTextDrawTextSize(playerid,registering_Data[15][playerid], 508.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[15][playerid], 0);

	registering_Data[18][playerid] = CreatePlayerTextDraw(playerid,577.000000, 110.000000, "LOZINKA");
	PlayerTextDrawAlignment(playerid,registering_Data[18][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,registering_Data[18][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[18][playerid], 2);
	PlayerTextDrawLetterSize(playerid,registering_Data[18][playerid], 0.230000, 1.300000);
	PlayerTextDrawColor(playerid,registering_Data[18][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[18][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[18][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[18][playerid], 0);
	PlayerTextDrawUseBox(playerid,registering_Data[18][playerid], 0);
	PlayerTextDrawBoxColor(playerid,registering_Data[18][playerid], 572661759);
	PlayerTextDrawTextSize(playerid,registering_Data[18][playerid], 5.000000, 82.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[18][playerid], 1);

	registering_Data[19][playerid] = CreatePlayerTextDraw(playerid,577.000000, 153.000000, "SPAWN");
	PlayerTextDrawAlignment(playerid,registering_Data[19][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,registering_Data[19][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[19][playerid], 2);
	PlayerTextDrawLetterSize(playerid,registering_Data[19][playerid], 0.230000, 1.300000);
	PlayerTextDrawColor(playerid,registering_Data[19][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[19][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[19][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[19][playerid], 0);
	PlayerTextDrawUseBox(playerid,registering_Data[19][playerid], 0);
	PlayerTextDrawBoxColor(playerid,registering_Data[19][playerid], 572661759);
	PlayerTextDrawTextSize(playerid,registering_Data[19][playerid], 5.000000, 80.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[19][playerid], 1);

	registering_Data[20][playerid] = CreatePlayerTextDraw(playerid,577.000000, 196.000000, "DRZAVA");
	PlayerTextDrawAlignment(playerid,registering_Data[20][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,registering_Data[20][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[20][playerid], 2);
	PlayerTextDrawLetterSize(playerid,registering_Data[20][playerid], 0.230000, 1.300000);
	PlayerTextDrawColor(playerid,registering_Data[20][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[20][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[20][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[20][playerid], 0);
	PlayerTextDrawUseBox(playerid,registering_Data[20][playerid], 0);
	PlayerTextDrawBoxColor(playerid,registering_Data[20][playerid], 572661759);
	PlayerTextDrawTextSize(playerid,registering_Data[20][playerid], 5.000000, 90.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[20][playerid], 1);

	registering_Data[21][playerid] = CreatePlayerTextDraw(playerid,577.000000, 239.000000, "POL");
	PlayerTextDrawAlignment(playerid,registering_Data[21][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,registering_Data[21][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[21][playerid], 2);
	PlayerTextDrawLetterSize(playerid,registering_Data[21][playerid], 0.230000, 1.300000);
	PlayerTextDrawColor(playerid,registering_Data[21][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[21][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[21][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[21][playerid], 0);
	PlayerTextDrawUseBox(playerid,registering_Data[21][playerid], 0);
	PlayerTextDrawBoxColor(playerid,registering_Data[21][playerid], 572661759);
	PlayerTextDrawTextSize(playerid,registering_Data[21][playerid], 5.000000, 70.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[21][playerid], 1);

	registering_Data[22][playerid] = CreatePlayerTextDraw(playerid,577.000000, 282.000000, "REGISTER");
	PlayerTextDrawAlignment(playerid,registering_Data[22][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,registering_Data[22][playerid], 255);
	PlayerTextDrawFont(playerid,registering_Data[22][playerid], 2);
	PlayerTextDrawLetterSize(playerid,registering_Data[22][playerid], 0.230000, 1.300000);
	PlayerTextDrawColor(playerid,registering_Data[22][playerid], -1);
	PlayerTextDrawSetOutline(playerid,registering_Data[22][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[22][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[22][playerid], 0);
	PlayerTextDrawUseBox(playerid,registering_Data[22][playerid], 0);
	PlayerTextDrawBoxColor(playerid,registering_Data[22][playerid], 572661759);
	PlayerTextDrawTextSize(playerid,registering_Data[22][playerid], 5.000000, 60.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[22][playerid], 1);

	registering_Data[24][playerid] = CreatePlayerTextDraw(playerid,485.000000, 103.000000, "lozinka preveiw");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[24][playerid], 0);
	PlayerTextDrawFont(playerid,registering_Data[24][playerid], 5);
	PlayerTextDrawLetterSize(playerid,registering_Data[24][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,registering_Data[24][playerid], 255);
	PlayerTextDrawSetOutline(playerid,registering_Data[24][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[24][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[24][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[24][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[24][playerid], 0x00000000);
	PlayerTextDrawTextSize(playerid,registering_Data[24][playerid], 27.000000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, registering_Data[24][playerid], 1239);
	PlayerTextDrawSetPreviewRot(playerid, registering_Data[24][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[24][playerid], 0);

	registering_Data[25][playerid] = CreatePlayerTextDraw(playerid,484.000000, 189.000000, "code preview");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[25][playerid], 0);
	PlayerTextDrawFont(playerid,registering_Data[25][playerid], 5);
	PlayerTextDrawLetterSize(playerid,registering_Data[25][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,registering_Data[25][playerid], 255);
	PlayerTextDrawSetOutline(playerid,registering_Data[25][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[25][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[25][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[25][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[25][playerid], 0x00000000);
	PlayerTextDrawTextSize(playerid,registering_Data[25][playerid], 27.000000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, registering_Data[25][playerid], 1239);
	PlayerTextDrawSetPreviewRot(playerid, registering_Data[25][playerid], 0.000000, 0.000000, 180.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[25][playerid], 0);

	registering_Data[26][playerid] = CreatePlayerTextDraw(playerid,484.000000, 147.000000, "email preview");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[26][playerid], 0);
	PlayerTextDrawFont(playerid,registering_Data[26][playerid], 5);
	PlayerTextDrawLetterSize(playerid,registering_Data[26][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,registering_Data[26][playerid], 255);
	PlayerTextDrawSetOutline(playerid,registering_Data[26][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[26][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[26][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[26][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[26][playerid], 0x00000000);
	PlayerTextDrawTextSize(playerid,registering_Data[26][playerid], 27.000000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, registering_Data[26][playerid], 1239);
	PlayerTextDrawSetPreviewRot(playerid, registering_Data[26][playerid], 0.000000, 0.000000, 40.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[26][playerid], 0);

	registering_Data[27][playerid] = CreatePlayerTextDraw(playerid,485.000000, 316.000000, "pol preview");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[27][playerid], 0);
	PlayerTextDrawFont(playerid,registering_Data[27][playerid], 5);
	PlayerTextDrawLetterSize(playerid,registering_Data[27][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,registering_Data[27][playerid], 255);
	PlayerTextDrawSetOutline(playerid,registering_Data[27][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[27][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[27][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[27][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[27][playerid], 0x00000000);
	PlayerTextDrawTextSize(playerid,registering_Data[27][playerid], 27.000000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, registering_Data[27][playerid], 1239);
	PlayerTextDrawSetPreviewRot(playerid, registering_Data[27][playerid], 0.000000, 0.000000, 40.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[27][playerid], 0);

	registering_Data[28][playerid] = CreatePlayerTextDraw(playerid,484.000000, 276.000000, "godine preview");
	PlayerTextDrawBackgroundColor(playerid,registering_Data[28][playerid], 0);
	PlayerTextDrawFont(playerid,registering_Data[28][playerid], 5);
	PlayerTextDrawLetterSize(playerid,registering_Data[28][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,registering_Data[28][playerid], 255);
	PlayerTextDrawSetOutline(playerid,registering_Data[28][playerid], 0);
	PlayerTextDrawSetProportional(playerid,registering_Data[28][playerid], 1);
	PlayerTextDrawSetShadow(playerid,registering_Data[28][playerid], 1);
	PlayerTextDrawUseBox(playerid,registering_Data[28][playerid], 1);
	PlayerTextDrawBoxColor(playerid,registering_Data[28][playerid], 0x00000000);
	PlayerTextDrawTextSize(playerid,registering_Data[28][playerid], 27.000000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, registering_Data[28][playerid], 1239);
	PlayerTextDrawSetPreviewRot(playerid, registering_Data[28][playerid], 0.000000, 0.000000, 40.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,registering_Data[28][playerid], 0);
	return true;
}

/*============================================================================*/

stock lawless_BankMoney(playerid)
{
    new lawless_bank_string[128];
    if(P_E[playerid][info_bank] < 10)
    {
        format(lawless_bank_string,sizeof(lawless_bank_string),"$0000000%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
    }
    else if(10 <= P_E[playerid][info_bank] < 100)
    {
        format(lawless_bank_string,sizeof(lawless_bank_string),"$000000%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
    }
    else if(100 <= P_E[playerid][info_bank] < 1000)
    {
        format(lawless_bank_string,sizeof(lawless_bank_string),"$00000%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
    }
    else if(1000 <= P_E[playerid][info_bank] < 10000)
    {
        format(lawless_bank_string,sizeof(lawless_bank_string),"$0000%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
    }
    else if(10000 <= P_E[playerid][info_bank] < 100000)
    {
        format(lawless_bank_string,sizeof(lawless_bank_string),"$000%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
    }
    else if(100000 <= P_E[playerid][info_bank] < 1000000)
    {
        format(lawless_bank_string,sizeof(lawless_bank_string),"$00%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
    }
    else if(1000000 <= P_E[playerid][info_bank] < 10000000)
    {
        format(lawless_bank_string,sizeof(lawless_bank_string),"$0%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
    }
    else if(10000000 <= P_E[playerid][info_bank] < 100000000)
    {
        format(lawless_bank_string,sizeof(lawless_bank_string),"$%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
    }
    else if(P_E[playerid][info_bank] < 0 && P_E[playerid][info_bank] > -10)
	{
		format(lawless_bank_string,sizeof(lawless_bank_string),"~r~-$0000000%d",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_bank] <= -10 && P_E[playerid][info_bank] > -100)
	{
		format(lawless_bank_string,sizeof(lawless_bank_string),"~r~-$000000%d",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_bank] <= -100 && P_E[playerid][info_bank] > -1000)
	{
		format(lawless_bank_string,sizeof(lawless_bank_string),"~r~-$00000%d",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_bank] <= -1000 && P_E[playerid][info_bank] > -10000)
	{
		format(lawless_bank_string,sizeof(lawless_bank_string),"~r~-$0000%d",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_bank] <= -10000 && P_E[playerid][info_bank] > -100000)
	{
		format(lawless_bank_string,sizeof(lawless_bank_string),"~r~-$000%d",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_bank] <= -100000 && P_E[playerid][info_bank] > -1000000)
	{
		format(lawless_bank_string,sizeof(lawless_bank_string),"~r~-$00%d",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_bank] <= -1000000 && P_E[playerid][info_bank] > -10000000)
	{
        format(lawless_bank_string,sizeof(lawless_bank_string),"~r~-$0%d",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_bank] <= -10000000 && P_E[playerid][info_bank] > -100000000)
	{
 		format(lawless_bank_string,sizeof(lawless_bank_string),"~r~-$%i",P_E[playerid][info_bank]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_bank_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
    return true;
}

/*============================================================================*/

stock lawless_EuroMoney(playerid)
{
    new lawless_euro_string[128];
    if(P_E[playerid][info_euro] < 10)
    {
        format(lawless_euro_string,sizeof(lawless_euro_string),"~y~e0000000%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,euro_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,euro_Data[0][playerid]);
    }
    else if(10 <= P_E[playerid][info_euro] < 100)
    {
        format(lawless_euro_string,sizeof(lawless_euro_string),"~y~e000000%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,euro_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,euro_Data[0][playerid]);
    }
    else if(100 <= P_E[playerid][info_euro] < 1000)
    {
        format(lawless_euro_string,sizeof(lawless_euro_string),"~y~e00000%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,euro_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,euro_Data[0][playerid]);
    }
    else if(1000 <= P_E[playerid][info_euro] < 10000)
    {
        format(lawless_euro_string,sizeof(lawless_euro_string),"~y~e0000%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,euro_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,euro_Data[0][playerid]);
    }
    else if(10000 <= P_E[playerid][info_euro] < 100000)
    {
        format(lawless_euro_string,sizeof(lawless_euro_string),"~y~e000%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,euro_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,euro_Data[0][playerid]);
    }
    else if(100000 <= P_E[playerid][info_euro] < 1000000)
    {
        format(lawless_euro_string,sizeof(lawless_euro_string),"~y~e00%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,euro_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,euro_Data[0][playerid]);
    }
    else if(1000000 <= P_E[playerid][info_euro] < 10000000)
    {
        format(lawless_euro_string,sizeof(lawless_euro_string),"~y~e0%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,euro_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,euro_Data[0][playerid]);
    }
    else if(10000000 <= P_E[playerid][info_euro] < 100000000)
    {
        format(lawless_euro_string,sizeof(lawless_euro_string),"~y~e%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,euro_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,euro_Data[0][playerid]);
    }
    else if(P_E[playerid][info_euro] < 0 && P_E[playerid][info_euro] > -10)
	{
		format(lawless_euro_string,sizeof(lawless_euro_string),"~r~-$0000000%d",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_euro] <= -10 && P_E[playerid][info_euro] > -100)
	{
		format(lawless_euro_string,sizeof(lawless_euro_string),"~r~-$000000%d",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_euro] <= -100 && P_E[playerid][info_euro] > -1000)
	{
		format(lawless_euro_string,sizeof(lawless_euro_string),"~r~-$00000%d",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_euro] <= -1000 && P_E[playerid][info_euro] > -10000)
	{
		format(lawless_euro_string,sizeof(lawless_euro_string),"~r~-$0000%d",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_euro] <= -10000 && P_E[playerid][info_euro] > -100000)
	{
		format(lawless_euro_string,sizeof(lawless_euro_string),"~r~-$000%d",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_euro] <= -100000 && P_E[playerid][info_euro] > -1000000)
	{
		format(lawless_euro_string,sizeof(lawless_euro_string),"~r~-$00%d",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_euro] <= -1000000 && P_E[playerid][info_euro] > -10000000)
	{
        format(lawless_euro_string,sizeof(lawless_euro_string),"~r~-$0%d",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	else if(P_E[playerid][info_euro] <= -10000000 && P_E[playerid][info_euro] > -100000000)
	{
 		format(lawless_euro_string,sizeof(lawless_euro_string),"~r~-$%i",P_E[playerid][info_euro]);
        lawless_PTDSS(playerid,bank_Data[0][playerid],lawless_euro_string);
        lawless_PTDS(playerid,bank_Data[0][playerid]);
	}
	return true;
}

/*============================================================================*/

stock lawless_SetPlayerWantedLevel(playerid)
{
	if(P_E[playerid][info_wantedlevel] == 0)
	{
 		lawless_PTDH(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xFFFFFF00);
 	}
 	else if(P_E[playerid][info_wantedlevel] == 1)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 2)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 3)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 4)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 5)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 6)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 7)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 8)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 9)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 10)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 11)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 12)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 13)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 14)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] == 15)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	else if(P_E[playerid][info_wantedlevel] > 15)
	{
	    lawless_PTDSS(playerid,wanted_Data[0][playerid],"~r~]]]]]]]]]]]]]]]]");
 		lawless_PTDS(playerid,wanted_Data[0][playerid]);
   		lawless_COLOR(playerid,0xAA333300);
	}
	return true;
}

/*============================================================================*/

stock lawless_SpawnUser(playerid)
{
    new string[512];
    lawless_SetPlayerHealth(playerid,98.0);
    lawless_Chat(playerid,20);
    lawless_BankMoney(playerid);
    lawless_EuroMoney(playerid);
    P_E[playerid][info_stat] = 1;

    new rand = random(sizeof(RandomCitySpawn));
    SetSpawnInfo(playerid,0,P_E[playerid][info_skin],RandomCitySpawn[rand][0],RandomCitySpawn[rand][1],RandomCitySpawn[rand][2],90,-1,-1,-1,-1,-1,-1);
	lawless_SP(playerid);
	defer lawless_SpawnConfirmed(playerid);

	lawless_SKIN(playerid,P_E[playerid][info_skin]);
	lawless_LEVEL(playerid,P_E[playerid][info_level]);
	lawless_GivePlayerMoney(playerid,P_E[playerid][info_cash]);

	if(P_E[playerid][info_admin] != 0)
	{
		format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' dobrodosli nazad na {5D9DB3}Lawless {FFFFFF}- {5D9DB3}Gaming{FFFFFF}server.\n\
		{FFFFFF}Posto imate poziciju 'law_adm'.\n\
		{FFFFFF}Sada je potrebno da upisete 'law_adm' code kako bi pristupili.",lawless_Nick(playerid));
		lawless_SPD(playerid, lawless_CODE, DSP, SDIALOG,string,""SERVER_COL"Login",""SERVER_COL"Izlaz");
		/* PORUKA DEVELOPERIMA - OWNERIMA DA ULAZI NEKO NA SERVER SA IP/ADMINOM */
	}

	INFO(playerid,"%s dobrodosli nazad, zadnji put ste bili vidjeni - '%d/%d/%d'.",lawless_Nick(playerid),P_E[playerid][info_last][2],P_E[playerid][info_last][1],P_E[playerid][info_last][0]);
    lawless_FREEZE(playerid,false);

	if(P_E[playerid][info_tutorial] == 0)
	{
	    lawless_Chat(playerid,20);
	    
	    INFO(playerid,"Niste odgledali tutorial do kraja!");
	    INFO(playerid,"Zbog toga ste vraceni ponovo na ceo tutorial,sledeci put odgledajte do kraja!");
	    
	    InterpolateCameraPos(playerid,350.108337,-2624.405273,64.378433,1048.482421,-2006.849365,28.495578,20000);
		InterpolateCameraLookAt(playerid,354.091461,-2621.391113,64.155853,1050.146850,-2002.349243,27.089042,20000);

		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,1);
		lawless_Tutorial_False[playerid] = 1;
		lawless_POSITIONS(playerid,1463.7633,-1041.4501,26.8281);

		lawless_PTDS(playerid,tutorial_Data[0][playerid]);
        lawless_PTDS(playerid,tutorial_Data[1][playerid]);
        lawless_PTDS(playerid,tutorial_Data[2][playerid]);
        lawless_PTDS(playerid,tutorial_Data[3][playerid]);
        lawless_PTDS(playerid,tutorial_Data[4][playerid]);
        lawless_PTDS(playerid,tutorial_Data[5][playerid]);
        lawless_PTDS(playerid,tutorial_Data[6][playerid]);
        lawless_PTDS(playerid,tutorial_Data[7][playerid]);
        lawless_PTDS(playerid,tutorial_Data[8][playerid]);
        lawless_PTDS(playerid,tutorial_Data[9][playerid]);
        lawless_PTDS(playerid,tutorial_Data[10][playerid]);
        lawless_PTDS(playerid,tutorial_Data[11][playerid]);
        lawless_PTDS(playerid,tutorial_Data[12][playerid]);
        lawless_PTDS(playerid,tutorial_Data[13][playerid]);
        lawless_PTDS(playerid,tutorial_Data[14][playerid]);
        lawless_PTDS(playerid,tutorial_Data[15][playerid]);
        lawless_PTDS(playerid,tutorial_Data[16][playerid]);
        defer lawless_CameraTutorial(playerid);
	}

    lawless_CREATE_ORG[playerid] = -1;
    lawless_CREATE_VEHS[playerid] = 0;
    lawless_JOIN_INTERIOR[playerid] = 0;
    lawless_CREATE_RANKS[playerid] = 0;
    lawless_Hospital[playerid] = 0;
    lawless_EDIT_LEVEL[playerid] = 0;
    lawless_GPS_HAVEN[playerid] = 0;
    lawless_BH[playerid] = 0;
    lawless_SALON[playerid] = -1;
    lawless_ORG_PICKUP[playerid] = -1;
    lawless_ORG_SEF[playerid] = 0;
    lawless_ASKQ_ANSWER[playerid] = 0;
    lawless_ANTI_BH[playerid] = 0;
    lawless_Loadinger[playerid] = -1;
    lawless_Tutorial_False[playerid] = -1;

    new Float:lawless_bar;
	if(P_E[playerid][info_hungry] > 0 ) lawless_bar = P_E[playerid][info_hungry];
	else if(P_E[playerid][info_hungry] <= 0 ) lawless_bar = 0;

    SetPlayerProgressBarValue(playerid,lawless_Glad[playerid],lawless_bar);
    ShowPlayerProgressBar(playerid,lawless_Glad[playerid]);
	return false;
}

/*============================================================================*/

stock lawless_updateSALON(salon)
{
    new lawless_string[300];
    DestroyDynamicPickup(lawless_salon_pickup[salon]);
    DestroyDynamic3DTextLabel(lawless_salon_label[salon]);

    if(A_E[salon][salon_created] == 1)
	{
	 	if(A_E[salon][salon_owned] == 0)
		{
		 	format(lawless_string,sizeof(lawless_string),"{DDFF00}[OWNERSHIP - NON OWNED - %d]\n\
			{FFFFFF}LEVEL - '%d'.\n\
			{FFFFFF}CENA - '$%d'.\n\
			{FFFFFF}IME AUTOSALONA - '%s'.\n\n\
			{FFFFFF}ZA KUPOVINU - '/KUPIAUTOSALON'.",salon,A_E[salon][salon_level],A_E[salon][salon_money],A_E[salon][salon_name]);
		 	lawless_salon_pickup[salon] = lawless_CDP(1239,1,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2]);
		 	lawless_salon_label[salon] = lawless_C3D(lawless_string,-1,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2],5);
		 	lawless_createdynamic_map_salon[salon] = lawless_MAPA(A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2],55,-1,-1,-1,-1,100);
		}
		else if(A_E[salon][salon_owned] == 1)
		{
		 	new lawless_buy[20];
		 	if(A_E[salon][salon_buy]) { lawless_buy = "OMOGUCENA"; } else { lawless_buy = "ONEMOGUCENA"; }

			format(lawless_string,sizeof(lawless_string),"{DDFF00}[OWNERSHIP - OWNED - %s - %s - %d]\n\
			{FFFFFF}KUPOVINA VOZILA - '%s'.\n\
			{FFFFFF}KORISTITE '/KUPIVOZILO' ZA KUPOVINU.",A_E[salon][salon_owner],A_E[salon][salon_name],salon,lawless_buy);
			lawless_salon_pickup[salon] = lawless_CDP(1239,1,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2]);
			lawless_salon_label[salon] = lawless_C3D(lawless_string,-1,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2],5);
			lawless_createdynamic_map_salon[salon] = lawless_MAPA(A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2],55,-1,-1,-1,-1,100);
		}
	}
	return true;
}

/*============================================================================*/

stock lawless_updateHOUSE(houseid)
{
    new lawless_string[300];
    DestroyDynamicPickup(lawless_houses_pickup[houseid]);
    DestroyDynamic3DTextLabel(lawless_houses_label[houseid]);

    if(H_E[houseid][house_created] == 1)
	{
	    if(H_E[houseid][house_owned] == 0)
		{
	 		new lawless_h_type[15];
	 		if(H_E[houseid][house_type] == 0) { lawless_h_type = "KAMP KUCA"; }
	 		else if(H_E[houseid][house_type] == 1) { lawless_h_type = "VELIKA KUCA"; }
	 		else if(H_E[houseid][house_type] == 2) { lawless_h_type = "SREDNJA KUCA"; }
	 		else if(H_E[houseid][house_type] == 3) { lawless_h_type = "MALA KUCA"; }

			format(lawless_string,sizeof(lawless_string),"{7EDDFC}[HOUSE - NON OWNED]\n{FFFFFF}LEVEL - '%d'.\n{FFFFFF}CENA - '$%d'.\n\
			{FFFFFF}VELICINA - '%s'.\n{7EDDFC}ZA KUPOVINU - '/KUPIKUCU'.",H_E[houseid][house_level],H_E[houseid][house_price],lawless_h_type);
			lawless_houses_label[houseid] = lawless_C3D(lawless_string,-1,H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2],5);
			lawless_houses_pickup[houseid] = lawless_CDP(19524,1,H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2]);
            lawless_createdynamic_map_house[houseid] = lawless_MAPA(H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2],31,-1,-1,-1,-1,100);
		}
		else if(H_E[houseid][house_owned] == 1)
		{
	 		new lawless_h_type[15];
	 		if(H_E[houseid][house_type] == 0) { lawless_h_type = "KAMP KUCA"; }
	 		else if(H_E[houseid][house_type] == 1) { lawless_h_type = "VELIKA KUCA"; }
	 		else if(H_E[houseid][house_type] == 2) { lawless_h_type = "SREDNJA KUCA"; }
	 		else if(H_E[houseid][house_type] == 3) { lawless_h_type = "MALA KUCA"; }

			format(lawless_string,sizeof(lawless_string),"{7EDDFC}[HOUSE - OWNED - %s]\n\
			{FFFFFF}LEVEL - '%d'.\n{FFFFFF}CENA - '$%d'.\n{FFFFFF}VELICINA - '%s'.",H_E[houseid][house_owner],H_E[houseid][house_level],H_E[houseid][house_price],lawless_h_type);
			lawless_houses_label[houseid] = lawless_C3D(lawless_string,-1,H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2],5);
			lawless_houses_pickup[houseid] = lawless_CDP(19522,1,H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2]);
	        lawless_createdynamic_map_house[houseid] = lawless_MAPA(H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2],32,-1,-1,-1,-1,100);
		}
	}
	return true;
}

/*============================================================================*/

stock lawless_Models(vehicleid,model[],len)
{
	new checking = GetVehicleModel(vehicleid);
	if(checking == 400) return format(model,len,"Landstalker", 0);
	else if(checking == 401) return format(model,len,"Bravura", 0);
	else if(checking == 402) return format(model,len,"Buffalo", 0);
	else if(checking == 403) return format(model,len,"Linerunner", 0);
	else if(checking == 404) return format(model,len,"Perenail", 0);
	else if(checking == 405) return format(model,len,"Sentinel", 0);
	else if(checking == 406) return format(model,len,"Dumper", 0);
	else if(checking == 407) return format(model,len,"Firetruck", 0);
	else if(checking == 408) return format(model,len,"Trashmaster", 0);
	else if(checking == 409) return format(model,len,"Stretch", 0);
	else if(checking == 410) return format(model,len,"Manana", 0);
	else if(checking == 411) return format(model,len,"Infernus", 0);
	else if(checking == 412) return format(model,len,"Vodooo", 0);
	else if(checking == 413) return format(model,len,"Pony", 0);
	else if(checking == 414) return format(model,len,"Mule", 0);
	else if(checking == 415) return format(model,len,"Cheetah", 0);
	else if(checking == 416) return format(model,len,"Ambulance", 0);
	else if(checking == 417) return format(model,len,"Leviathan", 0);
	else if(checking == 418) return format(model,len,"Moonbeam", 0);
	else if(checking == 419) return format(model,len,"Esperanto", 0);
	else if(checking == 420) return format(model,len,"Taxi", 0);
	else if(checking == 421) return format(model,len,"Washington", 0);
	else if(checking == 422) return format(model,len,"Bobcat", 0);
	else if(checking == 423) return format(model,len,"Mr Whoopee", 0);
	else if(checking == 424) return format(model,len,"BF Injection", 0);
	else if(checking == 425) return format(model,len,"Hunter", 0);
	else if(checking == 426) return format(model,len,"Premier", 0);
	else if(checking == 427) return format(model,len,"S.W.A.T Truck", 0);
	else if(checking == 428) return format(model,len,"Securicar", 0);
	else if(checking == 429) return format(model,len,"Banshee", 0);
	else if(checking == 430) return format(model,len,"Predator", 0);
	else if(checking == 431) return format(model,len,"Bus", 0);
	else if(checking == 432) return format(model,len,"Rhino", 0);
	else if(checking == 433) return format(model,len,"Barracks", 0);
	else if(checking == 434) return format(model,len,"Hotknife", 0);
	else if(checking == 435) return format(model,len,"Trailer", 0);
	else if(checking == 436) return format(model,len,"Previon", 0);
	else if(checking == 437) return format(model,len,"Coach", 0);
	else if(checking == 438) return format(model,len,"Cabbie", 0);
	else if(checking == 439) return format(model,len,"Stallion", 0);
	else if(checking == 440) return format(model,len,"Rumpo", 0);
	else if(checking == 441) return format(model,len,"RC Bandit", 0);
	else if(checking == 442) return format(model,len,"Romero", 0);
	else if(checking == 443) return format(model,len,"Packer", 0);
	else if(checking == 444) return format(model,len,"Monster", 0);
	else if(checking == 445) return format(model,len,"Admiral", 0);
	else if(checking == 446) return format(model,len,"Squalo", 0);
	else if(checking == 447) return format(model,len,"Seasparrow", 0);
	else if(checking == 448) return format(model,len,"Pizza Boy", 0);
	else if(checking == 449) return format(model,len,"Tram", 0);
	else if(checking == 450) return format(model,len,"Trailer 2", 0);
	else if(checking == 451) return format(model,len,"Turismo", 0);
	else if(checking == 452) return format(model,len,"Speeder", 0);
	else if(checking == 453) return format(model,len,"Refeer", 0);
	else if(checking == 454) return format(model,len,"Tropic", 0);
	else if(checking == 455) return format(model,len,"Flatbed", 0);
	else if(checking == 456) return format(model,len,"Yankee", 0);
	else if(checking == 457) return format(model,len,"Caddy", 0);
	else if(checking == 458) return format(model,len,"Solair", 0);
	else if(checking == 459) return format(model,len,"Top Fun", 0);
	else if(checking == 460) return format(model,len,"Skimmer", 0);
	else if(checking == 461) return format(model,len,"PCJ-600", 0);
	else if(checking == 462) return format(model,len,"Faggio", 0);
	else if(checking == 463) return format(model,len,"Freeway", 0);
	else if(checking == 464) return format(model,len,"RC Baron", 0);
	else if(checking == 465) return format(model,len,"RC Raider", 0);
	else if(checking == 466) return format(model,len,"Glendade", 0);
	else if(checking == 467) return format(model,len,"Oceanic", 0);
	else if(checking == 468) return format(model,len,"Sanchez", 0);
	else if(checking == 469) return format(model,len,"Sparrow", 0);
	else if(checking == 470) return format(model,len,"Patriot", 0);
	else if(checking == 471) return format(model,len,"Quad", 0);
	else if(checking == 472) return format(model,len,"Coastguard", 0);
	else if(checking == 473) return format(model,len,"Dinghy", 0);
	else if(checking == 474) return format(model,len,"Hermes", 0);
	else if(checking == 475) return format(model,len,"Sabre", 0);
	else if(checking == 476) return format(model,len,"Rustler", 0);
	else if(checking == 477) return format(model,len,"ZR-350", 0);
	else if(checking == 478) return format(model,len,"Walton", 0);
	else if(checking == 479) return format(model,len,"Regina", 0);
	else if(checking == 480) return format(model,len,"Comet", 0);
	else if(checking == 481) return format(model,len,"BMX", 0);
	else if(checking == 482) return format(model,len,"Burrito", 0);
	else if(checking == 483) return format(model,len,"Camper", 0);
	else if(checking == 484) return format(model,len,"Marquis", 0);
	else if(checking == 485) return format(model,len,"Baggage", 0);
	else if(checking == 486) return format(model,len,"Dozer", 0);
	else if(checking == 487) return format(model,len,"Maverick", 0);
	else if(checking == 488) return format(model,len,"News Maverick", 0);
	else if(checking == 489) return format(model,len,"Rancher", 0);
	else if(checking == 490) return format(model,len,"Federal Rancher", 0);
	else if(checking == 491) return format(model,len,"Virgo", 0);
	else if(checking == 492) return format(model,len,"Greenwood", 0);
	else if(checking == 493) return format(model,len,"Jetmax", 0);
	else if(checking == 494) return format(model,len,"Hotring", 0);
	else if(checking == 495) return format(model,len,"Sandking", 0);
	else if(checking == 496) return format(model,len,"Blista Compact", 0);
	else if(checking == 497) return format(model,len,"Police Maverick", 0);
	else if(checking == 498) return format(model,len,"Boxville", 0);
	else if(checking == 499) return format(model,len,"Benson", 0);
	else if(checking == 500) return format(model,len,"Mesa", 0);
	else if(checking == 501) return format(model,len,"RC Goblin", 0);
	else if(checking == 502) return format(model,len,"Hotring A", 0);
	else if(checking == 503) return format(model,len,"Hotring B", 0);
	else if(checking == 504) return format(model,len,"Blooding Banger", 0);
	else if(checking == 505) return format(model,len,"Rancher", 0);
	else if(checking == 506) return format(model,len,"Super GT", 0);
	else if(checking == 507) return format(model,len,"Elegant", 0);
	else if(checking == 508) return format(model,len,"Journey", 0);
	else if(checking == 509) return format(model,len,"Bike", 0);
	else if(checking == 510) return format(model,len,"Mountain Bike", 0);
	else if(checking == 511) return format(model,len,"Beagle", 0);
	else if(checking == 512) return format(model,len,"Cropduster", 0);
	else if(checking == 513) return format(model,len,"Stuntplane", 0);
	else if(checking == 514) return format(model,len,"Petrol", 0);
	else if(checking == 515) return format(model,len,"Roadtrain", 0);
	else if(checking == 516) return format(model,len,"Nebula", 0);
	else if(checking == 517) return format(model,len,"Majestic", 0);
	else if(checking == 518) return format(model,len,"Buccaneer", 0);
	else if(checking == 519) return format(model,len,"Shamal", 0);
	else if(checking == 520) return format(model,len,"Hydra", 0);
	else if(checking == 521) return format(model,len,"FCR-300", 0);
	else if(checking == 522) return format(model,len,"NRG-500", 0);
	else if(checking == 523) return format(model,len,"HPV-1000", 0);
	else if(checking == 524) return format(model,len,"Cement Truck", 0);
	else if(checking == 525) return format(model,len,"Towtruck", 0);
	else if(checking == 526) return format(model,len,"Fortune", 0);
	else if(checking == 527) return format(model,len,"Cadrona", 0);
	else if(checking == 528) return format(model,len,"Federal Truck", 0);
	else if(checking == 529) return format(model,len,"Williard", 0);
	else if(checking == 530) return format(model,len,"Fork Lift", 0);
	else if(checking == 531) return format(model,len,"Tractor", 0);
	else if(checking == 532) return format(model,len,"Combine", 0);
	else if(checking == 533) return format(model,len,"Feltzer", 0);
	else if(checking == 534) return format(model,len,"Remington", 0);
	else if(checking == 535) return format(model,len,"Slamvan", 0);
	else if(checking == 536) return format(model,len,"Blade", 0);
	else if(checking == 537) return format(model,len,"Freight", 0);
	else if(checking == 538) return format(model,len,"Streak", 0);
	else if(checking == 539) return format(model,len,"Vortex", 0);
	else if(checking == 540) return format(model,len,"Vincent", 0);
	else if(checking == 541) return format(model,len,"Bullet", 0);
	else if(checking == 542) return format(model,len,"Clover", 0);
	else if(checking == 543) return format(model,len,"Sadler", 0);
	else if(checking == 544) return format(model,len,"Stairs Firetruck", 0);
	else if(checking == 545) return format(model,len,"Hustler", 0);
	else if(checking == 546) return format(model,len,"Intruder", 0);
	else if(checking == 547) return format(model,len,"Primo", 0);
	else if(checking == 548) return format(model,len,"Cargobob", 0);
	else if(checking == 549) return format(model,len,"Tampa", 0);
	else if(checking == 550) return format(model,len,"Sunrise", 0);
	else if(checking == 551) return format(model,len,"Merit", 0);
	else if(checking == 552) return format(model,len,"Utility Van", 0);
	else if(checking == 553) return format(model,len,"Nevada", 0);
	else if(checking == 554) return format(model,len,"Yosemite", 0);
	else if(checking == 555) return format(model,len,"Windsor", 0);
	else if(checking == 556) return format(model,len,"Monster A", 0);
	else if(checking == 557) return format(model,len,"Monster B", 0);
	else if(checking == 558) return format(model,len,"Uranus", 0);
	else if(checking == 559) return format(model,len,"Jester", 0);
	else if(checking == 560) return format(model,len,"Sultan", 0);
	else if(checking == 561) return format(model,len,"Stratum", 0);
	else if(checking == 562) return format(model,len,"Elegy", 0);
	else if(checking == 563) return format(model,len,"Raindance", 0);
	else if(checking == 564) return format(model,len,"RC Tiger", 0);
	else if(checking == 565) return format(model,len,"Flash", 0);
	else if(checking == 566) return format(model,len,"Tahoma", 0);
	else if(checking == 567) return format(model,len,"Savanna", 0);
	else if(checking == 568) return format(model,len,"Bandito", 0);
	else if(checking == 569) return format(model,len,"Freight Flat", 0);
	else if(checking == 570) return format(model,len,"Streak", 0);
	else if(checking == 571) return format(model,len,"Kart", 0);
	else if(checking == 572) return format(model,len,"Mower", 0);
	else if(checking == 573) return format(model,len,"Duneride", 0);
	else if(checking == 574) return format(model,len,"Sweeper", 0);
	else if(checking == 575) return format(model,len,"Broadway", 0);
	else if(checking == 576) return format(model,len,"Tornado", 0);
	else if(checking == 577) return format(model,len,"AT-400", 0);
	else if(checking == 578) return format(model,len,"DFT-30", 0);
	else if(checking == 579) return format(model,len,"Huntley", 0);
	else if(checking == 580) return format(model,len,"Stafford", 0);
	else if(checking == 581) return format(model,len,"BF-400", 0);
	else if(checking == 582) return format(model,len,"Raindance", 0);
	else if(checking == 583) return format(model,len,"News Van", 0);
	else if(checking == 584) return format(model,len,"Tug", 0);
	else if(checking == 585) return format(model,len,"Petrol Tanker", 0);
	else if(checking == 586) return format(model,len,"Wayfarer", 0);
	else if(checking == 587) return format(model,len,"Euros", 0);
	else if(checking == 588) return format(model,len, "Hotdog", 0);
	else if(checking == 589) return format(model,len,"Club", 0);
	else if(checking == 590) return format(model,len,"Freight Box", 0);
	else if(checking == 591) return format(model,len,"Trailer 3", 0);
	else if(checking == 592) return format(model,len,"Andromada", 0);
	else if(checking == 593) return format(model,len,"Dodo", 0);
	else if(checking == 594) return format(model,len,"RC Cam", 0);
	else if(checking == 595) return format(model,len,"Launch", 0);
	else if(checking == 596) return format(model,len,"BGPD Patrol Car", 0);
	else if(checking == 597) return format(model,len,"INT Patrol Car", 0);
	else if(checking == 598) return format(model,len,"NG Patrol Car", 0);
	else if(checking == 599) return format(model,len,"BGPD Patrol Ranger", 0);
	else if(checking == 600) return format(model,len,"Picador", 0);
	else if(checking == 601) return format(model,len,"S.W.A.T Tank", 0);
    else if(checking == 602) return format(model,len,"Alpha", 0);
	else if(checking == 603) return format(model,len,"Phoenix", 0);
	else if(checking == 609) return format(model,len,"Boxville", 0);
	return false;
}

/*============================================================================*/

stock lawless_createLABEL()
{
    new id = (-1);
    for(new loop = (0), kloop = (-1), create_string[64] = "\0"; loop != MAX_LABEL; ++ kloop)
	{
       kloop = (loop+1);
       format(create_string,(sizeof create_string),LABS,kloop);
       if(!fexist(create_string))
	   {
          id = (kloop);
          break;
		}
	}
  	return (id);
}

/*============================================================================*/

stock lawless_createGPS()
{
    new id = (-1);
    for(new loop = (0), kloop = (-1), create_string[64] = "\0"; loop != MAX_GPS; ++ kloop)
	{
       kloop = (loop+1);
       format(create_string,(sizeof create_string),GPSS,kloop);
       if(!fexist(create_string))
	   {
          id = (kloop);
          break;
		}
	}
	return (id);
}

/*============================================================================*/

stock lawless_createORG()
{
    new id = (-1);
    for(new loop = (0), kloop = (-1), create_string[64] = "\0"; loop != MAX_ORG; ++ kloop)
	{
       kloop = (loop+1);
       format(create_string,(sizeof create_string),ORGS,kloop);
       if(!fexist(create_string))
	   {
          id = (kloop);
          break;
		}
	}
  	return (id);
}

/*============================================================================*/

stock lawless_createSALON()
{
    new id = (-1);
    for(new loop = (0), kloop = (-1), create_string[64] = "\0"; loop != MAX_SALONS; ++ kloop)
	{
       kloop = (loop+1);
       format(create_string,(sizeof create_string),SALON,kloop);
       if(!fexist(create_string))
	   {
          id = (kloop);
          break;
		}
	}
  	return (id);
}

/*============================================================================*/

stock lawless_createHOUSE()
{
    new id = (-1);
    for(new loop = (0), kloop = (-1), create_string[64] = "\0"; loop != MAX_HOUSES; ++ kloop)
	{
       kloop = (loop+1);
       format(create_string,(sizeof create_string),HOUS,kloop);
       if(!fexist(create_string))
	   {
          id = (kloop);
          break;
		}
	}
  	return (id);
}

/*============================================================================*/

stock lawless_Reset(playerid)
{
    P_E[playerid][info_pol] = 0;
    P_E[playerid][info_godine] = 0;
    P_E[playerid][info_skin] = 0;
	P_E[playerid][info_registration] = 0;
	P_E[playerid][info_level] = 0;
	P_E[playerid][info_cash] = 0;
	P_E[playerid][info_last][0] = 0;
	P_E[playerid][info_last][1] = 0;
	P_E[playerid][info_last][2] = 0;
	P_E[playerid][info_stat] = 0;
	P_E[playerid][info_bank] = 0;
	P_E[playerid][info_euro] = 0;
	P_E[playerid][info_paypoen] = 0;
	P_E[playerid][info_experiens] = 0;
	P_E[playerid][info_hours] = 0;
	P_E[playerid][info_colour] = 0;
	P_E[playerid][info_admin] = 0;
	P_E[playerid][info_acode] = 0;
	P_E[playerid][info_vehicles][0] = 9999;
	P_E[playerid][info_vehicles][1] = 9999;
	P_E[playerid][info_vehicles][2] = 9999;
	P_E[playerid][info_vehicles][3] = 9999;
	P_E[playerid][info_vehsalon] = 9999;
	P_E[playerid][info_insurance] = 0;
	P_E[playerid][info_hungry] = 100;
	P_E[playerid][info_tutorial] = 0;
	P_E[playerid][info_wantedlevel] = 0;
	P_E[playerid][info_upgrade] = 0;
	P_E[playerid][info_inteligenci] = 0;
	P_E[playerid][info_school] = 0;
	P_E[playerid][info_power] = 0;
	P_E[playerid][info_dexterity] = 0;
	P_E[playerid][info_vehicles_double_key][0] = 9999;
	P_E[playerid][info_vehicles_double_key][1] = 9999;
	P_E[playerid][info_vehicles_double_key][2] = 9999;
	P_E[playerid][info_vehicles_double_key][3] = 9999;
	P_E[playerid][info_leader] = 0;
	P_E[playerid][info_member] = 0;
	P_E[playerid][info_houses_key] = 9999;
	P_E[playerid][info_admin_hours] = 0;

	lawless_Login[playerid] = 0;
	lawless_Logo[playerid] = 0;
	lawless_Stepens[playerid] = 0;
	lawless_Hospital[playerid] = 0;
	lawless_Bleeding[playerid] = 0;
	lawless_Chatined[playerid] = 0;
	lawless_BH[playerid] = 0;
	lawless_ANTI_BH[playerid] = 0;
	lawless_CREATE_ORG[playerid] = -1;
	lawless_CREATE_VEHS[playerid] = 0;
	lawless_JOIN_INTERIOR[playerid] = 0;
	lawless_CREATE_RANKS[playerid] = 0;
	lawless_EDIT_LEVEL[playerid] = 0;
	lawless_GPS_HAVEN[playerid] = 0;
	lawless_ORG_PICKUP[playerid] = -1;
    lawless_ORG_SEF[playerid] = 0;
    lawless_ASKQ_ANSWER[playerid] = 0;
    lawless_Loadinger[playerid] = -1;
    lawless_SALON[playerid] = -1;
    lawless_Tutorial_False[playerid] = -1;
    
	lawless_Password[playerid] = false;
	lawless_Drzava[playerid] = false;
	lawless_Pol[playerid] = false;
	lawless_Godine[playerid] = false;
	lawless_Email[playerid] = false;
	lawless_Security[playerid] = false;
	
	AS_IE[playerid][askq_poslato] = false;
	AS_IE[playerid][askq_odgovoreno] = false;
	strmid(AS_IE[playerid][askq_odgovor_admin],"Nista",0,strlen("Nista"),32);
	strmid(AS_IE[playerid][askq_odgovor],"Nista",0,strlen("Nista"),128);
	return true;
}

/*============================================================================*/

stock lawless_restarting_anticheat()
{
    A_C[anticheat_save] = 0;
    A_C[anticheat_money] = 0;
    A_C[anticheat_health] = 0;
    A_C[anticheat_armour] = 0;
    A_C[anticheat_rcon] = 0;
    A_C[anticheat_chat] = 0;
    A_C[anticheat_say] = 0;
    A_C[anticheat_bunnyhop] = 0;
    A_C[anticheat_joypad] = 0;
    A_C[anticheat_weaponcrash] = 0;
    A_C[anticheat_register] = 1;
    lawless_saveAC();
	return true;
}

/*============================================================================*/

stock lawless_Bicikle(id)
{
	if(id == 481 || id == 509 || id == 510) return true;
	return false;
}

/*============================================================================*/

stock lawless_Brzina(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 178.8617875;
    return floatround(ST[3]);
}

/*============================================================================*/

lawless_Validname(const name[])
{
	if(!name[0] || strfind(name,"_") == -1) return false;
	else for (new i = 0, len = strlen(name); i != len; i ++)
	{
	 	if((i == 0) && (name[i] < 'A' || name[i] > 'Z')) return false;
		else if((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z')) return false;
		else if((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.') return false;
	}
	return true;
}

/*============================================================================*/

lawless_loading_LAPI()
{
    /*                        	ALL - LABELS                                  */

	lawless_C3D("{5D9DB3}Lawless\n{5D9DB3}Since 2016\n{5D9DB3}www.lawless-hq.com\n{FFFFFF}(c) all rights reserved\n\n{5D9DB3}By - #Dzoni",-1,1890.9182,-1681.2683,17.8636,10);

	/*                        	ALL - LABELS - END                            */
	return true;
}

/*============================================================================*/

lawless_loading_MAPS()
{
    /*                	MAP - KOMERCIJALNA - AXA - AUTO SALON 				  */

	new generalimotorsglavni = CreateObject(19325, 2057.68384, -1898.64941, 17.19010,   0.00000, 0.00000, 180.00000);
	SetObjectMaterialText(generalimotorsglavni, "GENERALI {000000}MOTORS", 0, 140, "Arial Black", 40, 1, 0xFFFF0000, 0, 1);
	new generalimotorsiznadsaltera = CreateObject(19353, 2047.05029, -1875.37231, 17.47151, 0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(generalimotorsiznadsaltera, "GENERALI {000000}MOTORS", 0, 140, "Arial Black", 37, 1, 0xFFFF0000, 0, 1);
	new generalisalter1 = CreateObject(19353, 2045.99500, -1879.78088, 12.95063, 0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(generalisalter1, "{000000}SALTER 2", 0, 140, "Arial", 50, 1, -1, 0, 1);
	new generalisalter2 = CreateObject(19353, 2049.02637, -1879.78088, 12.95060,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(generalisalter2, "{000000}SALTER 1", 0, 140, "Arial", 50, 1, -1, 0, 1);
	new generalinatpissastran1 = CreateObject(19353, 2047.02209, -1874.47803, 16.28480, 0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(generalinatpissastran1, "GENERALI {000000}MOTORS", 0, 140, "Arial Black", 37, 1, 0xFFFF0000, 0, 1);
	new generalinatpissastran2 = CreateObject(19353, 2046.92957, -1922.68225, 16.28480, 0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(generalinatpissastran2, "GENERALI {000000}MOTORS", 0, 140, "Arial Black", 37, 1, 0xFFFF0000, 0, 1);
	new genquality1 = CreateObject(19353, 2046.92957, -1922.68225, 15.54181, 0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(genquality1, "{000000}Quality & safety cars", 0, 140, "Arial", 30, 1, -1, 0, 1);
	new genquality2 = CreateObject(19353, 2047.02209, -1874.47803, 15.54181, 0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(genquality2, "{000000}Quality & safety cars", 0, 140, "Arial", 30, 1, -1, 0, 1);

	new podautosgen[17];
	podautosgen[0] = lawless_CDE(19377, 2041.86145, -1917.87549, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[1] = lawless_CDE(19377, 2041.86145, -1908.26599, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[2] = lawless_CDE(19377, 2041.86145, -1898.65845, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[3] = lawless_CDE(19377, 2041.86145, -1889.03760, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[4] = lawless_CDE(19377, 2041.86145, -1879.42639, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[5] = lawless_CDE(19377, 2052.35010, -1917.87549, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[6] = lawless_CDE(19377, 2052.35010, -1908.26599, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[7] = lawless_CDE(19377, 2052.35010, -1898.65845, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[8] = lawless_CDE(19377, 2052.35010, -1889.03760, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[9] = lawless_CDE(19377, 2052.35010, -1879.42639, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[10] = lawless_CDE(19377, 2062.83252, -1917.87549, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[11] = lawless_CDE(19377, 2062.83252, -1908.26599, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[12] = lawless_CDE(19377, 2062.83252, -1898.65845, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[13] = lawless_CDE(19377, 2062.83252, -1889.03760, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[14] = lawless_CDE(19377, 2062.83252, -1879.42639, 12.50760,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[15] = lawless_CDE(19377, 2066.46387, -1898.65845, 12.50500,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	podautosgen[16] = lawless_CDE(19377, 2066.46387, -1889.03760, 12.50500,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(podautosgen); i++)
	{
		SetDynamicObjectMaterial(podautosgen[i], 0, 8399, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);
	}

	new beloautosgen[25];
	beloautosgen[0] = lawless_CDE(18980, 2037.03931, -1922.25903, 7.64865,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[1] = lawless_CDE(18980, 2057.17725, -1922.25903, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[2] = lawless_CDE(18980, 2057.17725, -1874.93811, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[3] = lawless_CDE(18980, 2037.03931, -1874.93811, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[4] = lawless_CDE(19391, 2057.51904, -1898.74707, 14.32240,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[5] = lawless_CDE(18766, 2037.03931, -1901.07275, 15.15860,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	beloautosgen[6] = lawless_CDE(18766, 2037.03931, -1896.07556, 15.15860,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	beloautosgen[7] = lawless_CDE(18766, 2046.98364, -1922.25903, 15.15860,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	beloautosgen[8] = lawless_CDE(18766, 2046.98364, -1874.93811, 15.15860,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	beloautosgen[9] = lawless_CDE(18980, 2057.17725, -1885.40112, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[10] = lawless_CDE(18980, 2057.17725, -1911.31836, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[11] = lawless_CDE(18980, 2060.56201, -1882.07629, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[12] = lawless_CDE(18980, 2060.56201, -1878.29590, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[13] = lawless_CDE(18980, 2060.56201, -1918.89575, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[14] = lawless_CDE(18980, 2060.56201, -1914.64294, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[15] = lawless_CDE(18980, 2057.17725, -1891.06152, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[16] = lawless_CDE(18980, 2057.17725, -1906.02759, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[17] = lawless_CDE(18980, 2057.17725, -1892.04907, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[18] = lawless_CDE(18980, 2057.17725, -1905.06079, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[19] = lawless_CDE(18766, 2057.17310, -1898.65088, 17.65900,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	beloautosgen[20] = lawless_CDE(18980, 2046.86523, -1898.82959, 7.64870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	beloautosgen[21] = lawless_CDE(19353, 2045.96838, -1879.77820, 11.92210,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	beloautosgen[22] = lawless_CDE(19353, 2049.09424, -1879.77820, 11.92210,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	beloautosgen[23] = lawless_CDE(19353, 2051.74487, -1878.35620, 11.92210,   0.00000, 0.00000, -45.00000, 300.0, 300.0);
	beloautosgen[24] = lawless_CDE(19353, 2043.29724, -1878.34814, 11.92210,   0.00000, 0.00000, 45.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(beloautosgen); i++)
	{
		SetDynamicObjectMaterial(beloautosgen[i], 0, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	}

	new prozoriautosgen[44];
	prozoriautosgen[0] = lawless_CDE(19325, 2059.11230, -1883.98804, 16.81760,   90.00000, 45.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[1] = lawless_CDE(19325, 2059.11230, -1883.98804, 10.18290,   90.00000, 45.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[2] = lawless_CDE(19325, 2060.65405, -1880.43127, 16.81760,   90.00000, 90.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[3] = lawless_CDE(19325, 2059.11426, -1876.34766, 16.81760,   90.00000, -45.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[4] = lawless_CDE(19325, 2060.65405, -1880.43127, 10.18290,   90.00000, 90.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[5] = lawless_CDE(19325, 2059.11426, -1876.34766, 10.18290,   90.00000, -45.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[6] = lawless_CDE(19325, 2059.09155, -1920.81506, 16.81760,   90.00000, 45.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[7] = lawless_CDE(19325, 2059.11621, -1912.76794, 16.81760,   90.00000, -45.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[8] = lawless_CDE(19325, 2060.65405, -1916.78333, 16.81760,   90.00000, -90.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[9] = lawless_CDE(19325, 2059.09155, -1920.81506, 10.18290,   90.00000, 45.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[10] = lawless_CDE(19325, 2060.65405, -1916.78333, 10.18290,   90.00000, -90.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[11] = lawless_CDE(19325, 2059.11621, -1912.76794, 10.18290,   90.00000, -45.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[12] = lawless_CDE(19325, 2053.59790, -1922.71704, 18.04930,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[13] = lawless_CDE(19325, 2046.97620, -1922.71704, 18.04930,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[14] = lawless_CDE(19325, 2040.34705, -1922.71704, 18.04930,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[15] = lawless_CDE(19325, 2053.59790, -1922.71704, 13.92950,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[16] = lawless_CDE(19325, 2046.97620, -1922.71704, 13.92950,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[17] = lawless_CDE(19325, 2040.34705, -1922.71704, 13.92950,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[18] = lawless_CDE(19325, 2036.60974, -1918.69312, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[19] = lawless_CDE(19325, 2036.60974, -1912.06995, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[20] = lawless_CDE(19325, 2036.60974, -1905.46741, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[21] = lawless_CDE(19325, 2036.60974, -1918.69312, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[22] = lawless_CDE(19325, 2036.60974, -1912.06995, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[23] = lawless_CDE(19325, 2036.60974, -1905.46741, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[24] = lawless_CDE(19325, 2036.60974, -1878.44568, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[25] = lawless_CDE(19325, 2036.60974, -1885.02734, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[26] = lawless_CDE(19325, 2036.60974, -1891.63269, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[27] = lawless_CDE(19325, 2036.60974, -1878.44568, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[28] = lawless_CDE(19325, 2036.60974, -1885.02734, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[29] = lawless_CDE(19325, 2036.60974, -1891.63269, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[30] = lawless_CDE(19325, 2053.84058, -1874.59937, 18.04930,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[31] = lawless_CDE(19325, 2047.22266, -1874.59937, 18.04930,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[32] = lawless_CDE(19325, 2040.62524, -1874.59937, 18.04930,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[33] = lawless_CDE(19325, 2053.84058, -1874.59937, 13.92950,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[34] = lawless_CDE(19325, 2047.22266, -1874.59937, 13.92950,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[35] = lawless_CDE(19325, 2040.62524, -1874.59937, 13.92950,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	prozoriautosgen[36] = lawless_CDE(19325, 2057.60254, -1908.40100, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[37] = lawless_CDE(19325, 2057.60254, -1902.96936, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[38] = lawless_CDE(19325, 2057.60254, -1888.36560, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[39] = lawless_CDE(19325, 2057.60254, -1894.38538, 18.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[40] = lawless_CDE(19325, 2057.60254, -1908.40100, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[41] = lawless_CDE(19325, 2057.60254, -1902.96936, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[42] = lawless_CDE(19325, 2057.60254, -1894.38538, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	prozoriautosgen[43] = lawless_CDE(19325, 2057.60254, -1888.36560, 13.92950,   0.00000, 0.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(prozoriautosgen); i++)
	{
		SetDynamicObjectMaterial(prozoriautosgen[i], 0, 12840, "cos_bankroofs", "nt_bonav1", 0xFFFFFFFF);
	}

	new parketautosgen[13];
	parketautosgen[0] = lawless_CDE(19377, 2047.59656, -1916.95313, 19.32040,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[1] = lawless_CDE(19377, 2047.59656, -1907.32324, 19.32040,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[2] = lawless_CDE(19377, 2047.59656, -1897.69995, 19.32040,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[3] = lawless_CDE(19377, 2047.59656, -1888.07678, 19.32040,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[8] = lawless_CDE(19454, 2053.13135, -1894.06299, 12.52690,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[9] = lawless_CDE(19454, 2053.13135, -1903.66675, 12.52690,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[4] = lawless_CDE(19454, 2046.58740, -1906.73413, 12.52690,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	parketautosgen[5] = lawless_CDE(19454, 2040.02930, -1903.66675, 12.52690,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[6] = lawless_CDE(19454, 2040.02930, -1894.06299, 12.52690,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[7] = lawless_CDE(19454, 2046.58740, -1890.99585, 12.52690,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	parketautosgen[10] = lawless_CDE(19454, 2040.02930, -1913.28235, 12.52690,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[11] = lawless_CDE(19454, 2053.13135, -1913.28235, 12.52690,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parketautosgen[12] = lawless_CDE(19454, 2046.58740, -1916.34949, 12.52690,   0.00000, 90.00000, 90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(parketautosgen); i++)
	{
		SetDynamicObjectMaterial(parketautosgen[i], 0, 13007, "sw_bankint", "woodfloor1", 0xFFFFFFFF);
	}

	new ogradaautosgen[4];
	ogradaautosgen[0] = lawless_CDE(19325, 2062.52051, -1922.70801, 11.14920,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	ogradaautosgen[1] = lawless_CDE(19325, 2062.49365, -1874.60645, 11.14920,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	ogradaautosgen[2] = lawless_CDE(19325, 2063.92944, -1882.56873, 11.14920,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	ogradaautosgen[3] = lawless_CDE(19325, 2063.84570, -1914.17480, 11.14920,   0.00000, 0.00000, 90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(ogradaautosgen); i++)
	{
		SetDynamicObjectMaterial(ogradaautosgen[i], 0, 6487, "councl_law2", "lanlabra1_M", 0xFFFFFFFF);
	}

	new zivicaautosgen[12];
	zivicaautosgen[0] = lawless_CDE(18766, 2069.56299, -1922.20142, 8.24010,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	zivicaautosgen[1] = lawless_CDE(18766, 2071.56860, -1917.69312, 10.73170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	zivicaautosgen[2] = lawless_CDE(18766, 2067.56104, -1917.69531, 10.73170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	zivicaautosgen[3] = lawless_CDE(18766, 2067.56104, -1907.72412, 10.73170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	zivicaautosgen[4] = lawless_CDE(18766, 2071.56860, -1907.72412, 10.73170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	zivicaautosgen[5] = lawless_CDE(18766, 2069.56299, -1903.22302, 8.24010,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	zivicaautosgen[6] = lawless_CDE(18766, 2067.56104, -1879.56555, 10.73170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	zivicaautosgen[7] = lawless_CDE(18766, 2069.56299, -1875.06262, 8.24010,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	zivicaautosgen[8] = lawless_CDE(18766, 2071.56860, -1879.56555, 10.73170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	zivicaautosgen[9] = lawless_CDE(18766, 2071.56860, -1889.56079, 10.73170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	zivicaautosgen[10] = lawless_CDE(18766, 2067.56104, -1889.56079, 10.73170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	zivicaautosgen[11] = lawless_CDE(18766, 2069.56299, -1894.06482, 8.24010,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(zivicaautosgen); i++)
	{
		SetDynamicObjectMaterial(zivicaautosgen[i], 0, 6344, "rodeo04_law2", "golf_hedge1", 0xFFFFFFFF);
	}

	new travaautosgen[4];
	travaautosgen[0] = lawless_CDE(19454, 2069.56128, -1889.16980, 12.80800,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	travaautosgen[1] = lawless_CDE(19454, 2069.56128, -1879.57153, 12.80800,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	travaautosgen[2] = lawless_CDE(19454, 2069.56079, -1917.23474, 12.80800,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	travaautosgen[3] = lawless_CDE(19454, 2069.56128, -1907.63110, 12.80800,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(travaautosgen); i++)
	{
		SetDynamicObjectMaterial(travaautosgen[i], 0, 10560, "baseballground_sfs","Grass_128HV",0xFFFFFFFF);
	}

	new parkingcrniautosgen[52];
	parkingcrniautosgen[0] = lawless_CDE(19454, 2067.16650, -1902.84656, 10.85500,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[1] = lawless_CDE(19454, 2067.16650, -1905.58728, 10.85500,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[2] = lawless_CDE(19454, 2067.16650, -1908.46167, 10.85500,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[3] = lawless_CDE(19454, 2067.16650, -1911.27075, 10.85500,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[4] = lawless_CDE(19454, 2067.16650, -1894.45605, 10.85500,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[5] = lawless_CDE(19454, 2067.16650, -1891.75623, 10.85500,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[6] = lawless_CDE(19454, 2067.16650, -1888.89478, 10.85500,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[7] = lawless_CDE(19454, 2067.16650, -1885.87036, 10.85500,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[8] = lawless_CDE(2230, 2044.82422, -1878.97180, 12.54940,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[9] = lawless_CDE(2230, 2044.21545, -1879.91724, 12.54940,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[10] = lawless_CDE(2230, 2047.18054, -1879.91724, 12.54940,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[11] = lawless_CDE(2230, 2047.78894, -1878.97180, 12.54940,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[12] = lawless_CDE(2230, 2050.23706, -1879.91724, 12.54940,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[13] = lawless_CDE(2230, 2050.84546, -1878.97180, 12.54940,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[14] = lawless_CDE(2230, 2052.65894, -1877.63257, 12.54940,   0.00000, 0.00000, 225.00000, 300.0, 300.0);
	parkingcrniautosgen[15] = lawless_CDE(2230, 2052.42700, -1876.53894, 12.54940,   0.00000, 0.00000, 45.00000, 300.0, 300.0);
	parkingcrniautosgen[16] = lawless_CDE(2230, 2041.96167, -1877.22217, 12.54940,   0.00000, 0.00000, -225.00000, 300.0, 300.0);
	parkingcrniautosgen[17] = lawless_CDE(2230, 2043.03662, -1877.00757, 12.54940,   0.00000, 0.00000, -45.00000, 300.0, 300.0);
	parkingcrniautosgen[18] = lawless_CDE(1783, 2045.64233, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[19] = lawless_CDE(1783, 2046.26233, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[20] = lawless_CDE(1783, 2046.90234, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[21] = lawless_CDE(1783, 2047.54236, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[22] = lawless_CDE(1783, 2048.16113, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[23] = lawless_CDE(1783, 2048.79736, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[24] = lawless_CDE(1783, 2049.41553, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[25] = lawless_CDE(1783, 2050.04883, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[26] = lawless_CDE(1783, 2045.02234, -1879.62268, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[27] = lawless_CDE(1783, 2045.02234, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[28] = lawless_CDE(1783, 2045.64233, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[29] = lawless_CDE(1783, 2046.26233, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[30] = lawless_CDE(1783, 2046.90234, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[31] = lawless_CDE(1783, 2047.54236, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[32] = lawless_CDE(1783, 2048.16113, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[33] = lawless_CDE(1783, 2048.79883, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[34] = lawless_CDE(1783, 2049.41553, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[35] = lawless_CDE(1783, 2050.04883, -1879.22266, 13.46090,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	parkingcrniautosgen[36] = lawless_CDE(18981, 2048.71973, -1911.11267, 19.73894,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[37] = lawless_CDE(18981, 2048.71973, -1886.13879, 19.73890,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[38] = lawless_CDE(19353, 2063.99268, -1915.33264, 11.04850,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[39] = lawless_CDE(19353, 2065.66992, -1916.85107, 11.04850,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[40] = lawless_CDE(19353, 2065.66992, -1920.05493, 11.04850,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[41] = lawless_CDE(19353, 2062.30371, -1916.84937, 11.04850,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[42] = lawless_CDE(19353, 2062.30371, -1920.05493, 11.04850,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[43] = lawless_CDE(19353, 2065.51782, -1879.92444, 11.04850,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[44] = lawless_CDE(19353, 2063.99268, -1921.57056, 11.04850,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[45] = lawless_CDE(19353, 2065.51782, -1876.72546, 11.04850,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[46] = lawless_CDE(19353, 2064.00317, -1875.20203, 11.04850,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[47] = lawless_CDE(19353, 2062.10645, -1876.72546, 11.04850,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[48] = lawless_CDE(19353, 2062.10645, -1879.92444, 11.04850,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	parkingcrniautosgen[49] = lawless_CDE(19353, 2063.63867, -1875.20203, 11.04850,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[50] = lawless_CDE(19353, 2063.99829, -1881.44397, 11.04850,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	parkingcrniautosgen[51] = lawless_CDE(19353, 2063.61670, -1881.44312, 11.04850,   0.00000, 0.00000, 90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(parkingcrniautosgen); i++)
	{
		SetDynamicObjectMaterial(parkingcrniautosgen[i], 0, 1223, "dynsigns", "white64", 0xFF000000);
		SetDynamicObjectMaterial(parkingcrniautosgen[i], 1, 1223, "dynsigns", "white64", 0xFF000000);
		SetDynamicObjectMaterial(parkingcrniautosgen[i], 2, 1223, "dynsigns", "white64", 0xFF000000);
	}

	lawless_CDE(19373, 2064.00562, -1920.05493, 12.51100,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(19373, 2063.79175, -1876.72546, 12.51100,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 2063.77954, -1878.37390, 13.00090,   0.00000, 0.00000, 84.65990, 300.0, 300.0);
	lawless_CDE(19373, 2063.79175, -1879.92444, 12.51100,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(19373, 2064.00562, -1916.87109, 12.51100,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 2063.91553, -1918.36426, 13.00090,   0.00000, 0.00000, 84.65990, 300.0, 300.0);
	lawless_CDE(2164, 2052.03394, -1877.94666, 11.69330,   0.00000, 0.00000, 225.00000, 300.0, 300.0);
	lawless_CDE(2164, 2043.69324, -1878.61353, 11.69330,   0.00000, 0.00000, -225.00000, 300.0, 300.0);
	lawless_CDE(1714, 2045.89478, -1878.05347, 12.57510,   0.00000, 0.00000, 15.54000, 300.0, 300.0);
	lawless_CDE(1714, 2049.27026, -1878.14294, 12.57510,   0.00000, 0.00000, -21.66000, 300.0, 300.0);
	lawless_CDE(2167, 2044.97742, -1875.42773, 12.55470,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2167, 2049.03271, -1875.42773, 12.55470,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2202, 2046.34167, -1875.97107, 12.57430,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2254, 2046.97974, -1875.44348, 14.80751,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1808, 2047.52112, -1898.77832, 12.56070,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(1726, 2038.17017, -1896.98242, 12.55230,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(1726, 2038.17017, -1901.88208, 12.55230,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(1823, 2038.76758, -1898.93469, 12.55170,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(2813, 2038.28210, -1898.46570, 13.03620,   0.00000, 0.00000, -40.98000, 300.0, 300.0);
	lawless_CDE(2257, 2037.55688, -1898.53662, 15.95930,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(782, 2069.87622, -1884.14880, 12.69106,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(782, 2069.85278, -1912.05396, 12.69106,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(880, 2067.67871, -1904.74365, 11.15984,   0.00000, 0.00000, -63.96000, 300.0, 300.0);
	lawless_CDE(880, 2067.68823, -1889.19031, 11.15984,   0.00000, 0.00000, -63.96000, 300.0, 300.0);
	lawless_CDE(880, 2067.59692, -1915.72009, 11.15984,   0.00000, 0.00000, -63.96000, 300.0, 300.0);
	lawless_CDE(880, 2067.58276, -1876.69678, 11.15984,   0.00000, 0.00000, -63.96000, 300.0, 300.0);
	lawless_CDE(948, 2037.95959, -1893.82483, 12.55400,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(948, 2037.85120, -1903.33899, 12.55400,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(19172, 2046.98145, -1921.75537, 14.96660,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	lawless_CDE(18075, 2047.60986, -1913.64209, 19.21390,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(18075, 2047.60327, -1900.50549, 19.21390,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(18075, 2047.65991, -1888.35010, 19.21387,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(19893, 2045.93726, -1879.26184, 13.52410,   0.00000, 0.00000, 180.00000, 300.0, 300.0);
	lawless_CDE(19893, 2049.02051, -1879.27722, 13.52410,   0.00000, 0.00000, 180.00000, 300.0, 300.0);

	new axakosacrta = CreateObject(19353, 1010.9450, -1336.4252, 17.0228, 0.0000, 0.0000, 90.0460);
	SetObjectMaterialText(axakosacrta, "{e50446}/", 0, 140, "Arial", 130, 1, -1, 0, 1);
	new axaAA = CreateObject(19353, 1011.2192, -1336.4250, 16.3428, 0.0000, 0.0000, 90.0817);
	SetObjectMaterialText(axaAA, "AXA", 0, 100, "Arial", 80, 1, -1, 0, 1);
	new axaosiguranje = CreateObject(19353, 1008.7973, -1336.4276, 16.3428, 0.0000, 0.0000, 89.9750);
	SetObjectMaterialText(axaosiguranje, "OSIGURANJE", 0, 140, "Arial", 70, 0, -1, 0, 1);
	new axaustan = CreateObject(19353, 1009.7947, -1336.4382, 15.1428, 0.0000, 0.0000, 90.0755);
	SetObjectMaterialText(axaustan, "UNAPRADJUJEMO {e50446}/ {FFFFFF}STANDARDE", 0, 140, "Arial", 37, 1, -1, 0, 1);
	new axacrvcrt = CreateObject(19087, 1010.95477, -1336.35303, 15.81290,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(axacrvcrt, 0, 1231, "dynsigns", "white64", 0xFFe50446);

	new axazgrada[8];
	axazgrada[0] = lawless_CDE(19377, 1007.05408, -1336.93201, 13.95446,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	axazgrada[1] = lawless_CDE(19377, 997.44531, -1336.93201, 13.95450,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	axazgrada[2] = lawless_CDE(19377, 1011.78302, -1341.66101, 13.95450,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axazgrada[3] = lawless_CDE(19377, 1007.05408, -1346.40527, 13.95450,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	axazgrada[4] = lawless_CDE(19377, 997.44531, -1346.40527, 13.95450,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	axazgrada[5] = lawless_CDE(19377, 992.70288, -1341.66101, 13.95450,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axazgrada[6] = lawless_CDE(19377, 1006.61353, -1341.66248, 19.12860,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axazgrada[7] = lawless_CDE(19377, 997.87079, -1341.66248, 19.12860,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(axazgrada); i++)
	{
		SetDynamicObjectMaterial(axazgrada[i], 0, 8399, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);
	}

	new axastaklovrata = lawless_CDE(19454, 1001.40424, -1336.87585, 14.09540,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(axastaklovrata, 0, 3979, "civic01_lan", "sl_laglasswall2", 0xFF333333);
	new axasivavrata[4];
	axasivavrata[0] = lawless_CDE(19435, 999.73328, -1337.56055, 13.23040,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axasivavrata[1] = lawless_CDE(19435, 1002.99469, -1337.56055, 13.23040,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axasivavrata[2] = lawless_CDE(19435, 1000.60889, -1338.50696, 14.89150,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	axasivavrata[3] = lawless_CDE(19435, 1002.20679, -1338.50696, 14.89150,   0.00000, 90.00000, 90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(axasivavrata); i++)
	{
		SetDynamicObjectMaterial(axasivavrata[i], 0, 1231, "dynsigns", "white64", 0xFF1b1b1b);
	}

	new axacrtavrata = lawless_CDE(19089, 1001.33337, -1336.77844, 14.93220,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(axacrtavrata, 0, 1231, "dynsigns", "white64", 0xFF000000);
	new axabojavrata1 = lawless_CDE(19435, 1000.53528, -1336.86572, 13.23040,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	new axabojavrata2 = lawless_CDE(19435, 1002.12408, -1336.86572, 13.23040,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(axabojavrata1, 0, 2361, "lsmall_shops", "lsmall_window01", 0xFF29458e);
	SetDynamicObjectMaterial(axabojavrata2, 0, 2361, "lsmall_shops", "lsmall_window01", 0xFF29458e);
	new axakockalogo = lawless_CDE(18763, 1009.82104, -1337.85352, 15.83153,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(axakockalogo, 0, 1231, "dynsigns", "white64", 0xFF29458e);
	new axastaklo[3];
	axastaklo[0] = lawless_CDE(19435, 1003.21252, -1336.90649, 17.50000,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	axastaklo[1] = lawless_CDE(19435, 999.71851, -1336.90649, 17.50003,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	axastaklo[2] = lawless_CDE(19454, 1002.27472, -1346.45679, 15.46820,   0.00000, 0.00000, 90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(axastaklo); i++)
	{
		SetDynamicObjectMaterial(axastaklo[i], 0, 3979, "civic01_lan", "sl_laglasswall2", 0xFF333333);
	}

	new axaivicacrte[7];
	axaivicacrte[0] = lawless_CDE(19353, 993.98920, -1338.02539, 15.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axaivicacrte[1] = lawless_CDE(19353, 993.98920, -1338.02539, 16.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axaivicacrte[2] = lawless_CDE(19353, 993.98920, -1338.02539, 17.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axaivicacrte[3] = lawless_CDE(19353, 993.98920, -1338.02539, 18.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axaivicacrte[4] = lawless_CDE(19353, 993.98920, -1338.02539, 14.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axaivicacrte[5] = lawless_CDE(19353, 993.98920, -1338.02539, 13.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axaivicacrte[6] = lawless_CDE(19353, 993.98920, -1338.02539, 12.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(axaivicacrte); i++)
	{
		SetDynamicObjectMaterial(axaivicacrte[i], 0, 1231, "dynsigns", "white64", 0xFF29458e);
	}

	new axakonopac[11];
	axakonopac[0] = lawless_CDE(19087, 995.19873, -1336.41626, 18.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axakonopac[1] = lawless_CDE(19087, 995.19873, -1336.41626, 17.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axakonopac[2] = lawless_CDE(19087, 995.19873, -1336.41626, 16.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axakonopac[3] = lawless_CDE(19087, 995.19873, -1336.41626, 15.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axakonopac[4] = lawless_CDE(19087, 995.19873, -1336.41626, 14.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axakonopac[5] = lawless_CDE(19087, 995.19873, -1336.41626, 13.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axakonopac[6] = lawless_CDE(19087, 995.19873, -1336.41626, 12.94910,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	axakonopac[7] = lawless_CDE(19089, 1006.77417, -1336.84924, 15.84830,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axakonopac[8] = lawless_CDE(19089, 996.19360, -1336.84924, 15.84830,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axakonopac[9] = lawless_CDE(19454, 1007.04639, -1336.93054, 11.78330,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	axakonopac[10] = lawless_CDE(19454, 997.43500, -1336.93054, 11.78330,   0.00000, 0.00000, 90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(axakonopac); i++)
	{
		SetDynamicObjectMaterial(axakonopac[i], 0, 1231, "dynsigns", "white64", 0xFF333333);
	}

	new axaprilaz = lawless_CDE(19454, 1001.40417, -1335.07544, 12.31570,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(axaprilaz, 0, 4570, "stolenbuild03", "sl_blokpave2", 0xFFFFFFFF);
	new axatrava1 = lawless_CDE(19454, 1007.04291, -1335.09546, 12.29570,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	new axatrava2 = lawless_CDE(19454, 997.45648, -1335.09546, 12.29570,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(axatrava1, 0, 5708, "hospital_lawn", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(axatrava2, 0, 5708, "hospital_lawn", "Grass_128HV", 0xFFFFFFFF);
	new axabelo[8];
	axabelo[0] = lawless_CDE(19454, 1006.21692, -1338.10681, 10.73210,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axabelo[1] = lawless_CDE(19454, 1011.77582, -1338.10681, 10.73210,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axabelo[2] = lawless_CDE(19454, 996.57208, -1338.10681, 10.73210,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axabelo[3] = lawless_CDE(19454, 992.71619, -1338.10681, 10.73210,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	axabelo[4] = lawless_CDE(19435, 994.38263, -1333.37659, 11.68130,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	axabelo[5] = lawless_CDE(19435, 994.90680, -1333.37659, 11.68130,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	axabelo[6] = lawless_CDE(19435, 1010.10870, -1333.37659, 11.68130,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	axabelo[7] = lawless_CDE(19435, 1007.88062, -1333.37659, 11.68130,   90.00000, 0.00000, 90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(axabelo); i++)
	{
		SetDynamicObjectMaterial(axabelo[i], 0, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	}

	new axaograda1 = lawless_CDE(18981, 1020.53754, -1341.90247, 1.04072,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	new axaograda2 = lawless_CDE(18981, 998.09827, -1340.99658, 1.04072,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(axaograda1, 0, 13725, "gravblok01_lahills", "concpanel_la", 0xFFFFFFFF);
	SetDynamicObjectMaterial(axaograda2, 0, 13725, "gravblok01_lahills", "concpanel_la", 0xFFFFFFFF);
	new prvacrtalogakodvrata = CreateObject(19353, 1506.1068, -1464.7500, 18.0668, 0.0000, 0.0000, 89.9950);
	SetObjectMaterialText(prvacrtalogakodvrata, "~", 0, 140, "Arial", 250, 1, -1, 0, 1);
	new prvacrtalogakodvrata1 = CreateObject(19353, 1506.10681, -1464.75000, 17.59670,   0.00000, 0.00000, 89.99500);
	SetObjectMaterialText(prvacrtalogakodvrata1, "~", 0, 140, "Arial", 250, 1, -1, 0, 1);
	new drugacrtalogakodvrata = CreateObject(19353, 1475.67834, -1463.63086, 33.52340,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(drugacrtalogakodvrata, "{5d1d6b}~", 0, 100, "Arial", 220, 1, -1, 0, 1);
	new drugacrtalogakodvrata1 = CreateObject(19353, 1475.67834, -1463.63086, 32.67818,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(drugacrtalogakodvrata1, "{5d1d6b}~", 0, 100, "Arial", 220, 1, -1, 0, 1);
	new drugacrtalogakodvrata2 = CreateObject(19353, 1536.93958, -1463.63086, 32.67820,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(drugacrtalogakodvrata2, "{5d1d6b}~", 0, 100, "Arial", 220, 1, -1, 0, 1);
	new drugacrtalogakodvrata3 = CreateObject(19353, 1536.93958, -1463.63086, 33.52340,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(drugacrtalogakodvrata3, "{5d1d6b}~", 0, 100, "Arial", 220, 1, -1, 0, 1);
	new lkomerc = CreateObject(4238, 1516.29944, -1463.73450, 26.56120,   0.00000, 0.00000, -149.75999);
	new lijalna = CreateObject(4238, 1496.63123, -1463.73450, 26.56120,   0.00000, 0.00000, -149.75999);
	new lbanka = CreateObject(4238, 1505.97266, -1463.71912, 24.29671,   0.00000, 0.00000, -149.75999);
	SetObjectMaterialText(lkomerc, "{FFFFFF}KOMERC", 0, 90, "Arial", 68, 1, -16777216, 0, 1);
	SetObjectMaterialText(lijalna, "{FFFFFF}IJALNA", 0, 90, "Arial", 68, 1, -16777216, 0, 1);
	SetObjectMaterialText(lbanka, "{FFFFFF}BANKA", 0, 90, "Arial", 60, 1, -16777216, 0, 1);

	new komlevuzgr = lawless_CDE(6099, 1506.32520, -1478.73889, 29.28990,   0.00000, 0.00000, 90.00000, 600.0, 600.0);

	SetDynamicObjectMaterial(komlevuzgr, 0, 3979, "civic01_lan", "sl_laglasswall2", 0xFF333333);
	SetDynamicObjectMaterial(komlevuzgr, 1,  8399, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevuzgr, 2,  8399, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevuzgr, 3,  8399, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevuzgr, 4,  8399, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevuzgr, 5,  8399, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevuzgr, 6,  9906, "sfe_builda", "ws_carpark2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevuzgr, 7,  8399, "vgs_shops", "vgsclubwall05_128", 0xFFFFFFFF);

	new komlevuprilaz[3];
	komlevuprilaz[0] = lawless_CDE(18981, 1535.14673, -1458.35986, 12.05680,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuprilaz[1] = lawless_CDE(18981, 1510.14954, -1458.35986, 12.05680,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuprilaz[2] = lawless_CDE(18981, 1485.15845, -1458.35986, 12.05680,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(komlevuprilaz); i++)
	{
		SetDynamicObjectMaterial(komlevuprilaz[i], 0, 13014, "sw_block04", "concpanel_la", 0xFFFFFFFF);
	}

	new komlevutrava[37];
	komlevutrava[0] = lawless_CDE(19377, 1470.03552, -1451.13916, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[1] = lawless_CDE(19377, 1483.89368, -1450.97925, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[2] = lawless_CDE(19377, 1476.84021, -1450.97925, 12.49510,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[3] = lawless_CDE(19377, 1528.70154, -1450.97925, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[4] = lawless_CDE(19377, 1539.18555, -1450.97925, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[5] = lawless_CDE(19377, 1549.64563, -1451.13928, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[6] = lawless_CDE(19377, 1549.64563, -1460.75598, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[7] = lawless_CDE(19377, 1549.64563, -1470.38489, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[8] = lawless_CDE(19377, 1549.64563, -1480.01501, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[9] = lawless_CDE(19377, 1549.64563, -1489.64709, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[10] = lawless_CDE(19377, 1549.64563, -1499.24524, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[11] = lawless_CDE(19377, 1470.03552, -1460.75598, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[12] = lawless_CDE(19377, 1470.03552, -1470.38489, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[13] = lawless_CDE(19377, 1470.03552, -1480.01501, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[14] = lawless_CDE(19377, 1470.03552, -1499.24524, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[15] = lawless_CDE(19377, 1470.03552, -1489.64709, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[16] = lawless_CDE(19377, 1480.53137, -1470.38489, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[17] = lawless_CDE(19377, 1480.53137, -1480.01501, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[18] = lawless_CDE(19377, 1480.53137, -1489.64709, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[19] = lawless_CDE(19377, 1480.53137, -1499.24524, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[20] = lawless_CDE(19377, 1491.01770, -1489.64709, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[21] = lawless_CDE(19377, 1491.01770, -1499.24524, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[22] = lawless_CDE(19377, 1501.49023, -1489.64709, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[23] = lawless_CDE(19377, 1501.49023, -1499.24524, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[24] = lawless_CDE(19377, 1511.97791, -1489.64709, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[25] = lawless_CDE(19377, 1511.97791, -1499.24524, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[26] = lawless_CDE(19377, 1539.16406, -1470.38489, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[27] = lawless_CDE(19377, 1528.72485, -1470.38489, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[28] = lawless_CDE(19377, 1539.16406, -1480.01501, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[29] = lawless_CDE(19377, 1528.72485, -1480.01501, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[30] = lawless_CDE(19377, 1539.16406, -1489.64709, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[31] = lawless_CDE(19377, 1528.72485, -1489.64709, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[32] = lawless_CDE(19377, 1539.16406, -1499.24524, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[33] = lawless_CDE(19377, 1528.72485, -1499.24524, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[34] = lawless_CDE(19377, 1520.85364, -1499.23767, 12.49500,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[35] = lawless_CDE(19377, 1520.85364, -1489.68640, 12.49500,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevutrava[36] = lawless_CDE(19454, 1505.54810, -1454.97449, 12.49540,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(komlevutrava); i++)
	{
		SetDynamicObjectMaterial(komlevutrava[i], 0, 5708, "hospital_lawn", "Grass_128HV", 0xFFFFFFFF);
	}

	new komlevumermer[38];
	komlevumermer[0] = lawless_CDE(18766, 1539.69092, -1446.33948, 11.18870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[1] = lawless_CDE(18981, 1477.00159, -1446.33972, 0.31340,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[2] = lawless_CDE(18981, 1464.99976, -1458.33899, 1.16250,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[3] = lawless_CDE(18981, 1464.99976, -1483.33801, 1.16250,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[4] = lawless_CDE(18981, 1465.00427, -1491.70300, 1.16250,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[5] = lawless_CDE(18766, 1489.00281, -1450.84204, 10.31380,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[6] = lawless_CDE(18766, 1484.49976, -1455.34375, 10.31380,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[7] = lawless_CDE(18766, 1480.07654, -1455.34485, 10.31350,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[8] = lawless_CDE(18766, 1475.56262, -1460.83569, 10.31350,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[9] = lawless_CDE(18981, 1477.00598, -1503.71973, 1.16250,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[10] = lawless_CDE(18981, 1501.99084, -1503.71973, 1.16250,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[11] = lawless_CDE(18981, 1535.89807, -1446.33972, 0.31340,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[12] = lawless_CDE(18766, 1523.89783, -1450.83984, 10.31380,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[13] = lawless_CDE(18766, 1528.40283, -1455.34375, 10.31380,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[14] = lawless_CDE(18766, 1538.40015, -1455.34375, 10.31380,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[15] = lawless_CDE(18980, 1543.89795, -1455.34375, 0.31340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[16] = lawless_CDE(18766, 1543.90002, -1460.83887, 10.31380,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[17] = lawless_CDE(18766, 1539.40198, -1465.41895, 10.31380,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[18] = lawless_CDE(18766, 1529.40674, -1465.41895, 10.31380,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[19] = lawless_CDE(18766, 1549.96997, -1446.34070, 10.31380,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[20] = lawless_CDE(18981, 1554.47278, -1458.33899, 1.16250,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[21] = lawless_CDE(18981, 1554.47278, -1483.31152, 1.16250,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[22] = lawless_CDE(18981, 1554.47241, -1491.58716, 1.16210,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[23] = lawless_CDE(18981, 1542.46985, -1503.71973, 1.16250,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[24] = lawless_CDE(18981, 1520.53601, -1503.71924, 1.16220,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[25] = lawless_CDE(18980, 1489.00500, -1446.33789, 1.16250,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[26] = lawless_CDE(18980, 1523.89636, -1446.33789, 1.16250,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[27] = lawless_CDE(18766, 1504.08313, -1455.01135, 10.25230,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[28] = lawless_CDE(18766, 1507.07800, -1455.01135, 10.25230,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevumermer[29] = lawless_CDE(18766, 1477.33960, -1446.33948, 11.18870,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[30] = lawless_CDE(18980, 1504.08496, -1450.51001, 0.25340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[31] = lawless_CDE(18980, 1505.07996, -1450.51001, 0.25340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[32] = lawless_CDE(18980, 1506.07324, -1450.51001, 0.25340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[33] = lawless_CDE(18980, 1507.07104, -1450.51001, 0.25340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[34] = lawless_CDE(18980, 1504.08496, -1459.51196, 0.25340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[35] = lawless_CDE(18980, 1505.07996, -1459.51196, 0.25340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[36] = lawless_CDE(18980, 1506.07324, -1459.51196, 0.25340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevumermer[37] = lawless_CDE(18980, 1507.07104, -1459.51196, 0.25340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(komlevumermer); i++)
	{
		SetDynamicObjectMaterial(komlevumermer[i], 0, 3922, "bistro", "Marble2", 0);
	}

	new komlevuprovidnastakla[20];
	new komlevuprovidnastakla1[6];
	komlevuprovidnastakla[0] = lawless_CDE(19325, 1485.59998, -1446.30591, 11.58080,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[1] = lawless_CDE(19325, 1468.50781, -1446.30591, 11.58080,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[2] = lawless_CDE(19325, 1475.15002, -1446.30591, 11.58080,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[3] = lawless_CDE(19325, 1527.65344, -1446.30591, 11.58080,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[4] = lawless_CDE(19325, 1534.29407, -1446.30591, 11.58080,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[5] = lawless_CDE(19325, 1551.50732, -1446.30591, 11.58080,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[6] = lawless_CDE(19325, 1544.86475, -1446.30591, 11.58080,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[7] = lawless_CDE(19325, 1488.98364, -1449.74988, 11.04890,   10.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevuprovidnastakla[8] = lawless_CDE(19325, 1523.89465, -1449.73254, 11.04890,   10.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevuprovidnastakla[9] = lawless_CDE(19325, 1537.70081, -1464.02808, 10.93721,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[10] = lawless_CDE(19325, 1533.57898, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[11] = lawless_CDE(19325, 1529.69055, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[12] = lawless_CDE(19325, 1525.56946, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[13] = lawless_CDE(19325, 1522.20142, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[14] = lawless_CDE(19325, 1518.07581, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[15] = lawless_CDE(19325, 1477.34875, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[16] = lawless_CDE(19325, 1481.47205, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[17] = lawless_CDE(19325, 1485.59314, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[18] = lawless_CDE(19325, 1489.71521, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla[19] = lawless_CDE(19325, 1493.83997, -1464.02808, 10.93720,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla1[0] = lawless_CDE(19377, 1528.30457, -1463.83313, 26.37230,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla1[1] = lawless_CDE(19377, 1517.83374, -1463.83313, 26.37230,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla1[2] = lawless_CDE(19377, 1507.35315, -1463.83313, 26.37230,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla1[3] = lawless_CDE(19377, 1496.87659, -1463.83313, 26.37230,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla1[4] = lawless_CDE(19377, 1486.37366, -1463.83313, 26.37230,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevuprovidnastakla1[5] = lawless_CDE(19377, 1476.74341, -1463.83362, 26.37230,   90.00000, 0.00000, 90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(komlevuprovidnastakla); i++)
	{
		SetDynamicObjectMaterial(komlevuprovidnastakla[i], 0, 2361, "lsmall_shops", "lsmall_window01", 0xFF5d1d6b);
	}

	for(new i = 0; i < sizeof(komlevuprovidnastakla1); i++)
	{
		SetDynamicObjectMaterial(komlevuprovidnastakla1[i], 0, 1231, "dynsigns", "white64", 0xFF5d1d6b);
	}

	new komlevusivistub[16];
	komlevusivistub[0] = lawless_CDE(18981, 1520.84436, -1476.16858, 30.82241,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[1] = lawless_CDE(18981, 1495.86060, -1476.16858, 30.82240,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[2] = lawless_CDE(18981, 1484.98596, -1476.18152, 30.82240,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[3] = lawless_CDE(18980, 1539.40405, -1464.51721, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[4] = lawless_CDE(18980, 1475.71277, -1464.51721, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[5] = lawless_CDE(18980, 1531.39453, -1464.51721, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[6] = lawless_CDE(18980, 1523.80530, -1464.51721, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[7] = lawless_CDE(18980, 1516.20227, -1464.51721, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[8] = lawless_CDE(18980, 1489.35620, -1464.51721, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[9] = lawless_CDE(18980, 1482.31567, -1464.51721, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[10] = lawless_CDE(18980, 1488.55713, -1464.51428, 20.02110,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[11] = lawless_CDE(18980, 1513.53625, -1464.51428, 20.02110,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[12] = lawless_CDE(18980, 1527.40588, -1464.51428, 20.02110,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[13] = lawless_CDE(18980, 1496.34045, -1464.51721, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[14] = lawless_CDE(18980, 1473.87097, -1477.76392, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevusivistub[15] = lawless_CDE(18980, 1539.36377, -1477.15686, 8.70820,   0.00000, 0.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(komlevusivistub); i++)
	{
		SetDynamicObjectMaterial(komlevusivistub[i], 0, 1231, "dynsigns", "white64", 0xFF333333);
	}

	new komlevuzbun1 = lawless_CDE(18766, 1497.11230, -1446.49146, 11.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(komlevuzbun1, 0, 5708, "hospital_lawn", "Grass_128HV", 0xFFFFFFFF);
	new komlevuzbun2 = lawless_CDE(18766, 1514.87292, -1446.49146, 11.04930,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(komlevuzbun2, 0, 5708, "hospital_lawn", "Grass_128HV", 0xFFFFFFFF);

	new komlevuljubicasta[17];
	new komlevuljubicasta1[6];
	komlevuljubicasta[0] = lawless_CDE(18766, 1475.63879, -1464.11292, 38.22880,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[1] = lawless_CDE(18766, 1475.63879, -1464.11292, 28.24350,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[2] = lawless_CDE(18766, 1537.00403, -1464.11292, 38.22880,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[3] = lawless_CDE(18766, 1537.00403, -1464.11292, 28.24350,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[4] = lawless_CDE(19454, 1498.69019, -1469.51306, 14.28760,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[5] = lawless_CDE(19454, 1496.92090, -1469.51306, 12.20617,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[6] = lawless_CDE(19454, 1497.76453, -1469.51306, 13.19281,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[7] = lawless_CDE(19454, 1515.63110, -1469.51306, 12.20620,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[8] = lawless_CDE(19454, 1514.72437, -1469.51306, 13.19280,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[9] = lawless_CDE(19454, 1513.79565, -1469.51306, 14.28760,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta1[0] = lawless_CDE(18766, 1534.68665, -1466.57019, 16.23396,   90.00000, 90.00000, 90.00000, 300.0, 300.0);
	komlevuljubicasta1[1] = lawless_CDE(18766, 1527.45410, -1466.57019, 16.23400,   90.00000, 90.00000, 90.00000, 300.0, 300.0);
	komlevuljubicasta1[2] = lawless_CDE(18766, 1520.83716, -1466.57019, 16.23400,   90.00000, 90.00000, 90.00000, 300.0, 300.0);
	komlevuljubicasta1[3] = lawless_CDE(18766, 1491.81299, -1466.57019, 16.23400,   90.00000, 90.00000, 90.00000, 300.0, 300.0);
	komlevuljubicasta1[4] = lawless_CDE(18766, 1480.49048, -1466.57019, 16.23400,   90.00000, 90.00000, 90.00000, 300.0, 300.0);
	komlevuljubicasta1[5] = lawless_CDE(18766, 1486.52197, -1466.57019, 16.23400,   90.00000, 90.00000, 90.00000, 300.0, 300.0);
	komlevuljubicasta[10] = lawless_CDE(19089, 1539.11401, -1464.08264, 16.23970,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[11] = lawless_CDE(19089, 1531.24463, -1464.08264, 16.23970,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[12] = lawless_CDE(19089, 1523.69421, -1464.08264, 16.23970,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[13] = lawless_CDE(19089, 1496.42212, -1464.08264, 16.23970,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[14] = lawless_CDE(19089, 1489.61926, -1464.08264, 16.23970,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[15] = lawless_CDE(19089, 1482.63672, -1464.08264, 16.23970,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevuljubicasta[16] = lawless_CDE(19089, 1509.76563, -1464.67004, 16.48149,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(komlevuljubicasta); i++)
	{
		SetDynamicObjectMaterial(komlevuljubicasta[i], 0, 1231, "dynsigns", "white64", 0xFF5d1d6b);
	}

	for(new i = 0; i < sizeof(komlevuljubicasta1); i++)
	{
		SetDynamicObjectMaterial(komlevuljubicasta1[i], 0, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	}

	new komlevustakla[12];
	komlevustakla[0] = lawless_CDE(19377, 1534.53186, -1464.20959, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[1] = lawless_CDE(19377, 1524.03748, -1464.20959, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[2] = lawless_CDE(19377, 1480.53052, -1464.20959, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[3] = lawless_CDE(19377, 1491.02332, -1464.20959, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[4] = lawless_CDE(19377, 1521.69604, -1464.21265, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[5] = lawless_CDE(19377, 1489.97571, -1477.75378, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[6] = lawless_CDE(19377, 1539.65588, -1472.36084, 15.32860,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	komlevustakla[7] = lawless_CDE(19377, 1533.98071, -1477.37183, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[8] = lawless_CDE(19377, 1523.49719, -1477.37183, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[10] = lawless_CDE(19377, 1479.48315, -1477.75378, 15.32860,   90.00000, 0.00000, 90.00000, 300.0, 300.0);
	komlevustakla[11] = lawless_CDE(19377, 1473.60791, -1472.38208, 15.32860,   90.00000, 0.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(komlevustakla); i++)
	{
		SetDynamicObjectMaterial(komlevustakla[i], 0, 3979, "civic01_lan", "sl_laglasswall2", 0xFF333333);
	}

	new komlevubelo = lawless_CDE(18981, 1506.05920, -1465.19983, 7.87054,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(komlevubelo, 0, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	new komlevuvrata = lawless_CDE(19454, 1506.08313, -1464.74683, 14.28760,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	SetDynamicObjectMaterial(komlevuvrata, 0, 17533, "eastbeach7_lae2", "shopwindowlow2_256", 0);

	new komlevukonopac[15];
	komlevukonopac[0] = lawless_CDE(19089, 1539.11401, -1464.04272, 14.25090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[1] = lawless_CDE(19089, 1531.24463, -1464.04272, 14.25090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[2] = lawless_CDE(19089, 1523.69421, -1464.04272, 14.25090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[3] = lawless_CDE(19089, 1482.63672, -1464.04272, 14.25090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[4] = lawless_CDE(19089, 1489.61926, -1464.04272, 14.25090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[5] = lawless_CDE(19089, 1496.42212, -1464.04272, 14.25090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[6] = lawless_CDE(19089, 1472.65442, -1446.30774, 13.63090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[7] = lawless_CDE(19089, 1488.98352, -1446.30774, 13.63090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[8] = lawless_CDE(19089, 1531.39722, -1446.30774, 13.63090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[9] = lawless_CDE(19089, 1538.76184, -1446.30774, 13.63090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[10] = lawless_CDE(19089, 1554.53125, -1446.30774, 13.63090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[11] = lawless_CDE(19089, 1547.31262, -1446.30774, 13.63090,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	komlevukonopac[12] = lawless_CDE(19089, 1488.98853, -1446.82263, 13.64230,   0.00000, -80.00000, -90.00000, 300.0, 300.0);
	komlevukonopac[13] = lawless_CDE(19089, 1523.89392, -1446.82263, 13.64230,   0.00000, -80.00000, -90.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(komlevukonopac); i++)
	{
		SetDynamicObjectMaterial(komlevukonopac[i], 0, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	}

	new komlevukrug1 = lawless_CDE(2189, 1506.14075, -1464.66882, 17.73698,   0.00000, 90.00000, 90.00000, 500.0, 500.0);
	SetDynamicObjectMaterial(komlevukrug1, 0, 1231, "dynsigns", "white64", 0xFF5d1d6b);
	SetDynamicObjectMaterial(komlevukrug1, 1, 1231, "dynsigns", "white64", 0xFF5d1d6b);
	new komlevukrug2 = lawless_CDE(3430, 1475.66260, -1465.22607, 33.16160,   0.00000, 90.00000, 90.00000, 500.0, 500.0);
	SetDynamicObjectMaterial(komlevukrug2, 0, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevukrug2, 1, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevukrug2, 2, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevukrug2, 3, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	new komlevukrug3 = lawless_CDE(3430, 1536.93640, -1465.22607, 33.16160,   0.00000, 90.00000, 90.00000, 500.0, 500.0);
	SetDynamicObjectMaterial(komlevukrug3, 0, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevukrug3, 1, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevukrug3, 2, 1231, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(komlevukrug3, 3, 1231, "dynsigns", "white64", 0xFFFFFFFF);

	lawless_CDE(808, 1505.42249, -1455.31799, 14.35010,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(14469, 1479.22986, -1450.83618, 13.14480,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(14469, 1530.09290, -1450.83362, 13.14480,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(8991, 1469.42371, -1462.81750, 13.25470,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(717, 1469.06335, -1450.94470, 12.38323,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(717, 1549.18164, -1450.78711, 12.38323,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(837, 1539.38757, -1450.73572, 12.68102,   0.00000, 0.00000, 27.36000, 300.0, 300.0);
	lawless_CDE(8991, 1469.75220, -1476.99365, 13.25470,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(8991, 1469.79834, -1491.11621, 13.25470,   0.00000, 0.00000, 88.32000, 300.0, 300.0);
	lawless_CDE(8991, 1476.85144, -1498.15479, 13.25470,   0.00000, 0.00000, -1.14000, 300.0, 300.0);
	lawless_CDE(8991, 1490.30237, -1498.51343, 13.25470,   0.00000, 0.00000, -1.14000, 300.0, 300.0);
	lawless_CDE(8991, 1503.51904, -1498.87805, 13.25470,   0.00000, 0.00000, -1.14000, 300.0, 300.0);
	lawless_CDE(8991, 1516.93640, -1499.17407, 13.25470,   0.00000, 0.00000, -1.14000, 300.0, 300.0);
	lawless_CDE(8991, 1530.21606, -1499.41406, 13.25470,   0.00000, 0.00000, -1.14000, 300.0, 300.0);
	lawless_CDE(8991, 1543.61377, -1499.65234, 13.25470,   0.00000, 0.00000, -1.14000, 300.0, 300.0);
	lawless_CDE(8991, 1550.00647, -1490.78882, 13.25470,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(8991, 1549.70532, -1475.61243, 13.25470,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	lawless_CDE(8991, 1549.56360, -1461.39197, 13.25470,   0.00000, 0.00000, 90.00000, 300.0, 300.0);

	/*				MAP - KOMERCIJALNA - AXA - AUTO SALON - END				  */

	/* 						MAP - BANKA DIAMOND 							  */
	
	lawless_CDE(4563, 1095.50330, -1718.77966, -162.39362,   0.00000, 0.00000, 40.92001, 300.0, 300.0);
	lawless_CDE(4563, 1147.93811, -1670.23035, -162.49052,   0.00000, 0.00000, -229.25998, 300.0, 300.0);
	lawless_CDE(4563, 1062.65991, -1680.88757, -162.41144,   0.00000, 0.00000, 40.92001, 300.0, 300.0);
	lawless_CDE(4563, 1043.41687, -1658.87488, -162.43857,   0.00000, 0.00000, 40.92001, 300.0, 300.0);
	lawless_CDE(4563, 1116.10181, -1633.28674, -162.54907,   0.00000, 0.00000, -229.25998, 300.0, 300.0);
	lawless_CDE(4563, 1084.02600, -1596.06604, -162.39584,   0.00000, 0.00000, -229.25998, 300.0, 300.0);
	lawless_CDE(4563, 1129.75696, -1608.40698, -162.40855,   0.00000, 0.00000, -229.25998, 300.0, 300.0);
	lawless_CDE(9901, 1078.25037, -1609.45740, 12.59793,   0.00000, 0.00000, 89.81998, 300.0, 300.0);
	lawless_CDE(9949, 1069.65430, -1637.06750, 23.58170,   0.00000, 0.00000, 179.27998, 300.0, 300.0);
	lawless_CDE(9901, 1077.72644, -1636.82849, 12.59793,   0.00000, 0.00000, 89.81998, 300.0, 300.0);
	lawless_CDE(10024, 1090.63281, -1644.30286, 14.15761,   0.00000, 0.00000, -90.72001, 300.0, 300.0);
	lawless_CDE(10023, 1090.58289, -1644.29077, 19.60886,   0.00000, 0.00000, -90.72001, 300.0, 300.0);
	lawless_CDE(9901, 1106.11902, -1622.96741, 12.59793,   0.00000, 0.00000, 89.81998, 300.0, 300.0);
	lawless_CDE(615, 1052.61084, -1590.91003, 11.45967,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(615, 1052.25354, -1697.68579, 11.45967,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1136.02649, -1654.56714, 11.70036,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1136.24219, -1633.34363, 11.70036,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(750, 1135.54077, -1649.92700, 11.98471,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(750, 1135.46069, -1638.91711, 11.98471,   0.00000, 0.00000, 45.90001, 300.0, 300.0);
	lawless_CDE(758, 1105.94629, -1652.26660, 11.96184,   0.00000, 0.00000, 7.44000, 300.0, 300.0);
	lawless_CDE(758, 1106.02869, -1636.37329, 11.96184,   0.00000, 0.00000, -32.04000, 300.0, 300.0);
	lawless_CDE(1568, 1140.84619, -1675.74475, 12.89800,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1568, 1140.97339, -1665.41272, 12.89800,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1568, 1141.22693, -1618.12427, 12.89800,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(3515, 1123.55945, -1675.98279, 12.73775,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(3515, 1121.65173, -1611.19470, 12.73775,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(3532, 1137.54517, -1655.37195, 12.19867,   0.00000, 0.00000, 4.02000, 300.0, 300.0);
	lawless_CDE(3532, 1137.44153, -1649.76099, 12.19867,   0.00000, 0.00000, 4.02000, 300.0, 300.0);
	lawless_CDE(3532, 1137.42786, -1643.78186, 12.19867,   0.00000, 0.00000, 4.02000, 300.0, 300.0);
	lawless_CDE(3532, 1137.62024, -1638.06409, 12.19867,   0.00000, 0.00000, 4.02000, 300.0, 300.0);
	lawless_CDE(3532, 1137.51880, -1631.58398, 12.19867,   0.00000, 0.00000, 4.02000, 300.0, 300.0);
	lawless_CDE(3532, 1133.77295, -1634.80493, 12.19867,   0.00000, 0.00000, -26.70000, 300.0, 300.0);
	lawless_CDE(3532, 1131.59937, -1640.06494, 12.19867,   0.00000, 0.00000, -17.57999, 300.0, 300.0);
	lawless_CDE(3532, 1130.79944, -1645.69678, 12.19867,   0.00000, 0.00000, 6.60001, 300.0, 300.0);
	lawless_CDE(3532, 1132.25684, -1651.41821, 12.19867,   0.00000, 0.00000, 30.48001, 300.0, 300.0);
	lawless_CDE(3532, 1135.68457, -1655.95532, 12.19867,   0.00000, 0.00000, 44.94001, 300.0, 300.0);
	lawless_CDE(3532, 1133.40125, -1644.33447, 12.19867,   0.00000, 0.00000, 1.74001, 300.0, 300.0);
	lawless_CDE(9833, 1103.96973, -1662.88855, 12.00340,   0.00000, 20.00000, 73.49999, 300.0, 300.0);
	lawless_CDE(9833, 1104.15222, -1656.93384, 12.00340,   0.00000, 20.00000, 269.03979, 300.0, 300.0);
	lawless_CDE(9833, 1104.04102, -1632.25342, 12.00340,   0.00000, 20.00000, 75.35999, 300.0, 300.0);
	lawless_CDE(9833, 1103.67578, -1625.94446, 12.00340,   0.00000, 20.00000, 287.28003, 300.0, 300.0);
	lawless_CDE(673, 1105.78101, -1667.77441, 11.70036,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1105.90027, -1621.05566, 11.70036,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(19943, 1098.36328, -1677.82788, 9.54769,   0.00000, 0.00000, 47.94000, 300.0, 300.0);
	lawless_CDE(19943, 1098.40674, -1672.64783, 9.54769,   0.00000, 0.00000, 46.98000, 300.0, 300.0);
	lawless_CDE(19943, 1099.10681, -1616.08093, 9.54769,   0.00000, 0.00000, 46.26000, 300.0, 300.0);
	lawless_CDE(19943, 1099.14392, -1610.79626, 9.54769,   0.00000, 0.00000, 46.26000, 300.0, 300.0);
	lawless_CDE(14387, 1095.32800, -1700.26025, 12.44158,   0.00000, 0.00000, 89.52000, 300.0, 300.0);
	lawless_CDE(14387, 1090.63147, -1700.23193, 12.44158,   0.00000, 0.00000, 89.52000, 300.0, 300.0);
	lawless_CDE(14387, 1091.59021, -1590.25977, 12.44158,   0.00000, 0.00000, -90.11998, 300.0, 300.0);
	lawless_CDE(14387, 1096.26208, -1590.27454, 12.44158,   0.00000, 0.00000, -90.11998, 300.0, 300.0);
	lawless_CDE(3532, 1106.51978, -1628.83606, 12.19867,   0.00000, 0.00000, 4.02000, 300.0, 300.0);
	lawless_CDE(3532, 1106.62634, -1659.67114, 12.19867,   0.00000, 0.00000, 4.02000, 300.0, 300.0);
	lawless_CDE(673, 1055.79504, -1695.82117, 2.37162,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1074.50952, -1699.03186, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1072.14783, -1697.70813, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1050.79492, -1680.17969, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1050.72351, -1677.28931, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1050.16382, -1645.30383, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1051.34802, -1613.51868, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1054.57324, -1592.59302, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1058.86548, -1590.57031, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1076.01880, -1594.61023, 1.83875,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(700, 1049.48315, -1611.84534, 12.32119,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(700, 1049.94434, -1642.82068, 12.32119,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(700, 1049.48401, -1674.80884, 12.32119,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(700, 1085.35852, -1698.74341, 12.32119,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(700, 1085.57373, -1591.52185, 12.32119,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 1105.36450, -1621.31726, 12.32663,   0.00000, 0.00000, -6.96000, 300.0, 300.0);
	lawless_CDE(869, 1105.58997, -1667.38843, 12.32663,   0.00000, 0.00000, -6.96000, 300.0, 300.0);
	lawless_CDE(870, 1101.97180, -1667.96680, 12.18623,   0.00000, 0.00000, 33.84000, 300.0, 300.0);
	lawless_CDE(870, 1101.88000, -1621.38403, 12.18623,   0.00000, 0.00000, 33.84000, 300.0, 300.0);
	lawless_CDE(970, 1098.10278, -1692.17932, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1215, 1098.13440, -1694.82397, 12.18423,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(970, 1098.09229, -1687.02075, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(970, 1098.11646, -1697.42371, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1215, 1098.13428, -1689.60486, 12.18423,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(970, 1088.44568, -1686.59851, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1215, 1088.40942, -1694.70898, 12.18423,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(970, 1088.43616, -1692.01807, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(970, 1088.42847, -1697.39343, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1215, 1088.40845, -1689.29248, 12.18423,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(970, 1098.52002, -1593.00354, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(970, 1088.98462, -1593.15808, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1215, 1098.47412, -1595.91443, 12.18423,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(970, 1098.47412, -1598.62756, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1215, 1098.49072, -1601.45776, 12.18423,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(970, 1098.46497, -1604.13110, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1215, 1088.86267, -1595.83887, 12.18423,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(970, 1088.99121, -1598.55994, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1215, 1088.90967, -1601.27979, 12.18423,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(970, 1088.99475, -1603.92078, 12.72375,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	lawless_CDE(1232, 1099.07410, -1587.44617, 15.13066,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1232, 1088.40125, -1587.50232, 15.13066,   0.00000, 0.00000, 63.66000, 300.0, 300.0);
	lawless_CDE(1232, 1098.42798, -1703.02991, 15.13066,   0.00000, 0.00000, 121.38000, 300.0, 300.0);
	lawless_CDE(1232, 1087.57617, -1702.91431, 15.13066,   0.00000, 0.00000, 174.54008, 300.0, 300.0);
	lawless_CDE(1256, 1111.10461, -1646.29871, 12.83310,   0.00000, 0.00000, -180.06000, 300.0, 300.0);
	lawless_CDE(1256, 1111.15808, -1642.22119, 12.83310,   0.00000, 0.00000, -180.06000, 300.0, 300.0);
	lawless_CDE(3471, 1120.67236, -1665.08704, 13.34499,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(3471, 1120.19458, -1620.21594, 13.34499,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(3462, 1110.91455, -1650.18799, 13.61874,   0.00000, 0.00000, -177.35985, 300.0, 300.0);
	lawless_CDE(3462, 1110.85608, -1638.63037, 13.61874,   0.00000, 0.00000, -180.47984, 300.0, 300.0);
	lawless_CDE(3532, 1120.48059, -1613.41724, 12.13377,   0.00000, 0.00000, -19.56000, 300.0, 300.0);
	lawless_CDE(673, 1123.96912, -1610.30188, 0.94135,   0.00000, 0.00000, -55.62000, 300.0, 300.0);
	lawless_CDE(3532, 1121.42114, -1672.60620, 12.13377,   0.00000, 0.00000, 14.52000, 300.0, 300.0);
	lawless_CDE(3532, 1123.29663, -1673.40088, 12.13377,   0.00000, 0.00000, 17.81999, 300.0, 300.0);
	lawless_CDE(673, 1126.80090, -1677.17078, 0.94135,   0.00000, 0.00000, -55.62000, 300.0, 300.0);
	lawless_CDE(758, 1130.07471, -1677.14795, 9.95767,   0.00000, 0.00000, 60.54000, 300.0, 300.0);
	lawless_CDE(716, 1135.62219, -1606.49060, 12.27245,   0.00000, 0.00000, 56.58000, 300.0, 300.0);
	lawless_CDE(716, 1137.07178, -1623.65076, 12.27245,   0.00000, 0.00000, 56.58000, 300.0, 300.0);
	lawless_CDE(716, 1134.91187, -1675.85254, 12.27245,   0.00000, 0.00000, 59.34000, 300.0, 300.0);
	lawless_CDE(716, 1135.87854, -1661.13391, 12.27245,   0.00000, 0.00000, 55.50000, 300.0, 300.0);
	lawless_CDE(3657, 1095.28430, -1636.50574, 12.50993,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	lawless_CDE(3657, 1095.02185, -1652.47681, 12.50993,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	lawless_CDE(2745, 1085.48389, -1608.33679, 13.17648,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2745, 1084.51318, -1680.22717, 13.17648,   0.00000, 0.00000, -180.72002, 300.0, 300.0);
	lawless_CDE(673, 1120.77100, -1678.45142, 11.70036,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1119.57300, -1608.94629, 11.70036,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 1085.31860, -1602.61829, 12.53175,   0.00000, 0.00000, 80.28001, 300.0, 300.0);
	lawless_CDE(869, 1085.13953, -1596.31470, 12.53175,   0.00000, 0.00000, 80.28001, 300.0, 300.0);
	lawless_CDE(869, 1067.43481, -1593.81958, 12.53175,   0.00000, 0.00000, 152.93999, 300.0, 300.0);
	lawless_CDE(869, 1060.26123, -1594.43481, 12.53175,   0.00000, 0.00000, 172.37999, 300.0, 300.0);
	lawless_CDE(869, 1051.20081, -1600.48242, 12.53175,   0.00000, 0.00000, 255.35995, 300.0, 300.0);
	lawless_CDE(869, 1051.02087, -1622.91382, 12.53175,   0.00000, 0.00000, 255.35995, 300.0, 300.0);
	lawless_CDE(869, 1051.07764, -1631.36389, 12.53175,   0.00000, 0.00000, 255.35995, 300.0, 300.0);
	lawless_CDE(869, 1050.69592, -1654.40796, 12.53175,   0.00000, 0.00000, 255.35995, 300.0, 300.0);
	lawless_CDE(869, 1050.88989, -1664.84558, 12.53175,   0.00000, 0.00000, 255.35995, 300.0, 300.0);
	lawless_CDE(869, 1050.79016, -1694.29932, 12.53175,   0.00000, 0.00000, 262.97995, 300.0, 300.0);
	lawless_CDE(869, 1061.42676, -1696.35559, 12.53175,   0.00000, 0.00000, 298.73990, 300.0, 300.0);
	lawless_CDE(869, 1066.39478, -1696.72961, 12.53175,   0.00000, 0.00000, 374.57986, 300.0, 300.0);
	lawless_CDE(869, 1077.83545, -1694.59485, 12.53175,   0.00000, 0.00000, 357.23984, 300.0, 300.0);
	lawless_CDE(869, 1085.42200, -1694.90942, 12.53175,   0.00000, 0.00000, 438.47977, 300.0, 300.0);
	lawless_CDE(869, 1085.41699, -1687.91406, 12.53175,   0.00000, 0.00000, 438.47977, 300.0, 300.0);
	lawless_CDE(638, 1084.99011, -1636.39807, 12.65293,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(638, 1084.57214, -1652.94739, 12.65293,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(625, 1085.49402, -1648.91907, 12.79849,   0.00000, 0.00000, 96.60000, 300.0, 300.0);
	lawless_CDE(625, 1085.75049, -1636.42725, 12.79849,   0.00000, 0.00000, 96.60000, 300.0, 300.0);
	lawless_CDE(1215, 1140.81470, -1692.22534, 12.94442,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1215, 1140.87512, -1680.49768, 12.94442,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1215, 1140.48914, -1602.29883, 12.94442,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1215, 1140.35193, -1592.35010, 12.94442,   0.00000, 0.00000, 0.00000, 300.0, 300.0);

	new opstina1[5];
	opstina1[0] = lawless_CDE(19529, 1025.60278, -1744.65479, 12.09188,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina1[1] = lawless_CDE(19529, 1013.04053, -1684.74292, 12.10497,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina1[2] = lawless_CDE(19529, 995.26025, -1646.21973, 12.14410,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina1[3] = lawless_CDE(19529, 1025.93701, -1544.27527, 12.10497,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina1[4] = lawless_CDE(19529, 1161.65588, -1617.26331, 12.01426,   0.00000, 0.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina1); i++)
	{
		SetDynamicObjectMaterial(opstina1[i], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	}

	new opstina2[2];
	opstina2[0] = lawless_CDE(19529, 1037.15283, -1619.33301, 12.01321,   0.00000, 0.00000, -0.72000, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina2); i++)
	{
		SetDynamicObjectMaterial(opstina2[i], 0, 16639, "a51_labs", "dam_terazzo", 0xFFFFFFFF);
	}

	new opstina3[5];
	opstina3[0] = lawless_CDE(19529, 1161.40613, -1545.11194, 12.03214,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina3[1] = lawless_CDE(19529, 1160.49695, -1742.58264, 12.03214,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina3[2] = lawless_CDE(19377, 1134.34851, -1686.89270, 11.97412,   0.00000, 80.00000, 0.00000, 300.0, 300.0);
	opstina3[3] = lawless_CDE(19377, 1134.36414, -1685.48193, 11.97412,   0.00000, 80.00000, 0.00000, 300.0, 300.0);
	opstina3[4] = lawless_CDE(19377, 1134.17114, -1597.70837, 11.97412,   0.00000, 80.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina3); i++)
	{
		SetDynamicObjectMaterial(opstina3[i], 0,  3975, "lanbloke", "p_floor3", 0xFFFFFFFF);
	}

	new opstina4[13];
	opstina4[0] = lawless_CDE(19464, 1133.12390, -1698.55188, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[1] = lawless_CDE(19464, 1127.35986, -1698.55688, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[2] = lawless_CDE(19464, 1121.77539, -1698.59363, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[3] = lawless_CDE(19464, 1116.06372, -1698.58154, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[4] = lawless_CDE(19464, 1110.39880, -1698.54944, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[5] = lawless_CDE(19464, 1104.76221, -1698.50684, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[6] = lawless_CDE(19464, 1099.10938, -1698.55396, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[7] = lawless_CDE(19464, 1127.40063, -1591.91760, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[8] = lawless_CDE(19464, 1121.81555, -1591.94324, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[9] = lawless_CDE(19464, 1116.19153, -1591.96582, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[10] = lawless_CDE(19464, 1110.60925, -1591.96509, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[11] = lawless_CDE(19464, 1105.02515, -1592.02588, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina4[12] = lawless_CDE(19464, 1099.46082, -1592.04187, 9.60206,   0.00000, 0.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina4); i++)
	{
		SetDynamicObjectMaterial(opstina4[i], 0, 2169, "cj_office", "white32", 0xFFEDEDED);
	}

	new opstina5[26];
	opstina5[0] = lawless_CDE(19325, 1140.29724, -1698.68506, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[1] = lawless_CDE(19325, 1101.61584, -1702.30261, 12.67611,   0.00000, 0.00000, -90.60004, 300.0, 300.0);
	opstina5[2] = lawless_CDE(19325, 1108.20618, -1702.37280, 12.67611,   0.00000, 0.00000, -90.60004, 300.0, 300.0);
	opstina5[3] = lawless_CDE(19325, 1114.83032, -1702.44324, 12.67611,   0.00000, 0.00000, -90.60004, 300.0, 300.0);
	opstina5[4] = lawless_CDE(19325, 1121.40308, -1702.49304, 12.67611,   0.00000, 0.00000, -90.60004, 300.0, 300.0);
	opstina5[5] = lawless_CDE(19325, 1127.99792, -1702.52368, 12.67611,   0.00000, 0.00000, -89.94004, 300.0, 300.0);
	opstina5[6] = lawless_CDE(19325, 1134.45886, -1702.51331, 12.67611,   0.00000, 0.00000, -89.94004, 300.0, 300.0);
	opstina5[7] = lawless_CDE(19325, 1136.87195, -1702.48999, 12.67611,   0.00000, 0.00000, -89.94004, 300.0, 300.0);
	opstina5[8] = lawless_CDE(19325, 1140.29285, -1695.39587, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[9] = lawless_CDE(19325, 1140.07544, -1661.92932, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[10] = lawless_CDE(19325, 1140.08276, -1655.34863, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[11] = lawless_CDE(19325, 1140.07776, -1648.78674, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[12] = lawless_CDE(19325, 1140.06360, -1642.20654, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[13] = lawless_CDE(19325, 1140.08081, -1635.60107, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[14] = lawless_CDE(19325, 1140.07751, -1629.11609, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[15] = lawless_CDE(19325, 1140.05237, -1622.56152, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[16] = lawless_CDE(19325, 1140.04773, -1621.80151, 12.67611,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[17] = lawless_CDE(19325, 1136.24084, -1588.11646, 12.67611,   0.00000, 0.00000, 90.35998, 300.0, 300.0);
	opstina5[18] = lawless_CDE(19358, 1139.87036, -1590.29614, 12.97845,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina5[19] = lawless_CDE(19325, 1129.67163, -1588.15320, 12.67611,   0.00000, 0.00000, 90.35998, 300.0, 300.0);
	opstina5[20] = lawless_CDE(19325, 1123.06421, -1588.18726, 12.67611,   0.00000, 0.00000, 90.35998, 300.0, 300.0);
	opstina5[21] = lawless_CDE(19325, 1116.48254, -1588.23560, 12.67611,   0.00000, 0.00000, 90.77998, 300.0, 300.0);
	opstina5[22] = lawless_CDE(19325, 1109.91943, -1588.32202, 12.67611,   0.00000, 0.00000, 90.77998, 300.0, 300.0);
	opstina5[23] = lawless_CDE(19325, 1103.39954, -1588.39661, 12.67611,   0.00000, 0.00000, 90.77998, 300.0, 300.0);
	opstina5[24] = lawless_CDE(19325, 1101.81934, -1588.41418, 12.67611,   0.00000, 0.00000, 90.77998, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina5); i++)
	{
		SetDynamicObjectMaterial(opstina5[i], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	}

	new opstina6[14];
	opstina6[0] = lawless_CDE(19377, 1093.17603, -1696.92834, 11.97830,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[1] = lawless_CDE(19377, 1093.16675, -1687.30762, 11.97830,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[2] = lawless_CDE(19377, 1103.11096, -1675.28137, 11.97830,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[3] = lawless_CDE(19377, 1113.58887, -1675.27051, 11.97830,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[4] = lawless_CDE(19377, 1113.58533, -1665.65686, 11.97830,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[5] = lawless_CDE(19377, 1113.58215, -1656.12341, 11.93835,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[6] = lawless_CDE(19377, 1113.56592, -1646.47937, 11.93835,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[7] = lawless_CDE(19377, 1113.55017, -1635.21472, 11.93835,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[8] = lawless_CDE(19377, 1113.58435, -1625.64844, 11.93835,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[9] = lawless_CDE(19377, 1113.55701, -1612.99951, 11.96469,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[10] = lawless_CDE(19377, 1113.58105, -1616.02368, 11.95745,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[11] = lawless_CDE(19377, 1104.26404, -1613.08850, 11.96539,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[12] = lawless_CDE(19377, 1093.63550, -1601.20300, 11.97830,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	opstina6[13] = lawless_CDE(19377, 1093.66125, -1591.59802, 11.97830,   0.00000, 90.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina6); i++)
	{
		SetDynamicObjectMaterial(opstina6[i], 0, 13715, "richman02_lahills", "brickred", 0xFFFFFFFF);
	}

	new opstina7[3];
	opstina7[0] = lawless_CDE(11455, 1140.24854, -1678.06250, 15.65041,   0.00000, 0.00000, 89.70001, 300.0, 300.0);
	opstina7[1] = lawless_CDE(11455, 1139.78760, -1604.33203, 15.65041,   0.00000, 0.00000, 89.70001, 300.0, 300.0);
	opstina7[2] = lawless_CDE(11455, 1135.73755, -1644.23730, 14.62993,   0.00000, 0.00000, 89.70001, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina7); i++)
	{
		SetDynamicObjectMaterial(opstina7[i], 0, 2169, "cj_office", "white32", 0xFF585858);
	}

	for(new i = 0; i < sizeof(opstina7); i++)
	{
		SetDynamicObjectMaterial(opstina7[i], 1, 14789, "ab_sfgymmain", "gym_floor6");
	}

	new opstina9[2];
	opstina9[0] = lawless_CDE(8637, 1155.88965, -1661.33655, 12.11180,   0.00000, 0.00000, -22.62000, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina9); i++)
	{
		SetDynamicObjectMaterial(opstina9[i], 0, 4600, "theatrelan2", "gm_labuld2_b", 0xFFFFFFFF);
	}

	for(new i = 0; i < sizeof(opstina9); i++)
	{
		SetDynamicObjectMaterial(opstina9[i], 1, 3975, "lanbloke", "p_floor3", 0xFFFFFFFF);
	}

	new opstina11[4];
	opstina11[0] = lawless_CDE(19377, 1142.46521, -1671.78931, 12.68871,   0.00000, 90.00000, -25.32001, 300.0, 300.0);
	opstina11[1] = lawless_CDE(19377, 1133.08630, -1667.36157, 11.78107,   0.00000, 80.00000, -25.08000, 300.0, 300.0);
	opstina11[2] = lawless_CDE(19377, 1140.91846, -1610.89124, 12.68871,   0.00000, 90.00000, 40.56000, 300.0, 300.0);
	opstina11[3] = lawless_CDE(19377, 1133.07275, -1617.63098, 11.78107,   0.00000, 80.00000, 40.80001, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina11); i++)
	{
		SetDynamicObjectMaterial(opstina11[i], 0, 3975, "lanbloke", "p_floor3", 0xFFFFFFFF);
	}

	new opstina12[78];
	opstina12[0] = lawless_CDE(18766, 1051.77502, -1583.70789, 10.90854,   0.00000, 0.00000, -21.06000, 300.0, 300.0);
	opstina12[1] = lawless_CDE(18766, 1061.86377, -1587.20496, 10.90347,   0.00000, 0.00000, -16.08000, 300.0, 300.0);
	opstina12[2] = lawless_CDE(18766, 1052.33228, -1584.41528, 10.90347,   0.00000, 0.00000, -15.96000, 300.0, 300.0);
	opstina12[3] = lawless_CDE(18766, 1071.51208, -1588.56921, 10.90347,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[4] = lawless_CDE(18766, 1081.41602, -1588.52014, 10.90347,   0.00000, 0.00000, 0.24000, 300.0, 300.0);
	opstina12[5] = lawless_CDE(18981, 1097.55640, -1588.49756, 0.93565,   0.00000, 0.00000, -89.93998, 300.0, 300.0);
	opstina12[6] = lawless_CDE(18981, 1115.99658, -1588.43640, 0.92236,   0.00000, 0.00000, -89.81999, 300.0, 300.0);
	opstina12[7] = lawless_CDE(18981, 1127.57764, -1588.38708, 0.91876,   0.00000, 0.00000, -89.81999, 300.0, 300.0);
	opstina12[9] = lawless_CDE(18981, 1059.92065, -1701.97766, 0.91876,   0.00000, 0.00000, -89.81999, 300.0, 300.0);
	opstina12[10] = lawless_CDE(18981, 1075.04785, -1701.93591, 0.90729,   0.00000, 0.00000, -89.81999, 300.0, 300.0);
	opstina12[11] = lawless_CDE(18981, 1097.09546, -1702.05432, 0.94941,   0.00000, 0.00000, -90.35999, 300.0, 300.0);
	opstina12[12] = lawless_CDE(18766, 1109.28174, -1702.08899, 10.91029,   0.00000, 0.00000, -179.94003, 300.0, 300.0);
	opstina12[13] = lawless_CDE(18766, 1119.17834, -1702.07849, 10.91029,   0.00000, 0.00000, -179.94003, 300.0, 300.0);
	opstina12[14] = lawless_CDE(18766, 1129.11731, -1702.08398, 10.91029,   0.00000, 0.00000, -179.94003, 300.0, 300.0);
	opstina12[15] = lawless_CDE(18766, 1135.44971, -1702.07959, 10.91029,   0.00000, 0.00000, -179.94003, 300.0, 300.0);
	opstina12[16] = lawless_CDE(18766, 1047.43079, -1605.00330, 10.92335,   0.00000, 0.00000, -89.88001, 300.0, 300.0);
	opstina12[17] = lawless_CDE(18766, 1047.39136, -1595.10449, 10.92335,   0.00000, 0.00000, -89.88001, 300.0, 300.0);
	opstina12[18] = lawless_CDE(18766, 1047.35828, -1586.48743, 10.92335,   0.00000, 0.00000, -89.88001, 300.0, 300.0);
	opstina12[19] = lawless_CDE(18766, 1047.45154, -1614.88843, 10.92335,   0.00000, 0.00000, -89.88001, 300.0, 300.0);
	opstina12[20] = lawless_CDE(18981, 1047.45349, -1632.26001, 0.93565,   0.00000, 0.00000, -179.88000, 300.0, 300.0);
	opstina12[21] = lawless_CDE(18981, 1047.52100, -1657.18750, 0.93565,   0.00000, 0.00000, -179.88000, 300.0, 300.0);
	opstina12[22] = lawless_CDE(18981, 1047.54224, -1682.02808, 0.93565,   0.00000, 0.00000, -179.88000, 300.0, 300.0);
	opstina12[23] = lawless_CDE(18981, 1047.53101, -1690.02832, 0.97555,   0.00000, 0.00000, -179.88000, 300.0, 300.0);
	opstina12[24] = lawless_CDE(18981, 1143.80420, -1673.85840, 1.05389,   0.00000, 20.00000, -180.05994, 300.0, 300.0);
	opstina12[25] = lawless_CDE(18981, 1139.95874, -1630.37512, 0.91876,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[26] = lawless_CDE(18981, 1139.93530, -1653.32202, 0.93834,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[27] = lawless_CDE(18766, 1139.57324, -1590.37305, 8.41391,   0.00000, 90.00000, -89.88000, 300.0, 300.0);
	opstina12[28] = lawless_CDE(18766, 1103.93823, -1670.64978, 9.69636,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[29] = lawless_CDE(18981, 1108.40686, -1657.70142, -0.31110,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[30] = lawless_CDE(18766, 1103.71753, -1618.18176, 9.69636,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[31] = lawless_CDE(18981, 1108.20325, -1630.89844, -0.31110,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[33] = lawless_CDE(18981, 1131.72253, -1679.86731, -0.31110,   0.00000, 0.00000, -89.93999, 300.0, 300.0);
	opstina12[34] = lawless_CDE(18766, 1139.93945, -1696.66235, 10.92298,   0.00000, 0.00000, -89.88001, 300.0, 300.0);
	opstina12[35] = lawless_CDE(18766, 1139.91553, -1686.67834, 10.48403,   0.00000, 0.00000, -89.88001, 300.0, 300.0);
	opstina12[36] = lawless_CDE(18766, 1139.92773, -1684.99207, 10.47579,   0.00000, 0.00000, -89.88001, 300.0, 300.0);
	opstina12[37] = lawless_CDE(18766, 1140.19409, -1665.62708, 10.32330,   0.00000, 0.00000, -25.68001, 300.0, 300.0);
	opstina12[38] = lawless_CDE(18981, 1143.68481, -1613.17712, 1.05389,   0.00000, 20.00000, -180.05994, 300.0, 300.0);
	opstina12[39] = lawless_CDE(18766, 1140.59851, -1617.53333, 10.32330,   0.00000, 0.00000, 40.31998, 300.0, 300.0);
	opstina12[40] = lawless_CDE(18766, 1138.80420, -1680.53528, 10.41492,   0.00000, 0.00000, 0.41999, 300.0, 300.0);
	opstina12[41] = lawless_CDE(18766, 1138.83716, -1692.11462, 10.41492,   0.00000, 0.00000, 0.41999, 300.0, 300.0);
	opstina12[42] = lawless_CDE(18766, 1138.55713, -1602.25208, 10.42067,   0.00000, 0.00000, 0.41999, 300.0, 300.0);
	opstina12[43] = lawless_CDE(18766, 1139.49329, -1597.75317, 10.48403,   0.00000, 0.00000, -89.88001, 300.0, 300.0);
	opstina12[44] = lawless_CDE(18766, 1138.82568, -1592.45178, 10.16088,   0.00000, 0.00000, 0.41999, 300.0, 300.0);
	opstina12[45] = lawless_CDE(18766, 1139.55054, -1604.34412, 8.41391,   0.00000, 90.00000, -89.88000, 300.0, 300.0);
	opstina12[46] = lawless_CDE(18766, 1139.90637, -1677.84509, 8.41391,   0.00000, 90.00000, -89.88000, 300.0, 300.0);
	opstina12[47] = lawless_CDE(18762, 1139.98877, -1680.49878, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[48] = lawless_CDE(18762, 1139.43018, -1680.48328, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[49] = lawless_CDE(18762, 1139.94470, -1692.13281, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[50] = lawless_CDE(18762, 1139.65564, -1692.09766, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[51] = lawless_CDE(18762, 1139.93286, -1675.58789, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[52] = lawless_CDE(18762, 1139.99780, -1665.38611, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[53] = lawless_CDE(18762, 1139.98560, -1618.35815, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[54] = lawless_CDE(18762, 1139.56665, -1606.36768, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[55] = lawless_CDE(18762, 1139.55432, -1602.25232, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[56] = lawless_CDE(18762, 1139.58337, -1592.38464, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[57] = lawless_CDE(18766, 1098.08228, -1699.94763, 8.45173,   0.00000, 90.00000, -89.93999, 300.0, 300.0);
	opstina12[58] = lawless_CDE(18766, 1088.37256, -1699.96387, 8.45173,   0.00000, 90.00000, -89.93999, 300.0, 300.0);
	opstina12[59] = lawless_CDE(18762, 1088.38049, -1702.01453, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[60] = lawless_CDE(18762, 1098.09985, -1702.08105, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[61] = lawless_CDE(18766, 1093.06262, -1702.51672, 10.75148,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[62] = lawless_CDE(18766, 1093.05017, -1703.22510, 10.59103,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[63] = lawless_CDE(18766, 1093.05945, -1703.95874, 10.46031,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[64] = lawless_CDE(18766, 1093.04834, -1704.51135, 10.28126,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[65] = lawless_CDE(18766, 1088.84412, -1590.59985, 8.45173,   0.00000, 90.00000, -89.93999, 300.0, 300.0);
	opstina12[66] = lawless_CDE(18766, 1098.47351, -1590.51355, 8.45173,   0.00000, 90.00000, -89.93999, 300.0, 300.0);
	opstina12[67] = lawless_CDE(18766, 1093.72437, -1587.00549, 10.59103,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[68] = lawless_CDE(18766, 1093.74536, -1586.39795, 10.46031,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[69] = lawless_CDE(18766, 1093.73694, -1585.72278, 10.28126,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina12[70] = lawless_CDE(18762, 1098.47949, -1588.50793, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[71] = lawless_CDE(18762, 1088.85132, -1588.53271, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[72] = lawless_CDE(18762, 1139.92212, -1702.01404, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[73] = lawless_CDE(18766, 1098.35767, -1675.40186, 9.57855,   0.00000, 0.00000, -89.99993, 300.0, 300.0);
	opstina12[74] = lawless_CDE(18766, 1092.39514, -1682.00598, 9.57855,   0.00000, 0.00000, -0.59994, 300.0, 300.0);
	opstina12[75] = lawless_CDE(18766, 1093.59119, -1606.47607, 9.57855,   0.00000, 0.00000, -0.59994, 300.0, 300.0);
	opstina12[76] = lawless_CDE(18762, 1139.61108, -1588.33655, 12.30701,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina12[77] = lawless_CDE(18766, 1093.71655, -1587.66138, 10.75148,   0.00000, 0.00000, -179.99997, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina12); i++)
	{
		SetDynamicObjectMaterial(opstina12[i], 0, 18265, "w_town3cs_t", "ws_redbrickold", 0xFFFFFFFF);
	}

	new opstina13[51];
	opstina13[0] = lawless_CDE(4563, 1095.50330, -1718.77966, -162.39362,   0.00000, 0.00000, 40.92001, 300.0, 300.0);
	opstina13[1] = lawless_CDE(4563, 1147.93811, -1670.23035, -162.49052,   0.00000, 0.00000, -229.25998, 300.0, 300.0);
	opstina13[2] = lawless_CDE(4563, 1062.65991, -1680.88757, -162.41144,   0.00000, 0.00000, 40.92001, 300.0, 300.0);
	opstina13[3] = lawless_CDE(4563, 1043.41687, -1658.87488, -162.43857,   0.00000, 0.00000, 40.92001, 300.0, 300.0);
	opstina13[4] = lawless_CDE(4563, 1116.10181, -1633.28674, -162.54907,   0.00000, 0.00000, -229.25998, 300.0, 300.0);
	opstina13[5] = lawless_CDE(4563, 1084.02600, -1596.06604, -162.39584,   0.00000, 0.00000, -229.25998, 300.0, 300.0);
	opstina13[6] = lawless_CDE(4563, 1129.75696, -1608.40698, -162.40855,   0.00000, 0.00000, -229.25998, 300.0, 300.0);
	opstina13[7] = lawless_CDE(18981, 1098.08691, -1694.00745, -0.31110,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina13[8] = lawless_CDE(18981, 1088.40027, -1695.16821, -0.31110,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina13[9] = lawless_CDE(18766, 1103.81360, -1679.90063, 9.69636,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina13[10] = lawless_CDE(18766, 1113.76453, -1679.91699, 9.69636,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina13[11] = lawless_CDE(18766, 1103.93823, -1670.64978, 9.69636,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina13[12] = lawless_CDE(18766, 1119.17444, -1675.38147, 9.69636,   0.00000, 0.00000, -89.81993, 300.0, 300.0);
	opstina13[13] = lawless_CDE(18766, 1119.14978, -1670.81079, 9.71631,   0.00000, 0.00000, -89.81993, 300.0, 300.0);
	opstina13[14] = lawless_CDE(18766, 1118.61133, -1614.26453, 9.75603,   0.00000, 0.00000, -89.81993, 300.0, 300.0);
	opstina13[15] = lawless_CDE(18766, 1118.59229, -1612.51807, 9.75631,   0.00000, 0.00000, -89.81993, 300.0, 300.0);
	opstina13[16] = lawless_CDE(18766, 1113.09705, -1608.02380, 9.69636,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina13[17] = lawless_CDE(18766, 1104.50452, -1608.01208, 9.69636,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina13[18] = lawless_CDE(18766, 1103.71753, -1618.18176, 9.69636,   0.00000, 0.00000, -179.99997, 300.0, 300.0);
	opstina13[19] = lawless_CDE(18981, 1098.45361, -1592.79712, -0.31110,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina13[20] = lawless_CDE(18981, 1088.80249, -1593.62305, -0.31110,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina13[21] = lawless_CDE(18766, 1135.74011, -1678.52490, 9.71631,   0.00000, 0.00000, -28.85992, 300.0, 300.0);
	opstina13[22] = lawless_CDE(18766, 1131.35718, -1676.10010, 9.72783,   0.00000, 0.00000, -28.85992, 300.0, 300.0);
	opstina13[23] = lawless_CDE(18766, 1123.51416, -1670.28491, 9.71631,   0.00000, 0.00000, -44.03992, 300.0, 300.0);
	opstina13[24] = lawless_CDE(18766, 1120.83777, -1667.61963, 9.69978,   0.00000, 0.00000, -44.03992, 300.0, 300.0);
	opstina13[25] = lawless_CDE(18766, 1114.84131, -1659.97559, 9.71631,   0.00000, 0.00000, -59.45993, 300.0, 300.0);
	opstina13[26] = lawless_CDE(18766, 1112.52661, -1656.07275, 9.73602,   0.00000, 0.00000, -59.45993, 300.0, 300.0);
	opstina13[27] = lawless_CDE(18766, 1109.61975, -1647.07422, 9.73602,   0.00000, 0.00000, -84.65990, 300.0, 300.0);
	opstina13[28] = lawless_CDE(18766, 1137.03796, -1603.12659, 9.71631,   0.00000, 0.00000, 29.10009, 300.0, 300.0);
	opstina13[29] = lawless_CDE(18766, 1128.96460, -1608.72729, 9.71631,   0.00000, 0.00000, 39.90009, 300.0, 300.0);
	opstina13[30] = lawless_CDE(18766, 1126.71729, -1610.62354, 9.72900,   0.00000, 0.00000, 39.90009, 300.0, 300.0);
	opstina13[31] = lawless_CDE(18766, 1120.01501, -1617.59204, 9.71631,   0.00000, 0.00000, 52.08009, 300.0, 300.0);
	opstina13[32] = lawless_CDE(18766, 1117.79053, -1620.43213, 9.73278,   0.00000, 0.00000, 52.08009, 300.0, 300.0);
	opstina13[33] = lawless_CDE(18766, 1113.07642, -1628.93945, 9.73278,   0.00000, 0.00000, 69.54008, 300.0, 300.0);
	opstina13[34] = lawless_CDE(18766, 1111.59351, -1632.91345, 9.75273,   0.00000, 0.00000, 69.54008, 300.0, 300.0);
	opstina13[35] = lawless_CDE(18766, 1109.69214, -1642.37048, 9.73278,   0.00000, 0.00000, 87.66006, 300.0, 300.0);
	opstina13[36] = lawless_CDE(18766, 1136.54749, -1659.23376, 9.72783,   0.00000, 0.00000, -39.17993, 300.0, 300.0);
	opstina13[37] = lawless_CDE(18766, 1130.28186, -1652.02747, 9.72783,   0.00000, 0.00000, -58.73994, 300.0, 300.0);
	opstina13[38] = lawless_CDE(18766, 1128.34302, -1643.10522, 9.72783,   0.00000, 0.00000, -96.71991, 300.0, 300.0);
	opstina13[39] = lawless_CDE(18766, 1128.67017, -1643.20471, 9.72073,   0.00000, 0.00000, -96.71991, 300.0, 300.0);
	opstina13[40] = lawless_CDE(18766, 1131.08362, -1633.88428, 9.72783,   0.00000, 0.00000, -116.33990, 300.0, 300.0);
	opstina13[41] = lawless_CDE(18766, 1131.43359, -1635.15991, 9.72073,   0.00000, 0.00000, -116.39991, 300.0, 300.0);
	opstina13[42] = lawless_CDE(18766, 1136.95154, -1626.38110, 9.72783,   0.00000, 0.00000, -139.91995, 300.0, 300.0);
	opstina13[43] = lawless_CDE(18766, 1131.95996, -1634.16370, 9.72601,   0.00000, 0.00000, -116.39991, 300.0, 300.0);
	opstina13[44] = lawless_CDE(18766, 1137.72998, -1626.42822, 9.72601,   0.00000, 0.00000, -138.17986, 300.0, 300.0);
	opstina13[45] = lawless_CDE(18766, 1135.23975, -1629.24182, 9.71152,   0.00000, 0.00000, -131.39987, 300.0, 300.0);
	opstina13[46] = lawless_CDE(18981, 1131.72253, -1679.86731, -0.31110,   0.00000, 0.00000, -89.93999, 300.0, 300.0);
	opstina13[47] = lawless_CDE(18981, 1117.74255, -1608.01794, -0.31110,   0.00000, 0.00000, -89.93999, 300.0, 300.0);
	opstina13[48] = lawless_CDE(18981, 1099.24353, -1658.15759, -0.31110,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina13[49] = lawless_CDE(18981, 1099.23145, -1633.21692, -0.31110,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	opstina13[50] = lawless_CDE(18766, 1137.03796, -1603.12659, 9.71631,   0.00000, 0.00000, 29.10009, 300.0, 300.0);

	for(new i = 0; i < sizeof(opstina13); i++)
	{
		SetDynamicObjectMaterial(opstina13[i], 0, 6293, "lawland2", "stonewall_la", 0xFFFFFFFF);
	}

	new OPSTINA = CreateObject(19482, 1135.7618, -1644.2208, 14.9312, 0.0000, 0.0000, -0.2533);
	SetObjectMaterialText(OPSTINA, "OPSTINA", 0, 140, "ARIAL BLACK", 95, 0, -1, 0, 1);
	new Parking1 = CreateObject(19482, 1139.8017, -1604.2900, 15.8212, 0.0000, 0.0000, -0.6067);
	SetObjectMaterialText(Parking1, "PARKING", 0, 140, "Arial", 90, 1, -1, 0, 1);
	new Parking2 = CreateObject(19482, 1140.2637, -1678.0423, 15.7612, 0.0000, 0.0000, -0.4467);
	SetObjectMaterialText(Parking2, "PARKING", 0, 140, "Arial", 90, 1, -1, 0, 1);
	
	lawless_CDE(19325, 1705.21472, -1776.62769, 13.49340,   0.00000, 31.00000, 180.06000, 300.0, 300.0);
	lawless_CDE(19325, 1705.19409, -1781.16479, 13.49340,   0.00000, 31.00000, 180.06000, 300.0, 300.0);
	lawless_CDE(19325, 1705.23010, -1787.57068, 13.49340,   0.00000, 31.00000, 180.06000, 300.0, 300.0);
	lawless_CDE(19325, 1705.21692, -1794.20569, 13.49340,   0.00000, 31.00000, 180.06000, 300.0, 300.0);
	lawless_CDE(19325, 1705.18958, -1765.95837, 13.49340,   0.00000, 31.00000, 180.06000, 300.0, 300.0);
	lawless_CDE(19325, 1705.14990, -1759.35156, 13.49340,   0.00000, 31.00000, 180.06000, 300.0, 300.0);
	lawless_CDE(19325, 1705.11658, -1752.72852, 13.49340,   0.00000, 31.00000, 180.06000, 300.0, 300.0);
	lawless_CDE(1569, 1705.77515, -1770.20190, 12.35009,   0.00000, 0.00000, -89.63999, 300.0, 300.0);
	lawless_CDE(1569, 1705.80737, -1773.20422, 12.35009,   0.00000, 0.00000, 90.53999, 300.0, 300.0);
	lawless_CDE(19325, 1705.00330, -1766.86169, 18.52313,   0.00000, 31.00000, 359.99985, 300.0, 300.0);
	lawless_CDE(19325, 1705.00525, -1760.23328, 18.52313,   0.00000, 31.00000, 359.99985, 300.0, 300.0);
	lawless_CDE(19325, 1705.00281, -1753.60229, 18.52313,   0.00000, 31.00000, 359.99985, 300.0, 300.0);
	lawless_CDE(19325, 1705.10632, -1773.43018, 18.52313,   0.00000, 31.00000, 361.67978, 300.0, 300.0);
	lawless_CDE(19325, 1705.20532, -1779.97205, 18.52313,   0.00000, 31.00000, 359.99985, 300.0, 300.0);
	lawless_CDE(19325, 1705.18420, -1786.57397, 18.52313,   0.00000, 31.00000, 359.99985, 300.0, 300.0);
	lawless_CDE(19325, 1705.18579, -1793.20923, 18.52313,   0.00000, 31.00000, 359.99985, 300.0, 300.0);
	lawless_CDE(3857, 1709.45129, -1797.53906, 17.91557,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1709.50146, -1749.28772, 17.91557,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1709.45129, -1797.53906, 12.09246,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1709.50146, -1749.28772, 12.09409,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1733.68738, -1749.47083, 12.09409,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1726.24805, -1749.46472, 12.09409,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1726.24805, -1749.46472, 17.91950,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1733.68738, -1749.47083, 17.91782,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1720.17017, -1788.23157, 12.09409,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(3857, 1720.17017, -1788.23157, 17.90256,   0.00000, 0.00000, 44.99999, 300.0, 300.0);
	lawless_CDE(625, 1736.84705, -1785.66638, 13.13053,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(632, 1707.83447, -1751.38049, 12.77722,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(632, 1708.30090, -1795.33350, 12.77722,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(638, 1701.93604, -1773.83374, 13.02267,   0.00000, 0.00000, 90.11997, 300.0, 300.0);
	lawless_CDE(638, 1701.96057, -1769.46338, 13.02267,   0.00000, 0.00000, 89.75997, 300.0, 300.0);
	lawless_CDE(948, 1706.29858, -1773.35352, 12.38632,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(948, 1706.19812, -1769.98938, 12.38632,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1215, 1700.29993, -1769.45166, 12.54827,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1215, 1700.26355, -1773.81372, 12.54827,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1433, 1725.01331, -1753.26929, 12.54662,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(1671, 1728.32068, -1756.99695, 12.84287,   0.00000, 0.00000, 76.13999, 300.0, 300.0);
	lawless_CDE(1714, 1733.43640, -1751.84094, 12.38143,   0.00000, 0.00000, -174.54001, 300.0, 300.0);
	lawless_CDE(1726, 1723.78125, -1751.05066, 12.38146,   0.00000, 0.00000, -0.30001, 300.0, 300.0);
	lawless_CDE(1727, 1727.02954, -1751.94006, 12.38126,   0.00000, 0.00000, -67.32001, 300.0, 300.0);
	lawless_CDE(2030, 1709.26746, -1766.83643, 12.74662,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2030, 1709.29199, -1776.05164, 12.74662,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2066, 1736.90002, -1757.36267, 12.38333,   0.00000, 0.00000, -91.86001, 300.0, 300.0);
	lawless_CDE(2163, 1737.21936, -1750.59192, 12.33663,   0.00000, 0.00000, -91.38000, 300.0, 300.0);
	lawless_CDE(2164, 1737.16797, -1752.30750, 12.37779,   0.00000, 0.00000, -89.94003, 300.0, 300.0);
	lawless_CDE(2165, 1732.76880, -1750.87976, 12.37737,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2167, 1737.18250, -1754.06335, 12.37801,   0.00000, 0.00000, -89.70006, 300.0, 300.0);
	lawless_CDE(2202, 1736.33435, -1758.48450, 12.37830,   0.00000, 0.00000, -90.53999, 300.0, 300.0);
	lawless_CDE(2208, 1729.72290, -1755.85266, 12.37854,   0.00000, 0.00000, -71.88000, 300.0, 300.0);
	lawless_CDE(2207, 1730.02234, -1759.27966, 12.37893,   0.00000, 0.00000, -30.00000, 300.0, 300.0);
	lawless_CDE(1964, 1730.37744, -1757.03015, 13.38056,   0.00000, 0.00000, -72.54002, 300.0, 300.0);
	lawless_CDE(2118, 1716.51025, -1752.09180, 12.34763,   0.00000, 0.00000, 20.94000, 300.0, 300.0);
	lawless_CDE(2118, 1718.43274, -1751.70715, 12.34763,   0.00000, 0.00000, -29.70000, 300.0, 300.0);
	lawless_CDE(2226, 1716.98108, -1752.07007, 13.13586,   0.00000, 0.00000, 21.60000, 300.0, 300.0);
	lawless_CDE(2233, 1715.99060, -1751.81909, 12.38810,   0.00000, 0.00000, 35.75999, 300.0, 300.0);
	lawless_CDE(2233, 1718.29150, -1750.88025, 12.38810,   0.00000, 0.00000, 0.06000, 300.0, 300.0);
	lawless_CDE(2233, 1720.37903, -1752.55127, 12.38810,   0.00000, 0.00000, -48.30000, 300.0, 300.0);
	lawless_CDE(2245, 1718.84058, -1752.00964, 13.39713,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2252, 1709.25964, -1775.92822, 13.40075,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2251, 1709.21338, -1766.85962, 13.97977,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2260, 1715.54321, -1749.84595, 13.93564,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2262, 1717.41870, -1749.87244, 14.78956,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2267, 1719.53149, -1749.40369, 14.36293,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2266, 1721.27722, -1749.86475, 14.95081,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2332, 1736.86755, -1754.88757, 12.79392,   0.00000, 0.00000, -89.16000, 300.0, 300.0);
	lawless_CDE(2164, 1737.25244, -1755.82129, 12.37779,   0.00000, 0.00000, -89.94003, 300.0, 300.0);
	lawless_CDE(2066, 1736.88196, -1757.92078, 12.38333,   0.00000, 0.00000, -91.86001, 300.0, 300.0);
	lawless_CDE(1714, 1731.76953, -1756.24719, 12.38143,   0.00000, 0.00000, -68.94002, 300.0, 300.0);
	lawless_CDE(1727, 1727.38550, -1753.62976, 12.38126,   0.00000, 0.00000, -103.26003, 300.0, 300.0);
	lawless_CDE(1671, 1729.06018, -1758.70776, 12.84287,   0.00000, 0.00000, 129.84001, 300.0, 300.0);
	lawless_CDE(2568, 1736.77063, -1761.25220, 12.38284,   0.00000, 0.00000, -89.69998, 300.0, 300.0);
	lawless_CDE(2571, 1709.23767, -1752.15356, 12.38291,   0.00000, 0.00000, 2.52000, 300.0, 300.0);
	lawless_CDE(2826, 1708.91553, -1767.12195, 13.14422,   0.00000, 0.00000, 6.24000, 300.0, 300.0);
	lawless_CDE(2826, 1709.68127, -1766.98901, 13.14422,   0.00000, 0.00000, 140.87996, 300.0, 300.0);
	lawless_CDE(2894, 1731.70911, -1759.75732, 13.14889,   0.00000, 0.00000, -163.80000, 300.0, 300.0);
	lawless_CDE(19172, 1737.30786, -1770.61096, 15.60667,   0.00000, 0.00000, -89.99998, 300.0, 300.0);
	lawless_CDE(19325, 1733.19080, -1766.15723, 14.24085,   0.00000, 0.00000, 74.51998, 300.0, 300.0);
	lawless_CDE(19325, 1722.92969, -1753.72656, 14.24085,   0.00000, 0.00000, 188.45982, 300.0, 300.0);
	lawless_CDE(19325, 1728.39294, -1763.96863, 12.98237,   90.00000, 0.00000, 230.81990, 300.0, 300.0);
	lawless_CDE(19787, 1737.38037, -1774.46558, 15.30411,   0.00000, 0.00000, -90.84000, 300.0, 300.0);
	lawless_CDE(19787, 1737.37512, -1777.40576, 15.30411,   0.00000, 0.00000, -90.54000, 300.0, 300.0);
	lawless_CDE(19822, 1709.06555, -1776.34106, 13.14394,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(19822, 1708.83362, -1776.07361, 13.14394,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(19894, 1730.15356, -1756.55701, 13.24085,   0.00000, 0.00000, -77.16000, 300.0, 300.0);
	lawless_CDE(1433, 1708.98206, -1781.56006, 12.54662,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(11313, 1729.58484, -1788.06775, 14.35954,   0.00000, 0.00000, -89.94003, 300.0, 300.0);
	lawless_CDE(11313, 1729.33728, -1788.25464, 14.35954,   0.00000, 0.00000, -89.94003, 300.0, 300.0);
	lawless_CDE(1209, 1737.05981, -1768.15137, 12.38349,   0.00000, 0.00000, -90.47998, 300.0, 300.0);
	lawless_CDE(1670, 1725.17871, -1753.28870, 13.06635,   0.00000, 0.00000, 162.59998, 300.0, 300.0);
	lawless_CDE(1808, 1736.95361, -1768.94751, 12.39036,   0.00000, 0.00000, -88.79999, 300.0, 300.0);
	lawless_CDE(1828, 1733.78772, -1755.15479, 12.38434,   0.00000, 0.00000, -58.02000, 300.0, 300.0);
	lawless_CDE(948, 1717.92590, -1752.43311, 12.38632,   0.00000, 0.00000, -49.62000, 300.0, 300.0);
	lawless_CDE(2239, 1731.31982, -1750.73950, 12.38321,   0.00000, 0.00000, 34.50000, 300.0, 300.0);
	lawless_CDE(2241, 1723.56653, -1757.55872, 12.84873,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2241, 1726.41907, -1762.35205, 12.84873,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2257, 1737.28857, -1780.89636, 15.45259,   0.00000, 0.00000, -89.94002, 300.0, 300.0);
	lawless_CDE(2773, 1711.28040, -1763.20203, 12.74102,   0.00000, 0.00000, -60.72001, 300.0, 300.0);
	lawless_CDE(2773, 1717.20679, -1779.84729, 12.74102,   0.00000, 0.00000, -77.88000, 300.0, 300.0);
	lawless_CDE(2773, 1729.12524, -1772.34302, 12.74102,   0.00000, 0.00000, -49.50000, 300.0, 300.0);
	lawless_CDE(2773, 1726.62866, -1774.38831, 12.74102,   0.00000, 0.00000, -49.50000, 300.0, 300.0);
	lawless_CDE(2773, 1724.19092, -1776.56238, 12.74102,   0.00000, 0.00000, -49.50000, 300.0, 300.0);
	lawless_CDE(2816, 1709.00281, -1781.57568, 13.05239,   0.00000, 0.00000, -38.64000, 300.0, 300.0);
	lawless_CDE(2773, 1709.52625, -1787.73889, 12.74102,   0.00000, 0.00000, -61.50001, 300.0, 300.0);
	lawless_CDE(632, 1722.01563, -1751.33167, 12.79266,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(632, 1715.35461, -1795.37915, 12.79266,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2108, 1713.15930, -1750.63306, 12.38215,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(2241, 1736.00488, -1767.46619, 12.84873,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(18075, 1711.17212, -1757.88440, 20.52538,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(18075, 1711.07813, -1772.50159, 20.55004,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(18075, 1711.24646, -1786.81799, 20.50030,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(16780, 1732.18457, -1768.87244, 19.98716,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(647, 1741.83228, -1748.00549, 12.34487,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1741.47571, -1745.96362, 12.35121,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1702.77332, -1745.39417, 12.35121,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1721.55078, -1745.53772, 12.35121,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1741.43958, -1784.57996, 12.35121,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1742.12476, -1766.02612, 12.35121,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(746, 1715.52856, -1746.30774, 12.36742,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(746, 1741.88745, -1756.95435, 12.36742,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(832, 1713.83435, -1745.99353, 14.03627,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 1703.37354, -1745.82532, 12.75356,   0.00000, 0.00000, -11.28000, 300.0, 300.0);
	lawless_CDE(870, 1708.31982, -1745.92822, 12.55909,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 1722.55786, -1745.76074, 12.75356,   0.00000, 0.00000, -11.28000, 300.0, 300.0);
	lawless_CDE(870, 1728.84241, -1746.14954, 12.55909,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 1735.33435, -1746.19019, 12.75356,   0.00000, 0.00000, -11.28000, 300.0, 300.0);
	lawless_CDE(870, 1742.63086, -1745.95764, 12.55909,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 1742.21936, -1752.97668, 12.75356,   0.00000, 0.00000, -11.28000, 300.0, 300.0);
	lawless_CDE(869, 1742.50696, -1781.57959, 12.75356,   0.00000, 0.00000, -11.28000, 300.0, 300.0);
	lawless_CDE(746, 1742.64783, -1775.15784, 12.36742,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(673, 1702.38171, -1800.11536, 12.35121,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	lawless_CDE(869, 1703.17944, -1799.70398, 12.75356,   0.00000, 0.00000, -11.28000, 300.0, 300.0);
	lawless_CDE(746, 1712.08289, -1799.63354, 12.36742,   0.00000, 0.00000, -14.22000, 300.0, 300.0);
	lawless_CDE(9833, 1707.09204, -1800.06665, 10.34540,   0.00000, 0.00000, 0.00000, 300.0, 300.0);

	new autosalonm[111];
	autosalonm[1] = lawless_CDE(19377, 1704.69421, -1744.31848, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[2] = lawless_CDE(19377, 1715.17444, -1744.42786, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[3] = lawless_CDE(19377, 1725.67639, -1744.52966, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[4] = lawless_CDE(19377, 1736.15210, -1746.89661, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[5] = lawless_CDE(19377, 1746.57910, -1746.91382, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[6] = lawless_CDE(19377, 1742.96533, -1756.52112, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[7] = lawless_CDE(19377, 1742.90344, -1766.14868, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[8] = lawless_CDE(19377, 1742.91016, -1775.76965, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[9] = lawless_CDE(19377, 1742.90527, -1783.60986, 12.28383,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[10] = lawless_CDE(19377, 1704.83521, -1802.40784, 12.27628,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[11] = lawless_CDE(19377, 1711.35425, -1801.80359, 12.28083,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[12] = lawless_CDE(18762, 1745.16846, -1742.72021, 12.62807,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[13] = lawless_CDE(18981, 1733.22046, -1742.69446, 0.35075,   0.00000, 0.00000, -90.12000, 300.0, 300.0);
	autosalonm[14] = lawless_CDE(18981, 1711.57642, -1742.65442, 0.36447,   0.00000, 0.00000, -90.12000, 300.0, 300.0);
	autosalonm[15] = lawless_CDE(18762, 1699.61963, -1742.63831, 12.62807,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[17] = lawless_CDE(18762, 1699.61584, -1747.58264, 12.38222,   0.00000, 90.00000, -89.99998, 300.0, 300.0);
	autosalonm[18] = lawless_CDE(18762, 1699.61475, -1745.51221, 12.36276,   0.00000, 90.00000, -89.99998, 300.0, 300.0);
	autosalonm[19] = lawless_CDE(18762, 1699.51184, -1749.56189, 12.62807,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[20] = lawless_CDE(18762, 1702.08228, -1749.60547, 12.40275,   0.00000, 90.00000, -180.18002, 300.0, 300.0);
	autosalonm[21] = lawless_CDE(18762, 1703.04248, -1749.60852, 12.36276,   0.00000, 90.00000, -180.18002, 300.0, 300.0);
	autosalonm[22] = lawless_CDE(18980, 1699.49524, -1762.51111, 12.08122,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalonm[23] = lawless_CDE(18980, 1699.48328, -1789.33228, 12.08122,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalonm[24] = lawless_CDE(18762, 1699.47144, -1797.23059, 12.62807,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[25] = lawless_CDE(18762, 1699.43335, -1802.31665, 12.62807,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[26] = lawless_CDE(18762, 1702.46484, -1797.25928, 12.12689,   0.00000, 90.00000, -180.18002, 300.0, 300.0);
	autosalonm[27] = lawless_CDE(18762, 1703.25342, -1797.25964, 12.10964,   0.00000, 90.00000, -180.18002, 300.0, 300.0);
	autosalonm[28] = lawless_CDE(18981, 1711.48999, -1802.32703, 0.07373,   0.00000, 0.00000, -90.12000, 300.0, 300.0);
	autosalonm[29] = lawless_CDE(18762, 1716.12402, -1802.33862, 12.62807,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[30] = lawless_CDE(18762, 1716.16321, -1800.16650, 12.13148,   0.00000, 90.00000, -89.99998, 300.0, 300.0);
	autosalonm[31] = lawless_CDE(18981, 1732.60364, -1805.28589, 0.08991,   0.00000, 0.00000, -104.27998, 300.0, 300.0);
	autosalonm[32] = lawless_CDE(18980, 1699.48303, -1764.37256, 12.08122,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalonm[33] = lawless_CDE(19538, 1761.37708, -1773.17969, 12.35471,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[34] = lawless_CDE(19538, 1761.39075, -1778.45642, 12.31434,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[35] = lawless_CDE(19325, 1742.80103, -1742.53101, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[36] = lawless_CDE(19325, 1736.18347, -1742.52637, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[37] = lawless_CDE(19325, 1729.58337, -1742.53735, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[38] = lawless_CDE(19325, 1722.98486, -1742.54199, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[39] = lawless_CDE(19325, 1716.35645, -1742.53857, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[40] = lawless_CDE(19325, 1709.74597, -1742.52466, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[41] = lawless_CDE(19325, 1703.12170, -1742.52380, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[42] = lawless_CDE(19325, 1699.44373, -1746.07483, 12.53478,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[43] = lawless_CDE(19369, 1699.33765, -1801.15771, 12.82184,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[44] = lawless_CDE(19369, 1699.33325, -1798.43225, 12.82184,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalonm[45] = lawless_CDE(19325, 1702.84961, -1802.39746, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[46] = lawless_CDE(19325, 1709.45813, -1802.40393, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[47] = lawless_CDE(19325, 1712.93457, -1802.42200, 12.53478,   0.00000, 0.00000, -90.06000, 300.0, 300.0);
	autosalonm[48] = lawless_CDE(1251, 1702.27271, -1750.30688, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[49] = lawless_CDE(1251, 1702.23218, -1753.76758, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[50] = lawless_CDE(1251, 1702.28101, -1757.22998, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[51] = lawless_CDE(1251, 1702.30530, -1760.71069, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[52] = lawless_CDE(1251, 1702.35046, -1764.21045, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[53] = lawless_CDE(1251, 1702.20752, -1767.71082, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[54] = lawless_CDE(1251, 1702.26465, -1775.60254, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[55] = lawless_CDE(1251, 1702.26111, -1779.08313, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[56] = lawless_CDE(1251, 1702.37158, -1782.54578, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[57] = lawless_CDE(1251, 1702.32031, -1786.11060, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[58] = lawless_CDE(1251, 1702.50171, -1789.52197, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[59] = lawless_CDE(1251, 1702.27380, -1793.07593, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[60] = lawless_CDE(1251, 1702.28198, -1796.53638, 12.43585,   0.00000, 0.00000, -90.65999, 300.0, 300.0);
	autosalonm[61] = lawless_CDE(19461, 1700.76538, -1771.64587, 12.45825,   0.00000, 90.00000, 89.93999, 300.0, 300.0);
	autosalonm[62] = lawless_CDE(19377, 1710.98792, -1754.33911, 20.66645,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[63] = lawless_CDE(19377, 1710.97864, -1763.92395, 20.66045,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[64] = lawless_CDE(19377, 1711.01038, -1773.53540, 20.66473,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[65] = lawless_CDE(19377, 1710.99438, -1783.13794, 20.65273,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[66] = lawless_CDE(19377, 1711.00745, -1792.74780, 20.65166,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[67] = lawless_CDE(19377, 1721.43579, -1754.37109, 20.27529,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[68] = lawless_CDE(19377, 1721.41333, -1763.95117, 20.27545,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[69] = lawless_CDE(19377, 1721.40820, -1773.56799, 20.28129,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[70] = lawless_CDE(19377, 1721.40698, -1783.16345, 20.29013,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[71] = lawless_CDE(19377, 1731.87585, -1783.17468, 20.03946,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[72] = lawless_CDE(19377, 1731.89038, -1773.57568, 20.03783,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[73] = lawless_CDE(19377, 1731.88599, -1763.97717, 20.05052,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[74] = lawless_CDE(19377, 1731.92175, -1754.37842, 20.05590,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[75] = lawless_CDE(18980, 1715.97986, -1761.83276, 20.35740,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalonm[76] = lawless_CDE(18980, 1715.97229, -1774.89648, 20.35394,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalonm[77] = lawless_CDE(18980, 1726.66882, -1762.40430, 20.35770,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalonm[78] = lawless_CDE(18980, 1726.69592, -1775.15393, 20.35394,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalonm[79] = lawless_CDE(19376, 1717.74988, -1749.28955, 15.41309,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	autosalonm[80] = lawless_CDE(19376, 1737.33899, -1754.43469, 15.41309,   0.00000, 0.00000, 0.06000, 300.0, 300.0);
	autosalonm[81] = lawless_CDE(19376, 1737.37866, -1763.89941, 15.41309,   0.00000, 0.00000, 0.06000, 300.0, 300.0);
	autosalonm[82] = lawless_CDE(19376, 1737.40466, -1773.43018, 15.41309,   0.00000, 0.00000, 0.06000, 300.0, 300.0);
	autosalonm[83] = lawless_CDE(19376, 1737.40857, -1782.99402, 15.41309,   0.00000, 0.00000, 0.06000, 300.0, 300.0);
	autosalonm[84] = lawless_CDE(19376, 1732.36084, -1788.16699, 15.41309,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	autosalonm[85] = lawless_CDE(19376, 1728.62695, -1788.18628, 15.41309,   0.00000, 0.00000, 90.06000, 300.0, 300.0);
	autosalonm[86] = lawless_CDE(19376, 1716.33203, -1792.37646, 15.41309,   0.00000, 0.00000, 0.06000, 300.0, 300.0);
	autosalonm[87] = lawless_CDE(19377, 1711.01038, -1773.53540, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[88] = lawless_CDE(19377, 1710.99438, -1783.13794, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[89] = lawless_CDE(19377, 1711.00745, -1792.74780, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[90] = lawless_CDE(19377, 1710.97864, -1763.92395, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[91] = lawless_CDE(19377, 1710.98792, -1754.33911, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[92] = lawless_CDE(19377, 1721.43579, -1754.37109, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[93] = lawless_CDE(19377, 1721.41333, -1763.95117, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[94] = lawless_CDE(19377, 1721.40820, -1773.56799, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[95] = lawless_CDE(19377, 1721.40698, -1783.16345, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[96] = lawless_CDE(19377, 1731.87585, -1783.17468, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[97] = lawless_CDE(19377, 1731.89038, -1773.57568, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[98] = lawless_CDE(19377, 1731.88599, -1763.97717, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[99] = lawless_CDE(19377, 1731.92175, -1754.37842, 12.30171,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalonm[100] = lawless_CDE(1704, 1708.42773, -1784.67517, 12.38108,   0.00000, 0.00000, -214.44000, 300.0, 300.0);
	autosalonm[101] = lawless_CDE(1703, 1706.92395, -1782.58826, 12.38028,   0.00000, 0.00000, 89.76000, 300.0, 300.0);
	autosalonm[102] = lawless_CDE(1704, 1707.18652, -1779.02551, 12.38108,   0.00000, 0.00000, -306.24005, 300.0, 300.0);
	autosalonm[103] = lawless_CDE(19466, 1704.71387, -1770.17639, 15.81411,   0.00000, 0.00000, 90.29999, 300.0, 300.0);
	autosalonm[104] = lawless_CDE(19466, 1704.71387, -1770.17639, 13.87828,   0.00000, 0.00000, 90.29999, 300.0, 300.0);
	autosalonm[105] = lawless_CDE(19466, 1704.71387, -1770.17639, 11.94878,   0.00000, 0.00000, 90.29999, 300.0, 300.0);
	autosalonm[106] = lawless_CDE(19466, 1705.80347, -1771.28943, 15.81411,   0.00000, 0.00000, -0.00001, 300.0, 300.0);
	autosalonm[107] = lawless_CDE(19466, 1705.80066, -1772.08948, 15.81411,   0.00000, 0.00000, -0.00001, 300.0, 300.0);
	autosalonm[108] = lawless_CDE(19466, 1704.68164, -1773.21045, 15.81411,   0.00000, 0.00000, 90.29999, 300.0, 300.0);
	autosalonm[109] = lawless_CDE(19466, 1704.68164, -1773.21045, 13.87915,   0.00000, 0.00000, 90.29999, 300.0, 300.0);
	autosalonm[110] = lawless_CDE(19466, 1704.68164, -1773.21045, 11.95225,   0.00000, 0.00000, 90.29999, 300.0, 300.0);

	SetDynamicObjectMaterial(autosalonm[1], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[2], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[3], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[4], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[5], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[6], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[7], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[8], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[9], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[10], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[11], 0, 3310, "sw_poorhouse", "Grass_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[12], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[13], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[14], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[15], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[16], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[17], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[18], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[19], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[20], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[21], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[22], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[23], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[24], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[25], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[26], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[27], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[28], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[29], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[30], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[31], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[32], 0, 6340, "rodeo05_law2", "citywall6", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[33], 0, 3975, "lanbloke", "p_floor3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[34], 0, 3975, "lanbloke", "p_floor3", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[35], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[36], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[37], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[38], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[39], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[40], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[41], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[42], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[43], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[44], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[45], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[46], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[47], 0, 13861, "lahills_wiresnshit3", "sjmornfnce", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[48], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[49], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[50], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[51], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[52], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[53], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[54], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[55], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[56], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[57], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[58], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[59], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[60], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[61], 0, 2773, "airp_prop", "CJ_red_COUNTER");
	SetDynamicObjectMaterial(autosalonm[62], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[63], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[64], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[65], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[66], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[67], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[68], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[69], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[70], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[71], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[72], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[73], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[74], 0, 14417, "dr_gsnew", "mp_burn_ceiling");
	SetDynamicObjectMaterial(autosalonm[75], 0, 16377, "des_byofficeint", "CJ_WOOD5", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[76], 0, 16377, "des_byofficeint", "CJ_WOOD5", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[77], 0, 16377, "des_byofficeint", "CJ_WOOD5", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[78], 0, 16377, "des_byofficeint", "CJ_WOOD5", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonm[79], 0, 4559, "lanlacma_lan2", "lasbrwnhus3");
	SetDynamicObjectMaterial(autosalonm[80], 0, 4559, "lanlacma_lan2", "lasbrwnhus3");
	SetDynamicObjectMaterial(autosalonm[81], 0, 4559, "lanlacma_lan2", "lasbrwnhus3");
	SetDynamicObjectMaterial(autosalonm[82], 0, 4559, "lanlacma_lan2", "lasbrwnhus3");
	SetDynamicObjectMaterial(autosalonm[83], 0, 4559, "lanlacma_lan2", "lasbrwnhus3");
	SetDynamicObjectMaterial(autosalonm[84], 0, 4559, "lanlacma_lan2", "lasbrwnhus3");
	SetDynamicObjectMaterial(autosalonm[85], 0, 4559, "lanlacma_lan2", "lasbrwnhus3");
	SetDynamicObjectMaterial(autosalonm[86], 0, 4559, "lanlacma_lan2", "lasbrwnhus3");
	SetDynamicObjectMaterial(autosalonm[87], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[88], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[89], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[90], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[91], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[92], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[93], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[94], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[95], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[96], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[97], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[98], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[99], 0, 2118, "cj_tables", "marble1");
	SetDynamicObjectMaterial(autosalonm[100], 0, 14533, "pleas_dome", "ab_carpethexi");
	SetDynamicObjectMaterial(autosalonm[101], 0, 14533, "pleas_dome", "ab_carpethexi");
	SetDynamicObjectMaterial(autosalonm[102], 0, 14533, "pleas_dome", "ab_carpethexi");
	SetDynamicObjectMaterial(autosalonm[100], 1, 18029, "genintintsmallrest", "GB_restaursmll09");
	SetDynamicObjectMaterial(autosalonm[101], 1, 18029, "genintintsmallrest", "GB_restaursmll09");
	SetDynamicObjectMaterial(autosalonm[102], 1, 18029, "genintintsmallrest", "GB_restaursmll09");
	SetDynamicObjectMaterial(autosalonm[103], 0, -1, "none", "none", 0xFF5800E4);
	SetDynamicObjectMaterial(autosalonm[104], 0, -1, "none", "none", 0xFF5800E4);
	SetDynamicObjectMaterial(autosalonm[105], 0, -1, "none", "none", 0xFF5800E4);
	SetDynamicObjectMaterial(autosalonm[106], 0, -1, "none", "none", 0xFF5800E4);
	SetDynamicObjectMaterial(autosalonm[107], 0, -1, "none", "none", 0xFF5800E4);
	SetDynamicObjectMaterial(autosalonm[108], 0, -1, "none", "none", 0xFF5800E4);
	SetDynamicObjectMaterial(autosalonm[109], 0, -1, "none", "none", 0xFF5800E4);
	SetDynamicObjectMaterial(autosalonm[110], 0, -1, "none", "none", 0xFF5800E4);

	new autosalondio[36];
	autosalondio[0] = lawless_CDE(18762, 1734.50366, -1749.54565, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[1] = lawless_CDE(18762, 1729.56787, -1749.55762, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[2] = lawless_CDE(18762, 1724.61938, -1749.54602, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[3] = lawless_CDE(18762, 1719.65039, -1749.54712, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[4] = lawless_CDE(18762, 1714.68286, -1749.54272, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[5] = lawless_CDE(18762, 1708.23682, -1749.55017, 20.36028,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[6] = lawless_CDE(18762, 1709.77722, -1749.54858, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[7] = lawless_CDE(18980, 1706.19043, -1761.63660, 20.35394,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalondio[8] = lawless_CDE(18980, 1706.19275, -1785.26929, 20.35394,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalondio[9] = lawless_CDE(18762, 1709.11572, -1797.27856, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[10] = lawless_CDE(18762, 1714.03845, -1797.29700, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[11] = lawless_CDE(18762, 1716.01978, -1794.46118, 20.35942,   0.00000, 90.00000, 90.17999, 300.0, 300.0);
	autosalondio[12] = lawless_CDE(18762, 1715.99792, -1789.90027, 20.37908,   0.00000, 90.00000, 90.17999, 300.0, 300.0);
	autosalondio[13] = lawless_CDE(18762, 1718.97400, -1787.91248, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[14] = lawless_CDE(18762, 1723.92407, -1787.92371, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[15] = lawless_CDE(18762, 1728.89111, -1787.93799, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[16] = lawless_CDE(18762, 1733.81445, -1787.93140, 20.35942,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[17] = lawless_CDE(18762, 1735.25525, -1787.93762, 20.36018,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio[18] = lawless_CDE(18980, 1737.29797, -1775.03503, 20.35394,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalondio[19] = lawless_CDE(18980, 1737.32800, -1761.51233, 20.37370,   0.00000, 90.00000, 90.00000, 300.0, 300.0);
	autosalondio[20] = lawless_CDE(18980, 1737.30945, -1749.56519, 8.29161,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	autosalondio[21] = lawless_CDE(18980, 1729.94958, -1749.62732, 8.29161,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	autosalondio[22] = lawless_CDE(18980, 1722.42798, -1749.68469, 8.29161,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	autosalondio[23] = lawless_CDE(18980, 1713.14575, -1749.64453, 8.29161,   0.00000, 0.00000, 90.00000, 300.0, 300.0);
	autosalondio[24] = lawless_CDE(18762, 1704.99707, -1749.58325, 18.02769,   0.00000, 30.00000, 0.00000, 300.0, 300.0);
	autosalondio[25] = lawless_CDE(18762, 1705.00647, -1749.60522, 14.17841,   0.00000, 30.00000, 180.06004, 300.0, 300.0);
	autosalondio[26] = lawless_CDE(18762, 1705.28882, -1797.27747, 18.02769,   0.00000, 30.00000, 0.00000, 300.0, 300.0);
	autosalondio[27] = lawless_CDE(18762, 1705.26550, -1797.31213, 14.17841,   0.00000, 30.00000, 180.06004, 300.0, 300.0);
	autosalondio[28] = lawless_CDE(18762, 1716.12537, -1797.28552, 18.35126,   0.00000, 0.00000, 180.06000, 300.0, 300.0);
	autosalondio[29] = lawless_CDE(18762, 1716.13086, -1797.30469, 14.17840,   0.00000, 0.00000, 180.06000, 300.0, 300.0);
	autosalondio[30] = lawless_CDE(18762, 1716.19971, -1787.96130, 18.32526,   0.00000, 0.00000, 180.06000, 300.0, 300.0);
	autosalondio[31] = lawless_CDE(18762, 1716.20630, -1787.98022, 14.17840,   0.00000, 0.00000, 180.06000, 300.0, 300.0);
	autosalondio[32] = lawless_CDE(18762, 1737.29919, -1787.96643, 18.19427,   0.00000, 0.00000, 180.06000, 300.0, 300.0);
	autosalondio[33] = lawless_CDE(18762, 1737.31421, -1787.97961, 14.17840,   0.00000, 0.00000, 180.06000, 300.0, 300.0);
	autosalondio[34] = lawless_CDE(18762, 1705.27185, -1796.81714, 18.02769,   0.00000, 30.00000, 0.00000, 300.0, 300.0);
	autosalondio[35] = lawless_CDE(18762, 1705.00781, -1749.86304, 18.02769,   0.00000, 30.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(autosalondio); i++)
	{
		SetDynamicObjectMaterial(autosalondio[i], 0, 4830, "airport2", "LASLACMA96", 0xFFFFFFFF);
	}

	new autosalondio2[30];
	autosalondio2[0] = lawless_CDE(19442, 1706.81506, -1749.32397, 18.63814,   30.00000, 0.00000, 90.18000, 300.0, 300.0);
	autosalondio2[1] = lawless_CDE(19442, 1705.67554, -1749.35547, 16.66480,   30.00000, 0.00000, 90.18000, 300.0, 300.0);
	autosalondio2[2] = lawless_CDE(19442, 1706.06592, -1749.35547, 13.60149,   30.00000, 0.00000, 269.45990, 300.0, 300.0);
	autosalondio2[3] = lawless_CDE(19442, 1703.99377, -1751.07202, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[4] = lawless_CDE(19442, 1703.99951, -1754.55566, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[5] = lawless_CDE(19442, 1703.99194, -1758.02124, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[6] = lawless_CDE(19442, 1704.00537, -1761.50476, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[7] = lawless_CDE(19442, 1704.01917, -1764.98718, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[8] = lawless_CDE(19442, 1704.02075, -1768.44861, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[9] = lawless_CDE(19442, 1704.29346, -1771.69543, 16.76691,   0.00000, 90.00000, -90.17999, 300.0, 300.0);
	autosalondio2[10] = lawless_CDE(19442, 1705.08948, -1771.68701, 16.75189,   0.00000, 90.00000, -90.17999, 300.0, 300.0);
	autosalondio2[11] = lawless_CDE(19442, 1704.14136, -1774.90125, 16.00692,   90.00000, 0.00000, 0.90000, 300.0, 300.0);
	autosalondio2[12] = lawless_CDE(19442, 1704.15247, -1774.92725, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[13] = lawless_CDE(19442, 1704.17297, -1778.36951, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[14] = lawless_CDE(19442, 1704.18628, -1781.81201, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[15] = lawless_CDE(19442, 1704.20032, -1785.29773, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[16] = lawless_CDE(19442, 1704.19202, -1788.77856, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[17] = lawless_CDE(19442, 1704.20337, -1792.24646, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[18] = lawless_CDE(19442, 1704.21326, -1795.70898, 16.00692,   90.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio2[19] = lawless_CDE(19442, 1706.74573, -1797.51465, 18.80611,   30.00000, 0.00000, 90.18000, 300.0, 300.0);
	autosalondio2[20] = lawless_CDE(19442, 1705.50537, -1797.49890, 16.66480,   30.00000, 0.00000, 90.18000, 300.0, 300.0);
	autosalondio2[21] = lawless_CDE(19442, 1706.09521, -1797.51135, 13.95591,   30.00000, 0.00000, 271.13992, 300.0, 300.0);
	autosalondio2[22] = lawless_CDE(19442, 1707.76855, -1797.49451, 11.10492,   30.00000, 0.00000, 271.13992, 300.0, 300.0);
	autosalondio2[23] = lawless_CDE(19369, 1714.33862, -1797.48303, 19.08119,   0.00000, 0.00000, -90.05999, 300.0, 300.0);
	autosalondio2[24] = lawless_CDE(19369, 1714.33862, -1797.48303, 15.58226,   0.00000, 0.00000, -90.05999, 300.0, 300.0);
	autosalondio2[25] = lawless_CDE(19369, 1714.33862, -1797.48303, 12.08295,   0.00000, 0.00000, -90.05999, 300.0, 300.0);
	autosalondio2[26] = lawless_CDE(19442, 1705.01611, -1775.45618, 13.75130,   0.00000, 31.00000, 180.00000, 300.0, 300.0);
	autosalondio2[27] = lawless_CDE(19442, 1705.02429, -1773.95325, 13.75130,   0.00000, 31.00000, 180.00000, 300.0, 300.0);
	autosalondio2[28] = lawless_CDE(19442, 1704.90564, -1769.40295, 13.75130,   0.00000, 31.00000, 180.00000, 300.0, 300.0);
	autosalondio2[29] = lawless_CDE(19442, 1704.91467, -1767.82263, 13.75130,   0.00000, 31.00000, 180.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(autosalondio2); i++)
	{
		SetDynamicObjectMaterial(autosalondio2[i], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	}

	new autosalondio3[30];
	autosalondio3[0] = lawless_CDE(18981, 1725.23743, -1749.60156, 0.00184,   0.00000, 0.00000, 90.00001, 300.0, 300.0);
	autosalondio3[1] = lawless_CDE(18981, 1718.97217, -1749.60718, 0.00103,   0.00000, 0.00000, 90.00001, 300.0, 300.0);
	autosalondio3[2] = lawless_CDE(19461, 1705.73706, -1754.18750, 10.87022,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio3[3] = lawless_CDE(19461, 1705.73828, -1763.81030, 10.87022,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio3[4] = lawless_CDE(19461, 1705.76758, -1764.64832, 10.89274,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio3[5] = lawless_CDE(19461, 1705.83203, -1779.52466, 10.87022,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio3[6] = lawless_CDE(19461, 1705.81873, -1789.10657, 10.87022,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio3[7] = lawless_CDE(19461, 1705.81934, -1792.75171, 10.85044,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio3[8] = lawless_CDE(18766, 1711.68140, -1797.31506, 9.95845,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio3[9] = lawless_CDE(18762, 1716.17896, -1794.35876, 11.98774,   0.00000, 90.00000, -89.99998, 300.0, 300.0);
	autosalondio3[10] = lawless_CDE(18762, 1716.17188, -1789.93762, 12.02703,   0.00000, 90.00000, -89.99998, 300.0, 300.0);
	autosalondio3[11] = lawless_CDE(18762, 1719.10681, -1787.94104, 11.98774,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio3[12] = lawless_CDE(18762, 1724.10681, -1787.92505, 11.98774,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio3[13] = lawless_CDE(18762, 1729.06470, -1787.92395, 11.98774,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio3[14] = lawless_CDE(18762, 1735.36829, -1787.91846, 11.98891,   0.00000, 90.00000, 0.00000, 300.0, 300.0);
	autosalondio3[15] = lawless_CDE(18762, 1737.32446, -1785.90137, 11.96824,   0.00000, 90.00000, -89.99998, 300.0, 300.0);
	autosalondio3[16] = lawless_CDE(18762, 1737.32739, -1781.51013, 12.02703,   0.00000, 90.00000, -89.99998, 300.0, 300.0);
	autosalondio3[17] = lawless_CDE(18762, 1737.33044, -1776.58875, 12.02703,   0.00000, 90.00000, -89.99998, 300.0, 300.0);
	autosalondio3[18] = lawless_CDE(18981, 1737.32617, -1761.63147, -0.01673,   0.00000, 0.00000, 0.00000, 300.0, 300.0);

	for(new i = 0; i < sizeof(autosalondio3); i++)
	{
		SetDynamicObjectMaterial(autosalondio3[i], 0, 10765, "airportgnd_sfse", "ws_whiteplaster_top", 0xFFFFFFFF);
	}

	new autosalondio4[22];
	autosalondio4[0] = lawless_CDE(19089, 1704.04248, -1756.02698, 15.28630,   0.00000, 31.00000, -180.95979, 300.0, 300.0);
	autosalondio4[1] = lawless_CDE(19089, 1704.04907, -1762.64758, 15.28630,   0.00000, 31.00000, -180.95979, 300.0, 300.0);
	autosalondio4[2] = lawless_CDE(19089, 1703.58289, -1770.18335, 16.79340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[3] = lawless_CDE(19089, 1705.81787, -1770.20410, 16.79340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[4] = lawless_CDE(19089, 1705.77429, -1773.21912, 16.79340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[5] = lawless_CDE(19089, 1703.57288, -1773.21570, 16.79340,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[6] = lawless_CDE(19089, 1704.16382, -1779.92505, 15.22750,   0.00000, 31.00000, -180.95979, 300.0, 300.0);
	autosalondio4[7] = lawless_CDE(19089, 1704.16174, -1784.45764, 15.22750,   0.00000, 31.00000, -180.95979, 300.0, 300.0);
	autosalondio4[8] = lawless_CDE(19089, 1704.15417, -1790.90833, 15.22750,   0.00000, 31.00000, -180.95979, 300.0, 300.0);
	autosalondio4[9] = lawless_CDE(19817, 1710.65869, -1790.21313, 10.89673,   0.00000, 0.00000, -153.12003, 300.0, 300.0);
	autosalondio4[10] = lawless_CDE(19817, 1717.75781, -1782.51550, 10.89000,   0.00000, 0.00000, -166.61993, 300.0, 300.0);
	autosalondio4[11] = lawless_CDE(19817, 1710.03943, -1760.72156, 11.12770,   330.00000, 0.00000, -153.17996, 300.0, 300.0);
	autosalondio4[12] = lawless_CDE(19369, 1732.72974, -1773.61304, 12.52240,   0.00000, 70.00000, -137.03999, 300.0, 300.0);
	autosalondio4[13] = lawless_CDE(19369, 1730.27197, -1775.90564, 13.11424,   0.00000, 90.00000, -137.03999, 300.0, 300.0);
	autosalondio4[14] = lawless_CDE(19369, 1727.73145, -1778.29492, 13.11424,   0.00000, 90.00000, -137.03999, 300.0, 300.0);
	autosalondio4[15] = lawless_CDE(19369, 1725.27625, -1780.60156, 12.52240,   0.00000, 70.00000, 43.20001, 300.0, 300.0);
	autosalondio4[16] = lawless_CDE(19089, 1722.45056, -1750.45557, 16.33305,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[17] = lawless_CDE(19089, 1723.42200, -1757.00342, 16.33305,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[18] = lawless_CDE(19089, 1726.80396, -1762.66577, 16.33305,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[19] = lawless_CDE(19089, 1729.98840, -1765.26538, 16.33305,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[20] = lawless_CDE(19089, 1736.37610, -1767.03943, 16.33305,   0.00000, 0.00000, 0.00000, 300.0, 300.0);
	autosalondio4[21] = lawless_CDE(19089, 1704.16797, -1790.86572, 15.22750,   0.00000, 31.00000, -180.95979, 300.0, 300.0);

	for(new i = 0; i < sizeof(autosalondio4); i++)
	{
		SetDynamicObjectMaterial(autosalondio4[i], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	}

	lawless_CDE(18981, 1978.54626, -1293.62817, 22.48381,   0.00000, 90.00000, 0.00000,300.000,300.000);
	lawless_CDE(18981, 1978.52710, -1282.94934, 22.47947,   0.00000, 90.00000, 0.00000,300.000,300.000);
	lawless_CDE(19461, 2039.70752, -1325.44751, 21.20973,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19461, 2039.70618, -1315.81921, 21.20792,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19461, 2039.71423, -1306.20886, 21.20792,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19461, 2039.71777, -1296.58337, 21.20792,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19461, 2039.71960, -1286.95789, 21.22356,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19461, 2039.71887, -1277.38098, 21.24124,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19461, 2039.72107, -1276.28027, 21.24780,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(715, 2053.92285, -1327.64319, 31.06108,   0.00000, 0.00000, 2.94000,300.000,300.000);
	lawless_CDE(715, 2054.24170, -1275.27429, 31.06108,   0.00000, 0.00000, 2.94000,300.000,300.000);
	lawless_CDE(673, 2042.15918, -1326.84351, 20.27834,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(673, 2042.46887, -1275.35046, 20.27834,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(673, 2030.39417, -1323.61646, 22.53943,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(673, 2030.70764, -1304.60718, 22.53943,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(673, 2030.46741, -1291.61157, 22.53943,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(715, 2030.79028, -1277.10486, 31.06108,   0.00000, 0.00000, 28.26000,300.000,300.000);
	lawless_CDE(673, 2019.11646, -1278.20398, 22.53943,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(673, 2006.53027, -1278.51501, 21.49320,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(669, 1970.70825, -1327.11792, 22.97819,   0.00000, 0.00000, -207.60001,300.000,300.000);
	lawless_CDE(638, 1987.76917, -1320.28076, 23.67287,   0.00000, 0.00000, -51.00000,300.000,300.000);
	lawless_CDE(638, 1995.52087, -1309.35352, 23.67287,   0.00000, 0.00000, -22.86000,300.000,300.000);
	lawless_CDE(647, 1976.92053, -1323.85583, 22.95449,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(647, 2031.77600, -1322.00903, 22.95449,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(647, 2029.33167, -1306.04956, 22.95449,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(647, 2032.54163, -1291.43152, 22.95449,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(647, 2029.06738, -1280.72302, 22.95449,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(647, 2019.51807, -1279.79150, 22.95449,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(647, 2005.54846, -1276.05530, 22.95449,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(750, 2030.32690, -1314.66138, 23.09711,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(832, 2011.37024, -1278.44897, 24.51406,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(750, 2013.60242, -1280.35059, 22.33146,   0.00000, 30.00000, 137.81999,300.000,300.000);
	lawless_CDE(869, 2004.41858, -1281.34998, 23.41037,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(869, 2016.61462, -1274.78857, 23.41037,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(869, 2026.90491, -1274.54150, 23.41037,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(869, 2023.63391, -1282.35120, 23.41037,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(869, 2030.84070, -1286.70959, 23.41037,   0.00000, 0.00000, 30.36000,300.000,300.000);
	lawless_CDE(869, 2032.56165, -1302.33997, 23.41037,   0.00000, 0.00000, 30.36000,300.000,300.000);
	lawless_CDE(869, 2030.56519, -1310.40808, 23.41037,   0.00000, 0.00000, 0.84000,300.000,300.000);
	lawless_CDE(869, 2028.56445, -1319.13745, 23.41037,   0.00000, 0.00000, 32.16000,300.000,300.000);
	lawless_CDE(870, 2033.34631, -1317.97498, 23.11898,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(870, 2027.71704, -1304.09180, 23.11898,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(870, 2012.62610, -1282.99036, 23.11898,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(870, 2004.21338, -1273.78223, 23.11898,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(869, 2047.53369, -1327.08386, 23.41037,   0.00000, 0.00000, 0.84000,300.000,300.000);
	lawless_CDE(869, 2047.21021, -1275.34973, 23.41037,   0.00000, 0.00000, 0.84000,300.000,300.000);
	lawless_CDE(750, 2042.05981, -1301.18262, 23.09711,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(870, 2041.58191, -1305.51001, 23.11898,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(870, 2041.79785, -1296.05139, 23.11898,   0.00000, 0.00000, 36.48000,300.000,300.000);
	lawless_CDE(869, 1980.71973, -1327.47632, 23.41037,   0.00000, 0.00000, 0.84000,300.000,300.000);
	lawless_CDE(870, 2029.11279, -1324.97009, 23.11898,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(948, 1989.27856, -1319.28931, 23.01326,   0.00000, 0.00000, -53.58001,300.000,300.000);
	lawless_CDE(948, 1995.07019, -1311.10583, 23.01326,   0.00000, 0.00000, -27.36000,300.000,300.000);
	lawless_CDE(1258, 2036.08667, -1327.22729, 23.53632,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(1258, 2035.88477, -1296.40747, 23.53632,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(1480, 2027.88501, -1309.23694, 22.96068,   0.00000, 0.00000, 20.22000,300.000,300.000);
	lawless_CDE(1480, 2027.88501, -1309.23694, 24.70915,   0.00000, 0.00000, 20.22000,300.000,300.000);
	lawless_CDE(1568, 2040.08826, -1331.63550, 22.97732,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(1568, 2035.93689, -1331.59546, 22.97732,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(1568, 2040.08459, -1270.22266, 22.97732,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(1568, 2035.67908, -1270.15259, 22.97732,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(2942, 1985.47363, -1321.02478, 23.61330,   0.00000, 0.00000, 14.16000,300.000,300.000);
	lawless_CDE(3472, 2012.60327, -1329.42456, 22.96970,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(9833, 2048.69727, -1296.08984, 22.56220,   0.00000, 30.00000, -96.47998,300.000,300.000);
	lawless_CDE(9833, 2048.64844, -1307.04810, 22.56220,   0.00000, 30.00000, 79.20002,300.000,300.000);
	lawless_CDE(19121, 2012.45154, -1322.23718, 22.98099,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19425, 2022.93481, -1331.00256, 22.98142,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19425, 2019.65540, -1331.01917, 22.98142,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19425, 2016.35510, -1330.99719, 22.98142,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19425, 2002.19287, -1331.08203, 22.98142,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19425, 2005.49414, -1331.09009, 22.98142,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19425, 2008.77527, -1331.07825, 22.98142,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(970, 2012.56042, -1325.27185, 23.51243,   0.00000, 0.00000, 89.75999,300.000,300.000);
	lawless_CDE(970, 2012.59497, -1319.03101, 23.51243,   0.00000, 0.00000, 89.75999,300.000,300.000);
	lawless_CDE(3472, 2012.49756, -1314.87097, 22.96970,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(970, 2012.50500, -1310.94080, 23.51243,   0.00000, 0.00000, 89.75999,300.000,300.000);
	lawless_CDE(19121, 2012.37000, -1307.43713, 22.98099,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(970, 2012.53381, -1304.06262, 23.51243,   0.00000, 0.00000, 89.75999,300.000,300.000);
	lawless_CDE(3472, 2012.61682, -1299.57214, 22.96970,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(3337, 2012.54846, -1331.02844, 22.12544,   0.00000, 0.00000, -89.45998,300.000,300.000);
	lawless_CDE(19121, 2010.89197, -1331.19214, 22.98099,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19121, 2014.17944, -1331.13123, 22.98099,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(869, 1972.95667, -1324.18665, 23.41037,   0.00000, 0.00000, 0.84000,300.000,300.000);
	lawless_CDE(1232, 1983.96509, -1331.76367, 25.60878,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(1232, 2000.05457, -1331.71643, 25.60878,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(1232, 1999.90906, -1270.01965, 25.60878,   0.00000, 0.00000, 0.00000,300.000,300.000);
	lawless_CDE(19461, 2030.43335, -1326.82886, 21.46991,   0.00000, 0.00000, -89.82000,300.000,300.000);
	lawless_CDE(19461, 2030.67346, -1326.82556, 21.46961,   0.00000, 0.00000, -89.82000,300.000,300.000);
	lawless_CDE(19461, 2030.55713, -1299.55969, 21.46991,   0.00000, 0.00000, -89.82000,300.000,300.000);
	lawless_CDE(19461, 2030.53528, -1296.01978, 21.46991,   0.00000, 0.00000, -89.82000,300.000,300.000);
	lawless_CDE(1251, 2023.01501, -1323.77527, 22.97037,   0.00000, 0.00000, -49.74001,300.000,300.000);
	lawless_CDE(1251, 2023.03943, -1319.70813, 22.97037,   0.00000, 0.00000, -49.74001,300.000,300.000);
	lawless_CDE(1251, 2023.07935, -1315.61194, 22.97037,   0.00000, 0.00000, -49.74001,300.000,300.000);
	lawless_CDE(1251, 2023.12427, -1311.81421, 22.97037,   0.00000, 0.00000, -49.74001,300.000,300.000);
	lawless_CDE(1251, 2023.12292, -1307.88477, 22.97037,   0.00000, 0.00000, -49.74001,300.000,300.000);
	lawless_CDE(1251, 2023.11304, -1304.01306, 22.97037,   0.00000, 0.00000, -49.74001,300.000,300.000);
	lawless_CDE(1251, 2022.55701, -1288.44019, 22.97037,   0.00000, 0.00000, -49.74001,300.000,300.000);
	lawless_CDE(1251, 2022.98315, -1292.11060, 22.97037,   0.00000, 0.00000, -49.74001,300.000,300.000);
	lawless_CDE(1251, 2002.81067, -1323.58704, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);
	lawless_CDE(1251, 2002.90137, -1319.48657, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);
	lawless_CDE(1251, 2002.83923, -1315.05615, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);
	lawless_CDE(1251, 2002.81409, -1311.07520, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);
	lawless_CDE(1251, 2002.90747, -1307.04053, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);
	lawless_CDE(1251, 2002.86279, -1302.77209, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);
	lawless_CDE(1251, 2002.87512, -1298.60620, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);
	lawless_CDE(1251, 2002.83411, -1294.49072, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);
	lawless_CDE(1251, 2002.91992, -1290.37158, 22.97037,   0.00000, 0.00000, -137.27989,300.000,300.000);

	new bankadajmond[145];
	bankadajmond[1] = lawless_CDE(18981, 2032.12195, -1332.85986, 22.22358,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[2] = lawless_CDE(18981, 2054.40649, -1334.63257, 22.27373,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[3] = lawless_CDE(18981, 2032.11365, -1308.00708, 22.22358,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[4] = lawless_CDE(18981, 2032.16296, -1283.04163, 22.22358,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[5] = lawless_CDE(18981, 2053.47729, -1267.28589, 22.23734,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[6] = lawless_CDE(18981, 2065.83008, -1282.63428, 22.27373,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[7] = lawless_CDE(18981, 2065.85864, -1294.10559, 22.29360,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[8] = lawless_CDE(18981, 2065.86084, -1319.02673, 22.29360,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[9] = lawless_CDE(18762, 2047.14380, -1279.31348, 22.67232,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[10] = lawless_CDE(18762, 2050.87427, -1279.30762, 22.67290,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[11] = lawless_CDE(18980, 2053.76807, -1291.29602, 22.67945,   0.00000, 90.00000, 90.05998,300.000,300.000);
	bankadajmond[12] = lawless_CDE(18980, 2053.77393, -1310.61877, 22.67243,   0.00000, 90.00000, 90.05998,300.000,300.000);
	bankadajmond[13] = lawless_CDE(18762, 2050.82642, -1322.62488, 22.68126,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[14] = lawless_CDE(18762, 2047.07031, -1322.62366, 22.67232,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[15] = lawless_CDE(18980, 2044.19934, -1310.63574, 22.67243,   0.00000, 90.00000, 90.05998,300.000,300.000);
	bankadajmond[16] = lawless_CDE(18980, 2044.19946, -1291.29749, 22.67945,   0.00000, 90.00000, 90.05998,300.000,300.000);
	bankadajmond[17] = lawless_CDE(19538, 2068.18555, -1300.51978, 22.19634,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[18] = lawless_CDE(10444, 2049.80176, -1307.34351, 22.57936,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[19] = lawless_CDE(10444, 2050.58984, -1277.02502, 22.57936,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[20] = lawless_CDE(19377, 2030.74548, -1322.06616, 22.86667,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[21] = lawless_CDE(19377, 2030.92603, -1316.60071, 22.87888,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[22] = lawless_CDE(19377, 2030.93689, -1306.98816, 22.88437,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[23] = lawless_CDE(19377, 2030.93213, -1297.37170, 22.89150,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[24] = lawless_CDE(19377, 2030.92078, -1287.74683, 22.89607,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[25] = lawless_CDE(19377, 2030.93079, -1278.13770, 22.90153,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[26] = lawless_CDE(19377, 2030.92590, -1275.81104, 22.88661,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[27] = lawless_CDE(19377, 2020.45972, -1281.05994, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[28] = lawless_CDE(19377, 2020.42419, -1276.03638, 22.90596,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[29] = lawless_CDE(19377, 2009.92969, -1276.03845, 22.90596,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[30] = lawless_CDE(19377, 2009.97949, -1281.04089, 22.93665,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[31] = lawless_CDE(19377, 2005.21411, -1281.02661, 22.93872,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[32] = lawless_CDE(19377, 2004.55273, -1276.03589, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[33] = lawless_CDE(18981, 2012.39075, -1318.42944, 22.49116,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[34] = lawless_CDE(18981, 2012.42261, -1293.47400, 22.49116,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[35] = lawless_CDE(18981, 1978.55737, -1318.49365, 22.48381,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[36] = lawless_CDE(19461, 2021.72925, -1328.62292, 22.87045,   0.00000, 90.00000, 90.30000,300.000,300.000);
	bankadajmond[37] = lawless_CDE(19461, 2031.32385, -1328.58203, 22.87045,   0.00000, 90.00000, 90.30000,300.000,300.000);
	bankadajmond[38] = lawless_CDE(19461, 2037.89709, -1326.18652, 22.87045,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[39] = lawless_CDE(19461, 2037.90112, -1316.58398, 22.87045,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[40] = lawless_CDE(19461, 2037.91980, -1306.96130, 22.87045,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[41] = lawless_CDE(19461, 2037.91589, -1297.34778, 22.87045,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[42] = lawless_CDE(19461, 2029.68726, -1297.78601, 22.91407,   0.00000, 90.00000, 90.30000,300.000,300.000);
	bankadajmond[43] = lawless_CDE(19461, 2031.42102, -1297.81226, 22.89742,   0.00000, 90.00000, 90.30000,300.000,300.000);
	bankadajmond[44] = lawless_CDE(19461, 2037.92456, -1287.72131, 22.87045,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[45] = lawless_CDE(19461, 2037.91089, -1275.52332, 22.88011,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[46] = lawless_CDE(19461, 2037.91589, -1278.12390, 22.87045,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[47] = lawless_CDE(19377, 1994.50671, -1275.33691, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[48] = lawless_CDE(19377, 1995.07385, -1284.93579, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[49] = lawless_CDE(19377, 1995.07837, -1294.50659, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[50] = lawless_CDE(19377, 1995.11609, -1304.11365, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[51] = lawless_CDE(19377, 1995.11511, -1313.68298, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[52] = lawless_CDE(19377, 1995.11841, -1323.29443, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[53] = lawless_CDE(19377, 1995.12915, -1326.47156, 22.92729,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[54] = lawless_CDE(19377, 1989.45410, -1326.44885, 22.91755,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[55] = lawless_CDE(19377, 1989.45471, -1316.88000, 22.92729,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[56] = lawless_CDE(18762, 1966.55225, -1321.09619, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[57] = lawless_CDE(18980, 1966.59229, -1318.77173, 23.21157,   0.00000, 90.00000, -90.29999,300.000,300.000);
	bankadajmond[58] = lawless_CDE(18762, 1966.58118, -1330.77686, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[59] = lawless_CDE(18766, 1971.90674, -1330.75366, 21.21368,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[60] = lawless_CDE(18766, 1979.43640, -1330.76917, 21.24243,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[61] = lawless_CDE(18762, 1983.96936, -1330.79553, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[62] = lawless_CDE(18980, 1984.02466, -1317.99817, 22.70482,   0.00000, 90.00000, -90.41999,300.000,300.000);
	bankadajmond[63] = lawless_CDE(18762, 2000.07800, -1330.82471, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[64] = lawless_CDE(18980, 2000.03564, -1318.83606, 22.54753,   0.00000, 90.00000, -89.93999,300.000,300.000);
	bankadajmond[65] = lawless_CDE(18980, 2000.03479, -1298.46680, 22.52770,   0.00000, 90.00000, -89.93999,300.000,300.000);
	bankadajmond[66] = lawless_CDE(18762, 1999.62891, -1285.96863, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[67] = lawless_CDE(18762, 1999.72253, -1278.96875, 22.70287,   0.00000, 90.00000, -90.42000,300.000,300.000);
	bankadajmond[68] = lawless_CDE(18762, 1999.66809, -1283.94775, 22.70287,   0.00000, 90.00000, -90.42000,300.000,300.000);
	bankadajmond[69] = lawless_CDE(18762, 1999.74451, -1273.99023, 22.70287,   0.00000, 90.00000, -90.42000,300.000,300.000);
	bankadajmond[70] = lawless_CDE(18762, 1999.75562, -1271.00037, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[71] = lawless_CDE(18980, 2012.49182, -1285.93518, 22.70482,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[72] = lawless_CDE(18762, 2025.42017, -1293.61902, 22.70490,   0.00000, 90.00000, 89.75999,300.000,300.000);
	bankadajmond[73] = lawless_CDE(18762, 2025.44800, -1287.93433, 22.72473,   0.00000, 90.00000, 89.75999,300.000,300.000);
	bankadajmond[74] = lawless_CDE(18762, 2025.35791, -1302.01575, 22.70490,   0.00000, 90.00000, 89.75999,300.000,300.000);
	bankadajmond[75] = lawless_CDE(18980, 2025.24695, -1314.45691, 22.69940,   0.00000, 90.00000, -90.41999,300.000,300.000);
	bankadajmond[76] = lawless_CDE(18762, 2025.09119, -1330.74609, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[77] = lawless_CDE(18766, 2030.52258, -1330.73535, 20.71674,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[78] = lawless_CDE(18762, 2035.99231, -1330.77222, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[79] = lawless_CDE(18980, 2035.90369, -1314.36584, 22.71927,   0.00000, 90.00000, -89.70000,300.000,300.000);
	bankadajmond[80] = lawless_CDE(18980, 2035.89026, -1311.97693, 22.69940,   0.00000, 90.00000, -89.70000,300.000,300.000);
	bankadajmond[81] = lawless_CDE(18980, 2035.74255, -1283.57385, 22.69940,   0.00000, 90.00000, -89.70000,300.000,300.000);
	bankadajmond[82] = lawless_CDE(18762, 2040.10449, -1330.74866, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[83] = lawless_CDE(18766, 2045.33435, -1330.74951, 20.96498,   0.00000, 0.00000, -0.05999,300.000,300.000);
	bankadajmond[84] = lawless_CDE(18766, 2051.22144, -1330.75574, 20.97634,   0.00000, 0.00000, -0.05999,300.000,300.000);
	bankadajmond[85] = lawless_CDE(18762, 2056.67676, -1330.74609, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[86] = lawless_CDE(18766, 2056.69409, -1321.69409, 20.99396,   0.00000, 0.00000, -89.93999,300.000,300.000);
	bankadajmond[87] = lawless_CDE(18766, 2056.67090, -1325.31458, 20.97396,   0.00000, 0.00000, -89.93999,300.000,300.000);
	bankadajmond[88] = lawless_CDE(18762, 2056.67969, -1316.35522, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[89] = lawless_CDE(18762, 2056.70532, -1312.73743, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[90] = lawless_CDE(18766, 2056.69141, -1307.32324, 20.97396,   0.00000, 0.00000, -89.93999,300.000,300.000);
	bankadajmond[91] = lawless_CDE(18766, 2056.69189, -1297.35938, 20.97396,   0.00000, 0.00000, -89.93999,300.000,300.000);
	bankadajmond[92] = lawless_CDE(18766, 2056.68677, -1295.39819, 20.95396,   0.00000, 0.00000, -89.93999,300.000,300.000);
	bankadajmond[93] = lawless_CDE(18762, 2056.75610, -1290.11914, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[94] = lawless_CDE(18762, 2056.75317, -1286.42334, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[95] = lawless_CDE(18766, 2056.74609, -1280.94556, 20.97396,   0.00000, 0.00000, -89.93999,300.000,300.000);
	bankadajmond[96] = lawless_CDE(18766, 2056.73169, -1276.36108, 20.95396,   0.00000, 0.00000, -89.93999,300.000,300.000);
	bankadajmond[97] = lawless_CDE(18762, 2056.75000, -1271.05884, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[98] = lawless_CDE(18766, 2051.31104, -1271.03979, 20.97396,   0.00000, 0.00000, -0.05999,300.000,300.000);
	bankadajmond[99] = lawless_CDE(18766, 2045.47974, -1271.03125, 20.97634,   0.00000, 0.00000, -0.05999,300.000,300.000);
	bankadajmond[100] = lawless_CDE(18762, 2040.11682, -1271.03735, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[101] = lawless_CDE(18762, 2035.65967, -1270.97461, 23.40238,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[102] = lawless_CDE(18980, 2023.61279, -1271.01904, 22.97424,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[103] = lawless_CDE(18980, 2012.68835, -1271.01563, 22.97760,   0.00000, 90.00000, 0.00000,300.000,300.000);
	bankadajmond[104] = lawless_CDE(18766, 2040.94641, -1331.12830, 20.47370,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[143] = lawless_CDE(18762, 2025.44458, -1288.63916, 22.70490,   0.00000, 90.00000, 89.75999,300.000,300.000);
	bankadajmond[105] = lawless_CDE(19325, 2003.46191, -1270.75806, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[106] = lawless_CDE(19325, 2010.08411, -1270.78406, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[107] = lawless_CDE(19325, 2016.62524, -1270.81714, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[108] = lawless_CDE(19325, 2023.22046, -1270.83008, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[109] = lawless_CDE(19325, 2029.69092, -1270.81409, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[110] = lawless_CDE(19325, 2032.37366, -1270.83667, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[111] = lawless_CDE(19325, 2043.77759, -1270.83887, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[112] = lawless_CDE(19325, 2050.17822, -1270.83691, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[113] = lawless_CDE(19325, 2053.63818, -1270.81909, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[114] = lawless_CDE(19325, 2056.88379, -1274.56836, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[115] = lawless_CDE(19325, 2056.92969, -1280.83569, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[116] = lawless_CDE(19325, 2056.96997, -1282.84058, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[117] = lawless_CDE(19325, 2056.93628, -1293.68762, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[118] = lawless_CDE(19325, 2056.98169, -1300.08105, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[119] = lawless_CDE(19325, 2057.05249, -1306.63806, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[120] = lawless_CDE(19325, 2057.07251, -1309.55872, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[121] = lawless_CDE(19325, 2056.94385, -1319.88550, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[122] = lawless_CDE(19325, 2056.97778, -1326.41650, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[123] = lawless_CDE(19325, 2056.99170, -1327.46643, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[124] = lawless_CDE(19325, 2053.68604, -1330.98816, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[125] = lawless_CDE(19325, 2047.36658, -1330.97668, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[126] = lawless_CDE(19325, 2043.50562, -1330.99280, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[127] = lawless_CDE(19325, 2032.33899, -1330.90857, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[128] = lawless_CDE(19325, 2028.32153, -1330.91711, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[129] = lawless_CDE(19325, 1980.52124, -1331.13708, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[130] = lawless_CDE(19325, 1973.91748, -1331.12891, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[131] = lawless_CDE(19325, 1969.97546, -1331.15393, 22.91508,   0.00000, 0.00000, 89.87998,300.000,300.000);
	bankadajmond[132] = lawless_CDE(19325, 1966.44031, -1327.48401, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[133] = lawless_CDE(19325, 1966.38586, -1321.42334, 22.91508,   0.00000, 0.00000, 0.29999,300.000,300.000);
	bankadajmond[134] = lawless_CDE(19588, 2048.19995, -1314.52820, 24.16817,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[135] = lawless_CDE(19588, 2048.28052, -1288.34583, 24.16817,   0.00000, 0.00000, 0.00000,300.000,300.000);
	bankadajmond[136] = lawless_CDE(18766, 1995.79297, -1317.95227, 29.43426,   0.00000, 0.00000, 48.84000,300.000,300.000);
	bankadajmond[137] = lawless_CDE(18766, 1997.01611, -1316.52490, 29.43426,   0.00000, 0.00000, 48.84000,300.000,300.000);
	bankadajmond[138] = lawless_CDE(18762, 1992.79236, -1321.46948, 29.46935,   0.00000, 0.00000, -40.74001,300.000,300.000);
	bankadajmond[139] = lawless_CDE(18762, 1994.08997, -1319.94568, 32.34879,   0.00000, 90.00000, 48.84002,300.000,300.000);
	bankadajmond[140] = lawless_CDE(18762, 1997.32971, -1316.20264, 32.34879,   0.00000, 90.00000, 48.84002,300.000,300.000);
	bankadajmond[141] = lawless_CDE(18762, 1998.83215, -1314.51392, 32.36385,   0.00000, 90.00000, 48.84002,300.000,300.000);
	bankadajmond[142] = lawless_CDE(18762, 2000.20081, -1313.02869, 29.46935,   0.00000, 0.00000, -41.82001,300.000,300.000);
	bankadajmond[144] = lawless_CDE(4005, 1982.68811, -1297.28735, 35.88696,   0.00000, 0.00000, 0.00000,300.000,300.000);

	SetDynamicObjectMaterial(bankadajmond[1], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[2], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[3], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[4], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[5], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[6], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[7], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[8], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[9], 0, 8565, "vgsebuild01", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[10], 0, 8565, "vgsebuild01", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[11], 0, 8565, "vgsebuild01", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[12], 0, 8565, "vgsebuild01", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[13], 0, 8565, "vgsebuild01", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[14], 0, 8565, "vgsebuild01", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[15], 0, 8565, "vgsebuild01", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[16], 0, 8565, "vgsebuild01", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[17], 0, 4600, "theatrelan2", "gm_labuld2_b", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[18], 0, 3947, "rczero_track", "waterclear256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[19], 0, 3947, "rczero_track", "waterclear256", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[20], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[21], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[22], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[23], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[24], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[25], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[26], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[27], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[28], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[29], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[30], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[31], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[32], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[33], 0, 6487, "councl_law2", "rodeo3sjm", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[34], 0, 6487, "councl_law2", "rodeo3sjm", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[35], 0, 8460, "vgseland03_lvs", "grassdry_128HV", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[36], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[37], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[38], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[39], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[40], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[41], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[42], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[43], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[44], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[45], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[46], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[47], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[48], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[49], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[50], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[51], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[52], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[53], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[54], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[55], 0, 15053, "vghotelnice", "AH_flroortile3");
	SetDynamicObjectMaterial(bankadajmond[56], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[57], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[58], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[59], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[60], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[61], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[62], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[63], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[64], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[65], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[66], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[67], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[68], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[69], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[70], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[71], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[72], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[73], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[74], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[75], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[76], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[77], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[78], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[79], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[80], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[81], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[82], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[83], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[84], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[85], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[86], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[87], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[88], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[89], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[90], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[91], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[92], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[93], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[94], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[95], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[96], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[97], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[98], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[99], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[100], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[101], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[102], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[103], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[104], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[143], 0, 5730, "melrose05_lawn", "brickred", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[105], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[106], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[107], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[108], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[109], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[110], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[111], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[112], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[113], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[114], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[115], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[116], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[117], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[118], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[119], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[120], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[121], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[122], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[123], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[124], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[125], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[126], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[127], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[128], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[129], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[130], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[131], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[132], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[133], 0, 13744, "docg01alfa_lahills", "Gen_Metal", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bankadajmond[134], 0, 18029, "genintintsmallrest", "GB_restaursmll09");
	SetDynamicObjectMaterial(bankadajmond[135], 0, 18029, "genintintsmallrest", "GB_restaursmll09");
	SetDynamicObjectMaterial(bankadajmond[136], 0, 2169, "cj_office", "white32", 0xFFE0E0E0);
	SetDynamicObjectMaterial(bankadajmond[137], 0, 2169, "cj_office", "white32", 0xFFE0E0E0);
	SetDynamicObjectMaterial(bankadajmond[138], 0, 2169, "cj_office", "white32", 0xFF727272);
	SetDynamicObjectMaterial(bankadajmond[139], 0, 2169, "cj_office", "white32", 0xFF727272);
	SetDynamicObjectMaterial(bankadajmond[140], 0, 2169, "cj_office", "white32", 0xFF727272);
	SetDynamicObjectMaterial(bankadajmond[141], 0, 2169, "cj_office", "white32", 0xFF727272);
	SetDynamicObjectMaterial(bankadajmond[142], 0, 2169, "cj_office", "white32", 0xFF727272);
	SetDynamicObjectMaterial(bankadajmond[144], 2, 14533, "pleas_dome", "ab_velvor");
	SetDynamicObjectMaterial(bankadajmond[144], 1, -1, "none", "none", 0xFF9FF5FF);
	SetDynamicObjectMaterial(bankadajmond[144], 4, 14847, "mp_policesf", "mp_cop_marble");
	SetDynamicObjectMaterial(bankadajmond[144], 0, 14847, "mp_policesf", "mp_cop_marble");
	SetDynamicObjectMaterial(bankadajmond[144], 3, -1, "none", "none", 0xFF9FF5FF);

	new Parking = CreateObject(19327, 2012.55566, -1331.17334, 25.18870,   0.00000, 0.00000, 0.00000);
	new bANK = CreateObject(4729, 1997.57495, -1316.68530, 28.87870,   0.00000, 0.00000, -21.19990);
	new D = CreateObject(19464, 1994.55701, -1319.96765, 29.85870,   0.00000, 0.00000, 138.89990);
	new aiamond = CreateObject(4729, 1997.7656, -1316.4661, 29.3987, 0.0000, 0.0000, -21.0999);

	SetObjectMaterialText(Parking, "PARKING", 0, 140, "Arial", 130, 1, -1, 0, 1);
	SetObjectMaterialText(bANK, "BANK", 0, 140, "Arial", 60, 1, -1, 0, 1);
	SetObjectMaterialText(D, "D", 0, 140, "Matura MT Script Capitals", 250, 1, -16730675, 0, 1);
	SetObjectMaterialText(aiamond, "iamond", 0, 140, "Matura MT Script Capitals", 75, 0, -16730675, 0, 1);

	/* 					MAP - BANKA DIAMOND - END 							  */

	/*                        	MAP - BOLNICA                                 */

	new bolnicabylevu;
	bolnicabylevu = lawless_CDO(3873, 1227.17896, -1309.57471, 23.23928,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 1, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 2, 9169, "vgslowbuild", "concpanel_la", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bolnicabylevu, 3, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	bolnicabylevu = lawless_CDO(8411, 1198.05188, -1309.43604, -30.70790,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 2, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 3, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 4, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 5, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 6, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 7, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	bolnicabylevu = lawless_CDO(3873, 1168.69177, -1309.57471, 23.23930,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 1, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	SetDynamicObjectMaterial(bolnicabylevu, 2, 9169, "vgslowbuild", "concpanel_la", 0xFFFFFFFF);
	SetDynamicObjectMaterial(bolnicabylevu, 3, 3979, "civic01_lan", "sl_laglasswall2", 0xFF1EB7D6);
	bolnicabylevu = lawless_CDO(3934, 1199.27197, -1308.74500, 34.27320,   0.00000, 0.00000, 0.00000);
	bolnicabylevu = lawless_CDO(18980, 1210.88892, -1321.77747, 33.78330,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 9169, "vgslowbuild", "concpanel_la", 0xFFFFFFFF);
	bolnicabylevu = lawless_CDO(18980, 1185.91211, -1321.77747, 33.78330,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 9169, "vgslowbuild", "concpanel_la", 0xFFFFFFFF);
	bolnicabylevu = lawless_CDO(18980, 1185.91211, -1321.77747, 22.84581,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 9169, "vgslowbuild", "concpanel_la", 0xFFFFFFFF);
	bolnicabylevu = lawless_CDO(18980, 1210.88892, -1321.77747, 22.84580,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 9169, "vgslowbuild", "concpanel_la", 0xFFFFFFFF);
	bolnicabylevu = lawless_CDO(18980, 1210.88892, -1321.77747, 12.17620,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 9169, "vgslowbuild", "concpanel_la", 0xFFFFFFFF);
	bolnicabylevu = lawless_CDO(18980, 1185.91211, -1321.77747, 12.17620,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 9169, "vgslowbuild", "concpanel_la", 0xFFFFFFFF);
	bolnicabylevu = lawless_CDO(19454, 1198.89954, -1322.23804, 13.56800,   0.00000, 0.00000, 90.00000);//vrata
	SetDynamicObjectMaterial(bolnicabylevu, 0, 17533, "eastbeach7_lae2", "shopwindowlow2_256", 0);
	bolnicabylevu = lawless_CDO(18762, 1197.92871, -1321.85034, 28.19147,   0.00000, 0.00000, 0.00000);//krst
	SetDynamicObjectMaterial(bolnicabylevu, 0, 2361, "shopping_freezers", "white", 0xFFec1818);
	bolnicabylevu = lawless_CDO(18762, 1197.90405, -1321.84302, 28.22953,   0.00000, 90.00000, 0.00000);//krst
	SetDynamicObjectMaterial(bolnicabylevu, 0, 2361, "shopping_freezers", "white", 0xFFec1818);

	new bolnicabylevumermer[47];
	bolnicabylevumermer[0] = lawless_CDO(18981, 1217.95703, -1385.19104, 0.54400,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[1] = lawless_CDO(18981, 1233.62097, -1385.18994, 0.54400,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[2] = lawless_CDO(18981, 1245.64001, -1373.18201, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[3] = lawless_CDO(18981, 1245.64001, -1348.21106, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[4] = lawless_CDO(18981, 1245.64001, -1323.25000, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[5] = lawless_CDO(18981, 1245.64099, -1303.14600, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[6] = lawless_CDO(18981, 1233.63599, -1291.13000, 0.54400,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[7] = lawless_CDO(18981, 1208.75195, -1291.13000, 0.54400,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[8] = lawless_CDO(18981, 1183.79504, -1291.13000, 0.54400,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[9] = lawless_CDO(18981, 1162.13403, -1291.13403, 0.54400,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[10] = lawless_CDO(18981, 1150.12500, -1303.17297, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[11] = lawless_CDO(18981, 1150.12500, -1328.07898, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[12] = lawless_CDO(18981, 1150.12500, -1352.98901, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[13] = lawless_CDO(18981, 1150.12598, -1372.94604, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[14] = lawless_CDO(18981, 1183.03699, -1385.19104, 0.54400,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[15] = lawless_CDO(18981, 1162.13000, -1385.18994, 0.54400,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[16] = lawless_CDO(18766, 1200.50696, -1382.79297, 10.97400,   70.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[17] = lawless_CDO(18980, 1195.05603, -1385.18896, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[18] = lawless_CDO(18980, 1205.95605, -1385.19006, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[19] = lawless_CDO(18980, 1205.95618, -1384.28003, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[20] = lawless_CDO(18980, 1195.05615, -1384.28003, 0.54400,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[21] = lawless_CDO(18766, 1147.73206, -1323.22205, 12.21900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[22] = lawless_CDO(18766, 1147.73206, -1333.16895, 12.21900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[23] = lawless_CDO(18766, 1147.73206, -1343.09094, 12.21900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[24] = lawless_CDO(18766, 1164.82275, -1378.31958, 9.93070,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
 	bolnicabylevumermer[25] = lawless_CDO(18980, 1159.34668, -1378.31958, -0.06810,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[26] = lawless_CDO(18980, 1158.36755, -1378.31958, -0.06810,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[27] = lawless_CDO(18981, 1169.32495, -1366.31567, -0.06810,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[28] = lawless_CDO(18981, 1169.32495, -1341.32544, -0.06810,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[29] = lawless_CDO(18766, 1164.81970, -1329.32410, 9.93070,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[30] = lawless_CDO(18980, 1159.34717, -1329.32410, -0.06810,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[31] = lawless_CDO(18981, 1158.36060, -1366.31567, -0.06810,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[32] = lawless_CDO(18981, 1158.36060, -1341.32544, -0.06810,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[33] = lawless_CDO(18980, 1158.36780, -1329.32410, -0.06810,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[34] = lawless_CDO(18981, 1194.82263, -1367.70081, -0.47610,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[35] = lawless_CDO(18981, 1194.82263, -1392.67554, -0.47610,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[36] = lawless_CDO(18981, 1182.82166, -1355.69299, -0.47610,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[37] = lawless_CDO(18981, 1170.82031, -1343.68457, -0.47610,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[38] = lawless_CDO(18981, 1170.82031, -1318.71729, -0.47610,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[39] = lawless_CDO(18981, 1181.27393, -1318.67480, 0.16790,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[40] = lawless_CDO(18980, 1193.66174, -1330.65955, 0.16790,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[41] = lawless_CDO(18981, 1205.97266, -1318.66296, 0.16790,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[42] = lawless_CDO(18981, 1205.97266, -1343.65100, -0.47610,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[43] = lawless_CDO(18981, 1205.97266, -1368.63342, -0.47610,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[44] = lawless_CDO(18981, 1205.97266, -1393.60791, -0.47610,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[45] = lawless_CDO(18980, 1187.30042, -1330.65955, 0.16790,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevumermer[46] = lawless_CDO(18981, 1193.30176, -1318.65747, 11.41390,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);

	for(new i = 0; i < sizeof(bolnicabylevumermer); i++)
	{
		SetDynamicObjectMaterial(bolnicabylevumermer[i], 0, 3922, "bistro", "Marble2", 0);
	}

	bolnicabylevu = lawless_CDO(19325, 1190.83801, -1331.15173, 10.58340,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	bolnicabylevu = lawless_CDO(19325, 1184.09863, -1331.15173, 10.58340,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(bolnicabylevu, 0, 6487, "councl_law2", "lanlabra1_M", 0);

	new bolnicabylevurozecigle[17];
	bolnicabylevurozecigle[0] = lawless_CDO(19377, 1175.66968, -1350.48340, 11.81340,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[1] = lawless_CDO(19377, 1175.66968, -1340.85852, 11.81340,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[2] = lawless_CDO(19377, 1175.66968, -1331.23169, 11.81340,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[3] = lawless_CDO(19377, 1200.51990, -1321.60400, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[4] = lawless_CDO(19377, 1200.51990, -1331.23169, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[5] = lawless_CDO(19377, 1200.51990, -1379.33899, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[6] = lawless_CDO(19377, 1179.56763, -1340.85852, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[7] = lawless_CDO(19377, 1179.56763, -1331.23169, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[8] = lawless_CDO(19377, 1179.56763, -1321.64172, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[9] = lawless_CDO(19377, 1190.03235, -1350.48340, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[10] = lawless_CDO(19377, 1179.56763, -1350.48340, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[11] = lawless_CDO(19377, 1200.51990, -1369.71997, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[12] = lawless_CDO(19377, 1200.51990, -1360.10828, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[13] = lawless_CDO(19377, 1200.51990, -1350.48877, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[14] = lawless_CDO(19377, 1200.51990, -1340.85852, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[15] = lawless_CDO(19377, 1190.03235, -1340.85852, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	bolnicabylevurozecigle[16] = lawless_CDO(19377, 1190.03235, -1331.23169, 11.81360,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);

	for(new i = 0; i < sizeof(bolnicabylevurozecigle); i++)
	{
		SetDynamicObjectMaterial(bolnicabylevurozecigle[i], 0, 4007, "lanblokc", "sl_laoffblok2wall1");
	}

	lawless_CDO(19550, 1195.39905, -1332.19995, 11.86900,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19425, 1206.18396, -1385.07605, 12.21400,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19425, 1202.89502, -1385.07605, 12.21400,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19425, 1199.59802, -1385.07605, 12.21400,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19425, 1196.30005, -1385.07605, 12.21400,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19842, 1163.95581, -1341.34094, 12.05250,   0.00000, 0.00000, 0.00000);
	lawless_CDO(9047, 1226.62646, -1356.28503, 11.49540,   0.00000, 0.00000, 90.00000);
	lawless_CDO(8617, 1226.48657, -1356.44934, 12.54790,   0.00000, 0.00000, 90.00000);
	lawless_CDO(3515, 1226.60425, -1374.45471, 11.74781,   0.00000, 0.00000, 0.00000);
	lawless_CDO(3515, 1226.58228, -1356.68896, 11.74781,   0.00000, 0.00000, 0.00000);
	lawless_CDO(3515, 1226.58838, -1338.93274, 11.74781,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19842, 1163.95581, -1366.25244, 12.05248,   0.00000, 0.00000, 0.00000);
	lawless_CDO(673, 1185.50256, -1379.33508, 10.58570,   0.00000, 0.00000, 0.00000);
	lawless_CDO(673, 1185.50256, -1361.86023, 10.58570,   0.00000, 0.00000, 0.00000);
	lawless_CDO(837, 1185.76880, -1370.28259, 12.17150,   0.00000, 0.00000, 239.10001);
	lawless_CDO(867, 1184.77795, -1365.26636, 12.09439,   0.00000, 0.00000, 239.10001);
	lawless_CDO(867, 1184.80627, -1375.57947, 12.09439,   0.00000, 0.00000, 239.10001);
	lawless_CDO(14402, 1185.77454, -1366.09534, 11.96476,   0.00000, 0.00000, 0.00000);
	lawless_CDO(14402, 1185.34814, -1377.43542, 11.96476,   0.00000, 0.00000, 0.00000);
	lawless_CDO(8623, 1212.38513, -1341.77014, 12.55020,   0.00000, 0.00000, 90.00000);
	lawless_CDO(8623, 1212.12610, -1371.06348, 12.55020,   0.00000, 0.00000, 90.00000);
	lawless_CDO(746, 1212.49414, -1356.81543, 11.53370,   0.00000, 0.00000, 150.30000);

	/*                        	MAP - BOLNICA - END                           */

	/*                        	MAP - AUTO SALON                              */

    lawless_CDO(19325, 1540.72278, -1261.59766, 19.38235,   90.00000, 90.00000, -179.99998);
	lawless_CDO(19325, 1547.34949, -1261.57410, 15.55241,   90.00000, 90.00000, -179.99998);
	lawless_CDO(19325, 1546.08813, -1261.57861, 20.93502,   0.00000, 0.00000, -269.94000);
	lawless_CDO(19325, 1555.13489, -1258.51392, 19.38235,   90.00000, 90.00000, -89.82001);
	lawless_CDO(19325, 1557.42822, -1256.77319, 19.38235,   90.00000, 90.00000, -179.99998);
	lawless_CDO(19325, 1562.46399, -1256.83545, 19.38235,   90.00000, 90.00000, -179.99998);
	lawless_CDO(19325, 1567.44043, -1256.82678, 19.38235,   90.00000, 90.00000, -179.99998);
	lawless_CDO(19325, 1538.72021, -1258.69836, 19.38235,   90.00000, 90.00000, -89.82001);
	lawless_CDO(19325, 1538.69238, -1253.62085, 19.38235,   90.00000, 90.00000, -89.82001);
	lawless_CDO(19325, 1538.68372, -1248.60364, 19.38235,   90.00000, 90.00000, -89.82001);
	lawless_CDO(19325, 1538.63184, -1243.69775, 19.38235,   90.00000, 90.00000, -89.82001);
	lawless_CDO(19325, 1538.66467, -1239.42822, 19.38235,   90.00000, 90.00000, -89.82001);
	lawless_CDO(10575, 1570.53613, -1242.08337, 18.45860,   0.00000, 0.00000, -180.11993);
	lawless_CDO(638, 1540.65625, -1262.09692, 17.08395,   0.00000, 0.00000, -90.65998);
	lawless_CDO(638, 1547.67310, -1262.22937, 17.08395,   0.00000, 0.00000, -90.65998);
	lawless_CDO(870, 1547.83289, -1286.78333, 17.30558,   0.00000, 0.00000, -62.22001);
	lawless_CDO(870, 1561.67053, -1286.75000, 17.30558,   0.00000, 0.00000, -62.22001);
	lawless_CDO(870, 1556.94080, -1286.71936, 17.30558,   0.00000, 0.00000, -62.22001);
	lawless_CDO(870, 1552.96252, -1286.74548, 17.30558,   0.00000, 0.00000, -62.22001);
	lawless_CDO(948, 1542.41272, -1262.30676, 16.39772,   0.00000, 0.00000, 0.00000);
	lawless_CDO(948, 1545.93835, -1262.40637, 16.39772,   0.00000, 0.00000, 0.00000);
	lawless_CDO(970, 1579.20374, -1269.76941, 17.05222,   0.00000, 0.00000, -89.40001);
	lawless_CDO(970, 1579.27112, -1274.67944, 17.05222,   0.00000, 0.00000, -89.40001);
	lawless_CDO(970, 1579.29370, -1279.57166, 17.05222,   0.00000, 0.00000, -89.40001);
	lawless_CDO(970, 1579.32166, -1284.68591, 17.05222,   0.00000, 0.00000, -89.40001);
	lawless_CDO(1568, 1579.42273, -1287.50586, 16.49596,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1568, 1565.18555, -1287.34399, 16.49596,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1714, 1567.75867, -1255.31165, 16.53167,   0.00000, 0.00000, -180.36002);
	lawless_CDO(1721, 1568.35535, -1252.78735, 16.53194,   0.00000, 0.00000, -179.64003);
	lawless_CDO(2773, 1558.41199, -1244.52991, 17.04140,   0.00000, 0.00000, -89.28002);
	lawless_CDO(3472, 1555.32275, -1286.81104, 17.07033,   0.00000, 0.00000, 0.00000);
	lawless_CDO(716, 1542.93066, -1287.31860, 16.39937,   0.00000, 0.00000, 0.00000);
	lawless_CDO(716, 1530.37097, -1272.88953, 16.39937,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1568, 1540.14343, -1287.86829, 16.32204,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1568, 1529.67224, -1274.78149, 16.32204,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1215, 1579.32288, -1282.14941, 16.98344,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1215, 1579.28528, -1277.09937, 16.98344,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1215, 1579.31616, -1272.22742, 16.98344,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1215, 1579.27600, -1267.12305, 16.98344,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1215, 1570.40979, -1267.09253, 16.98344,   0.00000, 0.00000, 0.00000);
	lawless_CDO(948, 1548.73730, -1260.77283, 16.53408,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1671, 1557.71436, -1254.07495, 16.99988,   0.00000, 0.00000, -119.46001);
	lawless_CDO(1964, 1567.36108, -1254.00891, 17.47694,   0.00000, 0.00000, -179.75999);
	lawless_CDO(2030, 1553.12183, -1252.28674, 16.92988,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2118, 1562.06421, -1253.59033, 16.53554,   0.00000, 0.00000, -0.41999);
	lawless_CDO(2123, 1564.23364, -1253.63379, 17.10428,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2162, 1570.45752, -1253.37292, 16.53307,   0.00000, 0.00000, -90.35999);
	lawless_CDO(2165, 1556.30774, -1253.13586, 16.53348,   0.00000, 0.00000, -89.93999);
	lawless_CDO(2164, 1570.45667, -1251.60645, 16.53356,   0.00000, 0.00000, -90.12000);
	lawless_CDO(2173, 1567.20178, -1253.87207, 16.53369,   0.00000, 0.00000, 0.78002);
	lawless_CDO(2186, 1556.85156, -1255.98035, 16.53378,   0.00000, 0.00000, -180.41995);
	lawless_CDO(2226, 1552.94507, -1252.03735, 17.32415,   0.00000, 0.00000, -130.62001);
	lawless_CDO(2241, 1559.84705, -1255.62048, 17.02198,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2245, 1553.33276, -1252.52893, 17.58606,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2251, 1563.08484, -1248.85571, 17.88265,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2266, 1543.73340, -1237.52783, 18.94124,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2267, 1541.36926, -1237.07849, 18.72982,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2269, 1545.71533, -1237.52161, 18.83677,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2265, 1547.55298, -1237.52502, 19.05660,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2311, 1561.58862, -1248.88037, 16.53075,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2568, 1569.96960, -1247.73425, 16.53088,   0.00000, 0.00000, -90.05999);
	lawless_CDO(2811, 1569.40100, -1246.73596, 16.52858,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2816, 1562.34277, -1248.99780, 17.03164,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19786, 1552.58813, -1236.99939, 19.82612,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19893, 1567.99573, -1253.88953, 17.33161,   0.00000, 0.00000, -13.86000);
	lawless_CDO(2773, 1562.19214, -1244.56299, 17.04140,   0.00000, 0.00000, -89.28002);
	lawless_CDO(2773, 1558.33374, -1239.89014, 17.04140,   0.00000, 0.00000, -89.28002);
	lawless_CDO(2773, 1562.05933, -1239.86377, 17.04140,   0.00000, 0.00000, -89.28002);
	lawless_CDO(2773, 1547.87646, -1243.94958, 16.55556,   0.00000, 0.00000, -89.28002);
	lawless_CDO(2773, 1542.13000, -1243.71277, 16.55556,   0.00000, 0.00000, -89.28002);
	lawless_CDO(2773, 1549.09558, -1256.33484, 16.55556,   0.00000, 0.00000, -32.64001);
	lawless_CDO(2773, 1541.24036, -1257.59473, 17.04140,   0.00000, 0.00000, -90.84003);
	lawless_CDO(2773, 1541.19385, -1249.41614, 17.04140,   0.00000, 0.00000, -90.84003);
	lawless_CDO(2773, 1543.56689, -1253.32727, 16.55556,   0.00000, 0.00000, -180.47993);
	lawless_CDO(948, 1539.91504, -1260.85425, 16.53408,   0.00000, 0.00000, 0.00000);
	lawless_CDO(3859, 1554.77332, -1253.74194, 18.89325,   0.00000, 0.00000, 16.74000);
	lawless_CDO(3859, 1562.45190, -1251.13574, 18.89325,   0.00000, 0.00000, -73.31999);
	lawless_CDO(2162, 1570.46729, -1254.67371, 16.51307,   0.00000, 0.00000, -90.35999);
	lawless_CDO(1721, 1567.11816, -1252.77747, 16.53194,   0.00000, 0.00000, -179.64003);
	lawless_CDO(19893, 1563.24170, -1253.57898, 17.33161,   0.00000, 0.00000, 86.39999);
	lawless_CDO(19893, 1561.88196, -1253.59741, 17.33161,   0.00000, 0.00000, 271.92010);
	lawless_CDO(2251, 1562.45056, -1253.56409, 18.19000,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2123, 1560.97107, -1253.57739, 17.10428,   0.00000, 0.00000, 179.27995);
	lawless_CDO(1714, 1555.50208, -1253.67151, 16.53167,   0.00000, 0.00000, -263.82007);
	lawless_CDO(948, 1555.11438, -1255.68750, 16.53408,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2241, 1564.91650, -1255.62170, 17.02198,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2066, 1558.86743, -1255.76379, 16.53556,   0.00000, 0.00000, 179.76001);
	lawless_CDO(2066, 1558.26184, -1255.75146, 16.53556,   0.00000, 0.00000, 179.76001);
	lawless_CDO(2251, 1561.35547, -1248.83862, 17.88265,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2811, 1569.28674, -1237.80188, 16.52858,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2241, 1540.07471, -1246.09631, 17.02198,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2241, 1540.04346, -1241.93628, 17.02198,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2267, 1552.80273, -1260.57556, 19.36983,   0.00000, 0.00000, -179.69998);
	lawless_CDO(2269, 1550.95557, -1260.14551, 18.43937,   0.00000, 0.00000, 179.76001);
	lawless_CDO(19425, 1572.52454, -1265.29187, 16.51994,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19425, 1575.79907, -1265.29492, 16.51994,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19425, 1577.33435, -1265.28979, 16.52287,   0.00000, 0.00000, 0.00000);
	lawless_CDO(18075, 1546.54321, -1251.04565, 22.79879,   0.00000, 0.00000, 0.00000);
	lawless_CDO(18075, 1560.46570, -1242.63733, 22.79879,   0.00000, 0.00000, -94.26001);

	new autosalonaudi[119];

	autosalonaudi[1] = lawless_CDO(19431, 1541.22266, -1261.48450, 19.77915,   0.00000, 90.00000, 0.00000);
	autosalonaudi[2] = lawless_CDO(19431, 1544.70605, -1261.48706, 19.77915,   0.00000, 90.00000, 0.00000);
	autosalonaudi[3] = lawless_CDO(19431, 1547.69214, -1261.51416, 19.78017,   0.00000, 90.00000, 0.00000);
	autosalonaudi[4] = lawless_CDO(19431, 1549.34253, -1261.51208, 18.07073,   0.00000, 0.00000, 0.00000);
	autosalonaudi[5] = lawless_CDO(18766, 1551.88232, -1261.12976, 17.41386,   0.00000, 90.00000, 0.00000);

	autosalonaudi[6] = lawless_CDO(19358, 1541.21655, -1256.82739, 16.52840,   0.00000, 70.00000, 90.12000);
	autosalonaudi[7] = lawless_CDO(19358, 1541.19800, -1253.49487, 17.12416,   0.00000, 90.00000, 90.05991);
	autosalonaudi[8] = lawless_CDO(19358, 1541.17810, -1250.13672, 16.52840,   0.00000, 70.00000, 270.17999);
	autosalonaudi[9] = lawless_CDO(19358, 1555.30786, -1242.23999, 16.52840,   0.00000, 70.00000, 0.00000);
	autosalonaudi[10] = lawless_CDO(19358, 1558.66455, -1242.24097, 17.12416,   0.00000, 90.00000, 179.87990);
	autosalonaudi[11] = lawless_CDO(19358, 1562.14001, -1242.25134, 17.12416,   0.00000, 90.00000, 179.87990);
	autosalonaudi[12] = lawless_CDO(19358, 1565.48608, -1242.26477, 16.52840,   0.00000, 70.00000, 179.87993);

	autosalonaudi[13] = lawless_CDO(19817, 1550.35034, -1257.13037, 14.77255,   330.00000, 0.00000, -301.49988);
	autosalonaudi[14] = lawless_CDO(19817, 1542.22876, -1242.40515, 14.77255,   330.00000, 0.00000, -181.07988);
	autosalonaudi[15] = lawless_CDO(19817, 1547.96680, -1242.46802, 14.77255,   330.00000, 0.00000, -181.07988);

	autosalonaudi[16] = lawless_CDO(19089, 1565.08496, -1251.16528, 21.81844,   0.00000, 0.00000, 0.00000);
	autosalonaudi[17] = lawless_CDO(19089, 1559.82910, -1251.12390, 21.81844,   0.00000, 0.00000, 0.00000);
	autosalonaudi[18] = lawless_CDO(19089, 1554.78772, -1251.11548, 21.81844,   0.00000, 0.00000, 0.00000);

	autosalonaudi[19] = lawless_CDO(19893, 1561.88196, -1253.59741, 17.33161,   0.00000, 0.00000, 271.92010);
	autosalonaudi[20] = lawless_CDO(19893, 1563.24170, -1253.57898, 17.33161,   0.00000, 0.00000, 86.39999);

	autosalonaudi[21] = lawless_CDO(1713, 1564.65759, -1250.54224, 16.53161,   0.00000, 0.00000, -180.30005);
	autosalonaudi[22] = lawless_CDO(1708, 1562.32312, -1250.52661, 16.53123,   0.00000, 0.00000, -180.23997);
	autosalonaudi[23] = lawless_CDO(1708, 1560.89099, -1250.49817, 16.53123,   0.00000, 0.00000, -180.23997);

	autosalonaudi[24] = lawless_CDO(19377, 1549.70740, -1256.51990, 16.44211,   0.00000, 90.00000, 0.00000);
	autosalonaudi[25] = lawless_CDO(19377, 1544.26868, -1256.57458, 16.44280,   0.00000, 90.00000, 0.00000);
	autosalonaudi[26] = lawless_CDO(19377, 1554.71912, -1251.67151, 16.44952,   0.00000, 90.00000, 0.00000);
	autosalonaudi[27] = lawless_CDO(19377, 1544.25732, -1251.67529, 16.44952,   0.00000, 90.00000, 0.00000);
	autosalonaudi[28] = lawless_CDO(19377, 1544.24646, -1242.05981, 16.44952,   0.00000, 90.00000, 0.00000);
	autosalonaudi[29] = lawless_CDO(19377, 1554.70703, -1242.04443, 16.44952,   0.00000, 90.00000, 0.00000);
	autosalonaudi[30] = lawless_CDO(19377, 1565.18738, -1251.66101, 16.44952,   0.00000, 90.00000, 0.00000);
	autosalonaudi[31] = lawless_CDO(19377, 1565.15222, -1242.02539, 16.44952,   0.00000, 90.00000, 0.00000);

	autosalonaudi[32] = lawless_CDO(19377, 1543.88342, -1236.94238, 17.63784,   0.00000, 0.00000, -90.18000);
	autosalonaudi[33] = lawless_CDO(19377, 1553.42175, -1236.96301, 17.63778,   0.00000, 0.00000, -90.18000);
	autosalonaudi[34] = lawless_CDO(19377, 1557.00256, -1236.97461, 17.64010,   0.00000, 0.00000, -90.18000);
	autosalonaudi[35] = lawless_CDO(19377, 1565.25610, -1236.99634, 17.63784,   0.00000, 0.00000, -90.18000);

	autosalonaudi[36] = lawless_CDO(19377, 1570.55859, -1251.62195, 17.63784,   0.00000, 0.00000, -180.06003);

	autosalonaudi[37] = lawless_CDO(18980, 1539.00146, -1261.17078, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[38] = lawless_CDO(18762, 1541.00488, -1261.17981, 22.57330,   0.00000, 90.00000, 0.00000);
	autosalonaudi[39] = lawless_CDO(18762, 1545.94238, -1261.16772, 22.57330,   0.00000, 90.00000, 0.00000);
	autosalonaudi[40] = lawless_CDO(18762, 1551.92859, -1261.15283, 22.57480,   0.00000, 90.00000, 0.00000);
	autosalonaudi[41] = lawless_CDO(18980, 1554.86060, -1261.16455, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[42] = lawless_CDO(18762, 1554.86914, -1258.56970, 22.57330,   0.00000, 90.00000, -89.99999);
	autosalonaudi[43] = lawless_CDO(18762, 1557.73645, -1256.58105, 22.57480,   0.00000, 90.00000, 0.00000);
	autosalonaudi[44] = lawless_CDO(18762, 1562.68347, -1256.59033, 22.57480,   0.00000, 90.00000, 0.00000);
	autosalonaudi[45] = lawless_CDO(18762, 1567.57678, -1256.58521, 22.57480,   0.00000, 90.00000, 0.00000);
	autosalonaudi[46] = lawless_CDO(18980, 1554.91638, -1256.57581, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[47] = lawless_CDO(18980, 1559.93201, -1256.59766, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[48] = lawless_CDO(18980, 1564.92993, -1256.62720, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[49] = lawless_CDO(18980, 1569.37903, -1256.57117, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[50] = lawless_CDO(18980, 1570.36902, -1256.57446, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[51] = lawless_CDO(18762, 1570.36328, -1253.60107, 22.57330,   0.00000, 90.00000, -89.99999);
	autosalonaudi[52] = lawless_CDO(18762, 1570.37463, -1248.65564, 22.57330,   0.00000, 90.00000, -89.99999);
	autosalonaudi[53] = lawless_CDO(18980, 1570.39771, -1247.01355, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[54] = lawless_CDO(18980, 1570.43494, -1246.04907, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[55] = lawless_CDO(19431, 1570.49219, -1243.96069, 21.21049,   90.00000, 0.00000, 0.00000);
	autosalonaudi[56] = lawless_CDO(19431, 1570.47229, -1243.95935, 22.22814,   90.00000, 0.00000, 0.00000);
	autosalonaudi[57] = lawless_CDO(19431, 1570.47339, -1240.49280, 22.22814,   90.00000, 0.00000, 0.00000);
	autosalonaudi[58] = lawless_CDO(19431, 1570.48376, -1240.49829, 21.21049,   90.00000, 0.00000, 0.00000);
	autosalonaudi[59] = lawless_CDO(18980, 1570.40552, -1238.28320, 10.58850,   0.00000, 0.00000, 0.00000);
	autosalonaudi[60] = lawless_CDO(18980, 1570.38953, -1237.14514, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[61] = lawless_CDO(18980, 1557.67969, -1237.18176, 22.56987,   0.00000, 90.00000, 0.00000);
	autosalonaudi[62] = lawless_CDO(18980, 1551.87915, -1237.17578, 22.56910,   0.00000, 90.00000, 0.00000);
	autosalonaudi[63] = lawless_CDO(18980, 1539.00171, -1237.15845, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[64] = lawless_CDO(18980, 1539.01465, -1241.97095, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[65] = lawless_CDO(18980, 1538.97705, -1246.07397, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[66] = lawless_CDO(18980, 1539.00354, -1251.09473, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[67] = lawless_CDO(18980, 1538.98328, -1256.15234, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[68] = lawless_CDO(18762, 1539.02808, -1239.17664, 22.57330,   0.00000, 90.00000, -89.99999);
	autosalonaudi[69] = lawless_CDO(18762, 1539.01807, -1243.22217, 22.57330,   0.00000, 90.00000, -89.99999);
	autosalonaudi[70] = lawless_CDO(18762, 1539.01160, -1248.19666, 22.57330,   0.00000, 90.00000, -89.99999);
	autosalonaudi[71] = lawless_CDO(18762, 1539.00916, -1253.18469, 22.57330,   0.00000, 90.00000, -89.99999);
	autosalonaudi[72] = lawless_CDO(18762, 1539.00330, -1258.18750, 22.57330,   0.00000, 90.00000, -89.99999);
	autosalonaudi[73] = lawless_CDO(18980, 1554.85620, -1260.97974, 10.56851,   0.00000, 0.00000, 0.00000);
	autosalonaudi[74] = lawless_CDO(18980, 1570.39001, -1238.14270, 10.56851,   0.00000, 0.00000, 0.00000);

	autosalonaudi[75] = lawless_CDO(18766, 1570.36902, -1241.72217, 14.02539,   0.00000, 0.00000, -89.99998);
	autosalonaudi[76] = lawless_CDO(18766, 1570.35547, -1251.12537, 14.02539,   0.00000, 0.00000, -89.99998);
	autosalonaudi[77] = lawless_CDO(18766, 1565.10193, -1256.55444, 14.02366,   0.00000, 0.00000, 0.00000);
	autosalonaudi[78] = lawless_CDO(18766, 1560.37756, -1256.55872, 14.02539,   0.00000, 0.00000, 0.00000);
	autosalonaudi[79] = lawless_CDO(18766, 1554.85071, -1256.19604, 14.02539,   0.00000, 0.00000, -89.99998);
	autosalonaudi[80] = lawless_CDO(18766, 1549.85547, -1261.14844, 14.02539,   0.00000, 0.00000, 0.00000);
	autosalonaudi[81] = lawless_CDO(18766, 1544.46472, -1261.15259, 14.02664,   0.00000, 0.00000, 0.00000);
	autosalonaudi[82] = lawless_CDO(18766, 1539.00720, -1256.64258, 14.02736,   0.00000, 0.00000, -89.99998);
	autosalonaudi[83] = lawless_CDO(18766, 1539.02173, -1252.44177, 14.02539,   0.00000, 0.00000, -89.99998);
	autosalonaudi[84] = lawless_CDO(18766, 1539.01697, -1242.49438, 14.02539,   0.00000, 0.00000, -89.99998);
	autosalonaudi[85] = lawless_CDO(18766, 1545.04907, -1237.14758, 14.02539,   0.00000, 0.00000, 0.00000);
	autosalonaudi[86] = lawless_CDO(18766, 1544.08582, -1237.16138, 14.02402,   0.00000, 0.00000, 0.00000);
	autosalonaudi[87] = lawless_CDO(18766, 1555.02795, -1237.15991, 14.02539,   0.00000, 0.00000, 0.00000);
	autosalonaudi[88] = lawless_CDO(18766, 1565.01135, -1237.15454, 14.02539,   0.00000, 0.00000, 0.00000);

	autosalonaudi[89] = lawless_CDO(18766, 1574.85925, -1236.28638, 14.66500,   0.00000, 0.00000, 0.00000);
	autosalonaudi[90] = lawless_CDO(18766, 1579.35510, -1241.76819, 14.66500,   0.00000, 0.00000, -90.06000);
	autosalonaudi[91] = lawless_CDO(18766, 1579.35840, -1251.73486, 14.66500,   0.00000, 0.00000, -90.06000);
	autosalonaudi[92] = lawless_CDO(18766, 1579.36133, -1261.67957, 14.66500,   0.00000, 0.00000, -90.06000);
	autosalonaudi[93] = lawless_CDO(18766, 1570.39771, -1261.74158, 14.66500,   0.00000, 0.00000, -90.06000);

	autosalonaudi[94] = lawless_CDO(19377, 1576.11328, -1241.51843, 16.44952,   0.00000, 90.00000, 0.00000);
	autosalonaudi[95] = lawless_CDO(19377, 1576.10181, -1251.15198, 16.44952,   0.00000, 90.00000, 0.00000);
	autosalonaudi[96] = lawless_CDO(19377, 1576.11267, -1260.76270, 16.44952,   0.00000, 90.00000, 0.00000);

	autosalonaudi[97] = lawless_CDO(1251, 1563.21973, -1283.39417, 16.40086,   0.00000, 0.00000, -179.88008);
	autosalonaudi[98] = lawless_CDO(1251, 1560.03918, -1283.38196, 16.40086,   0.00000, 0.00000, -179.88008);
	autosalonaudi[99] = lawless_CDO(1251, 1556.91846, -1283.42004, 16.40086,   0.00000, 0.00000, -179.88008);
	autosalonaudi[100] = lawless_CDO(1251, 1554.05469, -1283.40674, 16.40086,   0.00000, 0.00000, -179.88008);
	autosalonaudi[101] = lawless_CDO(1251, 1550.90930, -1283.38293, 16.40086,   0.00000, 0.00000, -179.88008);
	autosalonaudi[102] = lawless_CDO(1251, 1548.06799, -1283.39429, 16.40086,   0.00000, 0.00000, -179.88008);
	autosalonaudi[103] = lawless_CDO(1251, 1544.84314, -1283.40808, 16.40086,   0.00000, 0.00000, -179.88008);
	autosalonaudi[104] = lawless_CDO(1251, 1564.62097, -1293.19153, 22.33551,   90.00000, 0.00000, -179.88010);
	autosalonaudi[105] = lawless_CDO(1251, 1564.62097, -1293.19153, 15.51036,   90.00000, 0.00000, -179.88010);
	autosalonaudi[106] = lawless_CDO(1251, 1545.48779, -1293.16162, 22.33551,   90.00000, 0.00000, -179.88010);
	autosalonaudi[107] = lawless_CDO(1251, 1545.48779, -1293.16162, 15.47567,   90.00000, 0.00000, -179.88010);

	autosalonaudi[108] = lawless_CDO(19431, 1564.61316, -1294.05725, 23.37293,   0.00000, 0.00000, 0.00000);
	autosalonaudi[109] = lawless_CDO(19431, 1545.46240, -1294.02917, 23.37293,   0.00000, 0.00000, 0.00000);

	autosalonaudi[110] = lawless_CDO(19377, 1544.26868, -1256.57458, 22.93649,   0.00000, 90.00000, 0.00000);
	autosalonaudi[111] = lawless_CDO(19377, 1549.70740, -1256.51990, 22.94298,   0.00000, 90.00000, 0.00000);
	autosalonaudi[112] = lawless_CDO(19377, 1544.25732, -1251.67529, 22.94227,   0.00000, 90.00000, 0.00000);
	autosalonaudi[113] = lawless_CDO(19377, 1544.24646, -1242.05981, 22.93591,   0.00000, 90.00000, 0.00000);
	autosalonaudi[114] = lawless_CDO(19377, 1554.70703, -1242.04443, 22.90444,   0.00000, 90.00000, 0.00000);
	autosalonaudi[115] = lawless_CDO(19377, 1554.71912, -1251.67151, 22.91813,   0.00000, 90.00000, 0.00000);
	autosalonaudi[116] = lawless_CDO(19377, 1565.18738, -1251.66101, 22.92824,   0.00000, 90.00000, 0.00000);
	autosalonaudi[117] = lawless_CDO(19377, 1565.15222, -1242.02539, 22.90680,   0.00000, 90.00000, 0.00000);

	autosalonaudi[118] = lawless_CDO(18762, 1550.92566, -1261.14868, 22.57330,   0.00000, 90.00000, 0.00000);

	SetDynamicObjectMaterial(autosalonaudi[1], 0, 2169, "cj_office", "white32", 0xFFDF0101);
	SetDynamicObjectMaterial(autosalonaudi[2], 0, 2169, "cj_office", "white32", 0xFFDF0101);
	SetDynamicObjectMaterial(autosalonaudi[3], 0, 2169, "cj_office", "white32", 0xFFDF0101);
	SetDynamicObjectMaterial(autosalonaudi[4], 0, 2169, "cj_office", "white32", 0xFFDF0101);
	SetDynamicObjectMaterial(autosalonaudi[5], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[6], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[7], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[8], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[9], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[10], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[11], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[12], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[13], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[14], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[15], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[16], 0, 2169, "cj_office", "white32", 0xFFDF0101);
	SetDynamicObjectMaterial(autosalonaudi[17], 0, 2169, "cj_office", "white32", 0xFFDF0101);
	SetDynamicObjectMaterial(autosalonaudi[18], 0, 2169, "cj_office", "white32", 0xFFDF0101);

	SetDynamicObjectMaterial(autosalonaudi[19], 1, 2169, "cj_office", "white32", 0xFF585858);
	SetDynamicObjectMaterial(autosalonaudi[20], 1, 2169, "cj_office", "white32", 0xFF585858);

	SetDynamicObjectMaterial(autosalonaudi[20], 0, 2169, "cj_office", "white32", 0xFF585858);

	SetDynamicObjectMaterial(autosalonaudi[21], 1, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[22], 1, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[23], 1, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[21], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[22], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[23], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[21], 2, 10631, "queensammo_sfs", "ammu_camo1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[22], 2, 10631, "queensammo_sfs", "ammu_camo1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[23], 2, 10631, "queensammo_sfs", "ammu_camo1", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[24], 0, 12841, "cos_pizzaplace", "b_wtilesreflect", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[25], 0, 12841, "cos_pizzaplace", "b_wtilesreflect", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[26], 0, 12841, "cos_pizzaplace", "b_wtilesreflect", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[27], 0, 12841, "cos_pizzaplace", "b_wtilesreflect", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[28], 0, 12841, "cos_pizzaplace", "b_wtilesreflect", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[29], 0, 12841, "cos_pizzaplace", "b_wtilesreflect", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[30], 0, 12841, "cos_pizzaplace", "b_wtilesreflect", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[31], 0, 12841, "cos_pizzaplace", "b_wtilesreflect", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[32], 0, 3603, "bevmans01_la", "hottop5d_law", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[33], 0, 3603, "bevmans01_la", "hottop5d_law", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[34], 0, 3603, "bevmans01_la", "hottop5d_law", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[35], 0, 3603, "bevmans01_la", "hottop5d_law", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[36], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[37], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[38], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[39], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[40], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[41], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[42], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[43], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[44], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[45], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[46], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[47], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[48], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[49], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[50], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[51], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[52], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[53], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[54], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[55], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[56], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[57], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[58], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[59], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[60], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[61], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[62], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[63], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[64], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[65], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[66], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[67], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[68], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[69], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[70], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[71], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[72], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[73], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[74], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[75], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[76], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[77], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[78], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[79], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[80], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[81], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[82], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[83], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[84], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[85], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[86], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[87], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[88], 0, 5267, "lashops91_las2", "laspowrec2", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[89], 0, 10386, "mountainsfs", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[90], 0, 10386, "mountainsfs", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[91], 0, 10386, "mountainsfs", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[92], 0, 10386, "mountainsfs", "ws_stonewall", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[93], 0, 10386, "mountainsfs", "ws_stonewall", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[94], 0, 6487, "councl_law2", "rodeo3sjm", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[95], 0, 6487, "councl_law2", "rodeo3sjm", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[96], 0, 6487, "councl_law2", "rodeo3sjm", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[97], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[98], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[99], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[100], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[101], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[102], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[103], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[104], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[105], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[106], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[107], 0, 2169, "cj_office", "white32", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[108], 0, 2169, "cj_office", "white32", 0xFFDF0101);
	SetDynamicObjectMaterial(autosalonaudi[109], 0, 2169, "cj_office", "white32", 0xFFDF0101);

	SetDynamicObjectMaterial(autosalonaudi[110], 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[111], 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[112], 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[113], 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[114], 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[115], 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[116], 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0xFFFFFFFF);
	SetDynamicObjectMaterial(autosalonaudi[117], 0, 11301, "carshow_sfse", "ws_officy_ceiling", 0xFFFFFFFF);

	SetDynamicObjectMaterial(autosalonaudi[118], 0, 11389, "hubint1_sfse", "rustb256128", 0xFFFFFFFF);

	new autosalonjedan = lawless_COB(19482, 1544.3714, -1261.6459, 20.3357, 0.0000, 0.0000, -89.6988);
	SetObjectMaterialText(autosalonjedan, "AUTO SALON", 0, 130, "Arial", 88, 0, -32256, 0, 1);

	new audidva = lawless_COB(19482, 1551.9635, -1261.6442, 16.9562, 0.0000, 0.0000, -89.9856);
	SetObjectMaterialText(audidva, "AUDI", 0, 140, "Arial", 200, 1, -65536, 0, 1);

	new auditri = lawless_COB(19482, 1545.3466, -1294.0302, 23.3380, 89.8999, -0.9999, -179.6798);
	SetObjectMaterialText(auditri, "AUDI", 0, 130, "Arial", 140, 1, -1, 0, 1);

	new AUDIcetetiri = lawless_COB(19482, 1564.7236, -1294.0439, 23.3504, 90.4999, 0.2000, 1.2685);
	SetObjectMaterialText(AUDIcetetiri, "AUDI", 0, 130, "Arial", 140, 1, -1, 0, 1);

	new AUDIpet = lawless_COB(19482, 1566.4732, -1237.0983, 20.8354, 0.0000, 0.0000, -90.2023);
	SetObjectMaterialText(AUDIpet, "AUDI", 0, 130, "Arial", 220, 1, -65536, 0, 1);

	new parking = lawless_COB(19482, 1555.1759, -1285.2342, 16.7562, 0.0000, 0.0000, 90.3830);
	SetObjectMaterialText(parking, "PARKING", 0, 140, "Arial", 120, 1, -1, 0, 1);

	new audikrugjedan = lawless_COB(19482, 1552.0273, -1261.6417, 18.3562, 0.0000, 0.0000, -90.1372);
	SetObjectMaterialText(audikrugjedan, "O", 0, 130, "Arial", 200, 0, -8092540, 0, 1);

	new audikrugdva = lawless_COB(19482, 1552.0317, -1261.6812, 19.1662, 0.0000, 0.0000, 269.8264);
	SetObjectMaterialText(audikrugdva, "O", 0, 130, "Arial", 200, 0, -8092540, 0, 1);

	new audikrugtri = lawless_COB(19482, 1552.0236, -1261.6367, 20.0162, 0.0000, 0.0000, -89.5488);
	SetObjectMaterialText(audikrugtri, "O", 0, 130, "Arial", 200, 0, -8092540, 0, 1);

	new audikrugcetiri = lawless_COB(19482, 1552.0085, -1261.6735, 20.8762, 0.0000, 0.0000, 269.1979);
	SetObjectMaterialText(audikrugcetiri, "O", 0, 130, "Arial", 200, 0, -8092540, 0, 1);

	new salonzica1 = lawless_CDO(19089, 889.27130, -1347.02490, 16.06370,   0.00000, 0.00000, 0.00000);
	new salonzica2 = lawless_CDO(19089, 889.27130, -1353.64893, 16.06370,   0.00000, 0.00000, 0.00000);
	new salonzica3 = lawless_CDO(19089, 895.78802, -1343.39722, 15.86950,   0.00000, 0.00000, 0.00000);
	new salonzica4 = lawless_CDO(19089, 891.53583, -1343.35376, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica5 = lawless_CDO(19089, 892.52283, -1343.35376, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica6 = lawless_CDO(19089, 889.03735, -1344.97449, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica7 = lawless_CDO(19089, 890.02441, -1344.97449, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica8 = lawless_CDO(19089, 882.78638, -1344.97449, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica9 = lawless_CDO(19089, 881.75238, -1344.97449, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica10 = lawless_CDO(19089, 898.91479, -1343.35376, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica11 = lawless_CDO(19089, 899.90179, -1343.35376, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica12 = lawless_CDO(19089, 901.25739, -1345.35046, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica13 = lawless_CDO(19089, 902.29138, -1345.35046, 18.64250,   0.00000, 0.00000, 0.00000);
	new salonzica14 = lawless_CDO(19366, 891.21863, -1350.25684, 10.86940,   0.00000, 0.00000, 0.00000);

	SetDynamicObjectMaterial(salonzica1, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica2, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica3, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica4, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica5, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica6, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica7, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica8, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica9, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica10, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica11, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica12, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica13, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(salonzica14, 0, 2361, "shopping_freezers", "white", 0xFF000000);

	new salonzid1 = lawless_CDO(18980, 882.27228, -1345.47119, 6.10980,   0.00000, 0.00000, 0.00000);
	new salonzid2 = lawless_CDO(18980, 889.55231, -1345.47119, 6.10980,   0.00000, 0.00000, 0.00000);
	new salonzid3 = lawless_CDO(18980, 892.02582, -1343.84583, 6.10980,   0.00000, 0.00000, 0.00000);
	new salonzid4 = lawless_CDO(18980, 899.43176, -1343.85645, 6.10980,   0.00000, 0.00000, 0.00000);
	new salonzid5 = lawless_CDO(18980, 901.76990, -1345.84521, 6.10980,   0.00000, 0.00000, 0.00000);
	new salonzid6 = lawless_CDO(19377, 901.76636, -1350.22461, 12.57197,   0.00000, 0.00000, 0.00000);
	new salonzid7 = lawless_CDO(19377, 896.94464, -1355.05200, 12.57200,   0.00000, 0.00000, 90.00000);
	new salonzid8 = lawless_CDO(19377, 887.41803, -1355.05200, 12.57200,   0.00000, 0.00000, 90.00000);
	new salonzid9 = lawless_CDO(19377, 882.31921, -1350.28235, 12.57200,   0.00000, 0.00000, 0.00000);
	new salonzid10 = lawless_CDO(19377, 887.14203, -1355.05200, 12.57200,   0.00000, 0.00000, 90.00000);
	new salonzid11 = lawless_CDO(19369, 897.34418, -1343.48804, 17.59320,   0.00000, 0.00000, 90.00000);
	new salonzid12 = lawless_CDO(19369, 894.14819, -1343.48804, 17.59320,   0.00000, 0.00000, 90.00000);
	new salonzid13 = lawless_CDO(19369, 890.35199, -1344.82361, 14.23320,   0.00000, 0.00000, -50.00000);
	new salonzid14 = lawless_CDO(19369, 890.35199, -1344.82361, 16.79420,   0.00000, 0.00000, -50.00000);
	new salonzid15 = lawless_CDO(18762, 886.75763, -1345.49072, 17.52330,   0.00000, 90.00000, 0.00000);
	new salonzid16 = lawless_CDO(18762, 886.75763, -1345.49072, 18.08730,   0.00000, 90.00000, 0.00000);
	new salonzid17 = lawless_CDO(18762, 885.06561, -1345.49072, 17.52330,   0.00000, 90.00000, 0.00000);
	new salonzid18 = lawless_CDO(18762, 885.06561, -1345.49072, 18.08730,   0.00000, 90.00000, 0.00000);
	new salonzid19 = lawless_CDO(18762, 885.06561, -1345.49072, 12.58830,   0.00000, 90.00000, 0.00000);
	new salonzid20 = lawless_CDO(18762, 886.71057, -1345.49072, 12.58830,   0.00000, 90.00000, 0.00000);

	SetDynamicObjectMaterial(salonzid1, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid2, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid3, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid4, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid5, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid6, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid7, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid8, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid9, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid10, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid11, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid12, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid13, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid14, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid15, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid16, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid17, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid18, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid19, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonzid20, 0, 16150, "ufo_bar", "GEwhite1_64", 0xFFFFFFFF);

	new salozidcic1 = lawless_CDO(19369, 890.33203, -1344.82471, 16.79420,   0.00000, 0.00000, -50.00000);
	new salozidcic2 = lawless_CDO(19369, 900.23853, -1344.53235, 16.79420,   0.00000, 0.00000, 50.00000);
	new salozidcic3 = lawless_CDO(19369, 890.73840, -1344.46521, 13.35620,   0.00000, 0.00000, -50.00000);
	new salozidcic4 = lawless_CDO(19369, 900.69690, -1344.90320, 13.35620,   0.00000, 0.00000, 50.00000);
	new salozidcic5 = lawless_CDO(19366, 891.21863, -1350.25684, 10.86940,   0.00000, 0.00000, 0.00000);

	SetDynamicObjectMaterial(salozidcic1, 0, 2361, "shopping_freezers", "white", 0xFF2B2929);
	SetDynamicObjectMaterial(salozidcic2, 0, 2361, "shopping_freezers", "white", 0xFF2B2929);
	SetDynamicObjectMaterial(salozidcic3, 0, 2361, "shopping_freezers", "white", 0xFF2B2929);
	SetDynamicObjectMaterial(salozidcic4, 0, 2361, "shopping_freezers", "white", 0xFF2B2929);
	SetDynamicObjectMaterial(salozidcic5, 0, 2361, "shopping_freezers", "white", 0xFF2B2929);

	new salonpod1 = lawless_CDO(19377, 884.18414, -1341.78894, 12.49470,   0.00000, 90.00000, 0.00000);
	new salonpod2 = lawless_CDO(19377, 894.68414, -1341.79675, 12.49470,   0.00000, 90.00000, 0.00000);
	new salonpod3 = lawless_CDO(19377, 902.15332, -1341.78271, 12.49270,   0.00000, 90.00000, 0.00000);
	new salonpod4 = lawless_CDO(19377, 902.18335, -1351.28381, 12.49270,   0.00000, 90.00000, 0.00000);
	new salonpod5 = lawless_CDO(19377, 891.70868, -1351.28809, 12.49270,   0.00000, 90.00000, 0.00000);
	new salonpod6 = lawless_CDO(19377, 881.27997, -1351.23303, 12.49270,   0.00000, 90.00000, 0.00000);

	SetDynamicObjectMaterial(salonpod1, 0, 12960, "sw_church", "ws_traingravel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonpod2, 0, 12960, "sw_church", "ws_traingravel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonpod3, 0, 12960, "sw_church", "ws_traingravel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonpod4, 0, 12960, "sw_church", "ws_traingravel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonpod5, 0, 12960, "sw_church", "ws_traingravel", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonpod6, 0, 12960, "sw_church", "ws_traingravel", 0xFFFFFFFF);

	new salonograda1 = lawless_CDO(18762, 904.98413, -1356.54407, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda2 = lawless_CDO(18762, 900.09906, -1356.56396, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda3 = lawless_CDO(18762, 895.21008, -1356.54407, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda4 = lawless_CDO(18762, 890.32312, -1356.54407, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda5 = lawless_CDO(18762, 885.43610, -1356.54407, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda6 = lawless_CDO(18762, 880.54907, -1356.54407, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda7 = lawless_CDO(18762, 878.55634, -1354.45911, 12.54400,   0.00000, 90.00000, 90.00000);
	new salonograda8 = lawless_CDO(18762, 878.55627, -1349.57214, 12.54400,   0.00000, 90.00000, 90.00000);
	new salonograda9 = lawless_CDO(18762, 878.55627, -1344.68506, 12.54400,   0.00000, 90.00000, 90.00000);
	new salonograda10 = lawless_CDO(18762, 878.55627, -1339.79810, 12.54400,   0.00000, 90.00000, 90.00000);
	new salonograda11 = lawless_CDO(18762, 907.06427, -1354.45911, 12.54400,   0.00000, 90.00000, 90.00000);
	new salonograda12 = lawless_CDO(18762, 907.06427, -1349.45410, 12.54400,   0.00000, 90.00000, 90.00000);
	new salonograda13 = lawless_CDO(18762, 907.06427, -1344.44910, 12.54400,   0.00000, 90.00000, 90.00000);
	new salonograda14 = lawless_CDO(18762, 907.06427, -1339.53516, 12.54400,   0.00000, 90.00000, 90.00000);
	new salonograda15 = lawless_CDO(18762, 880.55518, -1337.36292, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda16 = lawless_CDO(18762, 885.16217, -1337.36292, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda17 = lawless_CDO(18762, 890.16217, -1337.36292, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda18 = lawless_CDO(18762, 900.96222, -1337.36292, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda19 = lawless_CDO(18762, 905.04218, -1337.36292, 12.54400,   0.00000, 90.00000, 0.00000);
	new salonograda20 = lawless_CDO(18980, 892.62732, -1337.33350, 0.98680,   0.00000, 0.00000, 0.00000);
	new salonograda21 = lawless_CDO(18980, 898.81152, -1337.33618, 0.98680,   0.00000, 0.00000, 0.00000);
	new salonograda22 = lawless_CDO(18980, 878.68640, -1337.36438, 0.98680,   0.00000, 0.00000, 0.00000);
	new salonograda23 = lawless_CDO(18980, 907.45947, -1337.33618, 0.98680,   0.00000, 0.00000, 0.00000);

	SetDynamicObjectMaterial(salonograda1, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda2, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda3, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda4, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda5, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda6, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda7, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda8, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda9, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda10, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda11, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda12, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda13, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda14, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda15, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda16, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda17, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda18, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda19, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda20, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda21, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda22, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);
	SetDynamicObjectMaterial(salonograda23, 0, 12979, "sw_block9", "newall10", 0xFFFFFFFF);

	new salonzicaa1 = lawless_CDO(19325, 903.12048, -1337.28235,  12.0272,   0.00000, 0.00000, 90.00000);
	new salonzicaa2 = lawless_CDO(19325, 888.73108, -1337.40405,  12.0272,   0.00000, 0.00000, 90.00000);
	new salonzicaa3 = lawless_CDO(19325, 882.10413, -1337.40405,  12.0272,   0.00000, 0.00000, 90.00000);
	new salonzicaa4 = lawless_CDO(19325, 878.66571, -1341.16357,  12.0272,   0.00000, 0.00000, 0.00000);
	new salonzicaa5 = lawless_CDO(19325, 878.66571, -1347.79065,  12.0272,   0.00000, 0.00000, 0.00000);
	new salonzicaa6 = lawless_CDO(19325, 878.66571, -1353.28955,  12.0272,   0.00000, 0.00000, 0.00000);
	new salonzicaa7 = lawless_CDO(19325, 882.40887, -1356.36548,  12.0272,   0.00000, 0.00000, 90.00000);
	new salonzicaa8 = lawless_CDO(19325, 888.98889, -1356.36548,  12.0272,   0.00000, 0.00000, 90.00000);
	new salonzicaa9 = lawless_CDO(19325, 895.61591, -1356.36548,  12.0272,   0.00000, 0.00000, 90.00000);
	new salonzicaa10 = lawless_CDO(19325, 902.24292, -1356.36548,  12.0272,   0.00000, 0.00000, 90.00000);
	new salonzicaa11 = lawless_CDO(19325, 903.65289, -1356.36548,  12.0272,   0.00000, 0.00000, 90.00000);
	new salonzicaa12 = lawless_CDO(19325, 907.04010, -1352.79395,  12.0272,   0.00000, 0.00000, 0.00000);
	new salonzicaa13 = lawless_CDO(19325, 907.04010, -1346.11987,  12.0272,   0.00000, 0.00000, 0.00000);
	new salonzicaa14 = lawless_CDO(19325, 907.04010, -1341.23193,  12.0272,   0.00000, 0.00000, 0.00000);

	SetDynamicObjectMaterial(salonzicaa1, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa2, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa3, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa4, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa5, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa6, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa7, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa8, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa9, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa10, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa11, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa12, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa13, 0, 3820, "boxhses_sfsx", "ws_ irongate");
	SetDynamicObjectMaterial(salonzicaa14, 0, 3820, "boxhses_sfsx", "ws_ irongate");

	new salonznak7 = lawless_CDO(2695, 885.43152, -1345.32190, 14.80890,   180.00000, 40.00000, 0.00000);
	new salonznak8 = lawless_CDO(2695, 886.15149, -1345.32190, 15.67290,   180.00000, 40.00000, 0.00000);
	new salonznak9 = lawless_CDO(2695, 885.43451, -1345.32190, 15.76390,   180.00000, -40.00000, 0.00000);
	new salonznak10 = lawless_CDO(2695, 901.68359, -1350.77100, 15.97490,   0.00000, 40.00000, 90.00000);
	new salonznak11 = lawless_CDO(2695, 901.68359, -1349.99805, 15.94090,   180.00000, 40.00000, 90.00000);
	new salonznak12 = lawless_CDO(2695, 901.68359, -1350.77100, 15.11090,   180.00000, 40.00000, 90.00000);
	new salonznak13 = lawless_CDO(2695, 901.68359, -1349.99805, 15.07690,   180.00000, -40.00000, 90.00000);

	SetDynamicObjectMaterial(salonznak7, 0, 2361, "shopping_freezers", "white", 0xFFACA9A4);
	SetDynamicObjectMaterial(salonznak8, 0, 2361, "shopping_freezers", "white", 0xFFACA9A4);
	SetDynamicObjectMaterial(salonznak9, 0, 2361, "shopping_freezers", "white", 0xFFACA9A4);
	SetDynamicObjectMaterial(salonznak10, 0, 2361, "shopping_freezers", "white",0xFFACA9A4);
	SetDynamicObjectMaterial(salonznak11, 0, 2361, "shopping_freezers", "white", 0xFFACA9A4);
	SetDynamicObjectMaterial(salonznak12, 0, 2361, "shopping_freezers", "white", 0xFFACA9A4);
	SetDynamicObjectMaterial(salonznak13, 0, 2361, "shopping_freezers", "white", 0xFFACA9A4);

	lawless_CDO(19325, 886.07642, -1345.34875, 12.5277,   0.00000, 0.00000, 90.00000);
	lawless_CDO(19325, 893.71741, -1343.40088, 12.5277,   90.00000, 0.00000, 90.00000);
	lawless_CDO(19325, 897.85742, -1343.40088, 15.11970,   90.00000, 0.00000, 90.00000);
	lawless_CDO(19325, 889.27820, -1350.33997, 14.01570,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2118, 890.64349, -1350.76392, 12.51020,   0.00000, 0.00000, 90.00000);
	lawless_CDO(2123, 889.67706, -1349.13513, 13.19940,   0.00000, 0.00000, 156.00000);
	lawless_CDO(2251, 890.49329, -1350.26416, 14.12700,   0.00000, 0.00000, 0.00000);
	lawless_CDO(19893, 890.57294, -1349.66394, 13.29900,   0.00000, 0.00000, 229.00000);
	lawless_CDO(19893, 890.64429, -1350.84473, 13.29900,   0.00000, 0.00000, -62.00000);
	lawless_CDO(2123, 889.74817, -1351.33569, 13.19940,   0.00000, 0.00000, 215.00000);
	lawless_CDO(957, 891.18549, -1348.84302, 12.61570,   0.00000, 180.00000, 0.00000);
	lawless_CDO(957, 891.18549, -1350.31897, 12.61570,   0.00000, 180.00000, 0.00000);
	lawless_CDO(957, 891.18549, -1351.67200, 12.61570,   0.00000, 180.00000, 0.00000);
	lawless_CDO(2195, 890.98633, -1345.06067, 13.07310,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2195, 900.27631, -1345.32007, 13.07310,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2207, 899.01874, -1350.59705, 12.57840,   0.00000, 0.00000, -135.00000);
	lawless_CDO(1714, 899.99536, -1353.00427, 12.57730,   0.00000, 0.00000, -127.00000);
	lawless_CDO(19893, 898.44708, -1351.23926, 13.35320,   0.00000, 0.00000, 33.00000);
	lawless_CDO(2894, 899.29517, -1351.07092, 13.35264,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2259, 894.79102, -1354.46484, 14.58160,   0.00000, 0.00000, 180.00000);
	lawless_CDO(2066, 895.80927, -1354.89307, 12.57769,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2066, 895.24933, -1354.89307, 12.57770,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2066, 894.68927, -1354.89307, 12.57770,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2066, 894.12927, -1354.89307, 12.57770,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2773, 901.43463, -1348.35522, 12.85810,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2773, 901.47461, -1351.23523, 12.85810,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2773, 901.43457, -1353.83521, 12.85810,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1726, 899.00317, -1345.56885, 12.57840,   0.00000, 0.00000, -45.00000);
	lawless_CDO(2163, 897.99152, -1355.23572, 12.54510,   0.00000, 0.00000, 180.00000);
	lawless_CDO(2163, 899.71149, -1355.23572, 13.42510,   0.00000, 0.00000, 180.00000);
	lawless_CDO(1822, 898.45605, -1347.90112, 12.57876,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2208, 895.74768, -1352.62756, 12.57806,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1714, 895.99646, -1354.06738, 12.57730,   0.00000, 0.00000, -193.00000);
	lawless_CDO(1714, 898.36816, -1353.88245, 12.57730,   0.00000, 0.00000, -142.00000);
	lawless_CDO(19893, 897.67920, -1352.61536, 13.43320,   0.00000, 0.00000, 11.00000);
	lawless_CDO(19893, 896.15631, -1352.57727, 13.43320,   0.00000, 0.00000, 11.00000);
	lawless_CDO(2894, 896.98462, -1352.62695, 13.43260,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2241, 897.37170, -1351.77417, 13.03150,   0.00000, 0.00000, 0.00000);
	lawless_CDO(957, 898.79370, -1349.05969, 17.33251,   0.00000, 0.00000, 0.00000);
	lawless_CDO(957, 892.12170, -1349.05969, 17.33250,   0.00000, 0.00000, 0.00000);
	lawless_CDO(957, 884.61572, -1349.05969, 17.33250,   0.00000, 0.00000, 0.00000);
	lawless_CDO(957, 884.61572, -1351.97876, 17.33250,   0.00000, 0.00000, 0.00000);
	lawless_CDO(957, 892.12170, -1351.97876, 17.33250,   0.00000, 0.00000, 0.00000);
	lawless_CDO(957, 898.79370, -1351.97876, 17.33250,   0.00000, 0.00000, 0.00000);
	lawless_CDO(10575, 901.86218, -1350.30115, 14.49350,   0.00000, 0.00000, 180.00000);
	lawless_CDO(1696, 884.75385, -1351.02869, 13.23210,   -2.00000, 0.00000, 88.00000);
	lawless_CDO(2773, 887.39825, -1352.49146, 12.85810,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2773, 887.46698, -1349.18970, 12.85810,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2241, 887.61768, -1350.76978, 13.03150,   0.00000, 0.00000, 0.00000);
	lawless_CDO(2195, 882.81427, -1354.44397, 13.07310,   0.00000, 0.00000, 0.00000);

	new saloncvet1 = lawless_CDO(19366, 891.91638, -1345.99194, 12.49600,   0.00000, 90.00000, -49.00000);
	new saloncvet2 = lawless_CDO(19366, 899.68481, -1346.20435, 12.49600,   0.00000, 90.00000, -43.00000);

	SetDynamicObjectMaterial(saloncvet1, 0, 3922, "bistro", "Marble2", 0xFFFFFFFF);
	SetDynamicObjectMaterial(saloncvet2, 0, 3922, "bistro", "Marble2", 0xFFFFFFFF);

	new salonp1 = lawless_COB(19377, 896.50031, -1350.14490, 12.49671,   0.00000, 90.00000, 0.00000);
	new salonp2 = lawless_COB(19377, 887.62695, -1350.17993, 12.49670,   0.00000, 90.00000, 0.00000);
	new salonp3 = lawless_COB(19366, 897.34454, -1344.98645, 12.49800,   0.00000, 90.00000, 0.00000);
	new salonp4 = lawless_COB(19366, 893.85150, -1344.96851, 12.49800,   0.00000, 90.00000, 0.00000);

	SetObjectMaterial(salonp1, 0, 14594, "papaerchaseoffice", "ab_mottleGrey");
	SetObjectMaterial(salonp2, 0, 14594, "papaerchaseoffice", "ab_mottleGrey");
	SetObjectMaterial(salonp3, 0, 14594, "papaerchaseoffice", "ab_mottleGrey");
	SetObjectMaterial(salonp4, 0, 14594, "papaerchaseoffice", "ab_mottleGrey");

	new salonk1 = lawless_COB(19377, 896.50031, -1350.14490, 17.74970,   0.00000, 90.00000, 0.00000);
	new salonk2 = lawless_COB(19377, 887.61407, -1350.19531, 17.74970,   0.00000, 90.00000, 0.00000);
	new salonk3 = lawless_COB(19366, 897.34448, -1344.98645, 17.75170,   0.00000, 90.00000, 0.00000);
	new salonk4 = lawless_COB(19366, 893.85150, -1344.96851, 17.75170,   0.00000, 90.00000, 0.00000);
	new salonk5 = lawless_COB(19366, 892.06659, -1345.79700, 17.75170,   0.00000, 90.00000, -48.00000);
	new salonk6 = lawless_COB(19366, 899.47461, -1345.96838, 17.75170,   0.00000, 90.00000, -40.00000);

	SetObjectMaterial(salonk1, 0, 11301, "carshow_sfse", "ws_officy_ceiling");
	SetObjectMaterial(salonk2, 0, 11301, "carshow_sfse", "ws_officy_ceiling");
	SetObjectMaterial(salonk3, 0, 11301, "carshow_sfse", "ws_officy_ceiling");
	SetObjectMaterial(salonk4, 0, 11301, "carshow_sfse", "ws_officy_ceiling");
	SetObjectMaterial(salonk5, 0, 11301, "carshow_sfse", "ws_officy_ceiling");
	SetObjectMaterial(salonk6, 0, 11301, "carshow_sfse", "ws_officy_ceiling");

	new saloncrno1 = lawless_CDO(18762, 898.79999, -1350.27209, 17.83480,   0.00000, 90.00000, 90.00000);
	new saloncrno2 = lawless_CDO(18762, 891.94598, -1350.27209, 17.83480,   0.00000, 90.00000, 90.00000);
	new saloncrno3 = lawless_CDO(18762, 884.94299, -1350.27209, 17.83480,   0.00000, 90.00000, 90.00000);

	SetDynamicObjectMaterial(saloncrno1, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(saloncrno2, 0, 2361, "shopping_freezers", "white", 0xFF000000);
	SetDynamicObjectMaterial(saloncrno3, 0, 2361, "shopping_freezers", "white", 0xFF000000);

	new renaulttt = lawless_COB(19353, 885.6765, -1345.0766, 17.9806, 0.0000, 0.0000, 89.9517);
	SetObjectMaterialText(renaulttt, "{fdb515}RENAULT", 0, 140, "Arial", 120, 1, -1, 0, 1);

	new r2 = lawless_COB(19353, 897.8793, -1343.4346, 18.3868, 0.0000, 0.0000, 90.0010);
	SetObjectMaterialText(r2, "{fdb515}RENAULT", 0, 140, "Arial", 80, 1, -1, 0, 1);

	/*                        	MAP - AUTO SALON - END                        */

	/*                        	MAP - SPAWN                                   */

	new lawless_spawn_1;
	lawless_spawn_1 = lawless_CDE(19538,1891.019,-1713.842,12.343,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 14534, "ab_wooziea", "dt_office_roof", 0);
	lawless_spawn_1 = lawless_CDE(19887,1861.779,-1643.210,12.326,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(19887,1921.658,-1643.203,12.326,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(19887,1921.758,-1721.324,12.326,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(19887,1861.770,-1721.326,12.326,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1687.954,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1843.987,-1634.573,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1663.143,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1638.182,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1712.952,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1729.813,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1951.170,-1676.659,0.821,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1951.170,-1690.004,0.819,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(19538,1890.947,-1651.406,12.343,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 14534, "ab_wooziea", "dt_office_roof", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1687.954,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1843.987,-1634.573,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1663.143,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1638.182,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1712.952,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.001,-1729.813,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.128,-1689.544,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1869.075,-1689.548,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1868.597,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.041,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18766,1832.047,-1685.055,10.404,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18766,1832.052,-1680.442,10.402,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18766,1881.090,-1685.044,10.404,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18766,1881.078,-1679.822,10.402,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1913.919,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1938.726,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1913.919,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1913.908,-1689.548,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18981,1938.821,-1689.548,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18766,1901.880,-1679.833,10.402,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(18766,1901.880,-1685.060,10.400,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_1 = lawless_CDE(19588,1891.335,-1657.714,13.696,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(19545,1864.222,-1644.475,12.906,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	lawless_spawn_1 = lawless_CDE(19545,1926.713,-1644.453,12.906,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	lawless_spawn_1 = lawless_CDE(19545,1925.605,-1720.889,12.906,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	lawless_spawn_1 = lawless_CDE(19545,1863.161,-1720.903,12.906,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	lawless_spawn_1 = lawless_CDE(18981,1939.942,-1713.402,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1915.145,-1713.402,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1890.203,-1713.402,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1865.235,-1713.402,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1844.631,-1713.402,0.686,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1846.193,-1727.917,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1871.147,-1727.917,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1896.130,-1727.913,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1921.077,-1727.921,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1946.031,-1727.907,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1846.101,-1651.540,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1871.033,-1651.531,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1895.978,-1651.530,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1920.817,-1651.530,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1945.811,-1651.524,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1845.332,-1637.370,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1870.258,-1637.365,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1895.154,-1637.358,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1920.031,-1637.358,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(18981,1944.930,-1637.357,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_1 = lawless_CDE(19588,1891.335,-1706.937,13.696,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1568,1852.794,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1941.556,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1941.552,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1930.656,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1930.651,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1920.351,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1920.324,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1909.522,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1899.283,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1888.889,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1878.636,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1868.432,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1857.991,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1847.915,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1837.489,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1909.468,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1899.282,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1888.880,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1878.651,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1868.413,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1857.972,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1847.900,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1837.492,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1911.408,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1900.989,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1890.309,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1879.906,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1869.730,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1858.691,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1838.470,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1849.099,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1838.410,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1849.060,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1858.660,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1869.736,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1879.903,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1890.307,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1900.984,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1911.384,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1921.617,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1932.031,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1942.402,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1921.616,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1932.059,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(1280,1942.429,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_1 = lawless_CDE(18762,1890.902,-1683.659,15.472,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 7650, "vgnusedcar", "lightblue2_32", 0);
	lawless_spawn_1 = lawless_CDE(18762,1890.902,-1681.668,12.688,0.000,90.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 7650, "vgnusedcar", "lightblue2_32", 0);
	lawless_spawn_1 = lawless_CDE(19126,1890.887,-1679.470,13.267,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 7650, "vgnusedcar", "lightblue2_32", 0);
	lawless_spawn_1 = lawless_CDE(19126,1890.899,-1683.749,18.011,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_1, 0, 7650, "vgnusedcar", "lightblue2_32", 0);
	lawless_spawn_1 = lawless_CDE(19543,1932.669,-1682.508,12.443,0.000,0.000,90.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(19543,1849.705,-1682.508,12.371,0.000,0.000,90.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(3660,1845.625,-1681.943,13.741,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(3660,1867.873,-1682.078,13.741,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(700,1835.003,-1682.138,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(700,1856.353,-1682.358,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(700,1878.508,-1682.341,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(748,1844.364,-1686.267,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(748,1844.274,-1678.628,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(748,1867.739,-1678.780,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(748,1867.867,-1685.904,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(3660,1914.493,-1682.321,13.741,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(700,1903.445,-1682.580,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(700,1925.710,-1682.498,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(3660,1937.574,-1682.309,13.741,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(700,1948.207,-1682.417,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(748,1915.195,-1686.298,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(748,1915.074,-1679.195,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(748,1936.976,-1686.193,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(748,1937.128,-1678.765,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1842.362,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1863.181,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1873.562,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1883.980,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1894.403,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1904.848,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1915.230,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1925.720,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1936.100,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1946.402,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1842.380,-1714.186,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1852.704,-1727.256,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1863.193,-1714.130,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1873.665,-1727.197,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1883.952,-1713.961,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1894.376,-1727.243,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1904.816,-1714.107,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1915.173,-1727.319,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1925.599,-1714.058,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1936.057,-1727.291,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1946.489,-1714.057,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1843.555,-1638.100,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1853.930,-1650.913,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1864.428,-1637.971,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1874.737,-1650.856,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1885.136,-1638.049,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1895.541,-1650.801,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1905.935,-1638.069,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1916.348,-1650.851,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1926.750,-1638.026,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1937.180,-1650.900,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(673,1947.573,-1637.984,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1843.493,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1854.004,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1864.351,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1874.709,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1885.220,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1895.719,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1905.881,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1916.451,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1926.834,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1937.169,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(1568,1947.595,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(6965,1909.541,-1682.458,8.426,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(6965,1943.187,-1682.775,8.426,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(6965,1872.456,-1682.020,8.738,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(6965,1838.431,-1681.979,8.842,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(19126,1901.280,-1674.968,12.643,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(19126,1901.294,-1689.946,12.643,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(19126,1881.665,-1689.947,12.643,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_1 = lawless_CDE(19126,1881.648,-1674.957,12.643,0.000,0.000,0.000,600.000,600.000);

	new lawless_spawn_2;
	lawless_spawn_2 = lawless_CDE(19538,1891.019,-1713.842,12.343,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 14534, "ab_wooziea", "dt_office_roof", 0);
	lawless_spawn_2 = lawless_CDE(19887,1861.779,-1643.210,12.326,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(19887,1921.658,-1643.203,12.326,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(19887,1921.758,-1721.324,12.326,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(19887,1861.770,-1721.326,12.326,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1687.954,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1843.987,-1634.573,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1663.143,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1638.182,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1712.952,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1729.813,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1951.170,-1676.659,0.821,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1951.170,-1690.004,0.819,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(19538,1890.947,-1651.406,12.343,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 14534, "ab_wooziea", "dt_office_roof", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1687.954,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1843.987,-1634.573,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1663.143,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1638.182,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1712.952,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.001,-1729.813,10.760,0.000,-84.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.128,-1689.544,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1869.075,-1689.548,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1868.597,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.041,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18766,1832.047,-1685.055,10.404,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18766,1832.052,-1680.442,10.402,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18766,1881.090,-1685.044,10.404,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18766,1881.078,-1679.822,10.402,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1913.919,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1938.726,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1913.919,-1675.326,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1913.908,-1689.548,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18981,1938.821,-1689.548,0.398,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18766,1901.880,-1679.833,10.402,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(18766,1901.880,-1685.060,10.400,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "adeta", 0);
	lawless_spawn_2 = lawless_CDE(19588,1891.335,-1657.714,13.696,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(19545,1864.222,-1644.475,12.906,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	lawless_spawn_2 = lawless_CDE(19545,1926.713,-1644.453,12.906,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	lawless_spawn_2 = lawless_CDE(19545,1925.605,-1720.889,12.906,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	lawless_spawn_2 = lawless_CDE(19545,1863.161,-1720.903,12.906,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 14534, "ab_wooziea", "ab_tileDiamond", 0);
	lawless_spawn_2 = lawless_CDE(18981,1939.942,-1713.402,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1915.145,-1713.402,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1890.203,-1713.402,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1865.235,-1713.402,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1844.631,-1713.402,0.686,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1846.193,-1727.917,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1871.147,-1727.917,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1896.130,-1727.913,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1921.077,-1727.921,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1946.031,-1727.907,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1846.101,-1651.540,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1871.033,-1651.531,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1895.978,-1651.530,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1920.817,-1651.530,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1945.811,-1651.524,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1845.332,-1637.370,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1870.258,-1637.365,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1895.154,-1637.358,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1920.031,-1637.358,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(18981,1944.930,-1637.357,0.688,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 13691, "bevcunto2_lahills", "aamanbev96x", 0);
	lawless_spawn_2 = lawless_CDE(19588,1891.335,-1706.937,13.696,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1568,1852.794,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1941.556,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1941.552,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1930.656,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1930.651,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1920.351,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1920.324,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1909.522,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1899.283,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1888.889,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1878.636,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1868.432,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1857.991,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1847.915,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1837.489,-1721.176,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1909.468,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1899.282,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1888.880,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1878.651,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1868.413,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1857.972,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1847.900,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1837.492,-1720.495,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1911.408,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1900.989,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1890.309,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1879.906,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1869.730,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1858.691,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1838.470,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1849.099,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1838.410,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1849.060,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1858.660,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1869.736,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1879.903,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1890.307,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1900.984,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1911.384,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1921.617,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1932.031,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1942.402,-1644.009,13.320,0.000,0.000,-90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1921.616,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1932.059,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(1280,1942.429,-1644.727,13.320,0.000,0.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 1, 2755, "ab_dojowall", "mp_apt1_roomfloor", 0);
	lawless_spawn_2 = lawless_CDE(18762,1890.902,-1683.659,15.472,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 7650, "vgnusedcar", "lightblue2_32", 0);
	lawless_spawn_2 = lawless_CDE(18762,1890.902,-1681.668,12.688,0.000,90.000,90.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 7650, "vgnusedcar", "lightblue2_32", 0);
	lawless_spawn_2 = lawless_CDE(19126,1890.887,-1679.470,13.267,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 7650, "vgnusedcar", "lightblue2_32", 0);
	lawless_spawn_2 = lawless_CDE(19126,1890.899,-1683.749,18.011,0.000,0.000,0.000,600.000,600.000);
	SetDynamicObjectMaterial(lawless_spawn_2, 0, 7650, "vgnusedcar", "lightblue2_32", 0);
	lawless_spawn_2 = lawless_CDE(19543,1932.669,-1682.508,12.443,0.000,0.000,90.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(19543,1849.705,-1682.508,12.371,0.000,0.000,90.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(3660,1845.625,-1681.943,13.741,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(3660,1867.873,-1682.078,13.741,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(700,1835.003,-1682.138,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(700,1856.353,-1682.358,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(700,1878.508,-1682.341,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(748,1844.364,-1686.267,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(748,1844.274,-1678.628,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(748,1867.739,-1678.780,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(748,1867.867,-1685.904,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(3660,1914.493,-1682.321,13.741,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(700,1903.445,-1682.580,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(700,1925.710,-1682.498,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(3660,1937.574,-1682.309,13.741,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(700,1948.207,-1682.417,12.367,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(748,1915.195,-1686.298,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(748,1915.074,-1679.195,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(748,1936.976,-1686.193,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(748,1937.128,-1678.765,12.368,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1842.362,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1863.181,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1873.562,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1883.980,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1894.403,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1904.848,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1915.230,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1925.720,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1936.100,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1946.402,-1720.833,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1842.380,-1714.186,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1852.704,-1727.256,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1863.193,-1714.130,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1873.665,-1727.197,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1883.952,-1713.961,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1894.376,-1727.243,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1904.816,-1714.107,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1915.173,-1727.319,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1925.599,-1714.058,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1936.057,-1727.291,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1946.489,-1714.057,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1843.555,-1638.100,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1853.930,-1650.913,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1864.428,-1637.971,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1874.737,-1650.856,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1885.136,-1638.049,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1895.541,-1650.801,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1905.935,-1638.069,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1916.348,-1650.851,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1926.750,-1638.026,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1937.180,-1650.900,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(673,1947.573,-1637.984,10.925,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1843.493,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1854.004,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1864.351,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1874.709,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1885.220,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1895.719,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1905.881,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1916.451,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1926.834,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1937.169,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(1568,1947.595,-1644.588,12.902,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(6965,1909.541,-1682.458,8.426,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(6965,1943.187,-1682.775,8.426,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(6965,1872.456,-1682.020,8.738,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(6965,1838.431,-1681.979,8.842,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(19126,1901.280,-1674.968,12.643,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(19126,1901.294,-1689.946,12.643,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(19126,1881.665,-1689.947,12.643,0.000,0.000,0.000,600.000,600.000);
	lawless_spawn_2 = lawless_CDE(19126,1881.648,-1674.957,12.643,0.000,0.000,0.000,600.000,600.000);

	/*                        	MAP - SPAWN - END                             */

	/*                        	MAP - BIG CENTAR                              */

	new win1 = lawless_COB(19353, 2988.31348, -2024.65710, 15.11091,   0.00000, 0.00000, 90.00000);//zelena
	SetObjectMaterialText(win1, "{96c143}WIN", 0, 140, "Arial", 150, 1, -1, 0, 1);
	new wlogo = lawless_COB(19353, 2985.89263, -2024.60632, 15.11091,   0.00000, 0.00000, 90.00000);//crna
	SetObjectMaterialText(wlogo, "{96c143}W", 0, 140, "Arial", 100, 1, -1, 0, 1);
	new wmoto = lawless_COB(19353, 2985.89263, -2024.60632, 14.4091,   0.00000, 0.00000, 90.00000);//crna
	SetObjectMaterialText(wmoto, "{FFFFFF}I NA WEBU I NA ZEMLJI", 0, 140, "Arial", 40, 1, -1, 0, 1);
	new win2 = lawless_COB(19353, 2983.29419, -2024.60779, 15.11091,   0.00000, 0.00000, 90.00000);//zelena
	SetObjectMaterialText(win2, "{96c143}WIN", 0, 140, "Arial", 150, 1, -1, 0, 1);
	new winkrug = lawless_CDO(1822, 2986.40356, -2025.06592, 15.61690,   0.00000, 90.00000, 90.00000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(winkrug, 0, 2361, "shopping_freezers", "white", 0xFF96c143);
	new winwin1 = lawless_COB(19353, 2983.67651, -2027.40210, 12.65691,   0.00000, 0.00000, 90.00000);//crna
	SetObjectMaterialText(winwin1, "{000000}WIN WIN", 0, 140, "Arial", 50, 1, -1, 0, 1);
	new winwin2 = lawless_COB(19353, 2980.75610, -2027.41357, 12.65691,   0.00000, 0.00000, 90.00000);//crna
	SetObjectMaterialText(winwin2, "{000000}WIN WIN", 0, 140, "Arial", 50, 1, -1, 0, 1);
	new winwin3 = lawless_COB(19353, 2977.63550, -2027.40747, 12.65691,   0.00000, 0.00000, 90.00000);//crna
	SetObjectMaterialText(winwin3, "{000000}WIN WIN", 0, 140, "Arial", 50, 1, -1, 0, 1);
	new winwin4 = lawless_COB(19353, 2974.39380, -2027.38660, 12.65691,   0.00000, 0.00000, 90.00000);//crna
	SetObjectMaterialText(winwin4, "{000000}WIN WIN", 0, 140, "Arial", 50, 1, -1, 0, 1);
	new puticbig = lawless_CDO(19454, 2986.58301, -2023.28796, 10.07800,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(puticbig, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0);
	new crnawin[30];
	crnawin[0] = lawless_CDO(18980, 2991.17090, -2027.49585, 2.85320,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[1] = lawless_CDO(18980, 2972.24146, -2027.30444, 2.85320,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[2] = lawless_CDO(19454, 2988.17651, -2032.14404, 12.76470,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[3] = lawless_CDO(19454, 2985.05249, -2032.14404, 12.76470,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[4] = lawless_CDO(19454, 2982.31128, -2032.14404, 12.76470,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[5] = lawless_CDO(19454, 2979.36646, -2032.14404, 12.76470,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[6] = lawless_CDO(19454, 2978.12793, -2032.84290, 12.76470,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[7] = lawless_CDO(19454, 2976.17896, -2032.14404, 12.76470,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[8] = lawless_CDO(19454, 2976.58569, -2032.25452, 12.76470,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	crnawin[9] = lawless_CDO(19454, 2984.89429, -2032.80444, 12.76470,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[10] = lawless_CDO(18766, 2985.96582, -2027.90320, 12.01230,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[11] = lawless_CDO(18766, 2976.79980, -2027.90320, 12.01231,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[12] = lawless_CDO(18980, 2972.24146, -2037.33411, 2.85320,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[13] = lawless_CDO(18980, 2991.19092, -2037.33411, 2.85320,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[14] = lawless_CDO(18766, 2974.21753, -2029.57483, 14.60489,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[15] = lawless_CDO(18766, 2974.21753, -2029.57483, 15.57900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[16] = lawless_CDO(18766, 2979.20483, -2029.57483, 14.60490,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[17] = lawless_CDO(18766, 2979.20483, -2029.57483, 15.57900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[18] = lawless_CDO(18766, 2984.19556, -2029.57483, 14.60490,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[19] = lawless_CDO(18766, 2989.18164, -2029.57483, 14.60490,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[20] = lawless_CDO(18766, 2984.19556, -2029.57483, 15.57900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[21] = lawless_CDO(18766, 2989.18164, -2029.57483, 15.57900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[22] = lawless_CDO(18766, 2989.18408, -2032.83362, 14.60490,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[23] = lawless_CDO(18766, 2984.19238, -2032.83362, 14.60490,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[24] = lawless_CDO(18766, 2979.20020, -2032.83362, 14.60490,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[25] = lawless_CDO(18766, 2974.22021, -2032.83362, 14.60490,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[26] = lawless_CDO(18766, 2974.22021, -2032.83362, 15.57900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[27] = lawless_CDO(18766, 2979.20020, -2032.83362, 15.57900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[28] = lawless_CDO(18766, 2984.19238, -2032.83362, 15.57900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	crnawin[29] = lawless_CDO(18766, 2989.18408, -2032.83362, 15.57900,   90.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);

	for(new i = 0; i < sizeof(crnawin); i++)
	{
		SetDynamicObjectMaterial(crnawin[i], 0, 2361, "shopping_freezers", "white", 0xFF2c2c2c);
	}

	new zelenostaklowin[6];
	zelenostaklowin[0] = lawless_CDO(19377, 2985.85352, -2027.41736, 10.35310,   90.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	zelenostaklowin[1] = lawless_CDO(19377, 2977.00391, -2027.42444, 10.35310,   90.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	zelenostaklowin[2] = lawless_CDO(19377, 2991.57153, -2032.27332, 10.35310,   90.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	zelenostaklowin[3] = lawless_CDO(19377, 2986.32251, -2037.51990, 10.35310,   90.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	zelenostaklowin[4] = lawless_CDO(19377, 2977.43140, -2037.53882, 10.35310,   90.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	zelenostaklowin[5] = lawless_CDO(19377, 2971.86157, -2032.32397, 10.35310,   90.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);

	for(new i = 0; i < sizeof(zelenostaklowin); i++)
	{
		SetDynamicObjectMaterial(zelenostaklowin[i], 0, 2361, "shopping_freezers", "white", 0xFF96c143);
	}

	new winograda = lawless_CDO(19325, 2981.50342, -2023.78601, 8.99977,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(winograda, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	new ogradawin[11];
	ogradawin[0] = lawless_CDO(18766, 2975.75073, -2024.16284, 8.62900,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	ogradawin[1] = lawless_CDO(18766, 2971.24414, -2028.68262, 8.62900,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	ogradawin[2] = lawless_CDO(18980, 2984.35083, -2024.16284, -1.36880,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	ogradawin[3] = lawless_CDO(18980, 2988.81030, -2024.16284, -1.36880,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	ogradawin[4] = lawless_CDO(18980, 2989.79199, -2024.16284, -1.36880,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	ogradawin[5] = lawless_CDO(18980, 2990.78125, -2024.16284, -1.36880,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	ogradawin[6] = lawless_CDO(18980, 2991.76660, -2024.16284, -1.36880,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	ogradawin[7] = lawless_CDO(18766, 2971.24780, -2033.31140, 8.62900,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	ogradawin[8] = lawless_CDO(18766, 2980.40530, -2037.82040, 8.62900,    0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	ogradawin[9] = lawless_CDO(18766, 2991.49536, -2033.32483, 8.62900,   0.00000, 0.00000, 90.00000,-1,-1,-1,300.000,300.000);
	ogradawin[10] = lawless_CDO(18766, 2986.96851, -2037.83801, 8.62900,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	ogradawin[10] = lawless_CDO(18766, 2980.40527, -2037.82043, 8.62900,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);

	for(new i = 0; i < sizeof(ogradawin); i++)
	{
	    SetDynamicObjectMaterial(ogradawin[i], 0, 16639, "a51_labs", "dam_terazzo", 0);
	}

	new podwin[6];
	podwin[0] = lawless_CDO(19377, 2986.56982, -2028.64099, 10.08650,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	podwin[1] = lawless_CDO(19377, 2976.08032, -2028.64099, 10.08650,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	podwin[2] = lawless_CDO(19377, 2985.76611, -2032.14490, 11.07630,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	podwin[3] = lawless_CDO(19377, 2977.83936, -2032.14490, 11.07630,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	podwin[4] = lawless_CDO(19377, 2985.76611, -2032.14490, 10.16420,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);
	podwin[5] = lawless_CDO(19377, 2977.83936, -2032.14490, 10.16420,   0.00000, 90.00000, 0.00000,-1,-1,-1,300.000,300.000);

	for(new i = 0; i < sizeof(podwin); i++)
	{
	    SetDynamicObjectMaterial(podwin[i], 0, 14846, "genintintpoliceb", "p_floor3", 0);
	}

	lawless_CDO(1569, 2985.12036, -2027.36450, 10.12880,   0.00000, 0.00000, 0.00000,-1,-1,-1,300.000,300.000);
	lawless_CDO(1569, 2988.10254, -2027.36450, 10.12880,   0.00000, 0.00000, 180.00000,-1,-1,-1,300.000,300.000);
	new bigcentar = lawless_COB(3715, 2867.26587, -1962.96167, 19.24680,   0.00000, 0.00000, 90.00000);
	SetObjectMaterial(bigcentar, 0, 10765, "airportgnd_sfse", "black64", 0);
	SetObjectMaterial(bigcentar, 2, 10765, "airportgnd_sfse", "white", 0);
	new arhitektepodloga = lawless_COB(19435, 2867.29736, -1974.71045, 10.88140,   90.00000, 90.00000, 90.00000);
	SetObjectMaterial(arhitektepodloga, 0, 2361, "shopping_freezers", "white", 0xFFFFFFFF);
	new arhitektepodloga1 = lawless_COB(19435, 2867.29736, -1974.71045, 12.46480,   90.00000, 90.00000, 90.00000);
	SetObjectMaterial(arhitektepodloga1, 0, 2361, "shopping_freezers", "white", 0xFFFFFFFF);
	new natpisbig = lawless_COB(4238, 2867.17798, -1963.08972, 19.60980,   0.00000, 0.00000, -59.76000);
	SetObjectMaterialText(natpisbig, "{0d1f7e}BIG {000000}CENTAR", 0, 140, "Arial", 95, 1, -1, 0, 1);
	new natpisbig1 = lawless_COB(4238, 2867.35474, -1963.08276, 19.60980,   0.00000, 0.00000, -239.70006);
	SetObjectMaterialText(natpisbig1, "{0d1f7e}BIG {000000}CENTAR", 0, 140, "Arial", 95, 1, -1, 0, 1);
	new levuarhitekta = lawless_COB(19353, 2867.29492, -1974.56616, 12.46234,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(levuarhitekta, "{000000}Exterier architect: {0d1f7e}Levu", 0, 140, "Arial", 30, 1, -1, 0, 1);
	new relaxarhitekta = lawless_COB(19353, 2867.29492, -1974.56616, 11.90466,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(relaxarhitekta, "{000000}Enterier architect: {0d1f7e}Relaxx", 0, 140, "Arial", 30, 1, -1, 0, 1);
	new projekatkostao = lawless_COB(19353, 2867.29492, -1974.56616, 10.80466,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(projekatkostao, "{000000}PROJECT COST", 0, 140, "Arial", 30, 1, -1, 0, 1);
	new desetmiliona = lawless_COB(19353, 2867.29492, -1974.56616, 10.62466,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(desetmiliona, "{0d1f7e}94.500.000$", 0, 140, "Arial", 30, 1, -1, 0, 1);
	new big = lawless_COB(19353, 2969.76685, -1981.43103, 11.57071,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(big, "{0d1f7e}BIG", 0, 140, "Arial", 150, 1, -1, 0, 1);
	new big1 = lawless_COB(19353, 2969.77881, -1978.58716, 10.86870,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(big1, "{FFFFFF}CENTAR", 0, 140, "Arial", 100, 1, -1, 0, 1);
	new big2 = lawless_COB(19353, 2969.77856, -1978.58716, 11.57071,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(big2, "{0d1f7e}BIG", 0, 140, "Arial", 150, 1, -1, 0, 1);
	new big3 = lawless_COB(19353, 2969.77271, -1981.43103, 10.86870,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(big3, "{FFFFFF}CENTAR", 0, 140, "Arial", 100, 1, -1, 0, 1);
	new big4 = lawless_COB(19353, 2971.19238, -1980.02087, 11.57070,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(big4, "{0d1f7e}BIG", 0, 140, "Arial", 150, 1, -1, 0, 1);
	new big5 = lawless_COB(19353, 2971.19238, -1980.02124, 10.86870,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(big5, "{FFFFFF}CENTAR", 0, 140, "Arial", 100, 1, -1, 0, 1);
	new big6 = lawless_COB(19353, 2968.35449, -1979.98853, 10.86870,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(big6, "{FFFFFF}CENTAR", 0, 140, "Arial", 100, 1, -1, 0, 1);
	new big7 = lawless_COB(19353, 2968.35449, -1979.98450, 11.57070,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(big7, "{0d1f7e}BIG", 0, 140, "Arial", 150, 1, -1, 0, 1);

	new parkicbig;
	parkicbig = lawless_CDO(19454,2969.104,-1950.782,10.085,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 3967, "cj_airprt", "bigbrick", 0);
	parkicbig = lawless_CDO(19454,2969.104,-1941.157,10.085,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 3967, "cj_airprt", "bigbrick", 0);
	parkicbig = lawless_CDO(18981,2977.573,-1943.508,9.633,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 6487, "councl_law2", "grassdeep256", 0);
	parkicbig = lawless_CDO(18981,2960.848,-1943.508,9.653,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 6487, "councl_law2", "grassdeep256", 0);
	parkicbig = lawless_CDO(19377,2984.843,-1936.081,10.145,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 3967, "cj_airprt", "bigbrick", 0);
	parkicbig = lawless_CDO(19377,2976.166,-1936.081,10.147,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 3967, "cj_airprt", "bigbrick", 0);
	parkicbig = lawless_CDO(19377,2965.685,-1936.081,10.147,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 3967, "cj_airprt", "bigbrick", 0);
	parkicbig = lawless_CDO(19377,2955.181,-1936.081,10.147,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 3967, "cj_airprt", "bigbrick", 0);
	parkicbig = lawless_CDO(19377,2953.546,-1936.077,10.137,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 3967, "cj_airprt", "bigbrick", 0);
	parkicbig = lawless_CDO(19377,2965.002,-1975.359,10.128,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 4568, "skyscrap2_lan2", "sl_marblewall2", 0);
	parkicbig = lawless_CDO(19377,2975.444,-1975.359,10.128,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 4568, "skyscrap2_lan2", "sl_marblewall2", 0);
	parkicbig = lawless_CDO(19377,2965.002,-1984.920,10.128,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 4568, "skyscrap2_lan2", "sl_marblewall2", 0);
	parkicbig = lawless_CDO(19377,2975.444,-1984.920,10.128,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 4568, "skyscrap2_lan2", "sl_marblewall2", 0);
	parkicbig = lawless_CDO(18766,2960.227,-1975.569,8.302,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2960.227,-1984.769,8.302,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2964.755,-1989.253,8.302,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2975.716,-1989.253,8.302,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2980.235,-1975.571,8.302,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2980.235,-1984.769,8.302,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2970.097,-1989.256,8.302,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2969.767,-1971.073,8.302,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2974.276,-1980.005,8.302,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2969.767,-1975.492,8.302,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2969.767,-1984.513,8.302,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18766,2965.252,-1980.005,8.302,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 10023, "bigwhitesfe", "archgrnd1_SFE", 0);
	parkicbig = lawless_CDO(18765,2969.772,-1980.010,7.762,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 2361, "shopping_freezers", "white", 0xFF191919);
	parkicbig = lawless_CDO(18763,2969.772,-1980.010,9.913,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 11145, "carrierint_sfs", "ws_shipmetal3", 0);

	parkicbig = lawless_CDO(9833,2969.377,-1980.071,9.043,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2952.246,-1955.311,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2964.351,-1955.237,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2958.309,-1955.296,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2964.670,-1942.640,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2957.948,-1942.723,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2952.126,-1942.624,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2973.904,-1954.925,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2981.078,-1954.902,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2988.380,-1954.673,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2973.904,-1942.625,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2981.078,-1942.625,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(618,2988.380,-1942.625,10.195,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(759,2961.351,-1953.958,10.112,0.000,0.000,-47.879,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(759,2955.342,-1953.978,10.112,0.000,0.000,-47.879,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(759,2977.295,-1953.771,10.112,0.000,0.000,-47.879,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(759,2984.779,-1953.780,10.112,0.000,0.000,-47.879,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(879,2982.616,-1945.984,9.208,0.000,0.000,73.620,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(879,2956.587,-1948.339,9.208,0.000,0.000,-118.740,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(18981,2977.643,-1931.073,-1.318,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);

	SetDynamicObjectMaterial(parkicbig, 0, 6344, "rodeo04_law2", "golf_hedge1", 0);
	parkicbig = lawless_CDO(18981,2960.824,-1931.052,-1.318,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 6344, "rodeo04_law2", "golf_hedge1", 0);
	parkicbig = lawless_CDO(865,2957.430,-1947.883,10.237,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(865,2981.630,-1948.308,10.237,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(18981,2948.812,-1943.054,-1.318,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 6344, "rodeo04_law2", "golf_hedge1", 0);
	parkicbig = lawless_CDO(18981,2989.647,-1943.091,-1.318,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(parkicbig, 0, 6344, "rodeo04_law2", "golf_hedge1", 0);
	parkicbig = lawless_CDO(1280,2971.292,-1945.943,10.535,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2971.280,-1951.443,10.535,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(14400,2972.956,-1948.689,10.372,0.000,0.000,-252.600,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(14400,2964.533,-1947.674,10.372,0.000,0.000,-246.480,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2966.872,-1951.443,10.535,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2987.021,-1940.358,10.535,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2966.872,-1945.943,10.535,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2973.384,-1940.358,10.535,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2964.260,-1940.358,10.535,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2952.090,-1940.358,10.535,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(14402,2980.373,-1942.614,10.372,0.000,0.000,-252.600,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(14402,2958.371,-1942.476,10.372,0.000,0.000,-252.600,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2979.983,-1940.358,10.535,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(1280,2957.696,-1940.358,10.535,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(14402,2985.811,-1942.522,10.372,0.000,0.000,-252.600,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(14402,2975.128,-1942.566,10.372,0.000,0.000,-252.600,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(14402,2964.059,-1942.658,10.372,0.000,0.000,-252.600,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(14402,2952.908,-1942.715,10.372,0.000,0.000,-252.600,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(19603,2972.265,-1977.656,10.395,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(19603,2967.268,-1977.660,10.395,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(19603,2967.268,-1982.487,10.395,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	parkicbig = lawless_CDO(19603,2972.265,-1982.487,10.395,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);

	new zaraglavni = lawless_COB(19353, 2982.97241, -2008.81323, 14.74170,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(zaraglavni, "ZARA", 0, 140, "Aldhabi", 130, 1, -1, 0, 1);
	new zara1 = lawless_COB(19353, 2982.54517, -2004.41174, 12.44190,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(zara1, "ZARA", 0, 140, "Aldhabi", 120, 1, -1, 0, 1);
	new zara2 = lawless_COB(19353, 2982.54736, -2013.45642, 12.44190,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(zara2, "ZARA", 0, 140, "Aldhabi", 120, 1, -1, 0, 1);
	new zarabig;
	zarabig = lawless_CDO(19454,2986.583,-1975.242,10.078,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0);
	zarabig = lawless_CDO(19454,2986.583,-1984.863,10.078,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0);
	zarabig = lawless_CDO(19454,2986.583,-1994.488,10.078,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0);
	zarabig = lawless_CDO(19454,2986.583,-2004.099,10.078,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0);
	zarabig = lawless_CDO(19454,2986.583,-2013.664,10.078,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 3979, "civic01_lan", "sl_laoffblok2wall1", 0);
	zarabig = lawless_CDO(19377,2979.610,-2004.099,10.091,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 6487, "councl_law2", "rodeo3sjm", 0);
	zarabig = lawless_CDO(19377,2979.610,-2013.717,10.091,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 6487, "councl_law2", "rodeo3sjm", 0);

	zarabig = lawless_CDO(18980,2984.386,-1999.772,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2984.386,-2018.048,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2983.384,-2017.105,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2983.393,-2000.747,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2984.386,-2011.087,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2984.386,-2006.806,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2983.400,-2011.087,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2982.408,-2011.087,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2983.400,-2006.806,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18980,2982.408,-2006.806,-1.367,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18766,2978.910,-2018.048,8.629,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18766,2975.866,-1999.771,8.629,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18766,2971.360,-2004.276,8.629,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18766,2978.908,-1999.772,8.629,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18766,2975.873,-2018.047,8.629,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(18766,2971.360,-2013.535,8.629,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 16639, "a51_labs", "dam_terazzo", 0);
	zarabig = lawless_CDO(19377,2978.006,-2016.294,9.759,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0xFF494f5b);
	zarabig = lawless_CDO(19454,2972.619,-2013.717,10.091,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19377,2973.513,-2011.751,9.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0xFF494f5b);
	zarabig = lawless_CDO(19377,2973.511,-2006.070,9.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0xFF494f5b);
	zarabig = lawless_CDO(19377,2977.980,-2001.433,9.759,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 10871, "blacksky_sfse", "ws_skywinsgreen", 0xFF494f5b);
	zarabig = lawless_CDO(19325,2984.877,-2003.166,9.034,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	zarabig = lawless_CDO(19325,2984.874,-2014.648,9.034,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	zarabig = lawless_CDO(19435,2984.070,-2015.839,10.099,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2984.070,-2012.369,10.099,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2984.070,-2002.013,10.099,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2984.070,-2005.508,10.099,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2982.488,-2005.508,10.099,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2982.488,-2002.033,10.099,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2982.488,-2012.369,10.099,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2982.488,-2015.839,10.099,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2980.205,-2000.943,10.119,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2976.721,-2000.943,10.119,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2973.267,-2000.943,10.119,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2972.609,-2003.471,10.119,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2972.607,-2006.937,10.119,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2972.631,-2010.398,10.119,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2972.649,-2013.881,10.119,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2972.607,-2016.056,10.119,0.000,90.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2975.153,-2016.965,10.119,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2978.597,-2016.970,10.119,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19435,2981.101,-2016.822,10.119,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(19454,2972.619,-2004.099,10.091,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 4835, "airoads_las", "grassdry_128HV", 0);
	zarabig = lawless_CDO(18766,2978.033,-2014.442,14.728,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(18766,2978.033,-2009.456,14.728,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(18766,2978.033,-2003.432,14.728,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(18766,2978.033,-2006.568,14.728,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(18980,2982.401,-2016.121,2.602,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(18980,2973.614,-2016.121,2.602,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(18980,2973.614,-2001.699,2.602,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(18980,2982.402,-2001.699,2.602,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(19435,2982.530,-2004.437,12.430,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(19435,2982.530,-2013.466,12.430,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFF494f5b);
	zarabig = lawless_CDO(19377,2982.510,-2011.772,9.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFFf1e7e5);
	zarabig = lawless_CDO(19377,2982.507,-2006.378,9.759,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(zarabig, 0, 2361, "shopping_freezers", "white", 0xFFf1e7e5);
	zarabig = lawless_CDO(1569,2982.558,-2010.315,10.118,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	zarabig = lawless_CDO(1569,2982.558,-2007.400,10.118,0.000,0.000,-90.000,-1,-1,-1,300.000,300.000);
	zarabig = lawless_CDO(816,2983.707,-2004.080,10.218,0.000,0.000,-112.619);
	zarabig = lawless_CDO(816,2983.509,-2013.746,10.218,0.000,0.000,-112.619);

	new OMVtext = lawless_COB(19353, 2924.10449, -1973.40344, 14.79670,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(OMVtext, "OMV", 0, 140, "Arial", 150, 1, -1, 0, 1);
	new OMV1text = lawless_COB(19353, 2946.18652, -1973.40344, 14.79670,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(OMV1text, "OMV", 0, 140, "Arial", 150, 1, -1, 0, 1);
	new omvshop = lawless_COB(19353, 2934.04956, -1989.93811, 11.73000,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(omvshop, "OMV SHOP", 0, 140, "Arial", 90, 1, -15062719, 0, 1);
	new omvplava[7];
	omvplava[0] = lawless_CDO(18766, 2930.20337, -1973.11035, 5.80280,   0.00000, 90.00000, 90.00000);
	omvplava[1] = lawless_CDO(18766, 2939.22534, -1973.12085, 5.80280,   0.00000, 90.00000, 90.00000);
	omvplava[2] = lawless_CDO(18766, 2926.52490, -1976.78882, 14.82800,   90.00000, 90.00000, 0.00000);
	omvplava[3] = lawless_CDO(18766, 2931.50415, -1976.78882, 14.82800,   90.00000, 90.00000, 0.00000);
	omvplava[4] = lawless_CDO(18766, 2936.48535, -1976.78882, 14.82800,   90.00000, 90.00000, 0.00000);
	omvplava[5] = lawless_CDO(18766, 2941.46167, -1976.78882, 14.82800,   90.00000, 90.00000, 0.00000);
	omvplava[6] = lawless_CDO(18766, 2943.75317, -1976.78882, 14.82800,   90.00000, 90.00000, 0.00000);

	for(new i = 0; i < sizeof(omvplava); i++)
	{
	    SetDynamicObjectMaterial(omvplava[i], 0, 10765, "airportgnd_sfse", "white", 0xFF1A2941);
	}

	new omvzelena[13];
	omvzelena[0] = lawless_CDO(18766, 2934.71021, -1971.10828, 8.30195,   0.00000, 0.00000, 0.00000);
	omvzelena[1] = lawless_CDO(18766, 2934.71021, -1975.12891, 8.30200,   0.00000, 0.00000, 0.00000);
	omvzelena[2] = lawless_CDO(19435, 2940.78760, -1990.61731, 11.10360,   0.00000, 90.00000, 0.00000);
	omvzelena[3] = lawless_CDO(19435, 2937.34546, -1990.61731, 11.10360,   0.00000, 90.00000, 0.00000);
	omvzelena[4] = lawless_CDO(19435, 2935.50537, -1991.58069, 11.81370,   90.00000, 0.00000, 0.00000);
	omvzelena[5] = lawless_CDO(19435, 2937.16553, -1990.62598, 12.58020,   0.00000, 90.00000, 0.00000);
	omvzelena[6] = lawless_CDO(19435, 2940.64648, -1990.63672, 12.58020,   0.00000, 90.00000, 0.00000);
	omvzelena[7] = lawless_CDO(19435, 2942.44849, -1991.55872, 11.87370,   90.00000, 0.00000, 0.00000);
	omvzelena[8] = lawless_CDO(18766, 2926.52490, -1986.78760, 14.82800,   90.00000, 90.00000, 0.00000);
	omvzelena[9] = lawless_CDO(18766, 2931.50415, -1986.78760, 14.82800,   90.00000, 90.00000, 0.00000);
	omvzelena[10] = lawless_CDO(18766, 2936.48535, -1986.78760, 14.82800,   90.00000, 90.00000, 0.00000);
	omvzelena[11] = lawless_CDO(18766, 2941.46167, -1986.78760, 14.82800,   90.00000, 90.00000, 0.00000);
	omvzelena[12] = lawless_CDO(18766, 2943.75317, -1986.78760, 14.82800,   90.00000, 90.00000, 0.00000);

	for(new i = 0; i < sizeof(omvzelena); i++)
	{
	    SetDynamicObjectMaterial(omvzelena[i], 0, 10765, "airportgnd_sfse", "white", 0xFF366D1C);
	}

	new omvpod[8];
	omvpod[0] = lawless_CDO(19377, 2924.20215, -1975.36780, 10.22050,   0.00000, 90.00000, 0.00000);
	omvpod[1] = lawless_CDO(19377, 2934.67773, -1975.36780, 10.22050,   0.00000, 90.00000, 0.00000);
	omvpod[2] = lawless_CDO(19377, 2945.15112, -1975.36780, 10.22050,   0.00000, 90.00000, 0.00000);
	omvpod[3] = lawless_CDO(19377, 2924.20215, -1984.99097, 10.22050,   0.00000, 90.00000, 0.00000);
	omvpod[4] = lawless_CDO(19377, 2934.67773, -1984.99097, 10.22050,   0.00000, 90.00000, 0.00000);
	omvpod[5] = lawless_CDO(19377, 2945.15112, -1984.99097, 10.22050,   0.00000, 90.00000, 0.00000);
	omvpod[6] = lawless_CDO(19377, 2931.36719, -1991.09094, 10.20050,   0.00000, 90.00000, 0.00000);
	omvpod[7] = lawless_CDO(19377, 2938.49878, -1991.09094, 10.20050,   0.00000, 90.00000, 0.00000);

	for(new i = 0; i < sizeof(omvpod); i++)
	{
	    SetDynamicObjectMaterial(omvpod[i], 0, 14846, "genintintpoliceb", "p_floor3", 0);
	}

	new omvbela[12];
	omvbela[0] = lawless_CDO(18980, 2934.72119, -1981.66296, 2.67250,   0.00000, 0.00000, 0.00000);
	omvbela[1] = lawless_CDO(18766, 2938.70410, -1990.35876, 10.90220,   0.00000, 0.00000, 0.00000);
	omvbela[2] = lawless_CDO(18766, 2931.28052, -1990.35876, 10.90220,   0.00000, 0.00000, 0.00000);
	omvbela[3] = lawless_CDO(18766, 2926.61133, -1992.34155, 8.41100,   0.00000, 90.00000, 90.00000);
	omvbela[4] = lawless_CDO(18766, 2926.61133, -1997.34033, 8.41100,   0.00000, 90.00000, 90.00000);
	omvbela[5] = lawless_CDO(18766, 2928.64893, -1999.36597, 8.41100,   0.00000, 90.00000, 0.00000);
	omvbela[6] = lawless_CDO(18766, 2943.26733, -1992.35535, 8.41100,   0.00000, 90.00000, 90.00000);
	omvbela[7] = lawless_CDO(18766, 2943.26733, -1997.34033, 8.41100,   0.00000, 90.00000, 90.00000);
	omvbela[8] = lawless_CDO(18766, 2933.60938, -1999.36597, 8.41100,   0.00000, 90.00000, 0.00000);
	omvbela[9] = lawless_CDO(18766, 2941.25586, -1999.34595, 8.41100,   0.00000, 90.00000, 0.00000);
	omvbela[10] = lawless_CDO(18766, 2936.29541, -1999.34595, 8.41100,   0.00000, 90.00000, 0.00000);
	omvbela[11] = lawless_CDO(18766, 2934.71021, -1981.65601, 7.83600,   0.00000, 0.00000, 0.00000);

	for(new i = 0; i < sizeof(omvbela); i++)
	{
	    SetDynamicObjectMaterial(omvbela[i], 0, 10765, "airportgnd_sfse", "white", 0xFFe5e5e5);
	}

	new omvcrna[14];
	omvcrna[0] = lawless_CDO(18980, 2929.27100, -1981.34180, 2.67250,   0.00000, 0.00000, 0.00000);
	omvcrna[1] = lawless_CDO(18980, 2929.27100, -1981.96204, 2.67249,   0.00000, 0.00000, 0.00000);
	omvcrna[2] = lawless_CDO(18766, 2919.42480, -1975.57727, 8.30200,   0.00000, 0.00000, 90.00000);
	omvcrna[3] = lawless_CDO(18766, 2919.42480, -1984.87317, 8.30200,   0.00000, 0.00000, 90.00000);
	omvcrna[4] = lawless_CDO(18766, 2923.92749, -1989.38184, 8.30200,   0.00000, 0.00000, 0.00000);
	omvcrna[5] = lawless_CDO(18766, 2950.35522, -1975.57300, 8.30200,   0.00000, 0.00000, 90.00000);
	omvcrna[6] = lawless_CDO(18766, 2950.35522, -1984.87317, 8.30200,   0.00000, 0.00000, 90.00000);
	omvcrna[7] = lawless_CDO(18766, 2945.84985, -1989.38501, 8.30200,   0.00000, 0.00000, 0.00000);
	omvcrna[8] = lawless_CDO(18766, 2941.68750, -1994.62024, 13.71665,   90.00000, 0.00000, 90.00000);
	omvcrna[9] = lawless_CDO(18766, 2936.70703, -1994.62024, 13.71670,   90.00000, 0.00000, 90.00000);
	omvcrna[10] = lawless_CDO(18766, 2931.72803, -1994.62024, 13.71670,   90.00000, 0.00000, 90.00000);
	omvcrna[11] = lawless_CDO(18766, 2928.05029, -1994.62024, 13.71670,   90.00000, 0.00000, 90.00000);
	omvcrna[12] = lawless_CDO(18980, 2940.16089, -1981.34180, 2.67250,   0.00000, 0.00000, 0.00000);
	omvcrna[13] = lawless_CDO(18980, 2940.16089, -1981.96204, 2.67250,   0.00000, 0.00000, 0.00000);

	for(new i = 0; i < sizeof(omvcrna); i++)
	{
	    SetDynamicObjectMaterial(omvcrna[i], 0, 2361, "shopping_freezers", "white", 0xFF191919);
	}

	new omvpumpe[4];
	omvpumpe[0] = lawless_CDO(1676, 2930.88721, -1981.67371, 11.84860,   0.00000, 0.00000, 0.00000);
	omvpumpe[1] = lawless_CDO(1676, 2933.17749, -1981.67371, 11.84860,   0.00000, 0.00000, 0.00000);
	omvpumpe[2] = lawless_CDO(1676, 2938.60059, -1981.67371, 11.84860,   0.00000, 0.00000, 0.00000);
	omvpumpe[3] = lawless_CDO(1676, 2936.31689, -1981.67371, 11.84860,   0.00000, 0.00000, 0.00000);

	for(new i = 0; i < sizeof(omvpumpe); i++)
	{
	    SetDynamicObjectMaterial(omvpumpe[i], 1, 2361, "shopping_freezers", "white", 0xFF191919);
	}

	new omvstaklo[2];
	omvstaklo[0] = lawless_CDO(19435, 2940.77075, -1989.93701, 11.83879,   90.00000, 90.00000, 0.00000);
	omvstaklo[1] = lawless_CDO(19435, 2937.28540, -1989.93701, 11.83880,   90.00000, 90.00000, 0.00000);

	for(new i = 0; i < sizeof(omvstaklo); i++)
	{
	    SetDynamicObjectMaterial(omvstaklo[i], 0, 9169, "vgslowbuild", "marinawindow1_256", 0xFFFFFFFF);
	}

	new omvtrava = lawless_CDO(19454, 2934.72241, -1972.95178, 10.35490,   0.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(omvtrava, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	lawless_CDO(1569, 2929.61523, -1989.85327, 10.26944,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1569, 2932.61523, -1989.85327, 10.26940,   0.00000, 0.00000, 180.00000);
	lawless_CDO(869, 2933.05933, -1972.99048, 10.73220,   0.00000, 0.00000, 0.00000);
	lawless_CDO(869, 2936.57056, -1972.77917, 10.73220,   0.00000, 0.00000, 0.00000);
	new meridian = lawless_COB(19353, 2935.01831, -1955.52234, 14.40900,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(meridian, "{FFFFFF}MERIDIAN", 0, 140, "Comic Sans MS", 130, 1, -1, 0, 1);
	new mercrvena[24];
	mercrvena[0] = lawless_CDO(19454, 2942.64575, -1953.84778, 12.43480,   0.00000, 90.00000, 90.00000);
	mercrvena[1] = lawless_CDO(18766, 2927.49512, -1955.10718, 8.44368,   0.00000, 0.00000, 0.00000);
	mercrvena[2] = lawless_CDO(18766, 2942.52295, -1955.10681, 8.44370,   0.00000, 0.00000, 0.00000);
	mercrvena[3] = lawless_CDO(18980, 2922.97925, -1955.11755, 2.40656,   0.00000, 0.00000, 0.00000);
	mercrvena[4] = lawless_CDO(18980, 2931.99878, -1955.09985, 2.40660,   0.00000, 0.00000, 0.00000);
	mercrvena[5] = lawless_CDO(18980, 2947.01270, -1955.10767, 2.40660,   0.00000, 0.00000, 0.00000);
	mercrvena[6] = lawless_CDO(18980, 2938.01611, -1955.10767, 2.40660,   0.00000, 0.00000, 0.00000);
	mercrvena[7] = lawless_CDO(18766, 2927.47656, -1953.10632, 14.41210,   90.00000, 0.00000, 0.00000);
	mercrvena[8] = lawless_CDO(18766, 2942.52368, -1953.10266, 14.41210,   90.00000, 0.00000, 0.00000);
	mercrvena[9] = lawless_CDO(19454, 2927.48730, -1953.83948, 12.43480,   0.00000, 90.00000, 90.00000);
	mercrvena[10] = lawless_CDO(19435, 2933.88110, -1954.30371, 13.89510,   0.00000, 90.00000, 0.00000);
	mercrvena[11] = lawless_CDO(19435, 2936.78296, -1954.30371, 13.89510,   0.00000, 90.00000, 0.00000);
	mercrvena[12] = lawless_CDO(19454, 2924.18652, -1943.65967, 14.15500,   0.00000, 90.00000, 0.00000);
	mercrvena[13] = lawless_CDO(19454, 2924.18652, -1943.65967, 10.69234,   0.00000, 90.00000, 0.00000);
	mercrvena[14] = lawless_CDO(19435, 2923.22827, -1948.47009, 12.49140,   0.00000, 0.00000, 90.00000);
	mercrvena[15] = lawless_CDO(19435, 2923.25391, -1938.88733, 12.35140,   0.00000, 0.00000, 90.00000);
	mercrvena[16] = lawless_CDO(19435, 2923.22827, -1948.47009, 12.35140,   0.00000, 0.00000, 90.00000);
	mercrvena[17] = lawless_CDO(19435, 2923.25391, -1938.88733, 12.49140,   0.00000, 0.00000, 90.00000);
	mercrvena[18] = lawless_CDO(19454, 2945.84473, -1943.38049, 14.16580,   0.00000, 90.00000, 0.00000);
	mercrvena[19] = lawless_CDO(19454, 2945.84473, -1943.38049, 10.67250,   0.00000, 90.00000, 0.00000);
	mercrvena[20] = lawless_CDO(19435, 2946.77368, -1948.20264, 12.50280,   0.00000, 0.00000, 90.00000);
	mercrvena[21] = lawless_CDO(19435, 2946.80396, -1938.64038, 12.32280,   0.00000, 0.00000, 90.00000);
	mercrvena[22] = lawless_CDO(19435, 2946.77368, -1948.20264, 12.32280,   0.00000, 0.00000, 90.00000);
	mercrvena[23] = lawless_CDO(19435, 2946.80396, -1938.64038, 12.50280,   0.00000, 0.00000, 90.00000);

	for(new i = 0; i < sizeof(mercrvena); i++)
	{
	    SetDynamicObjectMaterial(mercrvena[i], 0, 2361, "shopping_freezers", "white", 0xFF830000);
	}

	new mersiva[7];
	mersiva[0] = lawless_CDO(18981, 2935.00488, -1943.09277, 9.85680,   0.00000, 90.00000, 0.00000);
	mersiva[1] = lawless_CDO(18766, 2936.75928, -1954.59595, 9.91170,   0.00000, 90.00000, 0.00000);
	mersiva[2] = lawless_CDO(18766, 2931.77954, -1954.59595, 9.91170,   0.00000, 90.00000, 0.00000);
	mersiva[3] = lawless_CDO(18981, 2922.96948, -1943.11426, 2.42180,   0.00000, 0.00000, 0.00000);
	mersiva[4] = lawless_CDO(18981, 2947.02979, -1943.08167, 2.42180,   0.00000, 0.00000, 0.00000);
	mersiva[5] = lawless_CDO(18981, 2935.00244, -1931.05151, 2.42180,   0.00000, 0.00000, 90.00000);
	mersiva[6] = lawless_CDO(18981, 2935.00488, -1943.09277, 14.42400,   0.00000, 90.00000, 0.00000);

	for(new i = 0; i < sizeof(mersiva); i++)
	{
	    SetDynamicObjectMaterial(mersiva[i], 0, 2361, "shopping_freezers", "white", 0xFFbebebe);
	}

	new merprozori[5];
	merprozori[0] = lawless_CDO(19454, 2927.46387, -1955.49158, 12.68010,   0.00000, 0.00000, 90.00000);
	merprozori[1] = lawless_CDO(19454, 2942.50024, -1955.49158, 12.68010,   0.00000, 0.00000, 90.00000);
	merprozori[2] = lawless_CDO(19454, 2934.68335, -1930.60876, 12.45440,   0.00000, 0.00000, 90.00000);
	merprozori[3] = lawless_CDO(19454, 2947.46631, -1943.37378, 12.45440,   0.00000, 0.00000, 0.00000);
	merprozori[4] = lawless_CDO(19454, 2922.54346, -1943.64966, 12.45440,   0.00000, 0.00000, 0.00000);

	for(new i = 0; i < sizeof(merprozori); i++)
	{
	    SetDynamicObjectMaterial(merprozori[i], 0, 3979, "civic01_lan", "sl_laglasswall2", 0xFFbebebe);
	}


	lawless_CDO(1569, 2933.50415, -1955.04065, 10.32310,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1569, 2936.44995, -1955.04065, 10.32310,   0.00000, 0.00000, 180.00000);
	new gymbc;
	new gymbaja = lawless_COB(4238, 2890.4687, -1982.7117, 15.2070, 0.0000, 0.0000, -149.7574);
	SetObjectMaterialText(gymbaja, "GYM BAJA", 0, 140, "Comic Sans MS", 60, 1, -1, 0, 1);
	gymbc = lawless_CDO(18981,2890.835,-1983.062,9.856,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 4828, "airport3_las", "gnhotelwall02_128", 0);
	gymbc = lawless_CDO(6066,2890.640,-1982.584,12.741,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19377,2898.315,-1982.812,10.619,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19377,2903.049,-1987.548,10.619,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19377,2898.312,-1992.269,10.619,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19377,2888.748,-1992.269,10.619,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19377,2883.413,-1982.812,10.619,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19377,2878.678,-1987.536,10.619,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19377,2883.426,-1992.265,10.619,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19377,2890.714,-1982.815,10.619,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19377,2897.874,-1987.558,15.800,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 16640, "a51", "plaintarmac1", 0);
	gymbc = lawless_CDO(19377,2887.423,-1987.558,15.801,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 16640, "a51", "plaintarmac1", 0);
	gymbc = lawless_CDO(19377,2883.881,-1987.558,15.800,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 16640, "a51", "plaintarmac1", 0);
	gymbc = lawless_CDO(19435,2903.064,-1987.636,12.670,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19435,2899.671,-1982.738,14.263,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19435,2903.064,-1987.636,14.263,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19435,2881.936,-1982.762,12.670,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19435,2899.671,-1982.738,12.670,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19435,2878.630,-1987.525,14.263,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19435,2881.936,-1982.762,14.263,90.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19435,2878.630,-1987.525,12.670,90.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(19454,2890.824,-1992.335,13.086,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 3979, "civic01_lan", "sl_laglasswall2", 0);
	gymbc = lawless_CDO(18766,2890.631,-1979.989,8.571,0.000,90.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 10023, "bigwhitesfe", "archgrnd3_SFE", 0);
	gymbc = lawless_CDO(19325,2903.341,-1974.851,9.256,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	gymbc = lawless_CDO(18980,2902.888,-1971.040,-1.175,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(19325,2903.341,-1981.491,9.256,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	gymbc = lawless_CDO(18766,2902.879,-1990.629,8.833,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(18766,2898.363,-1995.134,8.833,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(18980,2878.749,-1971.040,-1.175,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(19325,2878.319,-1974.851,9.256,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	gymbc = lawless_CDO(19325,2878.319,-1981.491,9.256,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	gymbc = lawless_CDO(18766,2878.738,-1990.629,8.833,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(18766,2883.247,-1995.143,8.833,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(18766,2890.850,-1995.104,8.833,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(19325,2882.449,-1970.550,9.256,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	gymbc = lawless_CDO(18980,2885.274,-1971.042,-1.175,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(19325,2899.175,-1970.548,9.256,0.000,0.000,90.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	gymbc = lawless_CDO(18980,2895.469,-1971.045,-1.175,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	SetDynamicObjectMaterial(gymbc, 0, 2423, "cj_ff_counters", "shop_floor1", 0);
	gymbc = lawless_CDO(1569,2889.114,-1979.533,10.332,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	gymbc = lawless_CDO(1569,2892.117,-1979.533,10.332,0.000,0.000,180.000,-1,-1,-1,300.000,300.000);
	gymbc = lawless_CDO(19325,2903.341,-1988.131,9.256,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	gymbc = lawless_CDO(19325,2878.319,-1988.131,9.256,0.000,0.000,0.000,-1,-1,-1,300.000,300.000);
	new mcdonaldsnatpis = lawless_COB(7914, 2892.15845, -1943.95435, 16.06482,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(mcdonaldsnatpis, "MC Donald's", 0, 140, "Forte", 90, 1, -16777216, 0, 1);
	new imlovinit = lawless_COB(19353, 2892.17725, -1944.33411, 13.72650,   0.00000, 0.00000, 90.00000);
	SetObjectMaterialText(imlovinit, "I'm lovin' it!", 0, 140, "Arial", 110, 1, -1, 0, 1);
	new imlovinit1 = lawless_COB(19353, 2873.56641, -1955.38635, 19.52664,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(imlovinit1, "I'm lovin' it!", 0, 140, "Arial", 110, 1, -16760832, 0, 1);
	new imlovinit2 = lawless_COB(19353, 2874.40063, -1955.38635, 19.52660,   0.00000, 0.00000, 0.00000);
	SetObjectMaterialText(imlovinit2, "I'm lovin' it!", 0, 140, "Arial", 110, 1, -16760832, 0, 1);
	new mcdonaldslevu = lawless_CDO(5418, 2882.79688, -1936.12927, 16.67370,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(mcdonaldslevu, 0, 10765, "airportgnd_sfse", "white", 0);
	SetDynamicObjectMaterial(mcdonaldslevu, 1, 1419, "break_fence3", "CJ_FRAME_Glass", 0);
	SetDynamicObjectMaterial(mcdonaldslevu, 2, 4828, "airport3_las", "mirrwind1_LAn", -13553359);
	SetDynamicObjectMaterial(mcdonaldslevu, 4, 10765, "airportgnd_sfse", "white", 0);
	SetDynamicObjectMaterial(mcdonaldslevu, 5, 10765, "airportgnd_sfse", "white", -1);
	SetDynamicObjectMaterial(mcdonaldslevu, 6, 10765, "airportgnd_sfse", "white", -15132391);
	SetDynamicObjectMaterial(mcdonaldslevu, 7, -1, "none", "none", -1);
	SetDynamicObjectMaterial(mcdonaldslevu, 8, 10765, "airportgnd_sfse", "white", -16760832);
	SetDynamicObjectMaterial(mcdonaldslevu, 9, 10765, "airportgnd_sfse", "white", -16760832);
	SetDynamicObjectMaterial(mcdonaldslevu, 10, 10765, "airportgnd_sfse", "white", -16760832);
	SetDynamicObjectMaterial(mcdonaldslevu, 11, 10765, "airportgnd_sfse", "white", -16760832);
	SetDynamicObjectMaterial(mcdonaldslevu, 12, 10765, "airportgnd_sfse", "white", 0);
	SetDynamicObjectMaterial(mcdonaldslevu, 13, 3820, "boxhses_sfsx", "stonewall_la", 0);
	SetDynamicObjectMaterial(mcdonaldslevu, 14, 10765, "airportgnd_sfse", "white", -16760832);
	SetDynamicObjectMaterial(mcdonaldslevu, 15, 10765, "airportgnd_sfse", "white", -16760832);

	new mcpod[4];
	mcpod[0] = lawless_CDO(18981, 2905.40942, -1943.07764, 9.85680,   0.00000, 90.00000, 0.00000);
	mcpod[1] = lawless_CDO(18981, 2880.45508, -1943.07764, 9.85680,   0.00000, 90.00000, 0.00000);
	mcpod[2] = lawless_CDO(18981, 2905.40942, -1926.18762, 9.85600,   0.00000, 90.00000, 0.00000);
	mcpod[3] = lawless_CDO(18981, 2880.45508, -1926.18762, 9.85600,   0.00000, 90.00000, 0.00000);

	for(new i = 0; i < sizeof(mcpod); i++)
	{
	    SetDynamicObjectMaterial(mcpod[i], 0, 14847, "mp_policesf", "mp_cop_vinyl", 0);
	}

	new mczivica[21];
	mczivica[0] = lawless_CDO(18766, 2872.95483, -1955.09595, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[1] = lawless_CDO(18766, 2882.92065, -1955.09595, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[2] = lawless_CDO(18766, 2887.43140, -1953.07690, 6.18880,   0.00000, 90.00000, 90.00000);
	mczivica[3] = lawless_CDO(18766, 2882.91309, -1951.07959, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[4] = lawless_CDO(18766, 2872.95483, -1951.07959, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[5] = lawless_CDO(18766, 2868.44629, -1953.09204, 6.18880,   0.00000, 90.00000, 90.00000);
	mczivica[6] = lawless_CDO(18766, 2912.92139, -1955.09595, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[7] = lawless_CDO(18766, 2902.94067, -1955.09595, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[8] = lawless_CDO(18766, 2898.42969, -1953.09204, 6.18880,   0.00000, 90.00000, 90.00000);
	mczivica[9] = lawless_CDO(18766, 2902.94067, -1951.07959, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[10] = lawless_CDO(18766, 2912.92139, -1951.07959, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[11] = lawless_CDO(18766, 2917.43286, -1953.09204, 6.18880,   0.00000, 90.00000, 90.00000);
	mczivica[12] = lawless_CDO(18981, 2868.45093, -1938.10339, -1.30780,   0.00000, 0.00000, 0.00000);
	mczivica[13] = lawless_CDO(18981, 2917.42529, -1938.10339, -1.30780,   0.00000, 0.00000, 0.00000);
	mczivica[14] = lawless_CDO(18981, 2917.42969, -1926.15833, -1.30780,   0.00000, 0.00000, 0.00000);
	mczivica[15] = lawless_CDO(18981, 2905.42334, -1914.15283, -1.30780,   0.00000, 0.00000, 90.00000);
	mczivica[16] = lawless_CDO(18981, 2880.44434, -1914.15283, -1.30780,   0.00000, 0.00000, 90.00000);
	mczivica[17] = lawless_CDO(18766, 2898.66577, -1924.64282, 8.69620,   0.00000, 0.00000, 90.00000);
	mczivica[18] = lawless_CDO(18766, 2890.02954, -1920.12732, 8.69620,   0.00000, 0.00000, 0.00000);
	mczivica[19] = lawless_CDO(18766, 2885.50806, -1924.64282, 8.69620,   0.00000, 0.00000, 90.00000);
	mczivica[20] = lawless_CDO(18766, 2894.15186, -1920.13281, 8.69620,   0.00000, 0.00000, 0.00000);

	for(new i = 0; i < sizeof(mczivica); i++)
	{
	    SetDynamicObjectMaterial(mczivica[i], 0, 6344, "rodeo04_law2", "golf_hedge1", 0);
	}

	new mctrava[6];
	mctrava[0] = lawless_CDO(19454, 2883.05835, -1953.04468, 10.27940,   0.00000, 90.00000, 90.00000);
	mctrava[1] = lawless_CDO(19454, 2873.50122, -1953.04468, 10.27940,   0.00000, 90.00000, 90.00000);
	mctrava[2] = lawless_CDO(19454, 2903.00122, -1953.04468, 10.27940,   0.00000, 90.00000, 90.00000);
	mctrava[3] = lawless_CDO(19454, 2912.59961, -1953.04468, 10.27940,   0.00000, 90.00000, 90.00000);
	mctrava[4] = lawless_CDO(19377, 2893.73950, -1924.51013, 10.57408,   0.00000, 90.00000, -180.00000);
	mctrava[5] = lawless_CDO(19377, 2890.92798, -1924.51013, 10.57310,   0.00000, 90.00000, -180.00000);

	for(new i = 0; i < sizeof(mctrava); i++)
	{
	    SetDynamicObjectMaterial(mctrava[i], 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	}

	new mcparkinglinije[8];
	mcparkinglinije[0] = lawless_CDO(19454, 2907.91479, -1924.53882, 8.61810,   0.00000, 0.00000, 0.00000);
	mcparkinglinije[1] = lawless_CDO(19454, 2904.94727, -1924.53882, 8.61810,   0.00000, 0.00000, 0.00000);
	mcparkinglinije[2] = lawless_CDO(19454, 2902.12769, -1924.53882, 8.61810,   0.00000, 0.00000, 0.00000);
	mcparkinglinije[3] = lawless_CDO(19454, 2899.29297, -1924.53882, 8.61810,   0.00000, 0.00000, 0.00000);
	mcparkinglinije[4] = lawless_CDO(19454, 2876.84229, -1924.53882, 8.61810,   0.00000, 0.00000, 0.00000);
	mcparkinglinije[5] = lawless_CDO(19454, 2879.57788, -1924.53882, 8.61810,   0.00000, 0.00000, 0.00000);
	mcparkinglinije[6] = lawless_CDO(19454, 2882.26978, -1924.53882, 8.61810,   0.00000, 0.00000, 0.00000);
	mcparkinglinije[7] = lawless_CDO(19454, 2884.97217, -1924.53882, 8.61810,   0.00000, 0.00000, 0.00000);

	for(new i = 0; i < sizeof(mcparkinglinije); i++)
	{
	    SetDynamicObjectMaterial(mcparkinglinije[i], 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	}

	lawless_CDO(8843, 2899.74976, -1946.99915, 10.36780,   0.00000, 0.00000, -90.00000);
	lawless_CDO(8843, 2912.93823, -1934.88684, 10.36780,   0.00000, 0.00000, 0.00000);
	lawless_CDO(8843, 2873.06641, -1934.88684, 10.36780,   0.00000, 0.00000, 180.00000);
	lawless_CDO(8623, 2892.03101, -1923.01379, 11.07695,   0.00000, 0.00000, 0.00000);
	lawless_CDO(717, 2878.06812, -1953.23718, 7.65007,   0.00000, 0.00000, 0.00000);
	lawless_CDO(717, 2908.45654, -1953.15344, 7.65007,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1569, 2890.69824, -1943.22571, 10.31780,   0.00000, 0.00000, 0.00000);
	lawless_CDO(1569, 2893.66455, -1943.22571, 10.31780,   0.00000, 0.00000, 180.00000);

	new tempobylevu;
	new tempo = lawless_COB(4238, 3029.34399, -1966.04382, 24.86060,   0.00000, 0.00000, -59.72000);
	SetObjectMaterialText(tempo, "{004b85}TEMPO", 0, 140, "Impact", 110, 1, -16753921, 0, 1);
	tempobylevu = lawless_CDO(19538,3023.862,-1970.338,10.120,0.000,0.000,-90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 9514, "711_sfw", "ws_carpark2", 0);
	tempobylevu = lawless_CDO(19545,3023.895,-1900.480,10.120,0.000,0.000,-90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 9514, "711_sfw", "ws_carpark2", 0);
	tempobylevu = lawless_CDO(9920,3057.398,-1936.897,-14.887,0.000,0.000,-90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 1, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 2, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(tempobylevu, 3, 1223, "dynsigns", "white64", 0xFF000000);
	SetDynamicObjectMaterial(tempobylevu, 4, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 5, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 6, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	SetDynamicObjectMaterial(tempobylevu, 7, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 8, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 9, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 10, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 11, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 12, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 13, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 14, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 15, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 16, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 17, 1223, "dynsigns", "white64", 0xFFf69249);
	SetDynamicObjectMaterial(tempobylevu, 18, 9514, "711_sfw", "ws_carpark2", 0);
	tempobylevu = lawless_CDO(3584,3043.980,-1919.364,14.086,0.000,0.000,180.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 2, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 3, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 4, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 5, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 6, 5520, "bdupshouse_lae", "shingles3", 0);
	SetDynamicObjectMaterial(tempobylevu, 7, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	tempobylevu = lawless_CDO(3584,3043.980,-2008.005,14.086,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 1, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 2, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 3, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 4, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 5, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tempobylevu, 6, 5520, "bdupshouse_lae", "shingles3", 0);
	SetDynamicObjectMaterial(tempobylevu, 7, 1223, "dynsigns", "white64", 0xFFFFFFFF);

	tempobylevu = lawless_CDO(18766, 3029.85181, -1956.83447, 23.01240,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	tempobylevu = lawless_CDO(18766, 3029.85181, -1956.83447, 26.83000,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	tempobylevu = lawless_CDO(18766, 3029.85181, -1957.61450, 23.01237,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	tempobylevu = lawless_CDO(18766, 3029.85181, -1967.39551, 24.95751,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	tempobylevu = lawless_CDO(18766, 3029.85181, -1957.61450, 26.82996,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	tempobylevu = lawless_CDO(19426, 3029.38355, -1953.70471, 27.51900,   45.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	tempobylevu = lawless_CDO(19426, 3029.37549, -1960.47278, 22.35070,   45.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFFFFFFF);
	tempobylevu = lawless_CDO(19454, 3037.27417, -1900.76978, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.26440, -1909.05237, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.27637, -1919.05420, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.27319, -1928.30554, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.22510, -2025.59485, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.26563, -1936.58984, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.23022, -2017.14795, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.25684, -2008.06580, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.22729, -1998.00464, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(19454, 3037.24756, -1989.90454, 12.09060,   90.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(18981,3036.133,-1950.785,9.820,0.000,90.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 17508, "barrio1_lae2", "brickred", 0);
	tempobylevu = lawless_CDO(18981,3036.133,-1975.779,9.820,0.000,90.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 17508, "barrio1_lae2", "brickred", 0);
	tempobylevu = lawless_CDO(19377,3028.433,-1938.360,5.105,0.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3023.705,-1943.093,5.105,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3023.705,-1952.704,5.105,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3023.705,-1962.322,5.105,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3023.705,-1971.942,5.105,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3023.705,-1981.500,5.105,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3023.705,-1983.509,5.105,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3028.433,-1988.238,5.105,0.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19454,3031.741,-1963.501,11.998,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6522, "cuntclub_law2", "marinawindow1_256", 0);
	tempobylevu = lawless_CDO(18981,3014.865,-1963.490,-1.180,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 4829, "airport_las", "Grass_128HV", 0);
	tempobylevu = lawless_CDO(19588,3016.932,-1963.235,11.088,-0.059,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 14577, "casinovault01", "cof_wood1", 0);
	tempobylevu = lawless_CDO(18766,3016.869,-1951.486,6.315,0.000,90.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 4829, "airport_las", "Grass_128HV", 0);
	tempobylevu = lawless_CDO(18981,3018.882,-1963.487,-1.180,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 4829, "airport_las", "Grass_128HV", 0);
	tempobylevu = lawless_CDO(18766,3016.869,-1975.496,6.315,0.000,90.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 4829, "airport_las", "Grass_128HV", 0);
	tempobylevu = lawless_CDO(18981,2992.243,-1943.089,-1.499,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,2992.243,-1918.124,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,2992.242,-1904.883,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3004.246,-1892.874,-1.499,0.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3029.210,-1892.874,-1.499,0.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3043.084,-1892.871,-0.173,0.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3055.090,-1904.885,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3055.090,-1929.862,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3055.090,-1954.830,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,2992.243,-1983.037,-1.499,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,2992.243,-2008.023,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,2992.249,-2020.964,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3004.271,-2032.974,-1.499,0.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3029.215,-2032.974,-1.499,0.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3043.084,-2032.985,-0.173,0.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3055.090,-2020.985,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3055.090,-1996.008,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18981,3055.080,-1975.912,-0.173,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18980,2992.243,-1955.090,-0.252,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(18980,2992.243,-1971.024,-0.252,0.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 3922, "bistro", "Marble2", 0);
	tempobylevu = lawless_CDO(6959,2992.263,-1991.222,-7.837,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	tempobylevu = lawless_CDO(6959,2992.263,-1934.737,-7.837,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	tempobylevu = lawless_CDO(6959,3012.374,-1892.923,-7.837,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	tempobylevu = lawless_CDO(6959,3012.579,-2033.000,-7.837,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "lanlabra1_M", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-1898.256,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-1908.231,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-1918.189,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-1928.168,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-2027.576,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-1938.128,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-2017.593,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-2007.639,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-1997.667,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(18766,3035.071,-1987.671,9.696,90.000,0.000,90.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 6487, "councl_law2", "Grass_lawn_128HV", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-1898.494,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-1908.937,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-1919.369,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-1929.837,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-2027.278,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-1940.273,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-2016.837,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-2006.376,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-1995.936,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3032.607,-1985.559,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3037.513,-1898.243,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19377,3037.624,-2027.236,5.492,90.000,0.000,0.000);
	SetDynamicObjectMaterial(tempobylevu, 0, 10765, "airportgnd_sfse", "white", 0);
	tempobylevu = lawless_CDO(19426, 3029.39673, -1954.67737, 25.20210,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFbcbdc0);
	tempobylevu = lawless_CDO(19426, 3029.38843, -1955.62134, 23.77780,   90.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFbcbdc0);
	tempobylevu = lawless_CDO(19426, 3029.33838, -1956.12024, 25.64330,   45.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFbcbdc0);
	tempobylevu = lawless_CDO(19426, 3029.41235, -1957.56519, 27.08600,   45.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFbcbdc0);
	tempobylevu = lawless_CDO(19426, 3029.39673, -1954.67737, 26.47460,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFbcbdc0);
	tempobylevu = lawless_CDO(19426, 3029.38989, -1956.42395, 23.77780,   90.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFbcbdc0);
	tempobylevu = lawless_CDO(19426, 3029.32422, -1958.16370, 23.93980,   45.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFf69249);
	tempobylevu = lawless_CDO(19426, 3029.34351, -1956.69470, 22.48680,   45.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFf69249);
	tempobylevu = lawless_CDO(19426, 3029.40039, -1957.9427, 25.38370,   90.00000, 90.00000, 90.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFf69249);
	tempobylevu = lawless_CDO(19426, 3029.39868, -1959.46289, 24.43360,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFf69249);
	tempobylevu = lawless_CDO(19426, 3029.39868, -1959.46289, 23.44340,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFFf69249);
	tempobylevu = lawless_CDO(18766, 3040.43164, -1895.71033, 16.55005,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3047.63013, -1895.71033, 16.55000,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3047.63013, -1895.71033, 11.58310,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3040.43164, -2031.45313, 16.55000,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3040.43164, -1895.71033, 11.58310,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3040.43164, -2031.45313, 11.58310,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3047.63013, -2031.45313, 16.55000,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3047.63013, -2031.45313, 11.58310,   0.00000, 0.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3034.12744, -1945.23145, 15.24750,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3034.12524, -1981.44995, 15.24750,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3034.14551, -1973.11804, 15.24750,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3034.14233, -1953.53467, 15.24750,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3039.68359, -2021.47327, 11.86191,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3039.39575, -1904.94348, 11.86191,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3039.65991, -1932.56067, 11.86191,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(18766, 3039.39478, -1993.78662, 11.86191,   0.00000, 90.00000, 0.00000);
	SetDynamicObjectMaterial(tempobylevu, 0, 1223, "dynsigns", "white64", 0xFF000000);
	tempobylevu = lawless_CDO(19532,2930.236,-1963.078,10.117,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(19539,2899.092,-1970.416,10.120,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(19539,2899.043,-1955.660,10.120,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(19546,2992.729,-1970.398,10.120,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(19546,2992.715,-1955.673,10.120,0.000,0.000,180.000);
	tempobylevu = lawless_CDO(19540,2992.722,-2032.810,10.120,0.000,0.000,180.000);
	tempobylevu = lawless_CDO(19539,3023.873,-2032.818,10.120,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(19539,3023.875,-1893.214,10.120,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(19540,2992.716,-1893.200,10.120,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(19540,3055.091,-1893.203,10.120,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(19539,3055.094,-1924.402,10.120,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(19540,3055.055,-2032.822,10.120,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(19539,3055.056,-2001.714,10.120,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(19541,3055.069,-1963.065,10.120,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(19530,3055.053,-2095.313,-72.361,0.000,90.000,-90.000);
	tempobylevu = lawless_CDO(19530,2930.169,-2095.295,-72.361,0.000,90.000,-90.000);
	tempobylevu = lawless_CDO(19530,3117.551,-2032.814,-72.361,0.000,90.000,0.000);
	tempobylevu = lawless_CDO(19530,3117.581,-1893.211,-72.361,0.000,90.000,0.000);
	tempobylevu = lawless_CDO(19530,3117.537,-1973.575,-72.361,0.000,90.000,0.000);
	tempobylevu = lawless_CDO(19530,3055.108,-1830.723,-72.361,0.000,90.000,90.000);
	tempobylevu = lawless_CDO(19530,2930.317,-1830.707,-72.361,0.000,90.000,90.000);
	tempobylevu = lawless_CDO(19544,2908.942,-1838.171,-9.871,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.824,-1972.672,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.831,-1978.492,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.846,-1984.271,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.838,-1990.012,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.821,-1995.832,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.823,-2001.733,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.838,-2007.416,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.799,-1953.490,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.794,-1947.804,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.788,-1942.282,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.800,-1936.562,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(970,2867.813,-1930.780,10.623,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(1226,2873.346,-1969.203,14.152,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(1226,2901.421,-1969.317,14.152,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(1226,2929.484,-1969.297,14.152,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(1226,2957.445,-1969.327,14.152,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(1226,2984.586,-1969.246,14.152,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(1226,2887.587,-1956.884,14.152,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(1226,2915.573,-1956.851,14.152,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(1226,2943.614,-1956.858,14.152,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(1226,2971.775,-1956.963,14.152,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(10183,3027.234,-2008.276,10.134,0.000,0.000,-45.000);
	tempobylevu = lawless_CDO(10183,3027.355,-1919.338,10.134,0.000,0.000,-44.279);
	tempobylevu = lawless_CDO(10183,2996.804,-1992.042,10.134,0.000,0.000,-224.399);
	tempobylevu = lawless_CDO(10183,2996.542,-1913.462,10.134,0.000,0.000,-224.399);
	tempobylevu = lawless_CDO(10183,2996.597,-1933.576,10.134,0.000,0.000,-224.399);
	tempobylevu = lawless_CDO(10183,2996.791,-2012.146,10.134,0.000,0.000,-224.399);
	tempobylevu = lawless_CDO(1569,3031.634,-1964.690,10.301,0.000,0.000,90.000);
	tempobylevu = lawless_CDO(1569,3031.634,-1961.687,10.301,0.000,0.000,-90.000);
	tempobylevu = lawless_CDO(19604,3016.871,-1956.124,11.129,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(19604,3016.871,-1966.115,11.129,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(19604,3016.871,-1970.910,11.129,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(9833,3016.260,-1969.567,6.913,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(9833,3016.188,-1956.906,6.913,0.000,0.000,0.000);
	tempobylevu = lawless_CDO(10183,3027.307,-1914.308,10.134,0.000,0.000,-44.279);
	tempobylevu = lawless_CDO(10183,3027.204,-2013.299,10.134,0.000,0.000,-45.000);

    /*                        	MAP - BIG CENTAR - END	                      */

    printf(""VERS"_SCRIPT - loading lawless_maps.");
    return true;
}

/*============================================================================*/

lawless_loading_SCRIPT_FILES()
{
    new string[256];
    new lawless_string[300];
    
    /*                        		SALON - LOAD                           	  */

	for(new salon = 1; salon < sizeof(A_E); salon++)
	{
		new salonfile[80];
		format(salonfile,sizeof(salonfile),SALON,salon);
		if(fexist(salonfile))
		{
			INI_ParseFile(salonfile,"loadSalons", .bExtra = true, .extra = salon);
			if(A_E[salon][salon_created] == 1)
			{
			    lawless_maxsalon++;
                if(A_E[salon][salon_owned] == 0)
				{
				    format(lawless_string,sizeof(lawless_string),"{DDFF00}[OWNERSHIP - NON OWNED - %d]\n\
					{FFFFFF}LEVEL - '%d'.\n\
					{FFFFFF}CENA - '$%d'.\n\
					{FFFFFF}IME AUTOSALONA - '%s'.\n\n\
					{FFFFFF}ZA KUPOVINU - '/KUPIAUTOSALON'.",salon,A_E[salon][salon_level],A_E[salon][salon_money],A_E[salon][salon_name]);
				    lawless_salon_pickup[salon] = lawless_CDP(1239,1,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2]);
				    lawless_salon_label[salon] = lawless_C3D(lawless_string,-1,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2],5);
                    lawless_createdynamic_map_salon[salon] = lawless_MAPA(A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2],55,-1,-1,-1,-1,100);
				}
				else if(A_E[salon][salon_owned] == 1)
				{
				    new lawless_buy[20];
				    if(A_E[salon][salon_buy]) { lawless_buy = "OMOGUCENA"; } else { lawless_buy = "ONEMOGUCENA"; }
                    format(lawless_string,sizeof(lawless_string),"{DDFF00}[OWNERSHIP - OWNED - %s - %s - %d]\n\
					{FFFFFF}KUPOVINA VOZILA - '%s'.\n\
					{FFFFFF}KORISTITE '/KUPIVOZILO' ZA KUPOVINU.",A_E[salon][salon_owner],A_E[salon][salon_name],salon,lawless_buy);
					lawless_salon_pickup[salon] = lawless_CDP(1239,1,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2]);
					lawless_salon_label[salon] = lawless_C3D(lawless_string,-1,A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2],5);
					lawless_createdynamic_map_salon[salon] = lawless_MAPA(A_E[salon][salon_position][0],A_E[salon][salon_position][1],A_E[salon][salon_position][2],55,-1,-1,-1,-1,100);
				}
			}
		}
	}
	printf(""VERS"_SCRIPT - loading lawless_autosalon.");

	/*                       SALON - LOAD - END                               */

	/*                       	GPS - LOAD                               	  */

	for(new gpsid = 1; gpsid < sizeof(G_E); gpsid++)
	{
		new lawless_ggps[40];
		format(lawless_ggps,sizeof(lawless_ggps),GPSS,gpsid);
		if(fexist(lawless_ggps))
		{
			INI_ParseFile(lawless_ggps,"loadGPS", .bExtra = true, .extra = gpsid);

			lawless_maxgpsovs++;
		}
	}
	printf(""VERS"_SCRIPT - loading lawless_gps_location.");

	/*                       GPS - LOAD - END			                 	  */

	/*                       ORGANIZACIJA - LOAD                        	  */

	for(new orgid = 1; orgid < MAX_ORG; orgid++)
	{
        new lawless_org[40];
        format(lawless_org,sizeof(lawless_org),ORGS,orgid);
        if(fexist(lawless_org))
		{
            INI_ParseFile(lawless_org,"loadOrganisation", .bExtra = true, .extra = orgid);

            format(string,sizeof(string),"{5D9DB3}[ORGANISATION - %d]\n\
            {FFFFFF}ORGANISATION NAME - {5D9DB3}%s{FFFFFF}.\n\n\
			{FFFFFF}KORISTITE '{5D9DB3}F{FFFFFF}' ZA ULAZAK.",orgid,O_E[orgid][org_name]);
			lawless_organisation_label[orgid] = lawless_C3D(string,-1,O_E[orgid][org_position_ext][0],O_E[orgid][org_position_ext][1],O_E[orgid][org_position_ext][2],5);
           	lawless_organisation_pickup[orgid] = lawless_CDP(1277,1,O_E[orgid][org_position_ext][0],O_E[orgid][org_position_ext][1],O_E[orgid][org_position_ext][2]);
           	lawless_createdynamic_map_org[orgid] = lawless_MAPA(O_E[orgid][org_position_ext][0],O_E[orgid][org_position_ext][1],O_E[orgid][org_position_ext][2],61,-1,-1,-1,-1,100);
           	
           	if(O_E[orgid][org_sef] == 1)
           	{
	           	format(string,sizeof(string),"{E5FF00}[ORGANISATION - %d - SEF]\n\
				{FFFFFF}ORGANISATION NAME - {E5FF00}%s{FFFFFF}.\n\
				{E5FF00}'{FFFFFF}Y{E5FF00}'",orgid,O_E[orgid][org_name]);
				lawless_organisation_sef_label[orgid] = lawless_C3D(string,-1,O_E[orgid][org_sef_position][0],O_E[orgid][org_sef_position][1],O_E[orgid][org_sef_position][2],5);
				lawless_organisation_sef_pickup[orgid] = lawless_CDP(1276,1,O_E[orgid][org_sef_position][0],O_E[orgid][org_sef_position][1],O_E[orgid][org_sef_position][2]);
				
				printf(""VERS"_SCRIPT - loading organisation sef - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_sef] == 0)
           	{
	           	printf(""VERS"_SCRIPT - loading organisation sef is not completed - [ORG - %d]!",orgid);
			}

			if(O_E[orgid][org_vehicles_created][0] == 1)
			{
			    O_E[orgid][org_vehicles_all][0] = CreateVehicle(O_E[orgid][org_vehicle_slot_1],O_E[orgid][org_vehicle_1][0],O_E[orgid][org_vehicle_1][1],O_E[orgid][org_vehicle_1][2],O_E[orgid][org_vehicle_1][3],0,0,30000);

                format(O_E[orgid][org_tablice_slot_1],10,""TABLIC_COL"org_%d",orgid);
				SetVehicleNumberPlate(O_E[orgid][org_vehicle_slot_1],O_E[orgid][org_tablice_slot_1]);

				printf(""VERS"_SCRIPT - loading vehicles slot number 1 - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_vehicles_created][0] == 0)
			{
				printf(""VERS"_SCRIPT - loading vehicles slot number 1 is not completed - [ORG - %d]!",orgid);
			}
			if(O_E[orgid][org_vehicles_created][1] == 1)
			{
			    O_E[orgid][org_vehicles_all][1] = CreateVehicle(O_E[orgid][org_vehicle_slot_2],O_E[orgid][org_vehicle_2][0],O_E[orgid][org_vehicle_2][1],O_E[orgid][org_vehicle_2][2],O_E[orgid][org_vehicle_2][3],0,0,30000);

                format(O_E[orgid][org_tablice_slot_2],10,""TABLIC_COL"org_%d",orgid);
				SetVehicleNumberPlate(O_E[orgid][org_vehicle_slot_2],O_E[orgid][org_tablice_slot_2]);

                printf(""VERS"_SCRIPT - loading vehicles slot number 2 - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_vehicles_created][1] == 0)
			{
				printf(""VERS"_SCRIPT - loading vehicles slot number 2 is not completed - [ORG - %d]!",orgid);
			}
			if(O_E[orgid][org_vehicles_created][2] == 1)
			{
			    O_E[orgid][org_vehicles_all][2] = CreateVehicle(O_E[orgid][org_vehicle_slot_3],O_E[orgid][org_vehicle_3][0],O_E[orgid][org_vehicle_3][1],O_E[orgid][org_vehicle_3][2],O_E[orgid][org_vehicle_3][3],0,0,30000);

                format(O_E[orgid][org_tablice_slot_3],10,""TABLIC_COL"org_%d",orgid);
				SetVehicleNumberPlate(O_E[orgid][org_vehicle_slot_3],O_E[orgid][org_tablice_slot_3]);

                printf(""VERS"_SCRIPT - loading vehicles slot number 3 - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_vehicles_created][2] == 0)
			{
				printf(""VERS"_SCRIPT - loading vehicles slot number 3 is not completed - [ORG - %d]!",orgid);
			}
			if(O_E[orgid][org_vehicles_created][3] == 1)
			{
			    O_E[orgid][org_vehicles_all][3] = CreateVehicle(O_E[orgid][org_vehicle_slot_4],O_E[orgid][org_vehicle_4][0],O_E[orgid][org_vehicle_4][1],O_E[orgid][org_vehicle_4][2],O_E[orgid][org_vehicle_4][3],0,0,30000);

                format(O_E[orgid][org_tablice_slot_4],10,""TABLIC_COL"org_%d",orgid);
				SetVehicleNumberPlate(O_E[orgid][org_vehicle_slot_4],O_E[orgid][org_tablice_slot_4]);

                printf(""VERS"_SCRIPT - loading vehicles slot number 4 - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_vehicles_created][3] == 0)
			{
				printf(""VERS"_SCRIPT - loading vehicles slot number 4 is not completed - [ORG - %d]!",orgid);
			}
			if(O_E[orgid][org_vehicles_created][4] == 1)
			{
			    O_E[orgid][org_vehicles_all][4] = CreateVehicle(O_E[orgid][org_vehicle_slot_5],O_E[orgid][org_vehicle_5][0],O_E[orgid][org_vehicle_5][1],O_E[orgid][org_vehicle_5][2],O_E[orgid][org_vehicle_5][3],0,0,30000);

                format(O_E[orgid][org_tablice_slot_5],10,""TABLIC_COL"org_%d",orgid);
				SetVehicleNumberPlate(O_E[orgid][org_vehicle_slot_5],O_E[orgid][org_tablice_slot_5]);

                printf(""VERS"_SCRIPT - loading vehicles slot number 5 - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_vehicles_created][4] == 0)
			{
				printf(""VERS"_SCRIPT - loading vehicles slot number 5 is not completed - [ORG - %d]!",orgid);
			}
			if(O_E[orgid][org_vehicles_created][5] == 1)
			{
			    O_E[orgid][org_vehicles_all][5] = CreateVehicle(O_E[orgid][org_vehicle_slot_6],O_E[orgid][org_vehicle_6][0],O_E[orgid][org_vehicle_6][1],O_E[orgid][org_vehicle_6][2],O_E[orgid][org_vehicle_6][3],0,0,30000);

				format(O_E[orgid][org_tablice_slot_6],10,""TABLIC_COL"org_%d",orgid);
				SetVehicleNumberPlate(O_E[orgid][org_vehicle_slot_6],O_E[orgid][org_tablice_slot_6]);
                
                printf(""VERS"_SCRIPT - loading vehicles slot number 6 - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_vehicles_created][5] == 0)
			{
				printf(""VERS"_SCRIPT - loading vehicles slot number 6 is not completed - [ORG - %d]!",orgid);
			}
			if(O_E[orgid][org_vehicles_created][6] == 1)
			{
			    O_E[orgid][org_vehicles_all][6] = CreateVehicle(O_E[orgid][org_vehicle_slot_7],O_E[orgid][org_vehicle_7][0],O_E[orgid][org_vehicle_7][1],O_E[orgid][org_vehicle_7][2],O_E[orgid][org_vehicle_7][3],0,0,30000);

                format(O_E[orgid][org_tablice_slot_7],10,""TABLIC_COL"org_%d",orgid);
				SetVehicleNumberPlate(O_E[orgid][org_vehicle_slot_7],O_E[orgid][org_tablice_slot_7]);

				printf(""VERS"_SCRIPT - loading vehicles slot number 7 - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_vehicles_created][6] == 0)
			{
				printf(""VERS"_SCRIPT - loading vehicles slot number 7 is not completed - [ORG - %d]!",orgid);
			}
			if(O_E[orgid][org_vehicles_created][7] == 1)
			{
			    O_E[orgid][org_vehicles_all][7] = CreateVehicle(O_E[orgid][org_vehicle_slot_8],O_E[orgid][org_vehicle_8][0],O_E[orgid][org_vehicle_8][1],O_E[orgid][org_vehicle_8][2],O_E[orgid][org_vehicle_8][3],0,0,30000);

                format(O_E[orgid][org_tablice_slot_8],10,""TABLIC_COL"org_%d",orgid);
				SetVehicleNumberPlate(O_E[orgid][org_vehicle_slot_8],O_E[orgid][org_tablice_slot_8]);

                printf(""VERS"_SCRIPT - loading vehicles slot number 8 - completed - [ORG - %d]!",orgid);
			}
			else if(O_E[orgid][org_vehicles_created][7] == 0)
			{
				printf(""VERS"_SCRIPT - loading vehicles slot number 8 is not completed - [ORG - %d]!",orgid);
			}

			lawless_maxorganisation++;
		}
	}
	printf(""VERS"_SCRIPT - loading lawless_organisation.");

	/*                        	ORGANIZACIJA - LOAD  - END                 	  */
	
	/*                        	HOUSE - LOAD                            	  */

	for(new houseid = 1; houseid < MAX_HOUSES; houseid++)
	{
        new lawless_ho[40];
        format(lawless_ho,sizeof(lawless_ho),HOUS,houseid);
        if(fexist(lawless_ho))
		{
            INI_ParseFile(lawless_ho,"loadHouses", .bExtra = true, .extra = houseid);

            if(H_E[houseid][house_created] == 1)
			{
				if(H_E[houseid][house_owned] == 0)
				{
				    new lawless_h_type[15];
				    if(H_E[houseid][house_type] == 0) { lawless_h_type = "KAMP KUCA"; }
			 		else if(H_E[houseid][house_type] == 1) { lawless_h_type = "VELIKA KUCA"; }
			 		else if(H_E[houseid][house_type] == 2) { lawless_h_type = "SREDNJA KUCA"; }
			 		else if(H_E[houseid][house_type] == 3) { lawless_h_type = "MALA KUCA"; }

				    format(string,sizeof(string),"{7EDDFC}[HOUSE - NON OWNED]\n{FFFFFF}LEVEL - '%d'.\n{FFFFFF}CENA - '$%d'.\n{FFFFFF}VELICINA - '%s'.\n\
					{7EDDFC}ZA KUPOVINU - '/KUPIKUCU'.",H_E[houseid][house_level],H_E[houseid][house_price],lawless_h_type);
				    lawless_houses_label[houseid] = lawless_C3D(string,-1,H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2],5);
					lawless_houses_pickup[houseid] = lawless_CDP(19524,1,H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2]);
                    lawless_createdynamic_map_house[houseid] = lawless_MAPA(H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2],31,-1,-1,-1,-1,100);
				}
				else if(H_E[houseid][house_owned] == 1)
				{
				    new lawless_h_type[15];
				    if(H_E[houseid][house_type] == 0) { lawless_h_type = "KAMP KUCA"; }
			 		else if(H_E[houseid][house_type] == 1) { lawless_h_type = "VELIKA KUCA"; }
			 		else if(H_E[houseid][house_type] == 2) { lawless_h_type = "SREDNJA KUCA"; }
			 		else if(H_E[houseid][house_type] == 3) { lawless_h_type = "MALA KUCA"; }

	                format(string,sizeof(string),"{7EDDFC}[HOUSE - OWNED - %s]\n{FFFFFF}LEVEL - '%d'.\n\
					{FFFFFF}CENA - '$%d'.\n{FFFFFF}VELICINA - '%s'.",H_E[houseid][house_owner],H_E[houseid][house_level],H_E[houseid][house_price],lawless_h_type);
				    lawless_houses_label[houseid] = lawless_C3D(string,-1,H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2],5);
					lawless_houses_pickup[houseid] = lawless_CDP(19522,1,H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2]);
			        lawless_createdynamic_map_house[houseid] = lawless_MAPA(H_E[houseid][house_outside][0],H_E[houseid][house_outside][1],H_E[houseid][house_outside][2],32,-1,-1,-1,-1,100);
				}
				lawless_maxhouses++;
				printf(""VERS"_SCRIPT - loading ownable houses - completed - [HOUSE - %d]!",houseid);
			}
		}
	}
	printf(""VERS"_SCRIPT - loading lawless_houses_ownable.");

    /*                        	HOUSE - LOAD - END                         	  */
	
	/*                        	VEHICLES - LOAD                            	  */
	
	for(new i = 1; i < MAX_CARS; i++)
	{
		new lawless_veh[50];
        format(lawless_veh,sizeof(lawless_veh),VEHS,i);
        if(fexist(lawless_veh))
		{
		    INI_ParseFile(lawless_veh,"loadVehicles", .bExtra = true, .extra = i);
			V_E[i][vehicle_id] = -1;
			
		    if(V_E[i][vehicle_model] != 0)
			{
				V_E[i][vehicle_id] = AddStaticVehicleEx(V_E[i][vehicle_model],V_E[i][vehicle_positions][0],V_E[i][vehicle_positions][1],V_E[i][vehicle_positions][2],V_E[i][vehicle_positions][3],V_E[i][vehicle_colors][0],V_E[i][vehicle_colors][1],30000);
				
				lawless_maxcars++;
				printf(""VERS"_SCRIPT - loading ownable vehicles - completed - [VEH - %d]!",i);
			}
			else if(V_E[i][vehicle_model] == 0)
			{
			    V_E[i][vehicle_id] = -1;
			    V_E[i][vehicle_positions][0] = 0.0;
			    V_E[i][vehicle_positions][1] = 0.0;
			    V_E[i][vehicle_positions][2] = 0.0;
			    V_E[i][vehicle_positions][3] = 0.0;
			    V_E[i][vehicle_colors][0] = 0;
			    V_E[i][vehicle_colors][1] = 0;
			    V_E[i][vehicle_price] = 0;
			    V_E[i][vehicle_owned] = 0;
			    V_E[i][vehicle_locked] = 0;
			    strmid(V_E[i][vehicle_owner],"Niko",0,strlen("Niko"),32);
			    lawless_saveVEHICLES(i);
			    
			    new lawless_delete[64];
				format(lawless_delete,sizeof(lawless_delete),VEHS,i);
    			if(fexist(lawless_delete))
				{
					fremove(lawless_delete);
					lawless_maxcars--;
					
					printf(""VERS"_SCRIPT - deleting lawless_vehicles_ownable - [VEH - %d]",i);
				}
			}
		}
	}
	printf(""VERS"_SCRIPT - loading lawless_vehicles_ownable.");
	
	/*                        	VEHICLES - LOAD  - END     	            	  */
	

	/*                        	LABEL - LOAD                            	  */

	for(new l = 1; l < MAX_LABEL; l++)
	{
		new labels[50];
		format(labels,sizeof(labels),LABS,l);
		if(fexist(labels))
		{
			INI_ParseFile(labels,"loadLabels", .bExtra = true, .extra = l);
			if(L_E[l][label_created] == 1)
			{
				format(string,sizeof(string),L_E[l][label_text]);
				lawless_labeli_label[l] = lawless_C3D(string,-1,L_E[l][label_position][0],L_E[l][label_position][1],L_E[l][label_position][2],5);
			}
			lawless_maxlabela++;
		}
	}
	printf(""VERS"_SCRIPT - loading lawless_label.");

	/*                        	LABEL - LOAD - END                         	  */
	
	return true;
}

/*============================================================================*/

timer lawless_Interpolate[500](playerid)
{
	new camera = random(4)+1;
	if(camera == 1)
	{
    	InterpolateCameraPos(playerid,1949.723144,-1042.112548,86.537628,2015.738769,-1249.116088,25.753694,15000);
		InterpolateCameraLookAt(playerid,1950.192993,-1046.672119,84.540283,2013.468139,-1244.727783,24.987197,15000);
	}
	else if(camera == 2)
	{
		InterpolateCameraPos(playerid,2299.325439,-2159.766113,42.211368,2584.985839,-2327.650146,46.299079,15000);
		InterpolateCameraLookAt(playerid,2304.060546,-2161.342529,41.906867,2580.122314,-2326.588378,45.831016,15000);
	}
	else if(camera == 3)
	{
    	InterpolateCameraPos(playerid,1368.538085,-2592.291259,49.194385,2062.126220,-2593.470214,14.578474,15000);
		InterpolateCameraLookAt(playerid,1373.256347,-2592.078613,47.553489,2057.130126,-2593.463867,14.383211,15000);
	}
	else if(camera == 4)
	{
    	InterpolateCameraPos(playerid,382.858856,-2267.440185,-7.373182,380.098632,-2015.352783,61.335002,15000);
		InterpolateCameraLookAt(playerid,382.723236,-2262.481933,-8.004306,379.970703,-2018.090576,57.153160,15000);
	}
	else if(camera == 5)
	{
		InterpolateCameraPos(playerid,382.858856,-2267.440185,-7.373182,380.098632,-2015.352783,61.335002,15000);
		InterpolateCameraLookAt(playerid,382.723236,-2262.481933,-8.004306,379.970703,-2018.090576,57.153160,15000);
	}
	return false;
}

/*============================================================================*/

timer lawless_CameraLogin[11000](playerid)
{
	new string[512];
	
    lawless_COLOR(playerid,0xAFAFAFAA);

	format(string,sizeof(string),"{FFFFFF}'{5D9DB3}%s{FFFFFF}' dobrodosli nazad na {5D9DB3}Lawless {FFFFFF}- {5D9DB3}Gaming{FFFFFF}server.\n\
	{FFFFFF}Vi posedujete account na nasem serveru.\n\
	{FFFFFF}Sada je potrebno da upisete sifru kako bi se ulogovali.\n\
	{FFFFFF}Za ukucavanje sifre imate '{5D9DB3}30{FFFFFF}' sekundi ili ce te biti kikovani.",lawless_Nick(playerid));
	lawless_SPD(playerid, lawless_LOGINER, DSP, SDIALOG,string,""SERVER_COL"Login",""SERVER_COL"Izlaz");
	return false;
}

/*============================================================================*/

timer lawless_Kick[2000](playerid)
{
    lawless_Chat(playerid,50);
	return Kick(playerid);
}

/*============================================================================*/

timer lawless_Chatinineg[5000](playerid)
{
    if(lawless_Logo[playerid] == 1)
	{
    	lawless_Chatined[playerid] = 0;
	}
	return false;
}

/*============================================================================*/

timer lawless_Camere[1000](playerid)
{
	defer lawless_Interpolate(playerid);
    defer lawless_StartRegister(playerid);
	return false;
}

/*============================================================================*/

timer lawless_StartRegister[20000](playerid)
{
    lawless_Stepens[playerid] = 1;
	return false;
}

/*============================================================================*/

timer lawless_SpawnConfirmed[3000](playerid)
{
    lawless_JOIN_INTERIOR[playerid] = 0; /* STAVLJENO OVDE ZBOG ULASKA/IZALSKA IZ INTERIERA */
    
    lawless_FREEZE(playerid,true);
	return false;
}

/*============================================================================*/

timer lawless_CameraRegister[1000](playerid)
{
    lawless_Chat(playerid,20);
    
	lawless_PTDS(playerid,registering_Data[4][playerid]);
	lawless_PTDS(playerid,registering_Data[5][playerid]);
	lawless_PTDS(playerid,registering_Data[6][playerid]);
	lawless_PTDS(playerid,registering_Data[7][playerid]);
	lawless_PTDS(playerid,registering_Data[8][playerid]);
	lawless_PTDS(playerid,registering_Data[9][playerid]);
	lawless_PTDS(playerid,registering_Data[10][playerid]);
	lawless_PTDS(playerid,registering_Data[11][playerid]);
	lawless_PTDS(playerid,registering_Data[12][playerid]);
	lawless_PTDS(playerid,registering_Data[13][playerid]);
	lawless_PTDS(playerid,registering_Data[14][playerid]);
	lawless_PTDS(playerid,registering_Data[15][playerid]);
	lawless_PTDS(playerid,registering_Data[16][playerid]);
	lawless_PTDS(playerid,registering_Data[17][playerid]);
	lawless_PTDS(playerid,registering_Data[18][playerid]);
	lawless_PTDS(playerid,registering_Data[19][playerid]);
	lawless_PTDS(playerid,registering_Data[20][playerid]);
	lawless_PTDS(playerid,registering_Data[21][playerid]);
	lawless_PTDS(playerid,registering_Data[22][playerid]);
	lawless_PTDS(playerid,registering_Data[23][playerid]);
	lawless_PTDS(playerid,registering_Data[24][playerid]);
	lawless_PTDS(playerid,registering_Data[25][playerid]);
	lawless_PTDS(playerid,registering_Data[26][playerid]);
	lawless_PTDS(playerid,registering_Data[27][playerid]);
	lawless_PTDS(playerid,registering_Data[28][playerid]);
	lawless_PTDS(playerid,registering_Data[29][playerid]);
	lawless_PTDS(playerid,registering_Data[30][playerid]);
	
	SelectTextDraw(playerid,0x33CCFFAA);

	lawless_Password[playerid] = false;
	lawless_Drzava[playerid] = false;
	lawless_Pol[playerid] = false;
	lawless_Godine[playerid] = false;
	lawless_Email[playerid] = false;
	lawless_Security[playerid] = false;
	return false;
}

/*============================================================================*/

timer lawless_ClearAntiBunnyHop[3000](playerid)
{
    if(lawless_BH[playerid] > 0)
	{
	    lawless_FREEZE(playerid,true);
	    ClearAnimations(playerid);
	    lawless_BH[playerid] = 0;
	    lawless_ANTI_BH[playerid] = 0;
	    INFO(playerid,"Efekat bunny hopa je prosao,sada se mozete ponovo kretati - ne krsite pravila servera!");
    }
	return false;
}

/*============================================================================*/

timer lawless_CameraTutorial[20000](playerid)
{
    lawless_PTDH(playerid,tutorial_Data[13][playerid]);
    lawless_PTDH(playerid,tutorial_Data[14][playerid]);
    lawless_PTDH(playerid,tutorial_Data[15][playerid]);
    lawless_PTDH(playerid,tutorial_Data[16][playerid]);

    InterpolateCameraPos(playerid,1146.333862,-1368.498168,42.793483,1257.646118,-1339.669921,32.777511,20000);
	InterpolateCameraLookAt(playerid,1149.192260,-1364.740966,41.146354,1252.847534,-1338.790161,31.682209,20000);

	lawless_PTDS(playerid,tutorial_Data[0][playerid]);
    lawless_PTDS(playerid,tutorial_Data[1][playerid]);
    lawless_PTDS(playerid,tutorial_Data[2][playerid]);
    lawless_PTDS(playerid,tutorial_Data[3][playerid]);
    lawless_PTDS(playerid,tutorial_Data[4][playerid]);
    lawless_PTDS(playerid,tutorial_Data[5][playerid]);
    lawless_PTDS(playerid,tutorial_Data[6][playerid]);
    lawless_PTDS(playerid,tutorial_Data[7][playerid]);
    lawless_PTDS(playerid,tutorial_Data[8][playerid]);
    lawless_PTDS(playerid,tutorial_Data[9][playerid]);
    lawless_PTDS(playerid,tutorial_Data[10][playerid]);
    lawless_PTDS(playerid,tutorial_Data[11][playerid]);
    lawless_PTDS(playerid,tutorial_Data[12][playerid]);

    lawless_PTDSS(playerid,tutorial_Data[14][playerid],"Bolnica Los Santosa ovde ce te se spawnovati,");
    lawless_PTDSS(playerid,tutorial_Data[15][playerid],"kada umrete a troskovi lecenja iznose '$100'.");
    lawless_PTDSS(playerid,tutorial_Data[16][playerid],"Posle smrti sledi novi zivot,budite marljivi.");
	lawless_PTDSS(playerid,tutorial_Data[13][playerid],"2/4");

 	lawless_PTDS(playerid,tutorial_Data[13][playerid]);
    lawless_PTDS(playerid,tutorial_Data[14][playerid]);
    lawless_PTDS(playerid,tutorial_Data[15][playerid]);
    lawless_PTDS(playerid,tutorial_Data[16][playerid]);
    
    defer lawless_CameraTutoriall(playerid);
	return false;
}

/*============================================================================*/

timer lawless_CameraTutoriall[20000](playerid)
{
    InterpolateCameraPos(playerid,1596.260742,-1312.327392,32.691680,1556.117431,-1266.476196,21.463396,20000);
	InterpolateCameraLookAt(playerid,1592.984741,-1308.687377,31.683025,1553.165893,-1262.812255,19.770940,20000);

    lawless_PTDH(playerid,tutorial_Data[13][playerid]);
    lawless_PTDH(playerid,tutorial_Data[14][playerid]);
    lawless_PTDH(playerid,tutorial_Data[15][playerid]);
    lawless_PTDH(playerid,tutorial_Data[16][playerid]);

    lawless_PTDSS(playerid,tutorial_Data[14][playerid],"Auto Salon AUDI - Los Santos");
    lawless_PTDSS(playerid,tutorial_Data[15][playerid],"Kupi brzo prodaj lako - niske cene,visok kvalitet.");
    lawless_PTDSS(playerid,tutorial_Data[16][playerid],"Mozete imati maksimalno 3 vozila/aviona/brodova.");
	lawless_PTDSS(playerid,tutorial_Data[13][playerid],"3/4");

 	lawless_PTDS(playerid,tutorial_Data[13][playerid]);
    lawless_PTDS(playerid,tutorial_Data[14][playerid]);
    lawless_PTDS(playerid,tutorial_Data[15][playerid]);
    lawless_PTDS(playerid,tutorial_Data[16][playerid]);
    
    defer lawless_CameraTutorialls(playerid);
	return false;
}

/*============================================================================*/

timer lawless_CameraTutorialls[15000](playerid)
{
    InterpolateCameraPos(playerid,2073.681152,-1314.203002,38.881980,2005.968139,-1324.642822,31.855728,15000);
	InterpolateCameraLookAt(playerid,2068.926025,-1314.040893,37.344787,2002.030029,-1321.602050,31.360446,15000);

    lawless_PTDH(playerid,tutorial_Data[13][playerid]);
    lawless_PTDH(playerid,tutorial_Data[14][playerid]);
    lawless_PTDH(playerid,tutorial_Data[15][playerid]);
    lawless_PTDH(playerid,tutorial_Data[16][playerid]);

    lawless_PTDSS(playerid,tutorial_Data[14][playerid],"Banka DIAMOND - Los Santos");
    lawless_PTDSS(playerid,tutorial_Data[15][playerid],"Povoljni refinansirajuci krediti za sve gradjane.");
    lawless_PTDSS(playerid,tutorial_Data[16][playerid],"Podigni,ostavi novac,kod nas su kamate najnize,uverite se.");
	lawless_PTDSS(playerid,tutorial_Data[13][playerid],"4/4");

 	lawless_PTDS(playerid,tutorial_Data[13][playerid]);
    lawless_PTDS(playerid,tutorial_Data[14][playerid]);
    lawless_PTDS(playerid,tutorial_Data[15][playerid]);
    lawless_PTDS(playerid,tutorial_Data[16][playerid]);
    defer lawless_CameraTutorialll(playerid);
    
	if(lawless_Tutorial_False[playerid] == 1)
	{
		defer lawless_CameraTutoriallsl(playerid);
	}
	return false;
}

/*============================================================================*/

timer lawless_CameraTutoriallsl[20000](playerid)
{
	lawless_Chat(playerid,20);

    lawless_PTDH(playerid,tutorial_Data[0][playerid]);
    lawless_PTDH(playerid,tutorial_Data[1][playerid]);
    lawless_PTDH(playerid,tutorial_Data[2][playerid]);
    lawless_PTDH(playerid,tutorial_Data[3][playerid]);
    lawless_PTDH(playerid,tutorial_Data[4][playerid]);
    lawless_PTDH(playerid,tutorial_Data[5][playerid]);
    lawless_PTDH(playerid,tutorial_Data[6][playerid]);
    lawless_PTDH(playerid,tutorial_Data[7][playerid]);
    lawless_PTDH(playerid,tutorial_Data[8][playerid]);
    lawless_PTDH(playerid,tutorial_Data[9][playerid]);
    lawless_PTDH(playerid,tutorial_Data[10][playerid]);
    lawless_PTDH(playerid,tutorial_Data[11][playerid]);
    lawless_PTDH(playerid,tutorial_Data[12][playerid]);
 	lawless_PTDH(playerid,tutorial_Data[13][playerid]);
    lawless_PTDH(playerid,tutorial_Data[14][playerid]);
    lawless_PTDH(playerid,tutorial_Data[15][playerid]);
    lawless_PTDH(playerid,tutorial_Data[16][playerid]);

	lawless_saveUser(playerid);

	lawless_SPECC(playerid,false);
 	lawless_SKIN(playerid,P_E[playerid][info_skin]);
	lawless_LEVEL(playerid,P_E[playerid][info_level]);
	lawless_GivePlayerMoney(playerid,P_E[playerid][info_cash]);

	new rand = random(sizeof(RandomCitySpawn));
	SetSpawnInfo(playerid,0,P_E[playerid][info_skin],RandomCitySpawn[rand][0],RandomCitySpawn[rand][1],RandomCitySpawn[rand][2],90,-1,-1,-1,-1,-1,-1);
	lawless_SP(playerid);

	lawless_BankMoney(playerid);
	lawless_EuroMoney(playerid);
	lawless_COLOR(playerid,0xFFFFFFFF);

	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	lawless_SetPlayerHealth(playerid,98.0);
	lawless_FREEZE(playerid,false);

	lawless_CREATE_ORG[playerid] = -1;
	lawless_CREATE_VEHS[playerid] = 0;
	lawless_JOIN_INTERIOR[playerid] = 0;
    lawless_CREATE_RANKS[playerid] = 0;
    lawless_Hospital[playerid] = 0;
    lawless_EDIT_LEVEL[playerid] = 0;
    lawless_GPS_HAVEN[playerid] = 0;
    lawless_ORG_PICKUP[playerid] = -1;
    lawless_ORG_SEF[playerid] = 0;
    lawless_ASKQ_ANSWER[playerid] = 0;
    lawless_BH[playerid] = 0;
    lawless_ANTI_BH[playerid] = 0;
    lawless_GPS_HAVEN[playerid] = 0;
    lawless_SALON[playerid] = -1;
    
    INFO(playerid,"Uspesno ste zavrsili vanredan tutorial,nastavite sa igrom gde ste stali!");
	return false;
}

/*============================================================================*/

timer lawless_CameraTutorialll[20000](playerid)
{
    lawless_Chat(playerid,20);
    
    lawless_PTDH(playerid,tutorial_Data[0][playerid]);
    lawless_PTDH(playerid,tutorial_Data[1][playerid]);
    lawless_PTDH(playerid,tutorial_Data[2][playerid]);
    lawless_PTDH(playerid,tutorial_Data[3][playerid]);
    lawless_PTDH(playerid,tutorial_Data[4][playerid]);
    lawless_PTDH(playerid,tutorial_Data[5][playerid]);
    lawless_PTDH(playerid,tutorial_Data[6][playerid]);
    lawless_PTDH(playerid,tutorial_Data[7][playerid]);
    lawless_PTDH(playerid,tutorial_Data[8][playerid]);
    lawless_PTDH(playerid,tutorial_Data[9][playerid]);
    lawless_PTDH(playerid,tutorial_Data[10][playerid]);
    lawless_PTDH(playerid,tutorial_Data[11][playerid]);
    lawless_PTDH(playerid,tutorial_Data[12][playerid]);
 	lawless_PTDH(playerid,tutorial_Data[13][playerid]);
    lawless_PTDH(playerid,tutorial_Data[14][playerid]);
    lawless_PTDH(playerid,tutorial_Data[15][playerid]);
    lawless_PTDH(playerid,tutorial_Data[16][playerid]);

	P_E[playerid][info_registration] = 1;
	P_E[playerid][info_stat] = 1;
	P_E[playerid][info_level] = 1;
	P_E[playerid][info_euro] = 0;
	P_E[playerid][info_paypoen] = 0;
	P_E[playerid][info_experiens] = 0;
	P_E[playerid][info_colour] = 0;
	P_E[playerid][info_vehsalon] = 9999;
	P_E[playerid][info_insurance] = 0;
	P_E[playerid][info_hungry] = 100;
	P_E[playerid][info_tutorial] = 1;
	P_E[playerid][info_wantedlevel] = 0;
	P_E[playerid][info_vehicles][0] = 9999;
	P_E[playerid][info_vehicles][1] = 9999;
	P_E[playerid][info_vehicles][2] = 9999;
	P_E[playerid][info_vehicles][3] = 9999;
	P_E[playerid][info_cash] += 500;
 	lawless_Logo[playerid] = 1;
  	lawless_saveUser(playerid);

	lawless_SPECC(playerid,false);
 	lawless_SKIN(playerid,P_E[playerid][info_skin]);
	lawless_LEVEL(playerid,P_E[playerid][info_level]);
	lawless_GivePlayerMoney(playerid,P_E[playerid][info_cash]);

	new rand = random(sizeof(RandomCitySpawn));
	SetSpawnInfo(playerid,0,P_E[playerid][info_skin],RandomCitySpawn[rand][0],RandomCitySpawn[rand][1],RandomCitySpawn[rand][2],90,-1,-1,-1,-1,-1,-1);
	lawless_SP(playerid);

	lawless_BankMoney(playerid);
	lawless_EuroMoney(playerid);
	lawless_COLOR(playerid,0xFFFFFFFF);

	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	lawless_SetPlayerHealth(playerid,98.0);
	lawless_FREEZE(playerid,false);

	INFO(playerid,"%s uspesno ste se registrovali, dobrodosli na Lawless Gaming server!",lawless_Nick(playerid));

	defer lawless_SpawnConfirmed(playerid);

	lawless_CREATE_ORG[playerid] = -1;
	lawless_CREATE_VEHS[playerid] = 0;
	lawless_JOIN_INTERIOR[playerid] = 0;
    lawless_CREATE_RANKS[playerid] = 0;
    lawless_Hospital[playerid] = 0;
    lawless_EDIT_LEVEL[playerid] = 0;
    lawless_GPS_HAVEN[playerid] = 0;
    lawless_ORG_PICKUP[playerid] = -1;
    lawless_ORG_SEF[playerid] = 0;
    lawless_ASKQ_ANSWER[playerid] = 0;
    lawless_BH[playerid] = 0;
    lawless_ANTI_BH[playerid] = 0;
    lawless_GPS_HAVEN[playerid] = 0;
    lawless_SALON[playerid] = -1;
    
    new Float:lawless_bar;
	if(P_E[playerid][info_hungry] > 0 ) lawless_bar = P_E[playerid][info_hungry];
	else if(P_E[playerid][info_hungry] <= 0 ) lawless_bar = 0;

    SetPlayerProgressBarValue(playerid,lawless_Glad[playerid],lawless_bar);
    ShowPlayerProgressBar(playerid,lawless_Glad[playerid]);
	return false;
}

/*============================================================================*/

task lawless_TimerFive[420000]()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid++)
    {
        if(lawless_Logo[playerid] == 1)
        {
            if(P_E[playerid][info_admin] == 0)
			{
	            new Float:lawless_hungry;
	            new Float:lawless_health;

	            if(P_E[playerid][info_hungry] == 100)
	            {
	   				P_E[playerid][info_hungry] -= 1;
	            }
	            else if(P_E[playerid][info_hungry] != 100)
	            {
	   				P_E[playerid][info_hungry] -= 1;
	            }

	            if(P_E[playerid][info_hungry] > 0)
				{
					lawless_hungry = P_E[playerid][info_hungry];
				}
				else if(P_E[playerid][info_hungry] <= 0)
				{
					lawless_hungry = 0;
				}

				SetPlayerProgressBarValue(playerid,lawless_Glad[playerid],lawless_hungry);
				GetPlayerHealth(playerid,lawless_health);

				if(P_E[playerid][info_hungry] < 0)
				{
					lawless_SetPlayerHealth(playerid,lawless_health-2);
					INFO(playerid,"Zbog potrebe za hranom,vas 'Health' - ce se smanjivati ukoliko nesto ne preduzmete!");
				}
			}
        }
    }
	return true;
}

/*============================================================================*/

task lawless_BleedingData[1000]()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid++)
    {
		if(lawless_Stepens[playerid] == 1)
		{
	    	lawless_Bleeding[playerid]++;
    	}
    }
	return true;
}

/*============================================================================*/

task lawless_Timing[60000]()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(lawless_Logo[i] == 1)
		{
  			if(P_E[i][info_paypoen] < 59)
     		{
 				P_E[i][info_paypoen]++;
 				if(P_E[i][info_paypoen] == 10 || P_E[i][info_paypoen] == 20 || P_E[i][info_paypoen] == 30 || P_E[i][info_paypoen] == 40 || P_E[i][info_paypoen] == 50) lawless_saveUser(i);
			}
			else
			{
  				lawless_PayDay(i);
  				P_E[i][info_paypoen] = 0;
			}
		}
	}
	return true;
}

/*============================================================================*/

task lawless_Seconds[500]()
{
    if(A_C[anticheat_save] == 1)
	{
	    if(A_C[anticheat_money] == 1)
	 	{
		    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
			{
				if(lawless_Logo[playerid] == 1)
	  			{
					if(P_E[playerid][info_cash] != GetPlayerMoney(playerid))
					{
						ResetPlayerMoney(playerid);
						GivePlayerMoney(playerid,P_E[playerid][info_cash]);
					}
				}
			}
		}
		if(A_C[anticheat_armour] == 1)
		{
		    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
			{
				if(lawless_Logo[playerid] == 1)
	  			{
					new Float:lawless_Armour;
			  		GetPlayerArmour(playerid,lawless_Armour);
			    	if(lawless_Armour > 98)
					{
						lawless_SetPlayerArmour(playerid,98.0);
					}
					return true;
				}
			}
		}
		if(A_C[anticheat_health] == 1)
		{
		    for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
			{
				if(lawless_Logo[playerid] == 1)
	  			{
					new Float:lawless_Health;
			  		GetPlayerHealth(playerid,lawless_Health);
			  		/* STAVITI PROVERU KAD JE KOD SPRUNKOVA */
			    	if(lawless_Health > 99.0)
					{
						lawless_SetPlayerHealth(playerid,98.0);
					}
					return true;
				}
			}
		}
	}
	foreach(Player,i)
	{
	    if(lawless_Logo[i] == 1)
		{
			if(P_E[i][info_admin] == 1)
			{
			    SetPlayerChatBubble(i,"{5D9DB3}[SERVER ADMIN]",0xFFFFFFFF,8.0,10000);

			    lawless_SetPlayerArmour(i,98.0);
	            lawless_SetPlayerHealth(i,98.0);
			}
			else if(P_E[i][info_admin] == 2)
			{
			    SetPlayerChatBubble(i,"{5D9DB3}[SERVER ADMIN]",0xFFFFFFFF,8.0,10000);

			    lawless_SetPlayerArmour(i,98.0);
	            lawless_SetPlayerHealth(i,98.0);
			}
			else if(P_E[i][info_admin] == 3)
			{
			    SetPlayerChatBubble(i,"{5D9DB3}[SERVER ADMIN]",0xFFFFFFFF,8.0,10000);

			    lawless_SetPlayerArmour(i,98.0);
	            lawless_SetPlayerHealth(i,98.0);
			}
			else if(P_E[i][info_admin] == 4)
			{
			    SetPlayerChatBubble(i,"{5D9DB3}[HEAD-ADMIN]",0xFFFFFFFF,8.0,10000);

			    lawless_SetPlayerArmour(i,98.0);
	            lawless_SetPlayerHealth(i,98.0);
			}
			else if(P_E[i][info_admin] == 5)
			{
			    SetPlayerChatBubble(i,"{5D9DB3}[DIREKTOR]",0xFFFFFFFF,8.0,10000);

			    lawless_SetPlayerArmour(i,98.0);
	            lawless_SetPlayerHealth(i,98.0);
			}
	        else if(P_E[i][info_admin] == 6)
			{
			    SetPlayerChatBubble(i,"{5D9DB3}[VLASNIK]",0xFFFFFFFF,8.0,10000);

			    lawless_SetPlayerArmour(i,98.0);
	            lawless_SetPlayerHealth(i,98.0);
			}
			else if(P_E[i][info_admin] == 7)
			{
	            SetPlayerChatBubble(i,"{5D9DB3}[DEVELOPER]",0xFFFFFFFF,8.0,10000);

	            lawless_SetPlayerArmour(i,98.0);
	            lawless_SetPlayerHealth(i,98.0);
			}
			
			if(IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER)
			{
			    if(!lawless_Bicikle(GetVehicleModel(GetPlayerVehicleID(i))))
			    {
			   		new lawless_speed[10];
			   		new Float:vehicle_health;
			   		GetVehicleHealth(GetPlayerVehicleID(i),vehicle_health);
			   		
			   		format(lawless_speed,sizeof(lawless_speed),"%dkm/h",lawless_Brzina(i));
			   		lawless_PTDSS(i,speedo_Data[1][i],lawless_speed);
			   		
			   		if(vehicle_health < 800.0)
				    {
				        lawless_PTDH(i,speedo_Data[3][i]); /* SPEEDO - GASI ZELENI MOTOR */
				        lawless_PTDS(i,speedo_Data[6][i]); /* SPEEDO - ZUTI MOTOR */
				    }
				    else if(vehicle_health < 600.0)
				    {
				        lawless_PTDH(i,speedo_Data[3][i]); /* SPEEDO - GASI ZELENI MOTOR */
				        lawless_PTDH(i,speedo_Data[6][i]); /* SPEEDO - GASI ZUTI MOTOR */
				        lawless_PTDS(i,speedo_Data[9][i]); /* SPEEDO - CRVENI MOTOR */
				    }
				}
			}
		}
	}
	return true;
}

/*============================================================================*/

task lawless_BleedingGata[1000]()
{
    for(new playerid; playerid < MAX_PLAYERS; playerid++)
    {
        if(lawless_Stepens[playerid] == 1)
		{
			if(lawless_Bleeding[playerid] == 1)
			{
			    lawless_COLOR(playerid,0xAFAFAFAA);
			    
	            lawless_PTDS(playerid,registering_Bleeding[0][playerid]);
	    	}
	    	else if(lawless_Bleeding[playerid] == 2)
			{
			    lawless_COLOR(playerid,0xAFAFAFAA);
			    
			    lawless_PTDH(playerid,registering_Bleeding[0][playerid]);
	            lawless_PTDS(playerid,registering_Bleeding[1][playerid]);
	    	}
	    	else if(lawless_Bleeding[playerid] == 3)
			{
			    lawless_COLOR(playerid,0xAFAFAFAA);
			    
			    lawless_PTDH(playerid,registering_Bleeding[0][playerid]);
			    lawless_PTDH(playerid,registering_Bleeding[1][playerid]);
	            lawless_PTDS(playerid,registering_Bleeding[2][playerid]);
	    	}
	    	else if(lawless_Bleeding[playerid] == 4)
			{
			    lawless_COLOR(playerid,0xAFAFAFAA);
			    
			    lawless_PTDH(playerid,registering_Bleeding[0][playerid]);
			    lawless_PTDH(playerid,registering_Bleeding[1][playerid]);
	            lawless_PTDH(playerid,registering_Bleeding[2][playerid]);
	            lawless_PTDS(playerid,registering_Bleeding[3][playerid]);
	    	}
	    	else if(lawless_Bleeding[playerid] == 5)
			{
			    lawless_COLOR(playerid,0xAFAFAFAA);
			    
			    lawless_PTDH(playerid,registering_Bleeding[0][playerid]);
			    lawless_PTDH(playerid,registering_Bleeding[1][playerid]);
			    lawless_PTDH(playerid,registering_Bleeding[2][playerid]);
	            lawless_PTDH(playerid,registering_Bleeding[3][playerid]);
	            lawless_PTDS(playerid,registering_Bleeding[4][playerid]);
	    	}
	    	else if(lawless_Bleeding[playerid] == 6)
			{
	            if(lawless_Logo[playerid] == 0)
	            {
	                lawless_COLOR(playerid,0xAFAFAFAA);
	                
				    lawless_PTDH(playerid,registering_Bleeding[0][playerid]);
				    lawless_PTDH(playerid,registering_Bleeding[1][playerid]);
		            lawless_PTDH(playerid,registering_Bleeding[2][playerid]);
		            lawless_PTDH(playerid,registering_Bleeding[3][playerid]);
		            lawless_PTDH(playerid,registering_Bleeding[4][playerid]);

		            lawless_Bleeding[playerid] = 0;
		            lawless_Stepens[playerid] = 0;
	            	lawless_CameraRegister(playerid);
	            }
	            else if(lawless_Logo[playerid] == 1)
	            {
				    lawless_PTDH(playerid,registering_Bleeding[0][playerid]);
				    lawless_PTDH(playerid,registering_Bleeding[1][playerid]);
		            lawless_PTDH(playerid,registering_Bleeding[2][playerid]);
		            lawless_PTDH(playerid,registering_Bleeding[3][playerid]);
		            lawless_PTDH(playerid,registering_Bleeding[4][playerid]);

		            lawless_Bleeding[playerid] = 0;
		            lawless_Stepens[playerid] = 0;

					if(P_E[playerid][info_colour] == 0)
					{
				        lawless_COLOR(playerid,0xFFFFFFFF);
					}
					else if(P_E[playerid][info_colour] == 1)
					{
					    lawless_COLOR(playerid,0xFF9900FF);
					}
					else if(P_E[playerid][info_colour] == 2)
					{
				        lawless_COLOR(playerid,0x800000FF);
					}
					else if(P_E[playerid][info_colour] == 3)
					{
				        lawless_COLOR(playerid,0x008080FF);
					}
					else if(P_E[playerid][info_colour] == 4)
					{
				        lawless_COLOR(playerid,0xFFC0CBFF);
					}
					else if(P_E[playerid][info_colour] == 5)
					{
				        lawless_COLOR(playerid,0xFF9900FF);
					}
	            }
	    	}
    	}
    }
	return true;
}

/*============================================================================*/

main()
{
	print("\n=============================================");
	print(" Lawless - Online Gaming Community");
	print(" loading - gamemode by - "HEAD_DEVELOPER"");
	print(" loading - owners - "OWNER_1" and "OWNER_2"");
	print(" loading - owners - "OWNER_3" and "OWNER_4"");
	print(" loading - head developer - "HEAD_DEVELOPER"");
	print(" loading - co developer - "CO_DEVELOPER"");
	print(" loading - director - "DIREKTOR"");
	print(" loading - head admin - "HEAD_ADMIN"");
	print(" loading - forum - "FORUM"");
	print("=============================================");
	print(" Lawless - Online Gaming Community");
	print(" loading - gamemode started loading...");
	print(" loading - gamemode has been loaded...");
	print(" loading - let's start samp-server.exe");
	print(" loading - licenses for gamemode - 2016 (c)");
	print("=============================================");
	printf("GPS_LOADED_COMPLETED - [%d/%d]...",lawless_maxgpsovs,MAX_GPS);
	printf("HOUSE_LOADED_COMPLETED - [%d/%d]...",lawless_maxhouses,MAX_HOUSES);
	printf("SALON_LOADED_COMPLETED - [%d/%d]...",lawless_maxsalon,MAX_SALONS);
	printf("LABEL_LOADED_COMPLETED - [%d/%d]...",lawless_maxlabela,MAX_LABEL);
	printf("VEHICLE_LOADED_COMPLETED - [%d/%d]...",lawless_maxcars,MAX_CARS);
	printf("ORGANISATION_LOADED_COMPLETED - [%d/%d]...",lawless_maxorganisation,MAX_ORG);
	printf("=============================================\n");
}

/*============================================================================*/

YCMD:server(playerid, params[], help)
{
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(!strcmp(lawless_Nick(playerid),DEVELOPER,true))
	{
	    lawless_SPD(playerid, lawless_SERVER, DSL, SDIALOG,"{5D9DB3}>> {FFFFFF}AntiCheat protekcije.\n\
		{5D9DB3}>> {FFFFFF}Kikuj sve igrace.\n{5D9DB3}>> {FFFFFF}Setuj donatorsku boju.\n\
		{5D9DB3}>> {FFFFFF}Ocisti chat servera.\n{5D9DB3}>> {FFFFFF}Server info.\n\
		{5D9DB3}>> {FFFFFF}Dinamicno kreiranje.\n{5D9DB3}>> {FFFFFF}Dinamicno brisanje.\n\
		{5D9DB3}>> {FFFFFF}Otkljucaj server.\n{5D9DB3}>> {FFFFFF}Update servera.",""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
	}
	else return ERROR(playerid,"Niste ovlasceni!");
	return true;
}

/*============================================================================*/

YCMD:deleteaccount(playerid, params[], help)
{
	new id_igraca[24];
	new account_file[64];
	new lawless_name[MAX_PLAYER_NAME];
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(!strcmp(lawless_Nick(playerid),DEVELOPER,true))
	{
	    if(sscanf(params,"s[24]",id_igraca)) return USAGE(playerid,"/deleteaccount [Nick(Ime_Prezime)]");
	    if(!strcmp(id_igraca,DEVELOPER,true)) return ERROR(playerid,"Ne mozes to!");
        format(account_file,sizeof(account_file),PATH,id_igraca);
        if(!fexist(account_file)) return ERROR(playerid,"Korisnicki racun '%s' ne postoji u bazi podataka!",id_igraca);

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(lawless_Logo[i] == 1)
		    {
		        GetPlayerName(i,lawless_name,sizeof(lawless_name));
		        if(!strcmp(lawless_name,id_igraca,true))
		        {
		            return ERROR(playerid,"Taj igrac je online - kikuj/banuj ga prvo!");
		        }
		    }
		}
        fremove(account_file);
        INFO(playerid,"Uspesno ste obrisali korisnicki racun igracu '%s', vise ga nece biti u bazi podataka!",id_igraca);
	}
	else return ERROR(playerid,"Niste ovlasceni!");
	return true;
}

/*============================================================================*/

YCMD:makeadmin(playerid, params[], help)
{
	new lawless_id;
	new lawless_max;
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(!strcmp(lawless_Nick(playerid),DEVELOPER,true))
	{
	    if(sscanf(params,"ui",lawless_id,lawless_max)) return USAGE(playerid,"/makeadmin [Nick(Ime_Prezime)] [Admin Level(1-7)]");
	    if(lawless_id == IPI) return ERROR(playerid,"Odabrani igrac trenutno nije online!");
	    if(lawless_max < 0 || lawless_max > 7) return ERROR(playerid,"Ne mozete manje od '0' niti vise od '7' levela!");
	    
	    if(lawless_max == 0)
	    {
	        lawless_COLOR(lawless_id,0xFFFFFF00);
	        
	        P_E[lawless_id][info_admin] = 0;
	        P_E[lawless_id][info_acode] = 0;
	        P_E[playerid][info_admin_hours] = 0;
	        P_E[lawless_id][info_skin] = random(100);
	        lawless_saveUser(lawless_id);
	        
	        lawless_SKIN(lawless_id,P_E[lawless_id][info_skin]);
	        
	        INFO(playerid,"Uspesno ste skinuli 'law_adm' poziciju 'law_adm' - '%s'.",lawless_Nick(lawless_id));
	        INFO(lawless_id,"Skinuta vam je pozicija 'law_adm',hvala vam za sve sto ste ucinili za 'Lawless'!");
	        INFO(lawless_id,"Takodje zbog skidanje pozicija 'law_adm' oduzeti su vam i sati 'law_adm'.");
	    }
	    else if(lawless_max == 1 || lawless_max == 2 || lawless_max == 3 || lawless_max == 4 || lawless_max == 5 || lawless_max == 6 || lawless_max == 7)
	    {
	        if(lawless_max == 1)
			{
	        	INFO(playerid,"Uspesno ste promovisali igraca - '%s' u 'law_adm_SERVER ADMIN' poziciju.",lawless_Nick(lawless_id));
	        	INFO(lawless_id,"Uspesno ste postali 'law_adm_SERVER ADMIN' - poziciju postavio 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
	        }
	        else if(lawless_max == 2)
			{
	        	INFO(playerid,"Uspesno ste promovisali igraca - '%s' u 'law_adm_SERVER ADMIN' poziciju.",lawless_Nick(lawless_id));
	        	INFO(lawless_id,"Uspesno ste postali 'law_adm_SERVER ADMIN' - poziciju postavio 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
	        }
	        else if(lawless_max == 3)
			{
	        	INFO(playerid,"Uspesno ste promovisali igraca - '%s' u 'law_adm_SERVER ADMIN' poziciju.",lawless_Nick(lawless_id));
	        	INFO(lawless_id,"Uspesno ste postali 'law_adm_SERVER ADMIN' - poziciju postavio 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
	        }
	        else if(lawless_max == 4)
			{
	        	INFO(playerid,"Uspesno ste promovisali igraca - '%s' u 'law_adm_HEAD' poziciju.",lawless_Nick(lawless_id));
	        	INFO(lawless_id,"Uspesno ste postali 'law_adm_HEAD' - poziciju postavio 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
	        }
	        else if(lawless_max == 5)
			{
	        	INFO(playerid,"Uspesno ste promovisali igraca - '%s' u 'law_adm_DIREKTOR' poziciju.",lawless_Nick(lawless_id));
	        	INFO(lawless_id,"Uspesno ste postali 'law_adm_DIREKTOR' - poziciju postavio 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
	        }
	        else if(lawless_max == 6)
			{
	        	INFO(playerid,"Uspesno ste promovisali igraca - '%s' u 'law_adm_VLASNIK' poziciju.",lawless_Nick(lawless_id));
	        	INFO(lawless_id,"Uspesno ste postali 'law_adm_VLASNIK' - poziciju postavio 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
	        }
	        else if(lawless_max == 7)
			{
			    if(!strcmp(lawless_Nick(lawless_id),DEVELOPER,true))
			    {
	        		INFO(playerid,"Uspesno ste promovisali igraca - '%s' u 'law_adm_DEVELOPER' poziciju.",lawless_Nick(lawless_id));
	        		INFO(lawless_id,"Uspesno ste postali 'law_adm_DEVELOPER' - poziciju postavio 'DEVELOPER' - '%s'.",lawless_Nick(playerid));
	        	}
	        	else return ERROR(playerid,"Rank 'DEVELOPER' - moze koristiti samo - '"DEVELOPER"'");
	        }
	        
	        if(P_E[lawless_id][info_pol] == 1)
	        {
		        P_E[lawless_id][info_admin] = lawless_max;
		        P_E[lawless_id][info_acode] = 5000+random(4000);
		        P_E[lawless_id][info_skin] = 294;
		        
		        INFO(lawless_id,"Uspesno vam je postavlje 'law_adm_code' - '%d'.",P_E[lawless_id][info_acode]);
		        INFO(lawless_id,"Obavezno slikajte ovaj 'INFO' - 'F8' - potrebno za ulazak u igru!");
	        }
	        else if(P_E[lawless_id][info_pol] == 2)
	        {
		        P_E[lawless_id][info_admin] = lawless_max;
		        P_E[lawless_id][info_acode] = 5000+random(4000);
		        P_E[lawless_id][info_skin] = 169;
		        
		        INFO(lawless_id,"Uspesno vam je postavlje 'law_adm_code' - '%d'.",P_E[lawless_id][info_acode]);
		        INFO(lawless_id,"Obavezno slikajte ovaj 'INFO' - 'F8' - potrebno za ulazak u igru!");
	        }
	        
	        lawless_saveUser(lawless_id);
	    }
	}
	else return ERROR(playerid,"Niste ovlasceni!");
	return true;
}

/*============================================================================*/

YCMD:changepassword(playerid, params[], help)
{
	new id_igraca[24];
	new lawless_files[80];
	new lawless_new_password[24];
    new lawless_name[MAX_PLAYER_NAME];
    new random_pass = 50000 + random(90000);
    
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(!strcmp(lawless_Nick(playerid),DEVELOPER,true))
	{
	    if(sscanf(params,"s[24]",id_igraca)) return USAGE(playerid,"/changepassword [Nick(Ime_Prezime)]");
	    
	    for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(lawless_Logo[i] == 1)
		    {
		        GetPlayerName(i,lawless_name,sizeof(lawless_name));
		        if(!strcmp(lawless_name,id_igraca,true))
		        {
		            return ERROR(playerid,"Taj igrac je online - kikuj/banuj ga prvo!");
		        }
		    }
		}
		
		format(lawless_files,sizeof(lawless_files),PATH,id_igraca);
		format(lawless_new_password,sizeof(lawless_new_password),"%d",random_pass);
		
		if(!fexist(lawless_files)) return ERROR(playerid,"Korisnicki racun '%s' ne postoji u bazi podataka!",id_igraca);
		
		INI_ParseFile(lawless_files,"loadOffline");
		
		new INI:File = INI_Open(lawless_files);
		INI_SetTag(File,"LAWLESS_GAMING_INFO_DATA:");
		INI_WriteString(File,"INFO_PASSWORD",lawless_new_password );
		INI_Close(File);
		
		INFO(playerid,"Uspesno je postavljena nova lozinka za sledeci account...");
		INFO(playerid,"Account Podatci - '%s' - Lozinka - '%s'.",id_igraca,lawless_new_password);
		INFO(playerid,"Posaljite - '%s' novu lozinku kako bi mogao sa njom da ponovo pristupi serveru!",id_igraca);
	}
	else return ERROR(playerid,"Niste ovlasceni!");
	return true;
}

/*============================================================================*/

YCMD:imovina(playerid, params[], help)
{
    new lawless_string[300];
	new lawless_imovina_1[30];
	new lawless_imovina_2[30];
	new lawless_imovina_one = P_E[playerid][info_vehsalon];
	new lawless_imovina_two = P_E[playerid][info_houses_key];
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(lawless_imovina_one == 9999 && lawless_imovina_two == 9999) return ERROR(playerid,"Ne posedujete imovinu!");

    if(lawless_imovina_one != 9999)
	{
		lawless_String(lawless_imovina_1,A_E[lawless_imovina_one][salon_name]);
	}
	else if(lawless_imovina_one == 9999)
	{
		lawless_String(lawless_imovina_1,"Nema");
	}
	
	if(lawless_imovina_two != 9999)
	{
		lawless_String(lawless_imovina_2,"Kuca");
	}
	else if(lawless_imovina_two == 9999)
	{
		lawless_String(lawless_imovina_2,"Nema");
	}

	format(lawless_string,sizeof(lawless_string),"{5D9DB3}[IMOVINA - [ID - %d] - 1] - {FFFFFF}%s.\n\
	{5D9DB3}[IMOVINA - [ID - %d] - 2] - {FFFFFF}%s.",P_E[playerid][info_vehsalon],lawless_imovina_1,P_E[playerid][info_houses_key],lawless_imovina_2);
	lawless_SPD(playerid, lawless_IMOVINA, DSL, SDIALOG,lawless_string,""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
	return true;
}

/*============================================================================*/

YCMD:kupiautosalon(playerid, params[], help)
{
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
 	for(new i; i < sizeof(A_E); i++)
	{
	    if(A_E[i][salon_created] == 1)
	    {
			if(IsPlayerInRangeOfPoint(playerid,1.0,A_E[i][salon_position][0],A_E[i][salon_position][1],A_E[i][salon_position][2]))
			{
	 			if(!strcmp(A_E[i][salon_owner],"Niko",true) && A_E[i][salon_owned] == 0)
				{
				    if(P_E[playerid][info_vehsalon] != 9999) return ERROR(playerid,"Vec posedujete jedan auto salon!");
					if(P_E[playerid][info_level] < A_E[i][salon_level]) return ERROR(playerid,"Potreban vam je level '%d' za ovaj auto salon!",A_E[i][salon_level]);
				 	if(P_E[playerid][info_cash] < A_E[i][salon_money]) return ERROR(playerid,"Nemate '$%d'.",A_E[i][salon_money]);

				 	A_E[i][salon_owned] = 1;
			 		P_E[playerid][info_vehsalon] = i;
			 		P_E[playerid][info_cash] -= A_E[i][salon_money];
			 		strmid(A_E[i][salon_owner],lawless_Nick(playerid),0,strlen(lawless_Nick(playerid)),255);

			 		lawless_saveSALON(i);
			 		lawless_updateSALON(i);
			 		lawless_saveUser(playerid);

					INFO(playerid,"Uspesno ste kupili auto salon(imovina) - '$%d' - '%s' - '('ID - %d')'.",A_E[i][salon_money],A_E[i][salon_name],i);
					INFO(playerid,"Za kontrolisanje imovine koristite komandu - '/imovina'.");
					lawless_GivePlayerMoney(playerid,P_E[playerid][info_cash]);
					return true;
				}
				else return ERROR(playerid,"Ovaj auto salon nije na prodaju!");
			}
		}
	}
	return true;
}

/*============================================================================*/

YCMD:test(playerid, params[], help)
{
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    
    P_E[playerid][info_cash] += 10000000;
    P_E[playerid][info_level] = 69;
    P_E[playerid][info_vehsalon] = 9999;
    P_E[playerid][info_skin] = random(100);

	lawless_saveUser(playerid);
	lawless_GivePlayerMoney(playerid,P_E[playerid][info_cash]);
	lawless_LEVEL(playerid,P_E[playerid][info_level]);
	lawless_SKIN(playerid,P_E[playerid][info_skin]);

	INFO(playerid,"Zbog testiranja systema dobili ste  - Level: 69 - Novac: $10.000.000 - Skin: %d!",P_E[playerid][info_skin]);
	INFO(playerid,"Glavne varijable oko kojih se vrte systemi su resetovane!");
	return true;
}

/*============================================================================*/

YCMD:postavilideraorganizacije(playerid, params[], help)
{
	new id_org;
	new slot_org;
	new org_file[40];
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(!strcmp(lawless_Nick(playerid),DEVELOPER,true))
	{
	    if(sscanf(params,"ui",id_org,slot_org)) return USAGE(playerid,"/postavilideraorganizacije [Nick(Ime_Prezime)] [Organisation]");
	    if(id_org == IPI) return ERROR(playerid,"Odabrani igrac trenutno nije online!");
	    format(org_file,sizeof(org_file),ORGS,slot_org);
	    
	    if(slot_org == 0)
		{
		    new organisation_id = P_E[id_org][info_leader];
		    
		    if(P_E[id_org][info_leader] == 0) return ERROR(playerid,"Nije lider!");
		    if(strcmp(lawless_Nick(id_org),O_E[organisation_id][org_leader_1],true) == 0)
			{
				strmid(O_E[organisation_id][org_leader_1],"Niko",0,strlen("Niko"),24);
			}
			else if(strcmp(lawless_Nick(id_org),O_E[organisation_id][org_leader_2],true) == 0)
			{
				strmid(O_E[organisation_id][org_leader_2],"Niko",0,strlen("Niko"),24);
			}
			
			P_E[id_org][info_leader] = 0;
			P_E[id_org][info_member] = 0;
			lawless_String(P_E[id_org][info_rank],"Nista");
			
			lawless_saveORG(organisation_id);
			lawless_saveUser(id_org);
			
			INFO(id_org,"Skinuta vam je pozicija lidera,hvala sto ste ucinili sve kao lider!");
			INFO(playerid,"Skinuli ste lidera '%s' - razlog ne poznat!",lawless_Nick(id_org));
			lawless_saveUser(id_org);
		}
		else
		{
		    if(P_E[id_org][info_member] != 1) return ERROR(playerid,"Vec je lider/clan neke organizacije!");
			if(P_E[id_org][info_leader] != 1) return ERROR(playerid,"Vec je lider/clan neke organizacije!");
		    if(!fexist(org_file)) return ERROR(playerid,"Organizacija ne postoji,pogledajte listu kreiranih organizacija!");
		    
		    if(!strcmp(O_E[slot_org][org_leader_1],"Niko",true))
			{
				strmid(O_E[slot_org][org_leader_1],lawless_Nick(id_org),0,strlen(lawless_Nick(id_org)),24 );
			}
			else if(!strcmp(O_E[slot_org][org_leader_2],"Niko",true))
			{
				strmid(O_E[slot_org][org_leader_2],lawless_Nick(id_org),0,strlen(lawless_Nick(id_org)),24 );
			}
	   		else return ERROR(playerid,"Vec je organizacija popunjena sa liderima!");
		    
		    P_E[id_org][info_leader] = slot_org;
			P_E[id_org][info_member] = slot_org;
			
			lawless_String(P_E[id_org][info_rank],O_E[slot_org][org_rank_6]);
			
			lawless_saveORG(slot_org);
			lawless_saveUser(id_org);
			
			if(P_E[id_org][info_pol] == 1)
			{
				P_E[id_org][info_skin] = O_E[slot_org][org_m_skin][5];
				SetPlayerSkin(id_org,O_E[slot_org][org_m_skin][5]);
			}
			else if(P_E[id_org][info_pol] == 2)
			{
				P_E[id_org][info_skin] = O_E[slot_org][org_z_skin][5];
				SetPlayerSkin(id_org,O_E[slot_org][org_z_skin][5]);
			}
			
			INFO(id_org,"Uspesno ste postali leader - '%s'.",O_E[slot_org][org_name]);
			INFO(playerid,"Postavili ste lidera - '%s' - '%s'.",lawless_Nick(id_org),O_E[slot_org][org_name]);
			lawless_saveUser(id_org);
		}
	}
	else return ERROR(playerid,"Niste ovlasceni!");
	return true;
}

/*============================================================================*/

YCMD:orgvehiclepark(playerid, params[], help)
{
	new id_org;
	new slot_org;
	new org_file[40];
	new Float:vehicle_position[4];
	if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(!strcmp(lawless_Nick(playerid),DEVELOPER,true))
	{
		GetVehiclePos(GetPlayerVehicleID(playerid),vehicle_position[0],vehicle_position[1],vehicle_position[2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid),vehicle_position[3]);

        if(sscanf(params,"dd",id_org,slot_org)) return USAGE(playerid,"/orgvehiclepark [Organisation[ID]] [Organisation[SLOT][1-8]]");
        if(slot_org < 1 || slot_org > 8) return ERROR(playerid,"Slot organizacijskih vozila ne moze biti manji od '1',niti veci od '8'!");
        if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Morate biti u vozilu!");

        format(org_file,sizeof(org_file),ORGS,id_org);
        if(!fexist(org_file)) return ERROR(playerid,"Organizacija '%d' ne postoji u bazi podataka!",id_org);

        if(slot_org == 1)
        {
            if(O_E[id_org][org_vehicles_created][0] == 0) return ERROR(playerid,"Pod slotom '1' nema kreirano organizacijsko vozilo - ne mozes edit!");
            if(O_E[IsPlayerInAnyVehicle(playerid)][org_vehicles_all][0] != 0) return ERROR(playerid,"Morate biti u vozilu pod slotom '1'.");
            
            DestroyVehicle(O_E[id_org][org_vehicles_all][0]);

	        O_E[id_org][org_vehicle_1][0] = vehicle_position[0];
	        O_E[id_org][org_vehicle_1][1] = vehicle_position[1];
	        O_E[id_org][org_vehicle_1][2] = vehicle_position[2];
	        O_E[id_org][org_vehicle_1][3] = vehicle_position[3];
	        lawless_saveORG(id_org);

	        O_E[id_org][org_vehicles_all][0] = CreateVehicle(O_E[id_org][org_vehicle_slot_1],O_E[id_org][org_vehicle_1][0],O_E[id_org][org_vehicle_1][1],O_E[id_org][org_vehicle_1][2],O_E[id_org][org_vehicle_1][3],0,0,30000);

            INFO(playerid,"Organizacijski ('ID - %d') - prilikom dodavanja vozila je koriscen!",id_org);
            INFO(playerid,"Organizacijski slot '1' - vozila promenjen,uspesno odradjeno sacuvavanje!");
		}
        else if(slot_org == 2)
        {
            if(O_E[id_org][org_vehicles_created][1] == 0) return ERROR(playerid,"Pod slotom '1' nema kreirano organizacijsko vozilo - ne mozes edit!");
            if(O_E[IsPlayerInAnyVehicle(playerid)][org_vehicles_all][1] != 0) return ERROR(playerid,"Morate biti u vozilu pod slotom '1'.");
            
            DestroyVehicle(O_E[id_org][org_vehicles_all][1]);

	        O_E[id_org][org_vehicle_2][0] = vehicle_position[0];
	        O_E[id_org][org_vehicle_2][1] = vehicle_position[1];
	        O_E[id_org][org_vehicle_2][2] = vehicle_position[2];
	        O_E[id_org][org_vehicle_2][3] = vehicle_position[3];
	        lawless_saveORG(id_org);

	        O_E[id_org][org_vehicles_all][1] = CreateVehicle(O_E[id_org][org_vehicle_slot_2],O_E[id_org][org_vehicle_2][0],O_E[id_org][org_vehicle_2][1],O_E[id_org][org_vehicle_2][2],O_E[id_org][org_vehicle_2][3],0,0,30000);

            INFO(playerid,"Organizacijski ('ID - %d') - prilikom dodavanja vozila je koriscen!",id_org);
            INFO(playerid,"Organizacijski slot '2' - vozila promenjen,uspesno odradjeno sacuvavanje!");
		}
        else if(slot_org == 3)
        {
            if(O_E[id_org][org_vehicles_created][2] == 0) return ERROR(playerid,"Pod slotom '1' nema kreirano organizacijsko vozilo - ne mozes edit!");
            if(O_E[IsPlayerInAnyVehicle(playerid)][org_vehicles_all][2] != 0) return ERROR(playerid,"Morate biti u vozilu pod slotom '1'.");
            
            DestroyVehicle(O_E[id_org][org_vehicles_all][2]);

	        O_E[id_org][org_vehicle_3][0] = vehicle_position[0];
	        O_E[id_org][org_vehicle_3][1] = vehicle_position[1];
	        O_E[id_org][org_vehicle_3][2] = vehicle_position[2];
	        O_E[id_org][org_vehicle_3][3] = vehicle_position[3];
	        lawless_saveORG(id_org);

	        O_E[id_org][org_vehicles_all][2] = CreateVehicle(O_E[id_org][org_vehicle_slot_3],O_E[id_org][org_vehicle_3][0],O_E[id_org][org_vehicle_3][1],O_E[id_org][org_vehicle_3][2],O_E[id_org][org_vehicle_3][3],0,0,30000);

            INFO(playerid,"Organizacijski ('ID - %d') - prilikom dodavanja vozila je koriscen!",id_org);
            INFO(playerid,"Organizacijski slot '3' - vozila promenjen,uspesno odradjeno sacuvavanje!");
		}
        else if(slot_org == 4)
        {
            if(O_E[id_org][org_vehicles_created][3] == 0) return ERROR(playerid,"Pod slotom '1' nema kreirano organizacijsko vozilo - ne mozes edit!");
            if(O_E[IsPlayerInAnyVehicle(playerid)][org_vehicles_all][3] != 0) return ERROR(playerid,"Morate biti u vozilu pod slotom '1'.");
            
            DestroyVehicle(O_E[id_org][org_vehicles_all][3]);

	        O_E[id_org][org_vehicle_4][0] = vehicle_position[0];
	        O_E[id_org][org_vehicle_4][1] = vehicle_position[1];
	        O_E[id_org][org_vehicle_4][2] = vehicle_position[2];
	        O_E[id_org][org_vehicle_4][3] = vehicle_position[3];
	        lawless_saveORG(id_org);

			O_E[id_org][org_vehicles_all][3] = CreateVehicle(O_E[id_org][org_vehicle_slot_4],O_E[id_org][org_vehicle_4][0],O_E[id_org][org_vehicle_4][1],O_E[id_org][org_vehicle_4][2],O_E[id_org][org_vehicle_4][3],0,0,30000);

            INFO(playerid,"Organizacijski ('ID - %d') - prilikom dodavanja vozila je koriscen!",id_org);
            INFO(playerid,"Organizacijski slot '4' - vozila promenjen,uspesno odradjeno sacuvavanje!");
		}
        else if(slot_org == 5)
        {
            if(O_E[id_org][org_vehicles_created][4] == 0) return ERROR(playerid,"Pod slotom '1' nema kreirano organizacijsko vozilo - ne mozes edit!");
            if(O_E[IsPlayerInAnyVehicle(playerid)][org_vehicles_all][4] != 0) return ERROR(playerid,"Morate biti u vozilu pod slotom '1'.");

            DestroyVehicle(O_E[id_org][org_vehicles_all][4]);

	        O_E[id_org][org_vehicle_5][0] = vehicle_position[0];
	        O_E[id_org][org_vehicle_5][1] = vehicle_position[1];
	        O_E[id_org][org_vehicle_5][2] = vehicle_position[2];
	        O_E[id_org][org_vehicle_5][3] = vehicle_position[3];
	        lawless_saveORG(id_org);

	        O_E[id_org][org_vehicles_all][4] = CreateVehicle(O_E[id_org][org_vehicle_slot_5],O_E[id_org][org_vehicle_5][0],O_E[id_org][org_vehicle_5][1],O_E[id_org][org_vehicle_5][2],O_E[id_org][org_vehicle_5][3],0,0,30000);

            INFO(playerid,"Organizacijski ('ID - %d') - prilikom dodavanja vozila je koriscen!",id_org);
            INFO(playerid,"Organizacijski slot '5' - vozila promenjen,uspesno odradjeno sacuvavanje!");
		}
        else if(slot_org == 6)
        {
            if(O_E[id_org][org_vehicles_created][5] == 0) return ERROR(playerid,"Pod slotom '1' nema kreirano organizacijsko vozilo - ne mozes edit!");
            if(O_E[IsPlayerInAnyVehicle(playerid)][org_vehicles_all][5] != 0) return ERROR(playerid,"Morate biti u vozilu pod slotom '1'.");

            DestroyVehicle(O_E[id_org][org_vehicles_all][5]);

	        O_E[id_org][org_vehicle_6][0] = vehicle_position[0];
	        O_E[id_org][org_vehicle_6][1] = vehicle_position[1];
	        O_E[id_org][org_vehicle_6][2] = vehicle_position[2];
	        O_E[id_org][org_vehicle_6][3] = vehicle_position[3];
	        lawless_saveORG(id_org);

	        O_E[id_org][org_vehicles_all][5] = CreateVehicle(O_E[id_org][org_vehicle_slot_6],O_E[id_org][org_vehicle_6][0],O_E[id_org][org_vehicle_6][1],O_E[id_org][org_vehicle_6][2],O_E[id_org][org_vehicle_6][3],0,0,30000);

            INFO(playerid,"Organizacijski ('ID - %d') - prilikom dodavanja vozila je koriscen!",id_org);
            INFO(playerid,"Organizacijski slot '6' - vozila promenjen,uspesno odradjeno sacuvavanje!");
	    }
        else if(slot_org == 7)
        {
            if(O_E[id_org][org_vehicles_created][6] == 0) return ERROR(playerid,"Pod slotom '1' nema kreirano organizacijsko vozilo - ne mozes edit!");
            if(O_E[IsPlayerInAnyVehicle(playerid)][org_vehicles_all][6] != 0) return ERROR(playerid,"Morate biti u vozilu pod slotom '1'.");

            DestroyVehicle(O_E[id_org][org_vehicles_all][6]);

	        O_E[id_org][org_vehicle_7][0] = vehicle_position[0];
	        O_E[id_org][org_vehicle_7][1] = vehicle_position[1];
	        O_E[id_org][org_vehicle_7][2] = vehicle_position[2];
	        O_E[id_org][org_vehicle_7][3] = vehicle_position[3];
	        lawless_saveORG(id_org);

	        O_E[id_org][org_vehicles_all][6] = CreateVehicle(O_E[id_org][org_vehicle_slot_7],O_E[id_org][org_vehicle_7][0],O_E[id_org][org_vehicle_7][1],O_E[id_org][org_vehicle_7][2],O_E[id_org][org_vehicle_7][3],0,0,30000);

            INFO(playerid,"Organizacijski ('ID - %d') - prilikom dodavanja vozila je koriscen!",id_org);
            INFO(playerid,"Organizacijski slot '7' - vozila promenjen,uspesno odradjeno sacuvavanje!");
		}
        else if(slot_org == 8)
        {
            if(O_E[id_org][org_vehicles_created][7] == 0) return ERROR(playerid,"Pod slotom '1' nema kreirano organizacijsko vozilo - ne mozes edit!");
            if(O_E[IsPlayerInAnyVehicle(playerid)][org_vehicles_all][7] != 0) return ERROR(playerid,"Morate biti u vozilu pod slotom '1'.");

            DestroyVehicle(O_E[id_org][org_vehicles_all][7]);

	        O_E[id_org][org_vehicle_8][0] = vehicle_position[0];
	        O_E[id_org][org_vehicle_8][1] = vehicle_position[1];
	        O_E[id_org][org_vehicle_8][2] = vehicle_position[2];
	        O_E[id_org][org_vehicle_8][3] = vehicle_position[3];
	        lawless_saveORG(id_org);

	        O_E[id_org][org_vehicles_all][7] = CreateVehicle(O_E[id_org][org_vehicle_slot_8],O_E[id_org][org_vehicle_8][0],O_E[id_org][org_vehicle_8][1],O_E[id_org][org_vehicle_8][2],O_E[id_org][org_vehicle_8][3],0,0,30000);

			INFO(playerid,"Organizacijski ('ID - %d') - prilikom dodavanja vozila je koriscen!",id_org);
			INFO(playerid,"Organizacijski slot '8' - vozila promenjen,uspesno odradjeno sacuvavanje!");
		}
	}
	else return ERROR(playerid,"Niste ovlasceni!");
	return true;
}

/*============================================================================*/

YCMD:gps(playerid, params[], help)
{
    new gps_list;
	new gps_string[500];
	new gps_restring[500];
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Morate biti vozac kako bi ste koristili,ovu komandu!");
	if(lawless_GPS_HAVEN[playerid] == 1) return ERROR(playerid,"Vec vam je aktiviran gps uredjaj!");

    for(new i = 1; i < MAX_GPS; i++)
 	{
 	    new lawless_ggps[40];
		format(lawless_ggps,sizeof(lawless_ggps),GPSS,i);
		if(fexist(lawless_ggps))
		{
			if(G_E[i][gps_id] == i)
			{
  				format(gps_restring,sizeof(gps_restring),"\n{5D9DB3}>> {FFFFFF}%s - [ID - %d]",G_E[i][gps_name_location],i);
    			strcat(gps_string,gps_restring);

     			lawless_GPS_USAGE[playerid][gps_list] = i;
      			gps_list++;
       		}
        }
    }

    lawless_SPD(playerid, lawless_GPS, DSL, SDIALOG,gps_string,""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
	return true;
}

/*============================================================================*/

YCMD:gpsoff(playerid, params[], help)
{
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(lawless_GPS_HAVEN[playerid] == 0) return ERROR(playerid,"Nije vam aktiviran gps uredjaj!");

    lawless_GPS_HAVEN[playerid] = 0;
    DisablePlayerCheckpoint(playerid);

	INFO(playerid,"Uspesno ste ugasili vas gps uredjaj - lokacija uklonjena sa radara!");
	INFO(playerid,"Ako zelite ponovo da koristite vas gps uredjaj - ukucajte '/gps' i izaberite lokaciju!");
	return true;
}

/*============================================================================*/

YCMD:listaskqs(playerid, params[], help)
{
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(!strcmp(lawless_Nick(playerid),DEVELOPER,true))
	{
	    strdel(lawless_string_ex,0,sizeof(lawless_string_ex));
	    
		for(new i = 1; i < MAX_ASKQ; i++)
		{
			format(lawless_string_ex,sizeof(lawless_string_ex),"%sASKQ[S - %d] - %s\n",lawless_string_ex,i,AS_E[i][askq_postavljac]);
		}
		lawless_SPD(playerid, lawless_ASKLIST, DSL, SDIALOG,lawless_string_ex,""SERVER_COL"Odgovori",""SERVER_COL"Izlaz");
	}
	else return ERROR(playerid,"Niste ovlasceni!");
	return true;
}

/*============================================================================*/

YCMD:askq(playerid, params[], help)
{
    new askQ = -1;
	new askq_text[128];
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(AS_IE[playerid][askq_poslato] == true) return ERROR(playerid,"Sacekajte da vam odgovore na prethodno pitanje!");
    if(sscanf(params,"s[128]",askq_text)) return USAGE(playerid,"/askq [Pitanje]");
    
	for(new id = 1; id < MAX_ASKQ; id++)
	{
		if(AS_E[id][askq_poslat] == false)
		{
			askQ = id;
			break;
		}
	}
    if(askQ == -1) return ERROR(playerid,"Lista sa pitanjima je popunjena,sacekajte da rese listu sa pitanjima!");
    
    AS_E[askQ][askq_poslat] = true;
	AS_E[askQ][askq_id] = playerid;

	AS_IE[playerid][askq_poslato] = true;
	AS_IE[playerid][askq_odgovoreno] = false;

	strmid(AS_E[askQ][askq_postavljac],lawless_Nick(playerid),0,strlen(lawless_Nick(playerid)),32);
	strmid(AS_E[askQ][askq_pitanje],askq_text,0,strlen(askq_text),128);
	
	INFO(playerid,"Uspesno ste poslali pitanje,sacekajte da ovlasceni odgovore na njega!");
	return true;
}

/*============================================================================*/

YCMD:accountupgrade(playerid, params[], help)
{
	new lawless_upgrade[32];
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(sscanf(params,"s[32]",lawless_upgrade)) return USAGE(playerid,"/accountupgrade [Inteligenci/Power/Dexterity]");
    
    if(strcmp(lawless_upgrade,"inteligenci",true) == 0)
	{
	    if(P_E[playerid][info_upgrade] < 2) return ERROR(playerid,"Za povecavanje inteligencije vam je potrebna '2' upgrade poena!");
	    
	    P_E[playerid][info_upgrade] -= 2;
	    P_E[playerid][info_inteligenci]++;
	    lawless_saveUser(playerid);

		INFO(playerid,"Uspesno ste upgradeovali vasu inteligenciju - '+1'.");
		INFO(playerid,"Visina vase inteligencije trenutno iznosi - '%d'.",P_E[playerid][info_inteligenci]);
		INFO(playerid,"Preostalo vam je '%d' upgrade poena,koje mozete naknadno iskoristiti!",P_E[playerid][info_upgrade]);
	}
	if(strcmp(lawless_upgrade,"power",true) == 0)
	{
	    if(P_E[playerid][info_upgrade] < 4) return ERROR(playerid,"Za povecavanje snage vam je potrebna '4' upgrade poena!");

        P_E[playerid][info_power]++;
        P_E[playerid][info_upgrade] -= 4;
	    lawless_saveUser(playerid);

		INFO(playerid,"Uspesno ste upgradeovali vasu snagu - '+1'.");
		INFO(playerid,"Visina vase snage trenutno iznosi - '%d'.",P_E[playerid][info_power]);
		INFO(playerid,"Preostalo vam je '%d' upgrade poena,koje mozete naknadno iskoristiti!",P_E[playerid][info_upgrade]);
	}
	if(strcmp(lawless_upgrade,"dexterity",true) == 0)
	{
	    if(P_E[playerid][info_upgrade] < 6) return ERROR(playerid,"Za povecavanje spretnosti vam je potrebna '6' upgrade poena!");

	    P_E[playerid][info_dexterity]++;
	    P_E[playerid][info_upgrade] -= 6;
	    lawless_saveUser(playerid);
	    
		INFO(playerid,"Uspesno ste upgradeovali vasu spretnos - '+1'.");
		INFO(playerid,"Visina vase spretnosti trenutno iznosi - '%d'.",P_E[playerid][info_dexterity]);
		INFO(playerid,"Preostalo vam je '%d' upgrade poena,koje mozete naknadno iskoristiti!",P_E[playerid][info_upgrade]);
	}
	return true;
}

/*============================================================================*/

YCMD:allmembers(playerid, params[], help)
{
	new organisation_id = P_E[playerid][info_leader];
    if(lawless_Logo[playerid] == 0) return ERROR(playerid,"Niste ulogovani!");
    if(P_E[playerid][info_leader] < 0) return ERROR(playerid,"Niste lider!");
    
    format(lawless_string_ex,sizeof(lawless_string_ex),"{FFFFFF}[M - 1] '%s'.\n{FFFFFF}[M - 2] '%s'.\n\
	{FFFFFF}[M - 3] '%s'.\n{FFFFFF}[M - 4] '%s'.\n\
	{FFFFFF}[M - 5] '%s'.\n{FFFFFF}[M - 6] '%s'.\n{FFFFFF}[M - 7] '%s'.\n\
	{FFFFFF}[M - 8] '%s'.\n{FFFFFF}[M - 9] '%s'.\n{FFFFFF}[M - 10] '%s'.\n\
	{FFFFFF}[M - 11] '%s'.\n{FFFFFF}[M - 12] '%s'.\n{FFFFFF}[M - 13] '%s'.\n\
	{FFFFFF}[M - 14] '%s'.\n{FFFFFF}[M - 15] '%s'.",
	O_E[organisation_id][org_member_1],O_E[organisation_id][org_member_2],O_E[organisation_id][org_member_3],O_E[organisation_id][org_member_4],O_E[organisation_id][org_member_5],
	O_E[organisation_id][org_member_6],O_E[organisation_id][org_member_7],O_E[organisation_id][org_member_8],O_E[organisation_id][org_member_9],O_E[organisation_id][org_member_10],
	O_E[organisation_id][org_member_11],O_E[organisation_id][org_member_12],O_E[organisation_id][org_member_13],O_E[organisation_id][org_member_14],O_E[organisation_id][org_member_15]);
    lawless_SPD(playerid, lawless_ALLMEMBERS, DSL, SDIALOG,lawless_string_ex,""SERVER_COL"Izaberi",""SERVER_COL"Izlaz");
    
    INFO(playerid,"Da kontrolisete clana pritisnite na njega,i izaberite opciju!");
	return true;
}

/*============================================================================*/

YCMD:speedo(playerid, params[], help)
{
	new on = 1;
	new lights;
	new alarm;
	new doors;
	new bonnet;
	new boot;
	new objective;
    SetVehicleParamsEx(GetPlayerVehicleID(playerid),on,lights,alarm,doors,bonnet,boot,objective);
	return true;
}

/*============================================================================*/

lawless_antiSTEAL()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

/*==============================================================================

						Lawless - Online Gaming Community
							  Script | v0.1

==============================================================================*/

/* DOVRSITI INVITE/UNINVITE/OFFLINE/ONLINE ZA CLANOVE - TAKODJE I ALLMEMBERS KONTROLISANJE PREKO DIALOGA */
/* URADITI FIRMA SYSTEM */
/* URADITI POSLOVE */
