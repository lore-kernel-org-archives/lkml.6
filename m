Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0819C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B6820657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfAOQaN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:30:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727667AbfAOQaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:30:13 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0FGTjBV142268
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:30:11 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q1h5bynf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:30:11 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <JOELN@il.ibm.com>;
        Tue, 15 Jan 2019 16:30:08 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 15 Jan 2019 16:30:00 -0000
Received: from us1a3-mail108.a3.dal06.isc4sb.com ([10.146.45.126])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019011516295938-700098 ;
          Tue, 15 Jan 2019 16:29:59 +0000 
In-Reply-To: <20190115153128.GA6310@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] docs-rst: userspace: update verbs API details
From:   "Joel Nider" <JOELN@il.ibm.com>
Date:   Tue, 15 Jan 2019 18:29:59 +0200
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com>
 <1547547991-5314-3-git-send-email-joeln@il.ibm.com>
 <20190115153128.GA6310@bombadil.infradead.org>
MIME-Version: 1.0
X-KeepSent: 64BB6EB2:8999493B-C2258383:0058B5B7;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 August 18, 2016
X-LLNOutbound: False
X-Disclaimed: 25507
X-TNEFEvaluated: 1
x-cbid: 19011516-3815-0000-0000-000009DAC9F2
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.008534
X-IBM-SpamModules-Versions: BY=3.00010412; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146889; UDB=6.00597374; IPR=6.00927181;
 BA=6.00006201; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00025141; XFM=3.00000015;
 UTC=2019-01-15 16:30:05
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-01-15 16:12:44 - 6.00009468
x-cbparentid: 19011516-3816-0000-0000-00000DB2E2F3
Message-Id: <OF64BB6EB2.8999493B-ONC2258383.0058B5B7-C2258383.005AA2FD@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote on 01/15/2019 05:31:28 PM:

> From: Matthew Wilcox <willy@infradead.org>
> To: Joel Nider <joeln@il.ibm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>, 
Leon 
> Romanovsky <leon@kernel.org>, Doug Ledford <dledford@redhat.com>, Mike 
> Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org, 
linux-kernel@vger.kernel.org
> Date: 01/15/2019 05:31 PM
> Subject: Re: [PATCH v2 2/2] docs-rst: userspace: update verbs API 
details
> 
> On Tue, Jan 15, 2019 at 12:26:31PM +0200, Joel Nider wrote:
> > It is important to understand the existing framework when implementing
> > a new verb. The majority of existing API functions are implemented 
using
> > the write syscall, but this has been superceded by the ioctl syscall
> > for new commands. This patch updates the documentation regarding how
> > to go about implementing a new verb, focusing on the new ioctl
> > interface.
> > 
> > The documentation is far from complete, but this is a good step in the
> > right direction. Future patches can add more detail according to need.
> > Also, the interface is still undergoing substantial changes so an
> > effort was made to document only the stable parts so as to avoid
> > incorrect information since documentation changes tend to lag behind
> > code changes.
> 
> I think this is a horrible direction to take.  The current document is
> clearly for _users_.  All this documentation you've added is for kernel
> hackers.  It needs to go in a different file, or not be added at all.
> 
Hmm, that's a bit heavy-handed in my opinion. If you look at what is 
currently under "Userspace API", there are a total of 4 files - not 
exactly what I would call comprehensive documentation of the Linux kernel 
interface. So the option of not adding more documentation simply because 
it is in the wrong section seems a bit defeatist (I think we can all agree 
more kernel docs is a good thing). So let's assume for the moment that it 
_should_ be added, and that we are discussing _where_. Yes, the document I 
am modifying has a bit of a mash of pure userspace API - functions and 
details that application developers must know - and the lower level 
details that are more useful for someone who wishes to extend this 
interface. The existing documentation (specifically unshare) also suffers 
from the same problem. There is a section (7) called "Low Level Design" 
which documents very much the same level of detail as the Infiniband doc, 
so this seems to be at least consistent.
I think there is a deeper issue - as an application developer, I would 
only look at this kernel documentation as a last resort. #1 is the 'man' 
pages, #2 is web search for an example (I know for many it's the other way 
around). So who really looks at this documentation? I say the vast 
majority is kernel hackers. So yes, this is about the user-facing API, but 
not from the application writer's perspective - it should be about how to 
create a consistent API for users, from the kernel hacker's perspective.

Joel

