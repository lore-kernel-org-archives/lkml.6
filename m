Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A12C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6A5206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6A5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIDVzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:55:50 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeIDVzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:55:50 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MEmVu-1g7ksb2HGc-00FxPx; Tue, 04 Sep 2018 19:29:39 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 3/4 next] net: lan78xx: Switch to SPDX identifier
Date:   Tue,  4 Sep 2018 19:29:11 +0200
Message-Id: <1536082152-3669-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
References: <1536082152-3669-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:1L1OCBo2KXTeU8ZPU/mZzda47t/PixdybJ0u6jjwjS49ooYomZp
 jhwOBb0zjmqaJzWfQxDW8i8z88Zf7vtdqQYkS8oza0pDPve1Mn/A/NZ3Xegq+6Y1sY30JKl
 egW9lV28m+3Yajf5As9Md9MOSUHc/48vlF3VlpzayoszL5t7bJqTfPBzliKjESDtQA0X/+t
 c7Zj2sabXxRwhjr9YpR2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/hHFeL8gq24=:kDl/tv/3qdCtZ6+uSZYq2q
 d6SNWVyqIl3NyLvT8mSoHahJ3aX4CgHNXctdkkh88Y4DxSmEEdcpTX5HVRMrTqMF5g3E+lC51
 egEZBjLiS16MGbQDdg9Avnw+uraS/5fbcbiZWDJmB4Dg0qbURydgfjuSvxmL7FieA/+Ag1WaJ
 q/dzUYUYYxoi76Po6NW6CezLhPItzMGE1Dh37pG9A6Wlol4CtAMU5LrkIOqq4xZED6ePDPaPi
 uVNEyS7JnSUPsNy8644rB+PKaidhvQStk+FLO+6Le7cY35j7r5YudFhjz8gYBmW7AKWjhxR57
 0AgVMicnzf6eG4apsFLxkqEH7gfgdJjpYCslmTYaXaP/5pBjNqYj/n7WnluJvhUey1uvjNRGN
 +S1AA19pkjvIFyDPMKIwbdgqeMeIr+IuAtL9mRJe+kcRpngnzwe1ELojR5FkBylEVOlIwTTzr
 LWlqpxmOCAkZTFtsNg6KN2S9k21hISQW681RPv4VzCJvyqcJxyRCnJHAyut4Xfg0qyi6CHzR9
 t+JWV3kgQKNfOcF5s96SnjRc6WNVIz9ULWvkPPWwvoI2TXBk9qZy21QprtHy3QHGaLc5FCEYm
 SzGzMer8FwRvPDWQEZVdbGzGQnD2cgabHmEVc1E5N53MnFrr/xxHLXJvxNBS4LBjNs5vdor01
 uesiP/ce1Lsr6VaIrqM96mN/38uhsposGym/JMu/sIDU4eu0qt1Oulz7stA23H3CY1xQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/usb/lan78xx.c | 14 +-------------
 drivers/net/usb/lan78xx.h | 14 +-------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3d505c2..e1c055d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015 Microchip Technology
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/version.h>
 #include <linux/module.h>
diff --git a/drivers/net/usb/lan78xx.h b/drivers/net/usb/lan78xx.h
index 25aa546..968e5e5 100644
--- a/drivers/net/usb/lan78xx.h
+++ b/drivers/net/usb/lan78xx.h
@@ -1,18 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2015 Microchip Technology
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef _LAN78XX_H
 #define _LAN78XX_H
-- 
2.7.4

