Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D925218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfAYXgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:36:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbfAYXgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:36:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0PNSdXR142969
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 18:36:54 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q87sqhtpn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 18:36:53 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bwarrum@linux.ibm.com>;
        Fri, 25 Jan 2019 23:36:53 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Jan 2019 23:36:50 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0PNanvw14876746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Jan 2019 23:36:49 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F7526A04D;
        Fri, 25 Jan 2019 23:36:49 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D73466A04F;
        Fri, 25 Jan 2019 23:36:47 +0000 (GMT)
Received: from vagrant-VirtualBox.rch.stglabs.ibm.com (unknown [9.10.79.122])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jan 2019 23:36:47 +0000 (GMT)
From:   Brad Warrum <bwarrum@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Brad Warrum <bwarrum@linux.ibm.com>,
        Steve Royer <seroyer@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: add myself as maintainer of ibmvmc driver
Date:   Fri, 25 Jan 2019 17:36:26 -0600
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19012523-0036-0000-0000-00000A8137DE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010477; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01151774; UDB=6.00600337; IPR=6.00932118;
 MB=3.00025291; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-25 23:36:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012523-0037-0000-0000-00004A7B9A9F
Message-Id: <1548459386-4596-1-git-send-email-bwarrum@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-25_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=799 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901250178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Royer has moved on to another project and has
requested that I maintain the IBM Power Virtual Management
Channel driver in his stead.

Cc: Steve Royer <seroyer@linux.ibm.com>
Signed-off-by: Brad Warrum <bwarrum@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a4..9a20eae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7244,7 +7244,7 @@ S:	Supported
 F:	drivers/scsi/ibmvscsi/ibmvfc*
 
 IBM Power Virtual Management Channel Driver
-M:	Steven Royer <seroyer@linux.ibm.com>
+M:	Brad Warrum <bwarrum@linux.ibm.com>
 S:	Supported
 F:	drivers/misc/ibmvmc.*
 
-- 
2.7.4

