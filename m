Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1719BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B2C20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B2C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeIBOZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:39 -0400
Received: from mout.perfora.net ([74.208.4.196]:54513 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIBOZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:38 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LhMBi-1faDkE2MpE-00mSIl; Sun, 02 Sep 2018 12:10:15 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 31/37] ARM: tegra: colibri_t20: drop module level model and compatible
Date:   Sun,  2 Sep 2018 12:09:00 +0200
Message-Id: <20180902100906.25792-32-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:e1PAnxMQr9Ps1Q/eaGL44j4XwUpmcgTRYvSgaHfBt2QrwGBDDE4
 659I9oU7rOQy7avvdEfbbEX8nMaLfCFAMYUa4RhbIE+wBn1NHoQ7l6sr5UcsfauxLaMQAsz
 kjE2FfXdIVi8c2wlBIB/Tj+0NJJSprw2FxCtMbDhbMrEYk1p5sfqhaq9uJvM69j5RQskBZE
 w05O5Dl/HQ6HqxyaUjOIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VLK5nc3ibsg=:d/FPdvoRJOzFuXFZuTdXtB
 a+OcLWzj5/2VKYcbZtOIDsd2wOuo5JWR8CfMwTPkzrHNHn/v+s6pntkkc/uXJM1n8kKWf+J4q
 cr7DaHzFhGm89BjxYV9fTr9Dr/ZcWOu/YeX2hcRget/aUHVycOE6qQRHCTMKQJJY8I+/PwlLs
 67VJ+tyyfgbbqJirhJ4MCuaw+FXO3PMDQLgPdDiIvZ4P9JpYB69SVQZIxr6M0/tLzUX0TcB4S
 hZubwaijPsOKURPzzxlpCfGwLMS5X9s9L5t5amtEOn8Y5fgxiJRo+v1bBx3BjACJhDhVP4fE4
 ymazgSpndgPmllwt0/2x6Sfnc7kcnvIDv1NWuLDAOnDTvhnub9zfTaqvzfxkXufdxSxYtzGyA
 9tPWVYtnT+CL586XUiZUgtM1cLkFJbmPVbaCWxI3ZB/701atT/Q7544Rxyd49kgFf7Q3dtuSf
 NtSTp0aZOW/buVG+uP2SSUJylTS1Y3ejwqSB8iDGotppIqjYnCHZ/m33JC8rDGTWFcsY65Oaj
 ubzhm8+HIf5BXXoRmFXrhhSRr0888BXSgRjNXOatl7iNGuc2yTSOmQqMZuNeajGL96Q2BgQJD
 1Ybx0noRMw9m4gweYkOZDWZ+eESR31J1hdR51WEfJAnum6k17EouPb1rydV78sNdpaW/hCty8
 Bd/lBt31hb4dACTCosqI+nVqjAthdZQ+X+5waiFv81RS2S5allGWRM2FaZh303nZ4+RM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop model and compatible nodes from the module level device tree as
they get overridden by the carrier board device tree anyway.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch as suggested by Rob.

 arch/arm/boot/dts/tegra20-colibri.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 53e06f31dbea..b4d429f672da 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -8,9 +8,6 @@
  * Colibri T20 512MB IT V1.2A
  */
 / {
-	model = "Toradex Colibri T20";
-	compatible = "toradex,colibri_t20", "nvidia,tegra20";
-
 	memory@0 {
 		/*
 		 * Set memory to 256 MB to be safe as this could be used on
-- 
2.14.4

