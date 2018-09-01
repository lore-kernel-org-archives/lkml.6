Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7656DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0D420843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0D420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeIAMYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:55 -0400
Received: from mout.perfora.net ([74.208.4.196]:44795 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeIAMYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:54 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MhTLo-1gHPX7345a-00Mf1G; Sat, 01 Sep 2018 10:13:40 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 20/34] ARM: tegra: colibri_t30: remove unused nvidia,is-wired property
Date:   Sat,  1 Sep 2018 10:12:34 +0200
Message-Id: <20180901081248.22639-21-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:B3/wnCjNXfoCUnXZpV9nybgRkPQC97qfBKuJ1WMqTfUozfh5j01
 5y/IQ3H+fV6M9zXIWZBtZdv6cyZQrZySnSCU2Ts2cK2NFuMBKd6zcKbq9ti55mfM6pj1t3W
 tna4FnsQaXzFo54DEqMoUsHPo9REsH6Z/DkkUWk+s2Y4lJogIJqaTCs/t3SePf6lnKawoM9
 Vs/3kjI+c2JckI4fLaptg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+5YVshXvDNw=:i3IQz1Vx5c8Nn0P5doGbiK
 gsfqN0cq9mO46UR73jDqFyklKFlAmTW5fKGU8+RwxN29ranHcAalOzHLIbzRe+hsz9p5Zu18q
 TmoVdHUcf9dGV5sotW3Ydba7RypPofJjIYkal5FcegUzogfNbIhrO49LRL+FFWeCLe/xhs1pw
 fqc7e8tayh9l6kbOU4W2wu2iN1EjKJDx3K3e+Yek21QgoHwA+9dal4Pg2hDB/b7SLZ16PE5qj
 oRoAcwwdpGnWcUFnqTuX+bzvY03thRd2GX2ZytZlOpvdsBxldoMdLZEJ6hwVT0MyNHWXhs5Zb
 baEKGKln9NDgqJzFeKZPxV54UUgrwlcxRzS9YSKoQQOgOtA94S9tYjO4DR+bmNoh8czEfFrqd
 RANoGBPv3/07uN7m7fbgeKaVuFVRdSGN1TqSiwiVLBZqiunYwVhCmN2vmnzkE8KchJgR1W3VS
 8yRPnrkEjnL5X9kDY/1Ly/A9xZuEqPGKL6dPHGaZhpV+XqewRPwjkha2/cEpjaWP8XoUckj5t
 cyBVPaiO2VtPUsOLdili+c5eHwZVBV/kutsmUpgCDLognZictVhWPUSuz1ieIE2u+feDPTTVB
 +fya3ZiBX7LBiokvIu7FX9Z7SNaACqBk8IpOa0IVK9E7a+i8Kkyx+0GnGakJkfeK2DzFyANvw
 pIKYpoGnTsQwBMgHIqqFGa7WwWCi5rpIE2VY9dCpTxGhwjLfPjOG4ltEkXUGpedFFyo4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Remove unused nvidia,is-wired property.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 0d8b0f319c6f..eb36ae3038a7 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -949,7 +949,6 @@
 
 	usb-phy@7d004000 {
 		status = "okay";
-		nvidia,is-wired = <1>;
 		vbus-supply = <&reg_lan_v_bus>;
 	};
 
-- 
2.14.4

