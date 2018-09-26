Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2EDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F40A214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F40A214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeIZTiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:38:08 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeIZTiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:38:08 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mf0Je-1fXTwc1GME-00gV7f; Wed, 26 Sep 2018 15:24:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: u300: regulator: add MODULE_LICENSE()
Date:   Wed, 26 Sep 2018 15:24:27 +0200
Message-Id: <20180926132434.3071168-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:UqXT+NdxbbP71jCCJD1ygFYnEuBNY9dmp5LQxe/4+hbL3Kfipyo
 /9HwnMFr7cP8DRrbtN5Os7u2TNKA2IA98i93eaR9ScC3a2SzDHH4HKoYTo2YEcuLuNdfSpQ
 igN4VvGGSs8GxUaloVRRNsIydXcvbSlwusP7mkjccIm2GP6sdm8FTe9YYAKPUXAymAmHFtM
 voQE+yobUTZBb394vK0uA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Qobvzg8wEZU=:bbqP5YAb8BScnJDuE+tzKo
 xoD/qdHWtyqvk9NhG8xJ0fTareAQObroouqazpeqdUeXfExUn/XdFkngdx2VxDn4ZwaT2WX8F
 DO8CdEJ/Lu9z3OpnK5BdJ7f+2dOACtJTb60f6n1zaDMZebB2QlJQYLdW8Rysv/mqzYhjMTPZM
 CsIEpEBFp3OuDMH4Y7X+gcAmHt6PNDUKL+Mtt2I8k36t4l3w9MXFUku/Ook9b0AvKB6IaV6Wp
 lTa9glGbQcQMQ2dtcG8CCINnlbRDPqzPgpZJwnNnyqaPfpQ4cZKlT3knJ8+sYRGhTsYcogdL1
 l8L4UY+63g6oBz4r9AeYI3sA39J0Om1N1kCzxC+uZ7b1t3mBayFTeHpez9fdYJqLR9COyCk9N
 tzU3jUbk8DjEiroZmNZesoR+GHKvuvL9VJC3qNNIQDbClenKbJ8SskNiZ1oD+oi3+dHc09g3s
 9g5sIQPUrcXJQjU63EA0lGDDuBJlm3vn2TM2M68k4LNaD9dh2Wyf0icXEuUsMOYYPh1+irdNB
 DrBHXCuVDICChch1a5p5kj8JaiinMLhX+B/nQsV5yb6pPWqBWzISyHSeSpaYE3GuQJ4/UEFc4
 7o0PCddDksYG+T/rtlWv01B3LDAIGuVCK49Y1yVbH7We1X8hyNv51FOlAA4hhURLoEwEGqjjF
 kZyxPeLu6t3pB4sR2gJBNaUplRFITExrRsEHeuub1+Cew2iO8c7EJ6v3By+DpRdtCYOw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The missing license showed up as a randconfig warning now, no idea
why we never saw that earlier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-u300/regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-u300/regulator.c b/arch/arm/mach-u300/regulator.c
index 595b574c2c50..96ec72bd3928 100644
--- a/arch/arm/mach-u300/regulator.c
+++ b/arch/arm/mach-u300/regulator.c
@@ -130,3 +130,5 @@ static int __init u300_init_boardpower(void)
 }
 
 device_initcall(u300_init_boardpower);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Linus Walleij");
-- 
2.18.0

