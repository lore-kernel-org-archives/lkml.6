Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEDBC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B2920892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B2920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeKKCtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:49:20 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKCtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:49:20 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MI5cP-1gFFFd0XB9-00FG90; Sat, 10 Nov 2018 18:02:50 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Kauer <florian.kauer@koalo.de>
Subject: [PATCH 17/17] ASoc: bcm2835-i2s: Switch to SPDX identifier
Date:   Sat, 10 Nov 2018 18:02:31 +0100
Message-Id: <1541869351-8499-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:xUHMgHoftkOpoPm7jwWzl5DQ2y5R5OQiSzxSWhtPprRL9CjeCpy
 KqpwtATiejoTey6Y2GHAwPDar8Jr0UxYooKriam/PPcaW8qrIN42ceJGymOsOccqCHmD/yg
 6slKRsYASum7ArstQGao+WYd4gYmlRsKt+PL57RFcaXyZhA4SgnMLiV/0Losr17O1Jx7p48
 2Tkcpn3pP7kycHr7oPvnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ejy9c5cntHc=:tqNw/knjssWzje51M1PUgA
 V7sVMbi2On4fbnWhaNA4576faGEXX2d78JUElj8AMSy0f5K+x1K/6pGA19lP90pD4Zrvu4RGJ
 a+UdgEibF95WX9U2jh5IvUGWdtIcAilQCBcBz7QSQikBWkpVz/JMC9wXumNWtCcSkgNuRMlTh
 zbPT0zajIh/8nCgFpEMj1eJpdVvq67aO7Nepi2zy1/kvvVTls3xOgbPCRKm1xL42Dzk1H0Xsy
 RyiogHWmm3I9jr3zD4xStiQCcJWyWq9/CjZCMv5AS5OVfDkIoNzC6cJz/4RpUHp5FwbPYjbxy
 2QEzwTEe9vTQFMaCyKPfJHf3ZzRQbiuSzVlQ/rttOE89ZWW9EJEkvOVAzuohHaU9HiFTnOKyc
 GE5OmEXG2mnBKuIjNlhSxS+/oXBiIuuHaBE/EHm/IdIgQ/apqUK7j3osJ+oLNZd7I7gLLpKYJ
 +gbLRJz36yDLXT6IuJERdMSIyJIUtWCLUusOWP0ddmBePRWxaiFwwamrJR7K6KZkkAZY0G+Q6
 79p1zJhFP3QthKxkjgm752r4h7enBDZ30p1ziZvS5JkcIGPty7M1q5467ub9+UzWmvVf+LPSG
 +awyZ6hCL131GHSrz3LLmn5IiT/9rG5+DY/AmtjY2fBcMqfc5N+lhP6uyVYbUcjc/VZMRF1oN
 rucjxH3HpIszxP61TLRWDATlH7nO/vK7j6Q6XOQhs6YpGAaOl1SoORjna/CWtwiRo9coSoAIO
 9nvPso4PnRif4p5Q1TDtncm00GKpM2cJYZRv/6Cx0AuKtuotC5HNMg7RQkJMIwRth292C2u4E
 Wt4sJ4gjI0TViCFmBaXiRTgHzzHeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Florian Kauer <florian.kauer@koalo.de>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 sound/soc/bcm/bcm2835-i2s.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index d5f73a8..0e4a0e9 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ALSA SoC I2S Audio Layer for Broadcom BCM2835 SoC
  *
@@ -20,15 +21,6 @@
  *	Freescale SSI ALSA SoC Digital Audio Interface (DAI) driver
  *	Author: Timur Tabi <timur@freescale.com>
  *	Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #include <linux/bitops.h>
-- 
2.7.4

