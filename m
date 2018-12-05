Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0994FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAB420850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hWSXlMFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAB420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeLEMz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:55:28 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:41982 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:55:28 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wB5CsIlc027765;
        Wed, 5 Dec 2018 21:54:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB5CsIlc027765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544014459;
        bh=ABN4Id0ITWlGPPFug9vn5zPzA9h/rDKJEe8f0mRIi5Q=;
        h=From:To:Cc:Subject:Date:From;
        b=hWSXlMFfvUueEf7yXCHAgHIVrpnn7BLpcbJ8gi9lyDVxIjiNR8MNnPjAzQJfVnyd3
         clsPCd61MOVaeUwvtd5mN8nq6vIMtAA56YF4Y8rLwJ9X4950Crp5TzDByXOQQuHbvk
         GYfnvurTjAlkPDdbnfmB24nc1E93AL0d2FpEtVQSJ44INACpwzIsCsesZNtO5sEezt
         83Q5hgjx3jM2YhPIJFZZPVoqVxdQrafItV71wYlxi88zdx/f1t0ExTfyivTgfwrDHI
         WHoLWtKTV0hx+FX3tBPCI8vzgHThWeVaU4dbMdp4w2FS3qtYytxbrV81EepMPr0Y4V
         XU1whcjSX8x2g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] gpio: uniphier: convert to SPDX License Identifier
Date:   Wed,  5 Dec 2018 21:54:09 +0900
Message-Id: <1544014449-5104-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl suggests to use SPDX license tag. I am happy to
follow it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpio/gpio-uniphier.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 74551cbd..0f662b2 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -1,16 +1,7 @@
-/*
- * Copyright (C) 2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2017 Socionext Inc.
+//   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <linux/bits.h>
 #include <linux/gpio/driver.h>
-- 
2.7.4

