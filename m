Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4052EECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BFA20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BFA20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbeGSPb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:31:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730521AbeGSPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E53274C735DBC;
        Thu, 19 Jul 2018 22:48:19 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:48:12 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 9/9] net: hns3: Add SPDX tags to HNS3 PF driver
Date:   Thu, 19 Jul 2018 15:47:06 +0100
Message-ID: <20180719144706.644-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719144706.644-1-salil.mehta@huawei.com>
References: <20180719144706.644-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Add the SPDX identifiers to HNS3 PF driver.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c             | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c        | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h         | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c      | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c  | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c  | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h  | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   | 10 ++--------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h   | 10 ++--------
 16 files changed, 32 insertions(+), 128 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 0762ad1..fff5be8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016-2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index da806fd..67befff 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016-2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HNAE3_H
 #define __HNAE3_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
index eb82700..ea5f8a8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016-2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include "hnae3.h"
 #include "hns3_enet.h"
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ba2797e..6c9e5d6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index bf9aa02..e4b4a8f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HNS3_ENET_H
 #define __HNS3_ENET_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 11620e0..80ba95d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/etherdevice.h>
 #include <linux/string.h>
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
index 68356da..165c3d5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 66a534a..5cd22f9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_CMD_H
 #define __HCLGE_CMD_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 955f0e3..f08ebb7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016-2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include "hclge_main.h"
 #include "hclge_tm.h"
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h
index 7d808ee..278f21e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_DCB_H__
 #define __HCLGE_DCB_H__
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e0b617c..a9b888f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016-2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/acpi.h>
 #include <linux/device.h>
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 7d4845e..dfa5c94 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_MAIN_H
 #define __HCLGE_MAIN_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index b6cfe6f..2065ee2f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
index c5e91cf..bb3ce35 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016-2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_MDIO_H
 #define __HCLGE_MDIO_H
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index e2acf3b..5db70a1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/etherdevice.h>
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index c82d49e..dd4c194 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -1,11 +1,5 @@
-/*
- * Copyright (c) 2016~2017 Hisilicon Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2016-2017 Hisilicon Limited.
 
 #ifndef __HCLGE_TM_H
 #define __HCLGE_TM_H
-- 
2.7.4


