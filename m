Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5444C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D7020841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D7020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeIBOYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:24:49 -0400
Received: from mout.perfora.net ([74.208.4.194]:54017 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeIBOYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:49 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LkRO1-1fK3Qh1EYV-00cEc4; Sun, 02 Sep 2018 12:09:28 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 06/37] ARM: tegra: colibri_t20: reorder host1x/hdmi properties
Date:   Sun,  2 Sep 2018 12:08:35 +0200
Message-Id: <20180902100906.25792-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:62iGRMyDyym8n89QcflXkS5CDneheH6iJSW40xSk3FQK140P9hU
 wzxDtlZkHE/t3T/xZPpVQOFB8ka/ZaJCtYNW0Cmhg6z4TU5P0wz+tPSxjItcpcVznfkGP3l
 Fcua8M78bbXEqZMyVWkSMc1ghVtZrLQvLp316l80CuZpJ3UakpENUxOhk6QmsvbLe9CiS9o
 +3RT47bxJETGzGms51Pdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qwtyShX0G6o=:jbOnc5bgAFd8J7+V/PbBG1
 RUXGlLc3bCN4cxNYr/kuTEfVhkTtTjqwoM1H9ULw3q5lr+rGGcIocJdXOZlDbIxDqAvhzyYJG
 wPKVVn3d93V3mC6BxeV6L3r4HrgItTy4IjspzYE9oktcliz3dU/2spvT4IOpfycNasmuUjncz
 JHuu2/hk6ts0HKIs7R5zaXJJCayT9gCWjNd1KXt4NDTfKUYagH0KNhA31gp1blJOe2D/TXBsQ
 EXM9KtK574dS3uD+ILAM0ReZuk/lAxgK15rCpeg6txxLhqDk76U9xI76klg9D2DirQekRm+sa
 1EL15XBLlJ1pGmS01p40uesDYE4zRhsuP4NABBv8NGpprJeMB/gh0f3vR5VnOnFr0f0tc96Xh
 ucwqacJo9UznbV+2UXrVt2UlFcc5FyriQETkVC5H/o8HpmCUl9yUBLlaXsqEUnoJ2ANTh4gep
 /EKNPWnXeVLxcBPTqHafM39m2+Q9RYVwAqzdyk1NfySfwzTV6k/0n2o7WbBiA7vXeuz2fTYL9
 dAH0M80fWyQp8aBg7w5lP0KbvMpFUqTTR9TuIj8SWvwsCKTOgpfo0lst+IzVAu+IjOowpyAZk
 eiw1sWZIBGLu+ElJP4fYWSBRUbgkeIODb0WpC/Ohw1POIqfNIoWeqfsy90jc/VaRu6NmOp3sw
 n6wozbRj374eIEC2o3cdJ+WHsouMJ2p4t2YQXYNqVZKHwBld57gbmG6x1+RLHwWbaV1g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder Host1x/HDMI properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index ad816fa827f7..c060b58cb490 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -16,12 +16,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			vdd-supply = <&hdmi_vdd_reg>;
-			pll-supply = <&hdmi_pll_reg>;
-
 			nvidia,ddc-i2c-bus = <&i2c_ddc>;
-			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
-				GPIO_ACTIVE_HIGH>;
+			nvidia,hpd-gpio =
+				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+			pll-supply = <&hdmi_pll_reg>;
+			vdd-supply = <&hdmi_vdd_reg>;
 		};
 	};
 
-- 
2.14.4

