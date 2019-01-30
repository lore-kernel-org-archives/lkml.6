Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807D5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B752175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfA3M5a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:57:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbfA3M53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:57:29 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UCtV7d075931
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:57:28 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qba7qee76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:57:27 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-kernel@vger.kernel.org> from <JOELN@il.ibm.com>;
        Wed, 30 Jan 2019 12:57:26 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 30 Jan 2019 12:57:21 -0000
Received: from us1a3-mail108.a3.dal06.isc4sb.com ([10.146.45.126])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2019013012572150-480607 ;
          Wed, 30 Jan 2019 12:57:21 +0000 
In-Reply-To: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
To:     "Jonathan Corbet" <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Mike Rapoport" <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] update infiniband uverbs documentation
From:   "Joel Nider" <JOELN@il.ibm.com>
Date:   Wed, 30 Jan 2019 14:57:21 +0200
References: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
X-KeepSent: 639BB113:4704AA4E-C2258392:004719E1;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP7 August 18, 2016
X-LLNOutbound: False
X-Disclaimed: 51099
X-TNEFEvaluated: 1
x-cbid: 19013012-3107-0000-0000-000009CF548B
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.037177
X-IBM-SpamModules-Versions: BY=3.00010503; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153919; UDB=6.00601641; IPR=6.00934293;
 BA=6.00006218; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00025353; XFM=3.00000015;
 UTC=2019-01-30 12:57:25
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-01-30 06:25:17 - 6.00009527
x-cbparentid: 19013012-3108-0000-0000-000031F36174
Message-Id: <OF639BB113.4704AA4E-ONC2258392.004719E1-C2258392.00472B4C@notes.na.collabserv.com>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Have you had a chance to review this patchset?

Thanks,

Joel Nider/Haifa/IBM@IBMIL wrote on 01/22/2019 12:00:32 PM:

> From: Joel Nider/Haifa/IBM@IBMIL
> To: "Jonathan Corbet" <corbet@lwn.net>
> Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" 
<leon@kernel.org>, 
> "Doug Ledford" <dledford@redhat.com>, "Mike Rapoport" 
<rppt@linux.ibm.com>, 
> Joel Nider/Haifa/IBM@IBMIL, linux-doc@vger.kernel.org, 
linux-kernel@vger.kernel.org
> Date: 01/22/2019 12:00 PM
> Subject: [PATCH v3 0/3] update infiniband uverbs documentation
> 
> A small patchset to update the verbs API documentation with some
> information regarding the ioctl syscall. First patch converts the
> file format to ReST, since this is the new preferred format, moves
> the file to Documentation/userspace-api, and updates the index.
> The 2nd patch adds the new content, documenting a bit of the internal
> workings of the kernel side of the API functions. The goal is to make
> it easier for developers unfamiliar with the structure to understand
> what is going on when adding a new function.
> The 3rd patch updates the MAINTAINERS file.
> 
> v3 addresses comments from Jon, Willy and Jason:
>  The location of the new content should be driver-api
>  The location of the old (converted) content should be userspace-api
>  MAINTAINERS file must be updated
> 
> Joel Nider (3):
>   docs-rst: Convert user verbs doc to rst
>   docs-rst: driver-api: Add infiniband interface documentation
>   MAINTAINERS: add new RDMA/Infiniband documentation
> 
>  Documentation/driver-api/index.rst              |  1 +
>  Documentation/driver-api/infiniband.rst         | 73 
+++++++++++++++++++++++++
>  Documentation/infiniband/user_verbs.txt         | 69 
-----------------------
>  Documentation/userspace-api/index.rst           |  1 +
>  Documentation/userspace-api/rdma_user_verbs.rst | 70 
++++++++++++++++++++++++
>  MAINTAINERS                                     |  2 +
>  6 files changed, 147 insertions(+), 69 deletions(-)
>  create mode 100644 Documentation/driver-api/infiniband.rst
>  delete mode 100644 Documentation/infiniband/user_verbs.txt
>  create mode 100644 Documentation/userspace-api/rdma_user_verbs.rst
> 
> -- 
> 2.7.4
> 


