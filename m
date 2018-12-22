Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC41CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A2D21927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 03:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbeLVDHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 22:07:23 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:49656 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733177AbeLVDHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 22:07:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 36E5C275C8;
        Fri, 21 Dec 2018 22:07:21 -0500 (EST)
To:     Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <e05665950235d8c8a5cc7e3e5f989b46b8e8a631.1545445081.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k/mac: Remove obsolete comment
Date:   Sat, 22 Dec 2018 13:18:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to The Guide To Mac Family Hardware, this is the correct way
to disable the VBL interrupt. The confusing comment here doesn't add any
value so remove it.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/via.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index 4fa32752bd7d..b5d320844b71 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -180,7 +180,6 @@ void __init via_init(void)
 
 	/*
 	 * SE/30: disable video IRQ
-	 * XXX: testing for SE/30 VBL
 	 */
 
 	if (macintosh_config->ident == MAC_MODEL_SE30) {
-- 
2.19.2
