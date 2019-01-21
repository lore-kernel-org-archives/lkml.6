Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE94FC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1A420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfAUT4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:56:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728047AbfAUT4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:56:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LJseMB139262
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:56:42 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q5jbcdc9d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:56:42 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 21 Jan 2019 19:56:42 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 19:56:39 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LJuc2m22741110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 19:56:38 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67F54AE05C;
        Mon, 21 Jan 2019 19:56:38 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C62BFAE05F;
        Mon, 21 Jan 2019 19:56:37 +0000 (GMT)
Received: from oc6728276242.ibm.com (unknown [9.85.171.190])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 19:56:37 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, joel@jms.id.au, tglx@linutronix.de,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/2] hwmon (occ): Fix license headers
Date:   Mon, 21 Jan 2019 13:56:31 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548100592-50383-1-git-send-email-eajames@linux.ibm.com>
References: <1548100592-50383-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19012119-0040-0000-0000-000004B5365B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010449; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01149804; UDB=6.00593882; IPR=6.00930128;
 MB=3.00025225; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-21 19:56:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012119-0041-0000-0000-000008C04406
Message-Id: <1548100592-50383-2-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=771 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files have inconsistent license information.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c |  3 ++-
 drivers/hwmon/occ/common.h |  3 ++-
 drivers/hwmon/occ/p8_i2c.c |  3 ++-
 drivers/hwmon/occ/p9_sbe.c |  3 ++-
 drivers/hwmon/occ/sysfs.c  | 13 ++-----------
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 391118c..b91a80a 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -1,4 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp 2019
 
 #include <linux/device.h>
 #include <linux/hwmon.h>
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index 7c44df3..55d4967 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -1,4 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp 2019
 
 #ifndef OCC_COMMON_H
 #define OCC_COMMON_H
diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
index b59efc9..76fb787 100644
--- a/drivers/hwmon/occ/p8_i2c.c
+++ b/drivers/hwmon/occ/p8_i2c.c
@@ -1,4 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp 2019
 
 #include <linux/device.h>
 #include <linux/errno.h>
diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index b65c1d1..f6387cc 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -1,4 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp 2019
 
 #include <linux/device.h>
 #include <linux/errno.h>
diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
index 743b26ec..fe3d15e 100644
--- a/drivers/hwmon/occ/sysfs.c
+++ b/drivers/hwmon/occ/sysfs.c
@@ -1,14 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * OCC hwmon driver sysfs interface
- *
- * Copyright (C) IBM Corporation 2018
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright IBM Corp 2019
 
 #include <linux/bitops.h>
 #include <linux/device.h>
-- 
1.8.3.1

