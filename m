Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6689DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3602E2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3602E2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbeKGXPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:15:53 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:34836 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeKGXPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:15:53 -0500
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id x1lR1y0043XaVaC011lRw3; Wed, 07 Nov 2018 14:45:25 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gKO97-0005CZ-7b; Wed, 07 Nov 2018 14:45:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gKO97-0003eN-4h; Wed, 07 Nov 2018 14:45:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] Documentation: ABI: led-trigger-pattern: Fix typos
Date:   Wed,  7 Nov 2018 14:45:24 +0100
Message-Id: <20181107134524.13989-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Spelling s/brigntess/brightness/,
  - Double "use".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/ABI/testing/sysfs-class-led-trigger-pattern | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
index fb3d1e03b8819bb9..1e5d172e064624d9 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -37,8 +37,8 @@ Description:
 		  0-|   /             \/             \/
 		    +---0----1----2----3----4----5----6------------> time (s)
 
-		2. To make the LED go instantly from one brigntess value to another,
-		we should use use zero-time lengths (the brightness must be same as
+		2. To make the LED go instantly from one brightness value to another,
+		we should use zero-time lengths (the brightness must be same as
 		the previous tuple's). So the format should be:
 		"brightness_1 duration_1 brightness_1 0 brightness_2 duration_2
 		brightness_2 0 ...". For example:
-- 
2.17.1

