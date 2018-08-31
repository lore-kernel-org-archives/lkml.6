Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4250520658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4250520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeHaUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:29 -0400
Received: from mout.perfora.net ([74.208.4.196]:59213 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbeHaUr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:29 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MaKkg-1gB6PI14si-00JvFl; Fri, 31 Aug 2018 18:39:04 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 20/34] ARM: tegra: apalis_t30: further lm95245 temperature sensor annotation
Date:   Fri, 31 Aug 2018 18:38:02 +0200
Message-Id: <20180831163817.23970-21-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:yMCCJMOEIU2kdgrrRIYB+igJG03FPpGe9oBw4G9NkuijrkWSn+W
 elCHXMTTZypKAgt8+GUmwbNWsH/7kNaji3aTg8t4gKnYuz0ctHvNbuZ3sMCIY9276G/jcih
 sVku+EBWm5e6yILiVhVcfbb0/NAQuHxI3+D3ELPdjdo2TDWX97uuezq1bxaOADpRil8BZ4l
 Q+3inG4N7MVsfwL02FAzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ao7HAIWtfMY=:M4A4FRgW+eNMeULX0sOSQx
 ZiWX1J5NoZglJNnhHRd2oI5fYRcd8/mvrZzMkmxdV9hJy6z3CGakyZl2z6/PBeYRwVUnBH3VZ
 A2ix1Jfw67XepNUYObSV1G2MXkcLAAvkFekxlnjrfocMX8aSEtY0yJa4QcFsajnNfMoHqWl8/
 f+Q8hPXS2kxWs/4pridVuV8D0Hl1rIqDwUFYunDUSWJdVtseDEvItpjnOqFKCIHxAcwOXk4nN
 0+OcLl+0rCufNyIaSFvpYVAoNz0yo/Ojjzx3lA9sVb/mPr2rNoTRrGd1tm3lPhUAVQjsa2Gg7
 MHmPc7GGj/1ZJptBhLBhcQ0e6J8C8Xu3Ks5HSDpNx4VxgN4MC+fj5iyBjRl3v9PhrPYrsZIvC
 6zFfLtlx17xnREIujwI+mZ52n1dtr1Ej8npUGxjgw1rhFlMnr9wjAWncX/vKY9ZWP/PIyxA/K
 q91c5eAfvOFvJ3FUm7OjybO53sGAwO4MZvo2nOpW4qEVlWf3f5nT4JzoPwDq5O1FlxG8ZrEEZ
 CKVagHJxdMmQow3Y/1o3z+Ck2yrMObdlD/vRSIv1vSqu7/NolXgDqz2JQx5J+TXvI0oeqmoLP
 PUAF/2XTMBI16x9KcBoXb6H8VyXU1ggu2hNtKdh7QPFFTFf7LqTZOy1NLD0Yu1AhHa2lGIbyb
 CyGaKfnKLvhu8LNbERKQBQDM4CxPMKG+ZTTVoXGDcZLPsLNbcSSfb7r/QlBYg0ud7XuI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Further LM95245 temperature sensor annotation.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 43d914f754e8..c3e37d944c62 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1009,7 +1009,7 @@
 
 		/*
 		 * LM95245 temperature sensor
-		 * Note: OVERT_N directly connected to PMIC PWRDN
+		 * Note: OVERT1# directly connected to TPS65911 PMIC PWRDN
 		 */
 		temp-sensor@4c {
 			compatible = "national,lm95245";
-- 
2.14.4

