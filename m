Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85E5C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DADD20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DADD20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeIAMZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:13 -0400
Received: from mout.perfora.net ([74.208.4.194]:56345 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeIAMZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:12 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LueDW-1fnJtT0MdM-00zpbM; Sat, 01 Sep 2018 10:13:55 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 28/34] ARM: tegra: colibri_t30: rename hdmiddc to hdmi_ddc
Date:   Sat,  1 Sep 2018 10:12:42 +0200
Message-Id: <20180901081248.22639-29-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Q+YqOYLDlMC8BMKOm4akgLs6W30SmaLiqT+jmbbXIGZNDUy66DW
 gBj8cPGI2cgQYSa3cZbXEE25aPr+H+7XkXX28QirOMxHJEAF4SxZ7Zx70LDxpW47rH9gasd
 zaAxLATpNCyL8PY1EJXPdO7fFb5+itfVFtc9usHu0CbqcnJ7O70Azs1ngoZ+hInwnps9Rex
 mvldl0UtbmL9JDQXMbgdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0ZEfwo2gH74=:WzfjjM6mhJpwEbCrv0ZJMw
 zK+EZcfQsPEIyYJc//ktB/7r7mVyunNaUIkaRzyVYSYfGYbBnOZwQkcSeiTWlwyMnNeVhWadj
 epCwDZzJOjYJrQRP6n0S5pRJ4EfZ9nu1+KRtapAynEM0OgobSJhnLwucq5MN6Z3tVi4XOdoiS
 TL/dl5EPBNFi3DPirvj1Db6chj6tHwwqo2FsrXBK0flEnQBxDr0DgolW/j2+GSefOARG6kQ6l
 5M8rEDZw2BwW8P8jqLWVx7g9pivBYT8WIA++oNgKKIazc7C8maG/Gbql1dIBRT91ei8GGbD17
 nb2kqZLU6pm6E0rrcKfcl9ISI8pCSWXOnO3VoN5H3CwncLXi8bVR08DJcC7Djjj9p/GbpAmgS
 BnOkCtmolM2a2gbVDb28v3VZyKZ92S2+t4mPnQUineKzdW/rMjdWE7/fgevu67DFloF0Q8QvG
 C9mOqOqqpKIWpyIbEKWnlkzRBVMM7WJubO/OR0O0oPgW1kBRNAQgk5rSyXQu13/o9CgM4Bopk
 yT6sm/JXkilu+bR/Mtmq1AQ5040fiJMh54sVCanbPlUuu/6FtoiwcVNrHFixoKsrS22E7xSaH
 +xrV9c/I59voq8QhDFRarYym8NXLfrlNQmHiacEYi9ZKADUqFYfAjAesR9Zgb3BnuoSL1I5d+
 gg/5phPcIMVyWjlMZ++mjrkqBhMh8DcLE9OFskf+0Sf/1+CyiozUXFnxrQylrO8i00wY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename hdmiddc to hdmi_ddc to be more in-line with other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index c08e09908578..49771ea379ed 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -71,7 +71,7 @@
 	};
 
 	/* DDC_CLOCK/DATA on X3 pin 15/16 (e.g. display EDID) */
-	hdmiddc: i2c@7000c700 {
+	i2c@7000c700 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index f4aee43402d1..03047d2bba9d 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -12,7 +12,7 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			nvidia,ddc-i2c-bus = <&hdmiddc>;
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
 			pll-supply = <&reg_1v8_avdd_hdmi_pll>;
@@ -707,7 +707,7 @@
 		compatible = "nvidia,tegra30-hsuart";
 	};
 
-	hdmiddc: i2c@7000c700 {
+	hdmi_ddc: i2c@7000c700 {
 		clock-frequency = <10000>;
 	};
 
-- 
2.14.4

