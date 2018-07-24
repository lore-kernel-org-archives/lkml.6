Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E12920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E12920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeGXLtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:16 -0400
Received: from mout.perfora.net ([74.208.4.194]:42917 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388413AbeGXLtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:15 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MXoiP-1fSukT3bCJ-00WnhR; Tue, 24 Jul 2018 12:43:19 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 02/15] ARM: tegra: apalis-tk1: reorder pcie properties
Date:   Tue, 24 Jul 2018 12:42:56 +0200
Message-Id: <20180724104309.21741-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:OjAYC1ca8VUIGaNPHgULUiaa5xnCQrs+1upUvY1YnkBbb0TiOOx
 mFrKI8OVPiDEH3UL8xiR/3/Bg4aSD8L3xxKKP8zqo5tjAlfiFae9Kjwli1DBIZkE00gX9Ih
 E6y8cLGFunTrPZwI6UUBapY5vRn55ne4capEQ/WnedITsDcVM/IHXrdlnfCKO8iVJCXgX4u
 rq8BWYTLLBV8j5lGCt/Lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cFFymDWig/8=:BO62TWZZMVYFE1ynrCK4Yi
 KGp5EK5r8w3IqXH4dquHVnpDJt4a0mdbjVOfFP4M/AnmIlEGczOn/rBav5UM8Rbe1ROgEQIVp
 wcxFou4v7Mw9cKSYzShhldBaAPtU/JanchwwLeXNNZQHFIAlc8B8dU6dnGe8ee/Ao36U7/6ED
 lHads8Z92f4rc5ypQ3nw4kscS9i/BOQwin1loPXO8v8+ymedWfMDr4ZKkmBITbgpNMr3h9hDP
 8aH7hz1eF79iEKddiwpBbl5cUIxXAONAIE15Ms6vefIRZQrQ5wt+naSFCzLVYpY6YTEophzVU
 8JGWqtpAeDpB7e4u4O9bqTT0E/wA6MB8KMcXDawhAkJtDpPIfoHSXUDYza20aw+0AEeqCBvDs
 bmMJMaaTXgQG04xOEtNmrEQ30EiXqcuTt7pbVEFm0k1o/WhVQEbmsgqvnG/n93jvQcEhimJWb
 lT6XoApLcDUvHW6xjRD1+cLXpnSPHH8pM62gM1Hdplkh/l84ZjeZ5DRqY5jGFMMfb99tIRIYO
 xex1ZsrUQW72IhW+/HRg6svFHrgf96AajXDQ9UHHjUVEDmMmV4s/FykHKwhgcSqh5+6086EOt
 qhVMwlYm0IsGzXy3gH8gk9JSUERF4VyLboc7mqX+zY9Q1k8PYM0ANN8+ejPkvfS46KKEpqzL/
 1D/fR4ADN6ZpH1I0xCHBIGx/MbzIhYQzPDAM8xPaNTL8IR+tA4F5h865tLibvoRQRqdg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder PCIe properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 09e3641258ae..cb7e53c86408 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -39,9 +39,9 @@
 
 		/* I210 Gigabit Ethernet Controller (On-module) */
 		pci@2,0 {
+			status = "okay";
 			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
 			phy-names = "pcie-0";
-			status = "okay";
 
 			pcie@0 {
 				reg = <0 0 0 0 0>;
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 5e7ae5e92fb8..d73ee974648a 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -74,9 +74,9 @@
 
 		/* I210 Gigabit Ethernet Controller (On-module) */
 		pci@2,0 {
+			status = "okay";
 			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
 			phy-names = "pcie-0";
-			status = "okay";
 
 			pcie@0 {
 				reg = <0 0 0 0 0>;
-- 
2.14.4

