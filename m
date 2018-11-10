Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B6220858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B6220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeKKCCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:02:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:57155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeKKCCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:02:22 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mzhzd-1fZ4Cx0fD7-00vdZk; Sat, 10 Nov 2018 17:16:26 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>,
        Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 12/17] pinctrl: bcm2835: Switch to SPDX identifier
Date:   Sat, 10 Nov 2018 17:15:11 +0100
Message-Id: <1541866511-7856-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:sAd26pb4N3as7POL19edmJJkl5PraA9RPgw+4VH/DVDxhv6AzjQ
 WOz8t9DpLQds233Z1ib72n8Yu++ZzXiIlDbOYM2paaXE08rL1CZ+7zJua+ZsBfRf1LntGju
 IW2+wVPSr9aAK3srXp0qL8JVfth9AtmQ1hiKTVSlJIUh2OxF5/ZUzkwclKLEGIgho9gLq8r
 anYfJiqgtBeO9EviVut1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hBTfjrP9y5Y=:FFa5jDZXDJQ9Dxw1Az/5hs
 yqf2uIteAqfAr+Iz6KREbceAunVlf/IIcgAgmGR+d+4YQTlfz0oN2/Z7DF6zTa9JehnPSW3S8
 7BK1R+nLs5hebxCopN91qvEsSgwXPA+19uwJk6AekHlKMQCzUysQVDdKbzQban9oAwzk8aePE
 AocT4clUwaMfY8J/vpJb5iycD0E98LxD1NmTffy3rx0CpKVn1z9UWLhwzkIRPDRj8ztuJEAqR
 XIOhYBhlj4mHrzUBlIDzSbz3dLttHkZ+Zk3LLet92L6Qi6EGr9TWV3Jy2Hagzr00ZcijHx0r7
 7dNwWUBqzNEaj8ebphwQdE+pLN99g2b6CaaoxaJ2B8HDAGhJl+2FVkfo/OJMgMn4HmI8sfP12
 iJ3qifLZ3Tfj1JVLptscdkZ3/VtYHZjNOLrF8HbXY88E+YdEpbPQC7ge4vUsSnzwmQUcSNfBB
 qEvn0TlZSnJrExWH352IvmFNqdj0T18GRBdg8FzoXcIoz8vl0q04HNOv1W/VUqsbpAG3tJ/2a
 gju0Qp9ClewHg2SBiKv2WBbgcQMujKmRvTk/UU8U5Mguhztm1xwZE1hkr7Hbah6ZBU0y/UafP
 5IW5sJoj8Lt5ayq4V1o+ttopSwnSjg5xMgEiPGjZpUkwnzH7ab7jrkabf00NSLTu9pAUyOlB8
 bEuqI/vSKntpl+4yPm8F8qOFRPVsWzNtS4j3wxhKPtgpgdiRdqNJUQi/8r9lS9rnwL0E6/v6K
 Jktxz7URCLBbToNQfYrw0xUxBn3TRQqHB6jtc1SPmNK9Tx71wnrdKdE2y3epqd1SheZa3hfJ4
 CRn1VhF2mdKxJjxnKZ4NMQxePWu7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Simon Arlott <simon@arlott.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 11 +----------
 include/dt-bindings/pinctrl/bcm2835.h |  8 +-------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 08925d2..0e08d5b 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Driver for Broadcom BCM2835 GPIO unit (pinctrl + GPIO)
  *
@@ -6,16 +7,6 @@
  * This driver is inspired by:
  * pinctrl-nomadik.c, please see original file for copyright information
  * pinctrl-tegra.c, please see original file for copyright information
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/bitmap.h>
diff --git a/include/dt-bindings/pinctrl/bcm2835.h b/include/dt-bindings/pinctrl/bcm2835.h
index e4e4fdf..32a721e8 100644
--- a/include/dt-bindings/pinctrl/bcm2835.h
+++ b/include/dt-bindings/pinctrl/bcm2835.h
@@ -1,14 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Header providing constants for bcm2835 pinctrl bindings.
  *
  * Copyright (C) 2015 Stefan Wahren <stefan.wahren@i2se.com>
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
  */
 
 #ifndef __DT_BINDINGS_PINCTRL_BCM2835_H__
-- 
2.7.4

