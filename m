Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BC1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD9A20817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD9A20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeKKCJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:09:02 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:56065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeKKCJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:09:02 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M27ep-1gNRqR2f1t-002ZCh; Sat, 10 Nov 2018 17:23:10 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Bart Tanghe <bart.tanghe@thomasmore.be>
Subject: [PATCH 13/17] pwm: bcm2835: Switch to SPDX identifier
Date:   Sat, 10 Nov 2018 17:22:58 +0100
Message-Id: <1541866978-7943-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:pRbFhVJomFRh1Uqjw3ttBu9ZVG3cLdO1GdlB6/hzdTsYVFCDFaf
 oJMA8sI1YjDemX6U8th45bI7Vwadvo4g7dN44nBXHYUqUa3DsfaajsQGtmh8lPl7tXbJzm5
 1gKkx54jaJsO3G6fnrlcVUs3arQmG5wIIFVhk2XooNY9xcoJRKGjZt2twf/NmJe9njHJK7l
 HCjjK1InDSMqoZSIzeq4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bYWGjrokBlw=:xaGda5sJeP4etTY/Lukdhh
 FQ5kQfhORZDu3zC2+5DjrGW3bY2Xkd2Nzg1cSAdUsF4IuQfRajDsyo3ewDpEpuHJQuzYb55BR
 ZfFyb8D3nmbJXQRHjgGTi9lyYE4kk5AYt3MVXkzfVEmYLc+e93LfsvnopkGsrL4mfOPfTgUHC
 gkPRqozT6pFt9xJvd1Ay1BjIzGT6fB9Dnzqv2SV+NyO5/QlJJBGDbXvSHWnHCGGzx41rL61Ih
 tlpNG5Zp3WDwpSpWy1wUoWg/9P4aPHT1YuFhOfGIqWTD7u9vgEDKcrnKas34h/pQP6WFnH++v
 JukBe77pYvStGd8L03BmNmrrj1R6gQ5VUnW+uBwsN6CZ5GiAeJ6aUsWvvn1amEk/EuDhD43bC
 buWLkzOKXLhhSvt0nbBj1oFz/7g+WQawxv3W/JUU3V6ptGxJ/BDaAiOhz/825I3AfveRWDe23
 IKo4maaS/dkDlwKqXphwusfhpPxV0UcBMDl1Xsg5f0Cz0bBCYYgSAIIooTELd/5BKdFzap0UV
 j+lUU7o2SHPrlvmcQnya+xmvY5KW6hdEh83aJF2PKELO10qhNqL2L4Q5HXAedJPdYSwvWnnHz
 XhT7rPVv2mdRaEla4aEhwktl4zm5/LqEuNRVLHR9xOGCRLq1Y0yz17YbxhF/E6+TfJdGUobVr
 y8d7uLJb8uZrTy8hKZRfKtJ9Qn329IvXxJpMsbGKJUSuVnCb14ldpq3nZf0nCjmxMxEa55jTm
 xanYjgiqy+JIeaBjI6f0PomSoi/JKy3UFgqtyZ08iS6onqYLzVvOibHfHHZ28fhVvjL1iocAG
 1rAAqxHgKHAMieDnryqLt57uYB7qg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Bart Tanghe <bart.tanghe@thomasmore.be>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pwm/pwm-bcm2835.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index db001cb..5652f46 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2014 Bart Tanghe <bart.tanghe@thomasmore.be>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2.
  */
 
 #include <linux/clk.h>
-- 
2.7.4

