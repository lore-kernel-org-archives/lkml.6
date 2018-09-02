Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3ECC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9217620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9217620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeIBOZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:45 -0400
Received: from mout.perfora.net ([74.208.4.194]:52955 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbeIBOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:45 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MPnbo-1g0EpB2U2k-0056rJ; Sun, 02 Sep 2018 12:10:24 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 36/37] ARM: tegra: colibri_t20: rename ac97 label to tegra_ac97
Date:   Sun,  2 Sep 2018 12:09:05 +0200
Message-Id: <20180902100906.25792-37-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:pbFrw9pNnAQL46w82+b0HnGghtbqSXn1ii/kFJwT9Q+TYQ6o4lg
 7mUO252ce3W/PRrGubjZhIPaC+k8kEIbwjvUQoC1c+ur3iKZTPIewe9RK1o/z7aP/WIi6FB
 TFMaSp59czNe8v13LTqNs60RtEcpdaXJdTlcx3LUPuXjKbSt0wBpYJQcuIfBvfm5igIjbnn
 LwAjKWmVJC0KRYF9jhCow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YLAjmpG4AS8=:XWqCFfAi0uizVf5sR9xLe/
 NGOb1G2ctR1orGvB25/jEJwfxHdTzYNrDkAoyyladrTpLiWaJR6hvKiNtqG/aT26ISWQZ2vQB
 vj2a+9aTYCa8EGikPPSOiC9JQrcPh+oH6xyALCuFjn0iToi8GMknNzPumuTQADMeTZ4w1h0dc
 xkUyRD4pMkouwPQua+g9Aj3d3Xw4RfvqoPFvpHqTwU5tfhkJV2vhIF0hJI9kqb8xyzdaMEHJG
 SWLqxdQby+Dqki6MC6bLsQWzqhB0OaLTBNyorPm3GQhssNXLuwNOgaAnrjX7A986NXDAUV4cM
 kEqyFXXa7/OKHTbadkCjqTGzJ34WDOt8KyCnJGUkYAXlslgTJzyYnf7JKE8FJFCjm2vRT1+z1
 zWjQHf9FfR+0Af/aAb0p0mFL5mOAuQb/URGnk58d0vSdABjZfmGy5na4KTaUqlDvaTjjtrgic
 lg4HgvhKwJlccRvrlKzvKfF6FYybkm1s8ihEm5Q/Xv6OyuV/wOvs+7LeF1ppQOEwf+KbEQyl4
 4LEaZYecf+dgUlWWexUzFeyE+QHaDAaKEZBExoicywIA0zTRDhjoSt+/qxcHP3qg5Ps2r9nrA
 lQdRsfM3KvlNexADE/niBWrGPJ9TxYWeNaKbfxB6bzZ966X1+tRZzHzIpMnFE3ZHRDRY+1ctj
 c7WoNvyyBdvVvLXFSnBkSqfriYRdyVGAlXq5KmuZxswrEEego3UDlQPPl6mDLXuSwM/Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename ac97 label to tegra_ac97 to be more in-line with the device tree
binding documentation.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 243615f6c349..6162d193e12c 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -418,7 +418,7 @@
 		};
 	};
 
-	ac97: ac97@70002000 {
+	tegra_ac97: ac97@70002000 {
 		status = "okay";
 		nvidia,codec-reset-gpio =
 			<&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
@@ -734,7 +734,7 @@
 			"LineIn", "LINEINL",
 			"LineIn", "LINEINR",
 			"Mic", "MIC1";
-		nvidia,ac97-controller = <&ac97>;
+		nvidia,ac97-controller = <&tegra_ac97>;
 		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
 			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
-- 
2.14.4

