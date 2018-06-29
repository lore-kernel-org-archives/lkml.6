Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41475C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4D423CB4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4D423CB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755561AbeF2PGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:06:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46856 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbeF2PGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:06:05 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fYuyJ-0002fE-Mc; Fri, 29 Jun 2018 15:06:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] spelling.txt: add more spellings to spelling.txt
Date:   Fri, 29 Jun 2018 16:06:03 +0100
Message-Id: <20180629150603.1159-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Here are some of the more common spelling mistakes and typos that I've
found while fixing up spelling mistakes in the kernel over the past 6
months.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: fix spelling mistake in parameters, thanks for spotting that Joe.
---
 scripts/spelling.txt | 88 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 9a058cff49d4..a81e97d908fc 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -10,6 +10,8 @@
 abandonning||abandoning
 abigious||ambiguous
 abitrate||arbitrate
+abord||abort
+aboslute||absolute
 abov||above
 abreviated||abbreviated
 absense||absence
@@ -25,6 +27,7 @@ accessable||accessible
 accesss||access
 accidentaly||accidentally
 accidentually||accidentally
+acclerated||accelerated
 accoding||according
 accomodate||accommodate
 accomodates||accommodates
@@ -58,12 +61,15 @@ addres||address
 adddress||address
 addreses||addresses
 addresss||address
+addrress||address
 aditional||additional
 aditionally||additionally
 aditionaly||additionally
 adminstrative||administrative
 adress||address
 adresses||addresses
+adrresses||addresses
+advertisment||advertisement
 adviced||advised
 afecting||affecting
 againt||against
@@ -100,6 +106,7 @@ alue||value
 ambigious||ambiguous
 amoung||among
 amout||amount
+amplifer||amplifier
 an union||a union
 an user||a user
 an userspace||a userspace
@@ -145,11 +152,15 @@ assistent||assistant
 assocation||association
 associcated||associated
 assotiated||associated
+asssert||assert
 assum||assume
 assumtpion||assumption
 asuming||assuming
 asycronous||asynchronous
 asynchnous||asynchronous
+asynchromous||asynchronous
+asymetric||asymmetric
+asymmeric||asymmetric
 atomatically||automatically
 atomicly||atomically
 atempt||attempt
@@ -172,6 +183,7 @@ avaible||available
 availabe||available
 availabled||available
 availablity||availability
+availaible||available
 availale||available
 availavility||availability
 availble||available
@@ -206,8 +218,11 @@ borad||board
 boundry||boundary
 brievely||briefly
 broadcat||broadcast
+bufufer||buffer
 cacluated||calculated
+caculate||calculate
 caculation||calculation
+cadidate||candidate
 calender||calendar
 calescing||coalescing
 calle||called
@@ -221,12 +236,14 @@ capabilty||capability
 capabitilies||capabilities
 capatibilities||capabilities
 capapbilities||capabilities
+caputure||capture
 carefuly||carefully
 cariage||carriage
 catagory||category
 cehck||check
 challange||challenge
 challanges||challenges
+chache||cache
 chanell||channel
 changable||changeable
 chanined||chained
@@ -240,6 +257,7 @@ charaters||characters
 charcter||character
 chcek||check
 chck||check
+checksumed||checksummed
 checksuming||checksumming
 childern||children
 childs||children
@@ -292,8 +310,10 @@ comunication||communication
 conbination||combination
 conditionaly||conditionally
 conected||connected
+conector||connector
 connecetd||connected
 configuartion||configuration
+configuation||configuration
 configuratoin||configuration
 configuraton||configuration
 configuretion||configuration
@@ -315,6 +335,7 @@ continous||continuous
 continously||continuously
 continueing||continuing
 contraints||constraints
+contruct||construct
 contol||control
 contoller||controller
 controled||controlled
@@ -343,6 +364,7 @@ dafault||default
 deafult||default
 deamon||daemon
 decompres||decompress
+decsribed||described
 decription||description
 dectected||detected
 defailt||default
@@ -379,6 +401,7 @@ desctiptor||descriptor
 desriptor||descriptor
 desriptors||descriptors
 destionation||destination
+destoried||destroyed
 destory||destroy
 destoryed||destroyed
 destorys||destroys
@@ -404,18 +427,25 @@ diffrentiate||differentiate
 difinition||definition
 dimesions||dimensions
 diplay||display
+directon||direction
 direectly||directly
+diregard||disregard
 disassocation||disassociation
 disapear||disappear
 disapeared||disappeared
 disappared||disappeared
+disbale||disable
+disbaled||disabled
 disble||disable
 disbled||disabled
 disconnet||disconnect
 discontinous||discontinuous
+disharge||discharge
 dispertion||dispersion
 dissapears||disappears
 distiction||distinction
+divisable||divisible
+divsiors||divisors
 docuentation||documentation
 documantation||documentation
 documentaion||documentation
@@ -427,6 +457,7 @@ downlad||download
 downlads||downloads
 druing||during
 dynmaic||dynamic
+eanable||enable
 easilly||easily
 ecspecially||especially
 edditable||editable
@@ -484,9 +515,12 @@ exprimental||experimental
 extened||extended
 extensability||extensibility
 extention||extension
+extenstion||extension
 extracter||extractor
+faield||failed
 falied||failed
 faild||failed
+failer||failure
 faill||fail
 failied||failed
 faillure||failure
@@ -520,6 +554,7 @@ forseeable||foreseeable
 forse||force
 fortan||fortran
 forwardig||forwarding
+frambuffer||framebuffer
 framming||framing
 framwork||framework
 frequncy||frequency
@@ -527,6 +562,7 @@ frome||from
 fucntion||function
 fuction||function
 fuctions||functions
+funcation||function
 funcion||function
 functionallity||functionality
 functionaly||functionally
@@ -540,6 +576,7 @@ futrue||future
 gaurenteed||guaranteed
 generiously||generously
 genereate||generate
+genereted||generated
 genric||generic
 globel||global
 grabing||grabbing
@@ -553,6 +590,7 @@ guarentee||guarantee
 halfs||halves
 hander||handler
 handfull||handful
+hanlde||handle
 hanled||handled
 happend||happened
 harware||hardware
@@ -561,6 +599,7 @@ helpfull||helpful
 hybernate||hibernate
 hierachy||hierarchy
 hierarchie||hierarchy
+homogenous||homogeneous
 howver||however
 hsould||should
 hypervior||hypervisor
@@ -568,6 +607,8 @@ hypter||hyper
 identidier||identifier
 iligal||illegal
 illigal||illegal
+illgal||illegal
+iomaped||iomapped
 imblance||imbalance
 immeadiately||immediately
 immedaite||immediate
@@ -618,10 +659,12 @@ initation||initiation
 initators||initiators
 initialiazation||initialization
 initializiation||initialization
+initialze||initialize
 initialzed||initialized
 initilization||initialization
 initilize||initialize
 inofficial||unofficial
+inrerface||interface
 insititute||institute
 instal||install
 instanciated||instantiated
@@ -657,6 +700,7 @@ intregral||integral
 intrrupt||interrupt
 intterrupt||interrupt
 intuative||intuitive
+inavlid||invalid
 invaid||invalid
 invald||invalid
 invalde||invalid
@@ -683,6 +727,7 @@ langauge||language
 langugage||language
 lauch||launch
 layed||laid
+legnth||length
 leightweight||lightweight
 lengh||length
 lenght||length
@@ -696,6 +741,7 @@ licenceing||licencing
 loggging||logging
 loggin||login
 logile||logfile
+loobpack||loopback
 loosing||losing
 losted||lost
 machinary||machinery
@@ -703,6 +749,7 @@ maintainance||maintenance
 maintainence||maintenance
 maintan||maintain
 makeing||making
+mailformed||malformed
 malplaced||misplaced
 malplace||misplace
 managable||manageable
@@ -710,6 +757,7 @@ managment||management
 mangement||management
 manoeuvering||maneuvering
 mappping||mapping
+matchs||matches
 mathimatical||mathematical
 mathimatic||mathematic
 mathimatics||mathematics
@@ -725,6 +773,7 @@ messsage||message
 messsages||messages
 micropone||microphone
 microprocesspr||microprocessor
+migrateable||migratable
 milliseonds||milliseconds
 minium||minimum
 minimam||minimum
@@ -741,6 +790,7 @@ missmatch||mismatch
 miximum||maximum
 mmnemonic||mnemonic
 mnay||many
+modfiy||modify
 modulues||modules
 momery||memory
 memomry||memory
@@ -777,6 +827,7 @@ notifed||notified
 numebr||number
 numner||number
 obtaion||obtain
+obusing||abusing
 occassionally||occasionally
 occationally||occasionally
 occurance||occurrence
@@ -787,6 +838,7 @@ occure||occurred
 occured||occurred
 occuring||occurring
 offet||offset
+offloded||offloaded
 omited||omitted
 omiting||omitting
 omitt||omit
@@ -829,6 +881,7 @@ parametes||parameters
 parametised||parametrised
 paramter||parameter
 paramters||parameters
+parmaters||parameters
 particuarly||particularly
 particularily||particularly
 partiton||partition
@@ -837,6 +890,7 @@ passin||passing
 pathes||paths
 pecularities||peculiarities
 peformance||performance
+peforming||performing
 peice||piece
 pendantic||pedantic
 peprocessor||preprocessor
@@ -846,6 +900,7 @@ peroid||period
 persistance||persistence
 persistant||persistent
 plalform||platform
+platfoem||platform
 platfrom||platform
 plattform||platform
 pleaes||please
@@ -858,6 +913,7 @@ posible||possible
 positon||position
 possibilites||possibilities
 powerfull||powerful
+preamle||preamble
 preample||preamble
 preapre||prepare
 preceeded||preceded
@@ -870,6 +926,7 @@ prefered||preferred
 prefferably||preferably
 premption||preemption
 prepaired||prepared
+preperation||preparation
 pressre||pressure
 primative||primitive
 princliple||principle
@@ -935,6 +992,7 @@ recommanded||recommended
 recyle||recycle
 redircet||redirect
 redirectrion||redirection
+redundacy||redundancy
 reename||rename
 refcounf||refcount
 refence||reference
@@ -945,6 +1003,7 @@ refernces||references
 refernnce||reference
 refrence||reference
 registerd||registered
+registeration||registration
 registeresd||registered
 registerred||registered
 registes||registers
@@ -973,7 +1032,9 @@ requirment||requirement
 requred||required
 requried||required
 requst||request
+reregisteration||reregistration
 reseting||resetting
+reseverd||reserved
 resizeable||resizable
 resouce||resource
 resouces||resources
@@ -982,6 +1043,7 @@ responce||response
 ressizes||resizes
 ressource||resource
 ressources||resources
+restesting||retesting
 retransmited||retransmitted
 retreived||retrieved
 retreive||retrieve
@@ -1006,6 +1068,7 @@ sacrifying||sacrificing
 safly||safely
 safty||safety
 savable||saveable
+scaleing||scaling
 scaned||scanned
 scaning||scanning
 scarch||search
@@ -1014,6 +1077,8 @@ searchs||searches
 secquence||sequence
 secund||second
 segement||segment
+semaphone||semaphore
+senario||scenario
 senarios||scenarios
 sentivite||sensitive
 separatly||separately
@@ -1025,9 +1090,13 @@ seperate||separate
 seperatly||separately
 seperator||separator
 sepperate||separate
+seqeunce||sequence
+seqeuncer||sequencer
+seqeuencer||sequencer
 sequece||sequence
 sequencial||sequential
 serveral||several
+servive||service
 setts||sets
 settting||setting
 shotdown||shutdown
@@ -1073,6 +1142,7 @@ standartization||standardization
 standart||standard
 staticly||statically
 stoped||stopped
+stoping||stopping
 stoppped||stopped
 straming||streaming
 struc||struct
@@ -1085,6 +1155,7 @@ subdirectoires||subdirectories
 suble||subtle
 substract||subtract
 submition||submission
+suceed||succeed
 succesfully||successfully
 succesful||successful
 successed||succeeded
@@ -1108,6 +1179,7 @@ surpressed||suppressed
 surpresses||suppresses
 susbsystem||subsystem
 suspeneded||suspended
+suspsend||suspend
 suspicously||suspiciously
 swaping||swapping
 switchs||switches
@@ -1122,6 +1194,7 @@ swtich||switch
 symetric||symmetric
 synax||syntax
 synchonized||synchronized
+synchronuously||synchronously
 syncronize||synchronize
 syncronized||synchronized
 syncronizing||synchronizing
@@ -1130,11 +1203,14 @@ syste||system
 sytem||system
 sythesis||synthesis
 taht||that
+tansmit||transmit
 targetted||targeted
 targetting||targeting
+taskelt||tasklet
 teh||the
 temorary||temporary
 temproarily||temporarily
+thead||thread
 therfore||therefore
 thier||their
 threds||threads
@@ -1143,11 +1219,14 @@ thresold||threshold
 throught||through
 troughput||throughput
 thses||these
+tiggers||triggers
 tiggered||triggered
 tipically||typically
+timeing||timing
 timout||timeout
 tmis||this
 torerable||tolerable
+traking||tracking
 tramsmitted||transmitted
 tramsmit||transmit
 tranasction||transaction
@@ -1162,6 +1241,7 @@ transormed||transformed
 trasfer||transfer
 trasmission||transmission
 treshold||threshold
+trigerred||triggered
 trigerring||triggering
 trun||turn
 tunning||tuning
@@ -1169,6 +1249,8 @@ ture||true
 tyep||type
 udpate||update
 uesd||used
+uknown||unknown
+usupported||unsupported
 uncommited||uncommitted
 unconditionaly||unconditionally
 underun||underrun
@@ -1181,11 +1263,14 @@ unexpeted||unexpected
 unexpexted||unexpected
 unfortunatelly||unfortunately
 unifiy||unify
+uniterrupted||uninterrupted
 unintialized||uninitialized
 unkmown||unknown
 unknonw||unknown
 unknow||unknown
 unkown||unknown
+unamed||unnamed
+uneeded||unneeded
 unneded||unneeded
 unneccecary||unnecessary
 unneccesary||unnecessary
@@ -1210,6 +1295,7 @@ usefull||useful
 usege||usage
 usera||users
 usualy||usually
+usupported||unsupported
 utilites||utilities
 utillities||utilities
 utilties||utilities
@@ -1233,7 +1319,9 @@ virtaul||virtual
 virtiual||virtual
 visiters||visitors
 vitual||virtual
+vunerable||vulnerable
 wakeus||wakeups
+wathdog||watchdog
 wating||waiting
 wiat||wait
 wether||whether
-- 
2.17.1

