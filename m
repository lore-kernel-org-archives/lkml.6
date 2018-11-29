Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD16C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1053920868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1053920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeK3C7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:59:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728363AbeK3C7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:59:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATFdoXf060506
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:53:17 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p2g4x8xby-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:50:06 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Thu, 29 Nov 2018 15:49:07 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Nov 2018 15:49:04 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wATFn4dc15925274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 15:49:04 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE2067805E;
        Thu, 29 Nov 2018 15:49:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD4CE78066;
        Thu, 29 Nov 2018 15:49:02 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.139.109])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 29 Nov 2018 15:49:02 +0000 (GMT)
Subject: Re: [PATCH] scsi: libsas: Add missing license and update to SPDX
 license identifier
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     John Garry <john.garry@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     martin.petersen@oracle.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Thu, 29 Nov 2018 07:49:01 -0800
In-Reply-To: <07b65f80-9b73-472f-1fb8-7c0133f1d1ab@huawei.com>
References: <1543328132-243266-1-git-send-email-john.garry@huawei.com>
         <20181127144333.GA11004@kroah.com>
         <8ae3a984-b4d4-f2eb-4aaa-b460441fa403@huawei.com>
         <07b65f80-9b73-472f-1fb8-7c0133f1d1ab@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112915-0016-0000-0000-0000095CE2DA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010143; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01124513; UDB=6.00583849; IPR=6.00904640;
 MB=3.00024384; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-29 15:49:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112915-0017-0000-0000-0000413B7536
Message-Id: <1543506541.2881.16.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 11:52 +0000, John Garry wrote:
[...]
> Hi Greg,
> 
> I also note that currently we have an inconsistency in license of 
> sas_init.c:
> 
> /*
>   * Serial Attached SCSI (SAS) Transport Layer initialization
>   *
>   * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
>   * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
>   *
>   * This file is licensed under GPLv2.
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
>   * published by the Free Software Foundation; either version 2 of
> the
>   * License, or (at your option) any later version.
>   *
>   * This program is distributed in the hope that it will be useful,
> but
>   * WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>   * General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-
> 1307
>   * USA
>   *
>   */
> 
> ...
> 
> MODULE_AUTHOR("Luben Tuikov <luben_tuikov@adaptec.com>");
> MODULE_DESCRIPTION("SAS Transport Layer");
> MODULE_LICENSE("GPL v2");
> 
> So the license specifies v2+ but module license states v2.
> 
> I could not find a docment for guidance on this. I also note that
> making sas_task.c v2 would mean mixing v2 and v2+ into the module.

The point here is to get help.  There are three pieces of evidence in
the file one for v2+ and two for v2.  So you can look in the git tree
to when it was actually contributed:

commit 2908d778ab3e244900c310974e1fc1c69066e450
Author: James Bottomley <James.Bottomley@SteelEye.com>
Date:   Tue Aug 29 09:22:51 2006 -0500

    [SCSI] aic94xx: new driver
 
and if you ask the original contributor he can tell you the original
intent was v2 only.  If you want to modify all the files in libsas and
aic9xxx to have that SPDX tag.

> At this point I'm reluctant to touch this in case I mess up, but
> there  is still the missing license in sas_task.c .

Again, the tree will tell you.  In this case it's

commit 366ca51f30de1cbb5b356c70b7bb22051c558e41
Author: James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Fri Jan 18 10:47:01 2008 -0600

    [SCSI] libsas: abstract STP task status into a function

So that file is a direct extraction from an existing v2 only file in
aic9xxx, so it's licence is also v2 only.

James

