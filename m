Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A912F20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfAQGd0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:33:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbfAQGd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:33:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0H6TTWD026742
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 01:33:25 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q2k6gtqch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 01:33:24 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <JOELN@il.ibm.com>;
        Thu, 17 Jan 2019 06:33:24 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 17 Jan 2019 06:33:18 -0000
Received: from us1a3-mail108.a3.dal06.isc4sb.com ([10.146.45.126])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019011706331761-80739 ;
          Thu, 17 Jan 2019 06:33:17 +0000 
In-Reply-To: <20190115143859.4cbd5d9c@lwn.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/2] docs-rst: userspace: update verbs API details
From:   "Joel Nider" <JOELN@il.ibm.com>
Date:   Thu, 17 Jan 2019 08:33:17 +0200
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com><1547547991-5314-3-git-send-email-joeln@il.ibm.com><20190115153128.GA6310@bombadil.infradead.org><OF64BB6EB2.8999493B-ONC2258383.0058B5B7-C2258383.005AA2FD@notes.na.collabserv.com><20190115110854.63200119@lwn.net><OF76A381CC.2F8183CE-ONC2258383.006FEA4D-C2258383.007140CB@notes.na.collabserv.com>
 <20190115143859.4cbd5d9c@lwn.net>
MIME-Version: 1.0
X-KeepSent: 50C1BD06:78985B8A-C2258384:004ECD0A;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 August 18, 2016
X-LLNOutbound: False
X-Disclaimed: 45319
X-TNEFEvaluated: 1
x-cbid: 19011706-9951-0000-0000-00000B003666
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.066691
X-IBM-SpamModules-Versions: BY=3.00010422; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01147643; UDB=6.00597830; IPR=6.00927941;
 BA=6.00006203; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00025167; XFM=3.00000015;
 UTC=2019-01-17 06:33:23
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-01-16 23:56:54 - 6.00009474
x-cbparentid: 19011706-9952-0000-0000-00001AFB94B3
Message-Id: <OF50C1BD06.78985B8A-ONC2258384.004ECD0A-C2258385.0024016B@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote on 01/15/2019 11:38:59 PM:

> We are not attempting to duplicate the man pages; there's been 
occasional
> talk of bringing them into the kernel tree, but enthusiasm for that is
> scarce for a number of good reasons.  But there's a lot of information
> about the user-space API that isn't in the man pages, including the 
piece
> you are converting to RST.

My next task is to update the man pages for rdma-core since I touched 
libibverbs as well (the _other_ side of this API). So I just want to make 
sure everything is documented exactly once (no more, no less) and in the 
correct place.

> For something like this, driver-api seems like the right place. Someday,
> in some glorious future, it could contain a full manual on how these
> drivers are written, using all of the nice kerneldoc comments that 
already
> exist under drivers/infiniband.
> 
> > OK, just to be clear - you are asking me to leave the original file 
as-is 
> > (well, after .rst conversion) but move it to the new location 
> > (Documentation/userspace-api), and put my new content into a new file 
in 
> > the old location (Documentation/infiniband)?
> 
> I'd rather see you put the new stuff under Documentation/driver-api, 
either
> in a standalone file or in a new subdirectory.

I took a quick look at what is already there, and I don't see how the RDMA 
stuff fits. It looks like the majority is about various busses (SPI, PCI, 
I2C, USB, etc) or other general platform support (clk, edac) that I would 
use when writing a driver. My changes are very infiniband-specific, and 
user-facing and don't really seem to fit in with the aforementioned 
modules. It seems to me that if it does not belong in userspace-api, then 
leaving it where it is is the best choice.

Regards,
Joel


