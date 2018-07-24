Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA2DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC3520894
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC3520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbeGXLt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:26 -0400
Received: from mout.perfora.net ([74.208.4.196]:58255 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388583AbeGXLtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:25 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lvj4s-1g5HdV0DaG-017VII; Tue, 24 Jul 2018 12:43:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 07/15] ARM: tegra: apalis-tk1: drop unused pinmux label
Date:   Tue, 24 Jul 2018 12:43:01 +0200
Message-Id: <20180724104309.21741-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:lSVdgZXJy+rYuqzJ3JLcert80LcAdHp7ZFDIGEfUvwG+aA5d9Mi
 XStc55JJ8mXqPCTUj5yc/E4fQIyYAKowv0Hse0OUP4n8Gjzbdass+ls1JJnArFacz+AtBf7
 Ny4B0/YVHVULbEDjsX2/2fl5N6E9kiBqq8P1H7n8ixFuvQAMKKi3E/4pp2B80cyhcLH5Rdo
 xtYmB94hmZwetQjv+VMrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Afym3Tte2PU=:8dgLWIaxs3PAlXJcdp4mxK
 wCW3iPu+6pSq8cyv/Xh4woieC5PS2LyuNIZF7y/g56dG/V94FfrD7eM1peC8EGCDB++ExVmNF
 lwn7nHBpLmEVmaY7c1Pc7h9opAs/duSW95ae95vjhW0odOcKo36N+V1UqU0Ua2bogSWvfXFRt
 nbRZRLcSilJPV2rbNEhtB2rEbYsozeJB/ewPVyrtp+DdZIk6QDlFqb+Fbo307/20bmmiykGLv
 0Con9Q9xvIu0uGJHu7dbqY6ODyEp+rjcQzbQ3gNwhzPPrBHdC1NEamjdvusxm8wLs+8k+LkAT
 auudq6CtG67qNPU3ss2zMESRlLiXxJWuikM+OAkazSnG/0FeR5OkWRX0Pl0w+e+lrg2k8Ynpn
 qpm3ED80x0scNzFpwPx8X2NM26bYXy4xzWJIMlTRgHkLyoI2O9ojNYjzpvlBIm4MtssR/JO07
 dIfL0xcLimMnPYJyw634Koyw5/R6FzvMfXt60Lk5IB4WM2ObDp2nBgxU9EAopvXRoaxuckURl
 UvX1GtJHQyJOm0xqqkNY2CxgeTC/h85b2ChejcOaxw1q+25664S66uyWB1BTRe1VOlyPwzfl+
 aeuNmG5E36cKvGhDuRH/K7MtkgWb3bhVbxPe6j213OjwAit8CtEkvy/KfnxER7vREx8eUQvNA
 lWFOqWls/K5bCirZ3SIzrWwCdJX/edxnBecQk81nmWepoINKNwVcg81HRjZo9Ufr8Rpo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused pinmux label.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index a8dcf960e44f..866946d683d4 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -68,7 +68,7 @@
 		vdd-supply = <&reg_vdd_gpu>;
 	};
 
-	pinmux: pinmux@70000868 {
+	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index b2aca71f96e7..2cf5d02afbbc 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -103,7 +103,7 @@
 		vdd-supply = <&reg_vdd_gpu>;
 	};
 
-	pinmux: pinmux@70000868 {
+	pinmux@70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&state_default>;
 
-- 
2.14.4

