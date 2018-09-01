Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE3C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4609C20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4609C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeIAMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:15 -0400
Received: from mout.perfora.net ([74.208.4.197]:60547 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeIAMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:14 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lvj4s-1fqdHv0gQ8-017Vdc; Sat, 01 Sep 2018 10:13:51 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 26/34] ARM: tegra: colibri_t30: drop module level model and compatible
Date:   Sat,  1 Sep 2018 10:12:40 +0200
Message-Id: <20180901081248.22639-27-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:L9dau9tyZsIBLm9TdVf/l1XkAhn2GLUAssyYuOwryBBJZjSKbul
 ccx3qmobLBRAOqTvswOCBYo9mKIOUVEKf2jTvY4BRyUtusLo3Zt8Ujusmb79455l0Hf5QbT
 Veqp2t8BhkpowP7sr2zr6qBfs4Rx1zBpWHqpumJHpLO1LVDnXqTN39kFvri6eBTP7pQKWl1
 yLoX1I3fExB495VpaoGhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j25EkKNCNHE=:nK07CvcOjtss5tbQIqj1tD
 aR1UBXXf1ToqJaHiMZ/m5nAyxgQbkWmhqOKgXSdig8swxSrerG/C49gH3F2wDoxRQ+mfA94nS
 ZdhhG0FIzl035DTvimKY6xK/RiGHe2X1+XjOhIfoeAvvbqHDyk5WvhIAkuEix6yOEJd7Nia0B
 DgcaBX9WT+gg+wyzw5sUi7LVAc2BJ3Yf0I+jrrtAV79/HRXFgXD4q6yRrS4RgPpsu8+lN2AIf
 Ut6gAd8wjQL3/EQC8BN4/nieCCK7GKlAY34frQQqt0R7DNYDO4mdOdfheXhYp2CNjh5VJdq1e
 8Z0GoOXA/QOSAUK0If5GcbdIXRIjZWAXn4vw6S2xj8N7PMPMf8FkZxACBmYXG3zEy2KIIOMDj
 Qhaj/hjmalgjPcGFaQGzXatw1pIThdf28MT6KxK1cLbmuheDfItY8C4QhAS0LTYatLkGCALkL
 CswuluVO7MPXuIm22rg1v4uQMxoyxQdQa4evchw32qs6FoJPufnlqMfPW47TNlBJLvU5JG2g/
 Rk0HX/uWP3+EAW88C23t3fGGBL8+syrM+eV15rAOhL5aIbF37dZwazpg6mqz/k6iOmO/ovV8L
 M2I3PPGnvZsCyqxWmt3rBCDyD3JFbjOs8Ui7LazWoO3VE1uFfqvjRqrbgsAAm+Bt/xCKU0TZt
 528r7RroGYW0F00tnx0pQhdONinZcfzpzUsa9jwvnKn6naiB0iRxR9MJjzdL1gA4Is9k=
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

 arch/arm/boot/dts/tegra30-colibri.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 9bd7034b8e66..f4aee43402d1 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -6,9 +6,6 @@
  * Compatible for Revisions V1.1B, V1.1C, V1.1D, V1.1E, V1.1F; IT: V1.1A, V1.1B
  */
 / {
-	model = "Toradex Colibri T30";
-	compatible = "toradex,colibri_t30", "nvidia,tegra30";
-
 	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
-- 
2.14.4

