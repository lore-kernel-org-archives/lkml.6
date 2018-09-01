Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527AEC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1632520846
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1632520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIARS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:18:26 -0400
Received: from mout.perfora.net ([74.208.4.194]:51629 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeIARRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:51 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MgNQ8-1gIiYN2rAc-00NlH6; Sat, 01 Sep 2018 15:05:42 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 14/19] ARM: tegra: apalis-tk1: drop module level model and compatible
Date:   Sat,  1 Sep 2018 15:04:59 +0200
Message-Id: <20180901130504.14318-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ZPcFVXYd6VFxUjN5EmXxgNKA3eT6JLVizJ0vWHUp/Mi1KtuhZ6C
 XfJOAjLf8CD3QdkMFXXpgfqPG2fdu9Qg21L+xtN9qA3vWCiyGGduXS489WOP9TEGAHBB0j4
 AUfwHF000K2iZ3iCKJEPwdliFryYwuD07l5bqOiLyL6BtVGnFW2HpiqaJKLWSAuAM0u0JNo
 GJ0cll83ke1kPUR7PFGQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RLZ61/JVbxY=:9UuLpmkavdM0kA1X+OzGA0
 IlB44yAh8OTTzm+w4xtr9QZ6gqUhZNR1mif3dTnvPdKgqWytnBpHIWeMIIoOPFa+7Qra/3jEd
 uI+22IYNOT+9ad3NzmJeHNx3lt3Jv4LxaivQkxNC4ySCbWCRiRmT6Vd/EKyKXYGvdSXSsNE2q
 pBuCtXtda7seK04V7esvM7O97tvJ7gd3pTLoIglaSMe4abu/p0UYvyDukjqREHEP9KY27sRRg
 5cvI6trOJ9NH3yrtr2Dl+YeuZTCeueopUQ0jPHX6cxkrUaAyd7fLLs2C+l7DgdVxZseeO1RT3
 rMjR4B0BGdsah23BR0ut+vDCCFYzBYfeHjr2LISPu6VcXdz3VbYSvPLYdWuPrevcCUExJJIpT
 1WTpWhRiARTEvEkO9TL0s3bo8i1krgYgtpcJ0pSW2iKjjUS/EQccINzhoIRm98BGfSmQ99bax
 su82NmfteRR6Z64wB87huWxY/nLuljkJ2QpuijuweFQ9c8z7eKrQEuDVgNZiICL9xzG3HxsHX
 s6HPhWR17jkkiRXU4urB8Z9TU9MnN0OP6RsTmgZGM0/oP56rqN3S1oOyYPGYBupMmUsl0sIJe
 wlZNqFRpHYCUMGGClS1mblpu24/wQussblMGH16w/nfFyjXB37lGIUvF3/QuK4cuqKx2TWRu0
 KocWE/cgCGsNGGkRpFzo7vqZ64TEFFnXLtwOq+0hmynVeyOKpQQz4WtFX3PheQAYv9NY=
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

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 4 ----
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 07dd208296d3..e70994518c70 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -11,10 +11,6 @@
  * Compatible for Revisions 2GB: V1.2A
  */
 / {
-	model = "Toradex Apalis TK1";
-	compatible = "toradex,apalis-tk1-v1.2", "toradex,apalis-tk1",
-		     "nvidia,tegra124";
-
 	memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index fe10c5180768..b1a05c37106d 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -47,9 +47,6 @@
  * Compatible for Revisions 2GB: V1.0A, V1.0B, V1.1A
  */
 / {
-	model = "Toradex Apalis TK1";
-	compatible = "toradex,apalis-tk1", "nvidia,tegra124";
-
 	memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
-- 
2.14.4

