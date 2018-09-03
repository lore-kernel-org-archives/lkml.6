Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB1320873
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB1320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeICVeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:34:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeICVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:34:06 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0McEmF-1gDaDG0o23-00JasP; Mon, 03 Sep 2018 19:12:57 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 3/4 next] net: lan78xx: Switch to SPDX identifier
Date:   Mon,  3 Sep 2018 19:12:38 +0200
Message-Id: <1535994759-8938-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
References: <1535994759-8938-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:hZmG4Xkexm6DlL2hMPNBbCAjpZl1xIjUNcKknMZOWIZj09mha++
 p/s/W43AZxY9Si+nDqJcxRhWNndj6qSjEyXpMdlUgyQPMLu+13Ks2WDlxZ66xmyV9fjbFK7
 yjuugD1gRbR3bidN+QkpOBkS194Eindl+a/taJkttkpU+80K0kbFo3uprLm0WPErpv82+tg
 DMOSG50212OUMCUHv1KIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ps3qeWIQbBg=:SPCke+RSOnkNLeSqxPRrsy
 wZk6KPc/f13lpR+T7lDdV6pvi1+1XbIh9MRPkfyqCYb5nRmpl+DaFCX1mknvCAQFu5gJsYUpo
 nWxC0gANwnh/d4RO6J2QP+dZHgYj9LowFV0wDiNUnpz4MfqZOq0gnRBLB+O6xfFkZ3BpbDuLU
 IIXvkFBbCycYx9PdiJgl2zNMre1WORnmt3MpFPjS3fVg1Fa/YQqKR3j3xzXbv9H5LvAugFnqO
 +W31F+2PHOdMqeufSoZPLAbuv2vQWc5Elt5wZ5k7l+N5Khim35c8h0JHw/WPJedg9vbXzAwxT
 l3zoKf1p+NAcPpmOcjAMjzoZkGmZX3qs6zoWrcoAxBwriHKqjEai08QvjBvQ2e+MAYsYhX9LD
 2rk5M0EfsPXqeTh+3ARHVvA1ZZP/0fY63Kjv1MeKRMuutGgc1Yp85l7a7rWgeN2yKENcyeg9a
 LWZ82YOMNRoVfRQweGNly8udtmVIZHUWPNYRg80izSuEJ6KYVjgKnRK797GwuCTHgzwIryRBl
 Ex6SUF3PDrbvebOAGcKMIaNy30cJ5xiXfvScYnVf/jsKUgEeLCpw7ulVDogEpZljwwnzrIqrr
 0/dj6Rb7G0FOvPZUMAx4Kx9GzVCbetimj4eIyE4ddhzGQgBF9LqW70CUPqzfThpsndlWXm23u
 lKnWaIFIKfW6FstY1+JIyNP8xH5kt4mF6/qF4fmNRPZVjzfhbljVeRz6MZo0w5X9tzxM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/usb/lan78xx.c | 18 ++----------------
 drivers/net/usb/lan78xx.h | 18 ++----------------
 2 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3d505c2..a6e88a4 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1,19 +1,5 @@
-/*
- * Copyright (C) 2015 Microchip Technology
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
- */
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2015 Microchip Technology */
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
diff --git a/drivers/net/usb/lan78xx.h b/drivers/net/usb/lan78xx.h
index 25aa546..e65cb54 100644
--- a/drivers/net/usb/lan78xx.h
+++ b/drivers/net/usb/lan78xx.h
@@ -1,19 +1,5 @@
-/*
- * Copyright (C) 2015 Microchip Technology
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
- */
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2015 Microchip Technology */
 #ifndef _LAN78XX_H
 #define _LAN78XX_H
 
-- 
2.7.4

