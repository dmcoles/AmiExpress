FTN Networking

So whatever messaging network you are wanting to join probably has many areas and you may
well not want to create a new /X conference for each one. /X5 supports multiple message bases
per conference. Instead of having one single MsgBase folder you can create multiple folders with
whatever name you wish and within the conference folder so for example I have

   bbs:
     Conf05
        MsgBase.1
        MsgBase.2
        MsgBase.3
        
In addition you need have a msgbases.info within the conference eg.
   bbs:
     Conf05
        MsgBase.1
        MsgBase.2
        MsgBase.3
        Msgbases.info

In my msgbases.info I have the following
        
NMSGBASES=3
NAME.1=Commodore Computers/Software/Hardware
Location.1=MsgBase.1/
Name.2=Amiga Computers/Software/Hardware
Location.2=MsgBase.2/
Name.3=Coleco Adam Computer/Software/HardwareLocation.3=MsgBase.3/
EXTSEND.1
EXTSEND.2
EXTSEND.3

NMSGBASES and the NAME and LOCATION properties are pretty self explanatory. Number, names and locations
of the message folders.

EXTSEND property tells /X that rather than creating a message in the normal manner when you send a message
for this message base it should create an external message file instead of the usual process. These external
message files go into EXT-OUT folder in the msgbase folder and are picked up by the tosser.

FTN tosser is a standalone exe that will run once and then quit so you need to run it on a regular frequency
either by using some kind of cron tool or in a shell script that loops around after a given delay.

it has a config file called FTN.cfg which is documented as follows (do not include the comments)

[MAIN]
MODE=BOTH                           - IN/OUT/BOTH
INBOUND=mail:inbound/
INBOUNDINSEC=mail:inbound/
OUTBOUND=mail:outbound/
UNPACKCMD=lha x {filename} t:ftn/   - this is the command used to unpack the packets might need to be changed if zip is being used
TEMPDIR=t:ftn/                      - tempdir here must match the above command. T: might not be suitable if files will be too big for ram:
#enable this and put the path to your mail outbound folder (including trailing / or \) 
#as seen from whereever you are running bink from (eg linux, windows)
#(not needed if you are running it from the amiga os as it will default ot the outbound path above
#FLOPATH=

[ORIGINNET]
ZONE=39
NET=137
NODE=999
POINT=                               -optional

[DESTNET]
ZONE=39
NET=39
NODE=0
POINT=                               -optional

[MISC]
PASSWORD=yourpass
TEAR=/X Tosser
ORIGIN=Phantasm BBS development system
COST=0
ATTR=0
TZOFFSET=0000

[CONFS]
TEST_CBM
bbs:Conf05/MsgBase.1/
TEST_AMY
bbs:Conf05/MsgBase.2/
NETMAIL
bbs:Conf05/MsgBase.3/