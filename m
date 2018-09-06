Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56559C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5F82075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5F82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeIFVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:54:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbeIFVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:54:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w86HAHis064761
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 13:18:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mb6j25u31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:18:07 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bryantly@linux.vnet.ibm.com>;
        Thu, 6 Sep 2018 13:18:06 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 13:18:03 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w86HI2Ya45875214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 17:18:02 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA24B2805A;
        Thu,  6 Sep 2018 13:16:13 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7523A2805C;
        Thu,  6 Sep 2018 13:16:13 -0400 (EDT)
Received: from bryants-mbp-4.rchland.ibm.com (unknown [9.10.79.137])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 Sep 2018 13:16:13 -0400 (EDT)
From:   "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org
Cc:     mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        "Bryant G. Ly" <bryantly@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Update Email Address for Bryant G. Ly
Date:   Thu,  6 Sep 2018 12:17:59 -0500
X-Mailer: git-send-email 2.7.2
X-TM-AS-GCONF: 00
x-cbid: 18090617-0040-0000-0000-0000046B61C9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009676; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01084458; UDB=6.00559734; IPR=6.00864458;
 MB=3.00023147; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-06 17:18:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090617-0041-0000-0000-000008728498
Message-Id: <1536254279-37408-1-git-send-email-bryantly@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=861 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bryant G. Ly" <bryantly@linux.ibm.com>

I am leaving IBM to go to Catalogic Software, updating email
address so I can continue to maintain the drivers.

Signed-off-by: Bryant G. Ly <bryantly@linux.ibm.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 285e096..6354b1e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -41,6 +41,8 @@ Boris Brezillon <boris.brezillon@bootlin.com> <b.brezillon.dev@gmail.com>
 Boris Brezillon <boris.brezillon@bootlin.com> <b.brezillon@overkiz.com>
 Brian Avery <b.avery@hp.com>
 Brian King <brking@us.ibm.com>
+Bryant G. Ly <bryangly@gmail.com> <bgly@us.ibm.com> <bryantly@linux.vnet.ibm.com>
+Bryant G. Ly <bryantly@linux.ibm.com>
 Christoph Hellwig <hch@lst.de>
 Christophe Ricard <christophe.ricard@gmail.com>
 Corey Minyard <minyard@acm.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b..8d529dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6983,7 +6983,7 @@ S:	Supported
 F:	drivers/scsi/ibmvscsi/ibmvfc*
 
 IBM Power Virtual Management Channel Driver
-M:	Bryant G. Ly <bryantly@linux.vnet.ibm.com>
+M:	Bryant G. Ly <bryangly@gmail.com>
 M:	Steven Royer <seroyer@linux.vnet.ibm.com>
 S:	Supported
 F:	drivers/misc/ibmvmc.*
@@ -6996,7 +6996,7 @@ F:	drivers/scsi/ibmvscsi/ibmvscsi*
 F:	include/scsi/viosrp.h
 
 IBM Power Virtual SCSI Device Target Driver
-M:	Bryant G. Ly <bryantly@linux.vnet.ibm.com>
+M:	Bryant G. Ly <bryangly@gmail.com>
 M:	Michael Cyr <mikecyr@linux.vnet.ibm.com>
 L:	linux-scsi@vger.kernel.org
 L:	target-devel@vger.kernel.org
-- 
2.7.2

