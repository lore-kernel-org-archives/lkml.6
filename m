Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBD42089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBD42089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJPSht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:37:49 -0400
Received: from mout.perfora.net ([74.208.4.197]:43621 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPSht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:37:49 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfAOk-1fsUXu2n8K-00onp2; Tue, 16 Oct 2018 12:47:51 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfAOk-1fsUXu2n8K-00onp2; Tue, 16 Oct 2018 12:47:51 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 3/9] ARM: tegra: colibri_t20: reorder pmic properties
Date:   Tue, 16 Oct 2018 12:47:24 +0200
Message-Id: <20181016104730.4598-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:MxOv11ND9BdRGM55aqGpWp+HhkKEfI3OP8WzxtuZHHB4yx915S8
 Y9UKINyiXz+2nNygrb+FrbuGOYq3Dfb1kTWJ9lgs1kSqdFy1pdRgpKy3JPjWFilBccvBmXz
 hItB+BDi3lmFI5TUt8AZ9hFDegH1y/VCCsDjzyCWXhIq6ad8sLWWLJwCFb8e0NP3OfHa6Od
 6eDMl5jvB4djIIfq9Y1vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gTZ+vslOmyA=:ktsfEt0vEqR//ppjZ5BtYj
 y2tHyRS4NX/o/jbgEpV5Ymei63gpbVZlYGyfImRAzhAnUECvsskGB9AOeTXqinzw4G1OxxWKU
 e6GAy24SGft4UrSovs/jIv0vaOsEGETiGuFQ8vV8qC8KYPaaVWS0vKNt+HxLsTmixDzmW5+n+
 HpAqhOO4FzY5k7W/G/gTqpDiGZaSucgjmUbMEyKt+h7QqdhRparLSBRCGnXrEE7hmhECOuXv7
 2HMtTMBMQ7gPz7qGIlTcxmPfI6ko378LBjJealU7WrD2Bopob7ttgEHGCAywyxSAhK6CsOq6k
 9/N+QlFIuXZB/m2rzGSKG1++7dtRuNJuKeKnGbhpoWeC4vwA1ymrgbXDGknke14K2bU6M9WAE
 LHi7qBUHHy+Ly3bBvtXk+kowNNDpwoFXyZyQ9RAdXgmKX4Y3E1bjb8Z+EeIES8e7pvtWpDWIv
 TmCWWQccxeCTk3/lbDqolv+Cb0Kn39WO8JOPitcjEBjL69vw4A3n15+e5rTRnDdz3+G40F8d2
 co4JVL5xz3fV1UAHz/2F9ORNnJiAl3zM6AmOSMMVYv+MksmwMQK9/f8fTO80yu6Udok7ns7OW
 g8M72UvW9kDRyaHJ+b3U/Eq435y6GvI7sLJ4kRkDc5szy8j524bOgafX9bPFdxZn5XEe3h7bn
 YBNeWOHdZH55//Fgkc/7El9U9VPkjFWWoB/qa/ulMI0B4kX8NQwd3HQtmGh6FTpBu8EA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder PMIC properties to be more in-line with any of our other device
trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None
Changes in v1: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 6162d193e12c..d3aba6501510 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -475,11 +475,11 @@
 		pmic@34 {
 			compatible = "ti,tps6586x";
 			reg = <0x34>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			ti,system-power-controller;
 			#gpio-cells = <2>;
 			gpio-controller;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			sys-supply = <&reg_module_3v3>;
+			ti,system-power-controller;
 			vin-sm0-supply = <&reg_3v3_vsys>;
 			vin-sm1-supply = <&reg_3v3_vsys>;
 			vin-sm2-supply = <&reg_3v3_vsys>;
-- 
2.14.4

