Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeCNUUq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:20:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752081AbeCNUUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:20:40 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 1/4] integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
Date: Wed, 14 Mar 2018 17:20:17 -0300
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031420-0044-0000-0000-000003F38C1C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003063; UDB=6.00510446; IPR=6.00782394;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 20:20:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031420-0045-0000-0000-000008238D1E
Message-Id: <20180314202020.3794-2-bauerman@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro isn't used anymore since commit 0d73a55208e9 ("ima: re-introduce
own integrity cache lock"), so remove it.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/integrity.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 8224880935e0..5e58e02ba8dc 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -30,7 +30,6 @@
 
 /* iint cache flags */
 #define IMA_ACTION_FLAGS	0xff000000
-#define IMA_ACTION_RULE_FLAGS	0x06000000
 #define IMA_DIGSIG_REQUIRED	0x01000000
 #define IMA_PERMIT_DIRECTIO	0x02000000
 #define IMA_NEW_FILE		0x04000000
