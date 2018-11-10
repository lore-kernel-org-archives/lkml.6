Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C32C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C654120854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C654120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeKKBpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:45:18 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:58429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKKBpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:45:18 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MA7b8-1gEPBn22wc-00BfLj; Sat, 10 Nov 2018 16:59:33 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/17] mailbox: bcm2835: Switch to SPDX identifier
Date:   Sat, 10 Nov 2018 16:59:15 +0100
Message-Id: <1541865555-7647-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:trsOoQu4ybVrVo+87Rta97/hHNs3nwLLbbi9Rg2qGnflPRymJhj
 5gXQezq4p+ub6SHuKhZb/2/WLU1aCSXN91oHLnrSFKoLiRLo12rISg3tvK7CIR2SYLmhLXM
 YTQgU9X2aGEKDGGhmpfa49dgjC3Kp5Xfm35YRarVM1qwPaon+smb1blhJpR3G1h0WKcfOA0
 e0aKuvE9MrPriC55EdQCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jje9JbjsTsk=:adiuRmb2I8ohZULlBfaYRX
 iWzamlMh2VrBl4VonxbruCp04fm6Pf/MU4DuC2iIbYAyaZbgp9KgYLsRi68UinvclQktM3zk4
 4nGAYphwFjwihO7c9gYEwbWvc6OYDprNeLW9ODgfyKFBResxNOyTZR0nweVxwLNWH/HZUp3NA
 kAKyvuWVoCzQ3PjyFGfsFatL9trnntjpGcNmLWECTslClSBPgSfjScJxbySINVBkSutBFH/Fs
 EoqtHOaaVK+j0UQeFkueBPvAGx6AWnlDBmnz8u8UMCSiV5xXDWk0C9tpQP06rGZKutQVHK9kY
 eB8o6hsX9AYiHig+kal8KEGOueUsksHWrusAAIaGLrupJX6lp+zt/+gISOHMnAW95Dg5Ws9D1
 rM6O3cGdr7DMMThaYfkxRBmMCfw4vojgghky4+dmV61Yy9Zbd8c42Ctc2Tn6e74bLzvWWMv7h
 9vmPuwHlX+5sK7n0ZmKv9zdBefZ0kq7Zvs/pODSCU1zAgut6eSRPrFEKT/qpAyX9gkMR46hVA
 N5oDa72bAXWbtd9lOIpeUhnz4C1W536zYJ6nx1Iip9aeNyrTFB0YJr6NUt1wvTtrNyd0afUKH
 Gr6Aa3suEEwSRMAcTIPcBeHHjg4EF7ZSbltnOAKicbJMkK7o1RgRpXRKb4/nOhgsvGOk7zdBN
 Dt2iyDthmPCDjHcURz+JVWbEd4gDG8KuO3Wg2x2WTHBDQInX03+Xyl3fPK5GVzs6OVaDqiYMy
 PYs9gRq6uNUc2nouy2kaeyBzSljubs0floA2d8ZHWiFgU6XAZ+AKKx/g0jj7zo/My+yXORIYk
 wpaLLTYkKImTy5MXIXxaBaqgf+ojA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mailbox/bcm2835-mailbox.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
index e92bbc5..bb3ee72 100644
--- a/drivers/mailbox/bcm2835-mailbox.c
+++ b/drivers/mailbox/bcm2835-mailbox.c
@@ -1,15 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2010,2015 Broadcom
  *  Copyright (C) 2013-2014 Lubomir Rintel
  *  Copyright (C) 2013 Craig McGeachie
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This device provides a mechanism for writing to the mailboxes,
- * that are shared between the ARM and the VideoCore processor
- *
  * Parts of the driver are based on:
  *  - arch/arm/mach-bcm2708/vcio.c file written by Gray Girling that was
  *    obtained from branch "rpi-3.6.y" of git://github.com/raspberrypi/
-- 
2.7.4

