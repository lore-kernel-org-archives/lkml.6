Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1963AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C701020856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C701020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeIBOYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:24:55 -0400
Received: from mout.perfora.net ([74.208.4.196]:52281 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeIBOYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:54 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M0SMt-1fdMxy0CNB-00uRxG; Sun, 02 Sep 2018 12:09:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 07/37] ARM: tegra: colibri_t20: iris: use no-1-8-v
Date:   Sun,  2 Sep 2018 12:08:36 +0200
Message-Id: <20180902100906.25792-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ATbCNSWWxOLk+/u0AP2n9VnC1xxkAcjPhbXa1fGbYQExntTAU/S
 p6dIFPkeyDX4RqEHFQHWdN3Ym1xcvQXoVRZ+cThGEOJyWDnAlZPr/m+TQLOHvY6VEFi0t+q
 Cws2Zobwai5jjVb5O2CWkmPUMzjZGScyp1MuEWL9hTPRRVznDuVJurcQ0LXCR3EjjClrKuK
 ikS9Moh6yHveBth99/PaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RwGEPPjG5UY=:s8D2fHxi/jUWB7Yb4Tg5qn
 BdZdMNHKrWISv+MDDrClRXUotDxdPEU++uvlmuNVc47EEEpvFCv6spaCaiQloIqJWU6DU/M+C
 2R5uqQ/HgIOyZckdhWXO3Nk1SEax5D1c6ib+82g3u/l0bBwy5nUUecGjcQ2KvJiX0il1+U5ZU
 DCKTaDf48MaqXEOw5bplHjDULv6Tm0/M/AWapMlg5aqr+LVN5olL6arLTt+GGOUuYfM0SiRw0
 N9oVgyZ8d/9i4NrZp4ZnyYAzU9MA3+xcJVeZsgEFr7xtqrkLsMdYAkU5QR2w3xiBU9vc5VwUq
 wuX9iphJXeKxEAug12/deVFI8ThIxRC4VKJeNCjXp8wICwq5/JjJFPb+uNagJmAFlH9M/ug+A
 HsAFe8mVOwtonBC00HABVbYthJToE7Ppw6CQwyTewNZYKcgbt/qXmmjrjgrxErc1FFLXDB5jI
 i34DV43D3msEywMnLRHuIlzqwGMbVKXymKKjk9wxGcawwagFr+Q8QopSUp3+mbf9+edBGRCZm
 1qN9KGnu2sjjFs5mcDo3TOG37fwN9rK3wXmrrcJjzkCALoC/0F9BM3GyuhaBfeBHLuw1vnPRT
 XrVumy1HUEcStkeiq/a48hRIgckTdhU4KlWCUFKsNFSx5StMdzfRfLn36twe7j9UYPvMIaYj3
 QLf6RHvqiI7xPnk+P3AiqIDJDXwAKmewY9vFRPRz5q+SUQbiEPh2n5GAu5ckoXPaNfBQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use no-1-8-v property rather than vmmc/vqmmc supplies and drop now
obsolete and anyway non-existent vcc_sd.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index cc9e372a3b58..3d430fa93e8c 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -101,8 +101,7 @@
 	sdhci@c8000600 {
 		status = "okay";
 		bus-width = <4>;
-		vmmc-supply = <&vcc_sd_reg>;
-		vqmmc-supply = <&vcc_sd_reg>;
+		no-1-8-v;
 	};
 
 	regulators {
@@ -116,15 +115,5 @@
 			regulator-always-on;
 			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 		};
-
-		vcc_sd_reg: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "vcc_sd";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
 	};
 };
-- 
2.14.4

