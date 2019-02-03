Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AD1C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4756F20855
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfBCMzD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:55:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726584AbfBCMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:55:03 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x13Cn7iS125097
        for <linux-kernel@vger.kernel.org>; Sun, 3 Feb 2019 07:55:02 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qdsebnand-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 07:55:02 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <JOELN@il.ibm.com>;
        Sun, 3 Feb 2019 12:55:01 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Sun, 3 Feb 2019 12:54:54 -0000
Received: from us1a3-mail108.a3.dal06.isc4sb.com ([10.146.45.126])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019020312545418-264105 ;
          Sun, 3 Feb 2019 12:54:54 +0000 
In-Reply-To: <20190201161533.5000ad95@lwn.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] update infiniband uverbs documentation
From:   "Joel Nider" <JOELN@il.ibm.com>
Date:   Sun, 3 Feb 2019 14:54:53 +0200
References: <1548151235-386-1-git-send-email-joeln@il.ibm.com><20190201165252.GA13002@ziepe.ca>
 <20190201161533.5000ad95@lwn.net>
MIME-Version: 1.0
X-KeepSent: 13737DE3:9F96BF4B-C2258396:0046B3B2;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 August 18, 2016
X-LLNOutbound: False
X-Disclaimed: 7727
X-TNEFEvaluated: 1
x-cbid: 19020312-9951-0000-0000-00000B3212F9
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000078
X-IBM-SpamModules-Versions: BY=3.00010527; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01155763; UDB=6.00602793; IPR=6.00936211;
 BA=6.00006221; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00025418; XFM=3.00000015;
 UTC=2019-02-03 12:54:59
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-02-03 10:56:28 - 6.00009543
x-cbparentid: 19020312-9952-0000-0000-00001B46141C
Message-Id: <OF13737DE3.9F96BF4B-ONC2258396.0046B3B2-C2258396.0046F1B2@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-03_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote on 02/02/2019 01:15:33 AM:

> Subject: Re: [PATCH v3 0/3] update infiniband uverbs documentation
> 
> On Fri, 1 Feb 2019 09:52:52 -0700
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > Doc folks, what is the feedback on these patches? Should I take
> > them through the rdma tree?
> 
> If you think they are ready (it seemed that there were still comments on
> one of the patches?) I'll take them, just let me know.

From Jason's latest review, it looks like 90% of what I wrote is no longer 
relevant:
> This array was deleted recently
> IB_VERBS_DELCARE_CMD is also deleted
> DECLARE_UVERBS_OBJECT_TREE as well

So I'm abandoning this patch.

> Thanks,
> 
> jon (aka "doc folks" :)
> 


