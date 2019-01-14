Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74148C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B2C2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfANSwZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:52:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbfANSwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:52:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EIiJaP090617
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:52:24 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q0w5xg3yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 13:52:23 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <JOELN@il.ibm.com>;
        Mon, 14 Jan 2019 18:52:23 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 14 Jan 2019 18:52:15 -0000
Received: from us1a3-mail108.a3.dal06.isc4sb.com ([10.146.45.126])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019011418521486-881154 ;
          Mon, 14 Jan 2019 18:52:14 +0000 
In-Reply-To: <20190114103421.7fef97c0@lwn.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 1/3] docs-rst: infiniband: Convert user verbs doc to rst
From:   "Joel Nider" <JOELN@il.ibm.com>
Date:   Mon, 14 Jan 2019 20:52:14 +0200
References: <1547456451-7102-1-git-send-email-joeln@il.ibm.com><1547456451-7102-2-git-send-email-joeln@il.ibm.com><20190114165621.GD22910@ziepe.ca>
 <20190114103421.7fef97c0@lwn.net>
MIME-Version: 1.0
X-KeepSent: E572E930:5960E029-C2258382:00673730;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 August 18, 2016
X-LLNOutbound: False
X-Disclaimed: 16875
X-TNEFEvaluated: 1
x-cbid: 19011418-3107-0000-0000-00000999387C
X-IBM-SpamModules-Scores: BY=0.142389; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00010405; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146463; UDB=6.00597114; IPR=6.00926749;
 BA=6.00006200; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00025124; XFM=3.00000015;
 UTC=2019-01-14 18:52:20
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-01-14 15:23:34 - 6.00009464
x-cbparentid: 19011418-3108-0000-0000-00001F5C6572
Message-Id: <OFE572E930.5960E029-ONC2258382.00673730-C2258382.0067A91D@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote on 01/14/2019 07:34:21 PM:

> From: Jonathan Corbet <corbet@lwn.net>
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Joel Nider <joeln@il.ibm.com>, Leon Romanovsky <leon@kernel.org>, 
Doug 
> Ledford <dledford@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>, 
linux-
> doc@vger.kernel.org, linux-kernel@vger.kernel.org
> Date: 01/14/2019 07:37 PM
> Subject: Re: [PATCH 1/3] docs-rst: infiniband: Convert user verbs doc to 
rst
> 
> On Mon, 14 Jan 2019 09:56:21 -0700
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > >  Documentation/infiniband/user_verbs.rst | 70 
+++++++++++++++++++++++++++++++++
> > >  Documentation/infiniband/user_verbs.txt | 69 
--------------------------------
> > >  2 files changed, 70 insertions(+), 69 deletions(-)
> > >  create mode 100644 Documentation/infiniband/user_verbs.rst
> > >  delete mode 100644 Documentation/infiniband/user_verbs.txt 
> > 
> > Thanks for getting this going Joel, I've been mulling over writing 
more
> > docs for this area for a while now.
> > 
> > Jonathan/linux-doc: Can you Ack at least the build system parts of
> > this please? I can take it through the rdma tree, unless you prefer
> > otherwise?
> 
> Can I make a request?  This appears to be user-oriented documentation; 
can
> we please place it into the userspace-api manual, rather than keeping it
> in its own silo?

I knew someone was going to ask me to do that :-)
I agree that userspace stuff should all be together, but I guess for 
historical reasons this one stayed in the infiniband section. So if Jason 
is ok with moving the doc, I'll take a look in the morning to see how best 
to work that into the patchset.

> Thanks,
> 
> jon
> 


