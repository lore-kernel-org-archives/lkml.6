Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE2BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B217020656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389903AbfAOUhM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:37:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729067AbfAOUhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:37:11 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FKajNE058509
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:37:10 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q1pk18e82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:37:09 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <JOELN@il.ibm.com>;
        Tue, 15 Jan 2019 20:37:08 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 15 Jan 2019 20:37:01 -0000
Received: from us1a3-mail108.a3.dal06.isc4sb.com ([10.146.45.126])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019011520370045-991947 ;
          Tue, 15 Jan 2019 20:37:00 +0000 
In-Reply-To: <20190115110854.63200119@lwn.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/2] docs-rst: userspace: update verbs API details
From:   "Joel Nider" <JOELN@il.ibm.com>
Date:   Tue, 15 Jan 2019 22:37:01 +0200
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com><1547547991-5314-3-git-send-email-joeln@il.ibm.com><20190115153128.GA6310@bombadil.infradead.org><OF64BB6EB2.8999493B-ONC2258383.0058B5B7-C2258383.005AA2FD@notes.na.collabserv.com>
 <20190115110854.63200119@lwn.net>
MIME-Version: 1.0
X-KeepSent: 76A381CC:2F8183CE-C2258383:006FEA4D;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 August 18, 2016
X-LLNOutbound: False
X-Disclaimed: 44599
X-TNEFEvaluated: 1
x-cbid: 19011520-5101-0000-0000-00000DDE7467
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.011814
X-IBM-SpamModules-Versions: BY=3.00010413; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146972; UDB=6.00597423; IPR=6.00927264;
 BA=6.00006202; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00025143; XFM=3.00000015;
 UTC=2019-01-15 20:37:06
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-01-15 19:34:12 - 6.00009469
x-cbparentid: 19011520-5102-0000-0000-00006AC0A2AF
Message-Id: <OF76A381CC.2F8183CE-ONC2258383.006FEA4D-C2258383.007140CB@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote on 01/15/2019 08:08:54 PM:

> From: Jonathan Corbet <corbet@lwn.net>
> To: "Joel Nider" <JOELN@il.ibm.com>
> Cc: Matthew Wilcox <willy@infradead.org>, Doug Ledford 
<dledford@redhat.com>,
> Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
linux-
> doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport 
<rppt@linux.ibm.com>
> Date: 01/15/2019 08:09 PM
> Subject: Re: [PATCH v2 2/2] docs-rst: userspace: update verbs API 
details
> 
> On Tue, 15 Jan 2019 18:29:59 +0200
> "Joel Nider" <JOELN@il.ibm.com> wrote:
> 
> > > I think this is a horrible direction to take.  The current document 
is
> > > clearly for _users_.  All this documentation you've added is for 
kernel
> > > hackers.  It needs to go in a different file, or not be added at 
all.
> > > 
> > Hmm, that's a bit heavy-handed in my opinion. If you look at what is 
> > currently under "Userspace API", there are a total of 4 files - not 
> > exactly what I would call comprehensive documentation of the Linux 
kernel 
> > interface. 
> 
> One has to start somewhere - I'm glad to see you adding to it.
> 
> > So the option of not adding more documentation simply because 
> > it is in the wrong section seems a bit defeatist (I think we can all 
agree 
> > more kernel docs is a good thing). So let's assume for the moment that 
it 
> > _should_ be added, and that we are discussing _where_.
> 
> I think we definitely want to add it.
> 
> > Yes, the document I 
> > am modifying has a bit of a mash of pure userspace API - functions and 

> > details that application developers must know - and the lower level 
> > details that are more useful for someone who wishes to extend this 
> > interface. The existing documentation (specifically unshare) also 
suffers 
> > from the same problem. There is a section (7) called "Low Level 
Design" 
> > which documents very much the same level of detail as the Infiniband 
doc, 
> > so this seems to be at least consistent.
> > I think there is a deeper issue - as an application developer, I would 

> > only look at this kernel documentation as a last resort. #1 is the 
'man' 
> > pages, #2 is web search for an example (I know for many it's the other 
way 
> > around). So who really looks at this documentation? I say the vast 
> > majority is kernel hackers. So yes, this is about the user-facing API, 
but 
> > not from the application writer's perspective - it should be about how 
to 
> > create a consistent API for users, from the kernel hacker's 
perspective.
> 
> The intent behind the user-space API manual is to document the 
user-space
> API; it's meant to be read by people writing applications and such.
> Perhaps they find it with a web search, but it will be there for them, 
one
> hopes, when they want it.

So is the intent then to duplicate what is already in 'man'? Why would we 
want 2 different locations for basically the same information? Wouldn't it 
make more sense to just put these few details into appropriate 'man' 
pages?

> The project of reworking the kernel documentation to be more 
comprehensive
> and more focused on its readers, rather than, as Rob Landley once put 
it,
> "a gigantic mess, currently organized based on where random passers-by 
put
> things down last" is still in an early stage.  But that doesn't mean 
that
> we shouldn't try to always move in the right direction. 

It looks like I misunderstood the purpose of the "userspace API" section 
then. So is there a section that is meant for a guide on how to write an 
interface function?

> So I agree with
> Willy that this particular text is better suited to the driver-API
> manual.  Even if a bare bit of information on its own there for now, 
it's
> a starting place.  Can I ask you to do that, please?

OK, just to be clear - you are asking me to leave the original file as-is 
(well, after .rst conversion) but move it to the new location 
(Documentation/userspace-api), and put my new content into a new file in 
the old location (Documentation/infiniband)?
 
> Thanks,
> 
> jon
> 


