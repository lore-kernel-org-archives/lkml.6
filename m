Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B2C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FAA2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 11:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FAA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeLBLOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:14:40 -0500
Received: from shell.v3.sk ([90.176.6.54]:60600 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbeLBLOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 06:14:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F282AC7E34;
        Sun,  2 Dec 2018 12:14:35 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MoKnBYLNaEnt; Sun,  2 Dec 2018 12:14:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AADCFC7E36;
        Sun,  2 Dec 2018 12:14:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P9b-jlzVKqXO; Sun,  2 Dec 2018 12:14:31 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C3E3DC7E34;
        Sun,  2 Dec 2018 12:14:30 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] MAINTAINERS: update entry for MMP platform
Date:   Sun,  2 Dec 2018 12:14:28 +0100
Message-Id: <20181202111428.1543-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move Eric Miao and Haojian Zhuang over to CREDITS, since they're AWOL
for some time already. The git trees have gone away too.

I'm adding myself as a reviewer. I'd like to be Cc'd on patches and will
be able to test them, but I don't possess a data sheet thus there might
be things I'll be unable to review. Hence the Odd-Fixes status.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 CREDITS     | 8 ++++++++
 MAINTAINERS | 7 ++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/CREDITS b/CREDITS
index c9273393fe14..7d397ee67524 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2541,6 +2541,10 @@ S: Ormond
 S: Victoria 3163
 S: Australia
=20
+N: Eric Miao
+E: eric.y.miao@gmail.com
+D: MMP support
+
 N: Pauline Middelink
 E: middelin@polyware.nl
 D: General low-level bug fixes, /proc fixes, identd support
@@ -4115,6 +4119,10 @@ S: 1507 145th Place SE #B5
 S: Bellevue, Washington 98007
 S: USA
=20
+N: Haojian Zhuang
+E: haojian.zhuang@gmail.com
+D: MMP support
+
 N: Richard Zidlicky
 E: rz@linux-m68k.org, rdzidlic@geocities.com
 W: http://www.geocities.com/rdzidlic
diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..5741ed390432 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9940,12 +9940,9 @@ S:	Odd Fixes
 F:	drivers/media/radio/radio-miropcm20*
=20
 MMP SUPPORT
-M:	Eric Miao <eric.y.miao@gmail.com>
-M:	Haojian Zhuang <haojian.zhuang@gmail.com>
+R:	Lubomir Rintel <lkundrak@v3.sk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-T:	git git://github.com/hzhuang1/linux.git
-T:	git git://git.linaro.org/people/ycmiao/pxa-linux.git
-S:	Maintained
+S:	Odd Fixes
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
=20
--=20
2.19.1

