Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFC9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C6B20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfANLCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:02:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42100 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANLCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:02:18 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gj00V-0003J5-Rf; Mon, 14 Jan 2019 11:02:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spelling.txt: add more spellings to spelling.txt
Date:   Mon, 14 Jan 2019 11:02:15 +0000
Message-Id: <20190114110215.1986-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Here are some of the more common spelling mistakes and typos that I've
found while fixing up spelling mistakes in the kernel over the past 4
months.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/spelling.txt | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 517d0c3f83df..86b87332b9e5 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -10,6 +10,8 @@
 abandonning||abandoning
 abigious||ambiguous
 abitrate||arbitrate
+abnornally||abnormally
+abnrormal||abnormal
 abord||abort
 aboslute||absolute
 abov||above
@@ -107,6 +109,7 @@ ambigious||ambiguous
 amoung||among
 amout||amount
 amplifer||amplifier
+amplifyer||amplifier
 an union||a union
 an user||a user
 an userspace||a userspace
@@ -145,6 +148,7 @@ artillary||artillery
 asign||assign
 asser||assert
 assertation||assertion
+assertting||asserting
 assiged||assigned
 assigment||assignment
 assigments||assignments
@@ -168,6 +172,8 @@ attachement||attachment
 attched||attached
 attemps||attempts
 attemping||attempting
+attepmpt||attempt
+attnetion||attention
 attruibutes||attributes
 authentification||authentication
 automaticaly||automatically
@@ -217,6 +223,7 @@ boardcast||broadcast
 borad||board
 boundry||boundary
 brievely||briefly
+broadcase||broadcast
 broadcat||broadcast
 bufufer||buffer
 cacluated||calculated
@@ -234,6 +241,7 @@ cancle||cancel
 capabilites||capabilities
 capabilty||capability
 capabitilies||capabilities
+capablity||capability
 capatibilities||capabilities
 capapbilities||capabilities
 caputure||capture
@@ -274,6 +282,7 @@ clared||cleared
 closeing||closing
 clustred||clustered
 coexistance||coexistence
+colescing||coalescing
 collapsable||collapsible
 colorfull||colorful
 comand||command
@@ -290,6 +299,7 @@ comsumer||consumer
 comsuming||consuming
 compability||compatibility
 compaibility||compatibility
+comparsion||comparison
 compatability||compatibility
 compatable||compatible
 compatibiliy||compatibility
@@ -303,6 +313,7 @@ completly||completely
 complient||compliant
 componnents||components
 compoment||component
+comppatible||compatible
 compres||compress
 compresion||compression
 comression||compression
@@ -368,6 +379,8 @@ decsribed||described
 decription||description
 dectected||detected
 defailt||default
+deferal||deferral
+deffered||deferred
 defferred||deferred
 definate||definite
 definately||definitely
@@ -400,6 +413,7 @@ descritptor||descriptor
 desctiptor||descriptor
 desriptor||descriptor
 desriptors||descriptors
+desination||destination
 destionation||destination
 destoried||destroyed
 destory||destroy
@@ -426,7 +440,9 @@ diffrent||different
 differenciate||differentiate
 diffrentiate||differentiate
 difinition||definition
+dimention||dimension
 dimesions||dimensions
+dispalying||displaying
 diplay||display
 directon||direction
 direectly||directly
@@ -442,6 +458,7 @@ disbled||disabled
 disconnet||disconnect
 discontinous||discontinuous
 disharge||discharge
+disnabled||disabled
 dispertion||dispersion
 dissapears||disappears
 distiction||distinction
@@ -456,6 +473,7 @@ dorp||drop
 dosen||doesn
 downlad||download
 downlads||downloads
+droped||dropped
 druing||during
 dynmaic||dynamic
 eanable||enable
@@ -471,6 +489,7 @@ elementry||elementary
 eletronic||electronic
 embeded||embedded
 enabledi||enabled
+enble||enable
 enchanced||enhanced
 encorporating||incorporating
 encrupted||encrypted
@@ -479,6 +498,9 @@ encryptio||encryption
 endianess||endianness
 enhaced||enhanced
 enlightnment||enlightenment
+enqueing||enqueuing
+entires||entries
+entites||entities
 entrys||entries
 enocded||encoded
 enterily||entirely
@@ -498,6 +520,8 @@ etsbalishment||establishment
 excecutable||executable
 exceded||exceeded
 excellant||excellent
+execeeded||exceeded
+execeeds||exceeds
 exeed||exceed
 existance||existence
 existant||existent
@@ -506,6 +530,7 @@ exlcude||exclude
 exlcusive||exclusive
 exmaple||example
 expecially||especially
+experies||expires
 explicite||explicit
 explicitely||explicitly
 explict||explicit
@@ -521,6 +546,7 @@ extracter||extractor
 faield||failed
 falied||failed
 faild||failed
+failded||failed
 failer||failure
 faill||fail
 failied||failed
@@ -540,6 +566,7 @@ fetaure||feature
 fetaures||features
 fileystem||filesystem
 fimware||firmware
+firmare||firmware
 firware||firmware
 finanize||finalize
 findn||find
@@ -574,6 +601,7 @@ funtions||functions
 furthur||further
 futhermore||furthermore
 futrue||future
+gauage||gauge
 gaurenteed||guaranteed
 generiously||generously
 genereate||generate
@@ -645,6 +673,7 @@ independed||independent
 indiate||indicate
 indicat||indicate
 inexpect||inexpected
+inferface||interface
 infomation||information
 informatiom||information
 informations||information
@@ -662,14 +691,17 @@ initialiazation||initialization
 initializiation||initialization
 initialze||initialize
 initialzed||initialized
+initialzing||initializing
 initilization||initialization
 initilize||initialize
 inofficial||unofficial
 inrerface||interface
 insititute||institute
+instace||instance
 instal||install
 instanciate||instantiate
 instanciated||instantiated
+insufficent||insufficient
 inteface||interface
 integreated||integrated
 integrety||integrity
@@ -684,6 +716,8 @@ intermittant||intermittent
 internel||internal
 interoprability||interoperability
 interuupt||interrupt
+interupt||interrupt
+interupts||interrupts
 interrface||interface
 interrrupt||interrupt
 interrup||interrupt
@@ -699,11 +733,14 @@ intialization||initialization
 intialized||initialized
 intialize||initialize
 intregral||integral
+intrerrupt||interrupt
 intrrupt||interrupt
 intterrupt||interrupt
 intuative||intuitive
 inavlid||invalid
 invaid||invalid
+invaild||invalid
+invailid||invalid
 invald||invalid
 invalde||invalid
 invalide||invalid
@@ -712,6 +749,7 @@ invalud||invalid
 invididual||individual
 invokation||invocation
 invokations||invocations
+ireelevant||irrelevant
 irrelevent||irrelevant
 isnt||isn't
 isssue||issue
@@ -747,6 +785,7 @@ loobpack||loopback
 loosing||losing
 losted||lost
 machinary||machinery
+maibox||mailbox
 maintainance||maintenance
 maintainence||maintenance
 maintan||maintain
@@ -758,14 +797,19 @@ managable||manageable
 managment||management
 mangement||management
 manoeuvering||maneuvering
+manufaucturing||manufacturing
 mappping||mapping
 matchs||matches
 mathimatical||mathematical
 mathimatic||mathematic
 mathimatics||mathematics
+maximium||maximum
 maxium||maximum
 mechamism||mechanism
 meetign||meeting
+memeory||memory
+memmber||member
+memoery||memory
 ment||meant
 mergable||mergeable
 mesage||message
@@ -779,6 +823,7 @@ migrateable||migratable
 milliseonds||milliseconds
 minium||minimum
 minimam||minimum
+miniumum||minimum
 minumum||minimum
 misalinged||misaligned
 miscelleneous||miscellaneous
@@ -839,6 +884,7 @@ occurence||occurrence
 occure||occurred
 occured||occurred
 occuring||occurring
+offser||offset
 offet||offset
 offloded||offloaded
 omited||omitted
@@ -855,6 +901,7 @@ optmizations||optimizations
 orientatied||orientated
 orientied||oriented
 orignal||original
+originial||original
 otherise||otherwise
 ouput||output
 oustanding||outstanding
@@ -874,6 +921,7 @@ packege||package
 packge||package
 packtes||packets
 pakage||package
+paket||packet
 pallette||palette
 paln||plan
 paramameters||parameters
@@ -886,6 +934,8 @@ paramters||parameters
 parmaters||parameters
 particuarly||particularly
 particularily||particularly
+partion||partition
+partions||partitions
 partiton||partition
 pased||passed
 passin||passing
@@ -897,10 +947,12 @@ peice||piece
 pendantic||pedantic
 peprocessor||preprocessor
 perfoming||performing
+peripherial||peripheral
 permissons||permissions
 peroid||period
 persistance||persistence
 persistant||persistent
+phoneticly||phonetically
 plalform||platform
 platfoem||platform
 platfrom||platform
@@ -915,6 +967,7 @@ posible||possible
 positon||position
 possibilites||possibilities
 powerfull||powerful
+pramater||parameter
 preamle||preamble
 preample||preamble
 preapre||prepare
@@ -976,6 +1029,7 @@ psudo||pseudo
 psuedo||pseudo
 psychadelic||psychedelic
 pwoer||power
+queing||queuing
 quering||querying
 randomally||randomly
 raoming||roaming
@@ -1004,6 +1058,7 @@ refering||referring
 refernces||references
 refernnce||reference
 refrence||reference
+registed||registered
 registerd||registered
 registeration||registration
 registeresd||registered
@@ -1018,6 +1073,7 @@ regulamentations||regulations
 reigstration||registration
 releated||related
 relevent||relevant
+reloade||reload
 remoote||remote
 remore||remote
 removeable||removable
@@ -1036,19 +1092,23 @@ requried||required
 requst||request
 reregisteration||reregistration
 reseting||resetting
+reseved||reserved
 reseverd||reserved
 resizeable||resizable
 resouce||resource
 resouces||resources
 resoures||resources
 responce||response
+resrouce||resource
 ressizes||resizes
 ressource||resource
 ressources||resources
 restesting||retesting
+resumbmitting||resubmitting
 retransmited||retransmitted
 retreived||retrieved
 retreive||retrieve
+retreiving||retrieving
 retrive||retrieve
 retuned||returned
 reudce||reduce
@@ -1120,6 +1180,7 @@ sleeped||slept
 softwares||software
 speach||speech
 specfic||specific
+specfield||specified
 speciefied||specified
 specifc||specific
 specifed||specified
@@ -1142,7 +1203,10 @@ staion||station
 standardss||standards
 standartization||standardization
 standart||standard
+standy||standby
+stardard||standard
 staticly||statically
+statuss||status
 stoped||stopped
 stoping||stopping
 stoppped||stopped
@@ -1227,12 +1291,14 @@ tipically||typically
 timeing||timing
 timout||timeout
 tmis||this
+toogle||toggle
 torerable||tolerable
 traking||tracking
 tramsmitted||transmitted
 tramsmit||transmit
 tranasction||transaction
 tranfer||transfer
+transcevier||transceiver
 transciever||transceiver
 transferd||transferred
 transfered||transferred
@@ -1267,6 +1333,7 @@ unfortunatelly||unfortunately
 unifiy||unify
 uniterrupted||uninterrupted
 unintialized||uninitialized
+unitialized||uninitialized
 unkmown||unknown
 unknonw||unknown
 unknow||unknown
@@ -1291,7 +1358,9 @@ unsuccessfull||unsuccessful
 unsuported||unsupported
 untill||until
 unuseful||useless
+unvalid||invalid
 upate||update
+upsupported||unsupported
 usefule||useful
 usefull||useful
 usege||usage
-- 
2.19.1

