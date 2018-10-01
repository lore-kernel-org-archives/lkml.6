Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA9C2148C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA9C2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeJAXFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:05:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725740AbeJAXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:05:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91GPoa2071681
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 12:26:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2munn5c228-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:26:31 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mrochs@linux.ibm.com>;
        Mon, 1 Oct 2018 10:26:30 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 10:26:27 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w91GQQJu16711880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Oct 2018 09:26:26 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E21B27805F;
        Mon,  1 Oct 2018 10:26:25 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CB0378060;
        Mon,  1 Oct 2018 10:26:25 -0600 (MDT)
Received: from p8tul1-build.aus.stglabs.ibm.com (unknown [9.3.141.206])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Oct 2018 10:26:25 -0600 (MDT)
From:   "Matthew R. Ochs" <mrochs@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Uma Krishnan <ukrishn@linux.ibm.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Fix typo in cxlflash stanza
Date:   Mon,  1 Oct 2018 11:26:10 -0500
X-Mailer: git-send-email 2.1.0
X-TM-AS-GCONF: 00
x-cbid: 18100116-0012-0000-0000-000016BF288C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009803; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096378; UDB=6.00566912; IPR=6.00876421;
 MB=3.00023576; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 16:26:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100116-0013-0000-0000-00005498F063
Message-Id: <1538411170-1977-1-git-send-email-mrochs@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=746 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uapi header file listed in the cxlflash stanza has a typo.

Removed the trailing 's' from the filename.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Matthew R. Ochs <mrochs@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b22e7fd..1038857 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4032,7 +4032,7 @@ M:	Uma Krishnan <ukrishn@linux.vnet.ibm.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/cxlflash/
-F:	include/uapi/scsi/cxlflash_ioctls.h
+F:	include/uapi/scsi/cxlflash_ioctl.h
 F:	Documentation/powerpc/cxlflash.txt
 
 CYBERPRO FB DRIVER
-- 
2.1.0

