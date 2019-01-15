Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A38C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D79420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389954AbfAOUlh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:41:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730179AbfAOUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:41:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FKd8DP073062
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:41:36 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q1mfegnpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 15:41:35 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <JOELN@il.ibm.com>;
        Tue, 15 Jan 2019 20:41:35 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 15 Jan 2019 20:41:27 -0000
Received: from us1a3-mail108.a3.dal06.isc4sb.com ([10.146.45.126])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019011520412456-996194 ;
          Tue, 15 Jan 2019 20:41:24 +0000 
In-Reply-To: <20190115110218.3d844efc@lwn.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] docs-rst: Convert user verbs doc to rst
From:   "Joel Nider" <JOELN@il.ibm.com>
Date:   Tue, 15 Jan 2019 22:41:25 +0200
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com><1547547991-5314-2-git-send-email-joeln@il.ibm.com><20190115151402.GA22045@ziepe.ca>
 <20190115110218.3d844efc@lwn.net>
MIME-Version: 1.0
X-KeepSent: 3B8FDB62:8EA185E4-C2258383:007190BE;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 August 18, 2016
X-LLNOutbound: False
X-Disclaimed: 7623
X-TNEFEvaluated: 1
x-cbid: 19011520-7093-0000-0000-000009CC75C7
X-IBM-SpamModules-Scores: BY=0.142283; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.001693
X-IBM-SpamModules-Versions: BY=3.00010413; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146973; UDB=6.00597424; IPR=6.00927266;
 BA=6.00006202; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00025143; XFM=3.00000015;
 UTC=2019-01-15 20:41:32
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-01-15 19:39:15 - 6.00009469
x-cbparentid: 19011520-7094-0000-0000-00006F2DA849
Message-Id: <OF3B8FDB62.8EA185E4-ONC2258383.007190BE-C2258383.0071A7E3@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote on 01/15/2019 08:02:18 PM:

> From: Jonathan Corbet <corbet@lwn.net>
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Joel Nider <joeln@il.ibm.com>, Leon Romanovsky <leon@kernel.org>, 
Doug 
> Ledford <dledford@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>, 
linux-
> doc@vger.kernel.org, linux-kernel@vger.kernel.org
> Date: 01/15/2019 08:14 PM
> Subject: Re: [PATCH v2 1/2] docs-rst: Convert user verbs doc to rst
> 
> On Tue, 15 Jan 2019 08:14:02 -0700
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > > Move user_verbs from infiniband to userspace while changing the
> > > format. Replace the existing Documentation/infiniband/user_verbs.txt
> > > with Documentation/userspace-api/user_verbs.rst. No substantial 
changes
> > > to the content - just some minor reformatting to have the rendering
> > > come out nicely.
> > > 
> > > Since this documents a userspace API, its home should be with the
> > > other userspace API docs.
> > > 
> > > This is in preparation for updating the content in a subsequent
> > > patch.
> > > 
> > > Signed-off-by: Joel Nider <joeln@il.ibm.com>
> > > ---
> > >  Documentation/infiniband/user_verbs.txt    | 69 
-----------------------------
> > >  Documentation/userspace-api/index.rst      |  1 +
> > >  Documentation/userspace-api/user_verbs.rst | 70 
++++++++++++++++++++++++++++++
> > >  3 files changed, 71 insertions(+), 69 deletions(-)
> > >  delete mode 100644 Documentation/infiniband/user_verbs.txt
> > >  create mode 100644 Documentation/userspace-api/user_verbs.rst 
> > 
> > Need to update MAINTAINERS for the new file.. Maybe call this
> > rdma_user_verbs.rst as we could also have rdma_umad, rdma_cm, etc
> 
> Both of those suggestions make sense.  Joel, can you do a quick respin
> along those lines?  Then I think this one is ready.

Yes, if I understood your other message correctly (I'll wait to see your 
response on the other thread), I can make these two changes.

> Thanks,
> 
> jon
> 


