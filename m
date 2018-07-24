Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B673C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE4720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE4720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbeGXLt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:28 -0400
Received: from mout.perfora.net ([74.208.4.194]:53465 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388583AbeGXLt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:27 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MXXjU-1fTBjB0P0I-00WWaG; Tue, 24 Jul 2018 12:43:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 08/15] ARM: tegra: apalis-tk1: white-space clean-up
Date:   Tue, 24 Jul 2018 12:43:02 +0200
Message-Id: <20180724104309.21741-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Pj4UMNGQ8utcAYupMcznktL+COFGcScxDJZTfLXJABvVFycl577
 eGDvLU/u2QpJjKllmYMbqHJeL24Rz3iyZxqTsjn3TICTLbvlKVCZOmMKkPR1IstxWVpf10Y
 ROMskgfZzp/0TIGJcRP7er0ouxEAX7oeYeBUJHhX7gSYPBxxQGaAYePgYrTfcYuspsCT8/z
 nfbjiiJ4j0dyoWLyX6aeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:67DNKV+x0aw=:1DAGR/emrI+PgV1pON1ARc
 4/RsmvCLCPN3YgtXMXH2VO94hjcxY2rul/UdM4MpzKpaAA7fiPlDmoeU4j9bTtuVNje2a32xV
 PyQVkNx4jEFhk/cP2bzqWgNf2DeCpmD8hWiZiUbeYu1huKXvctbm9MirP5XSVAc7GYyNpOo5k
 Ygeblsrru6oS+kV9lTLjUa0c/4LkEHe8OIpevrEx455qkm3cmCR6DqzD31ZQzDTbdzyaX+WuZ
 /tDkr8d+V09y1ePSOjvKCsIvCXeJHijVgdnN/XkzqqYXbw6fcZyXT0guI1SwTzx2kKgrSCvSz
 1T9VQK6GThDPsNIuftALghkiSx8L3O9QdMCpu4ZEsnSf6ckUVPNBrbppeabJDa1gSILLaD9AY
 oxJvxc+SkKcGrAkX8ioTOEl5s8lgUlwTeubMa4FT8+pqnZunNmkaUx7tUXvHgiwKa6ltAh14/
 Bg2jnMRSNTa7GmWqeq0eFsKW/98QETrphehFMABPU03tE8zMBEZXkr8sUmgfItworl7KPQlbn
 S67rg27dS0S/AgLQOKgqhzuqHBytzBm/gmotkw0fXB4tH0YbILYd3dCF21oX11LXBNRiah6uc
 R8fdAJuViDXOevjfLnH9AyuJCaaRJFRcjS/22QCJ5MMP0BN6irZRd5RJvioCBvtyPg3EpbHxu
 TsEltvxwsDui9UV6PwfEzCj+xvWqu0/1TPBEjqLYxVyp2FU2AhF4N/MadUQC78ZfrsPU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

White-space clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 3 ---
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 866946d683d4..8ea696c91341 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1881,7 +1881,6 @@
 			usb2-0 {
 				status = "okay";
 				mode = "otg";
-
 				vbus-supply = <&reg_usbo1_vbus>;
 			};
 
@@ -1889,7 +1888,6 @@
 			usb2-1 {
 				status = "okay";
 				mode = "host";
-
 				vbus-supply = <&reg_usbh_vbus>;
 			};
 
@@ -1897,7 +1895,6 @@
 			usb2-2 {
 				status = "okay";
 				mode = "host";
-
 				vbus-supply = <&reg_usbh_vbus>;
 			};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 2cf5d02afbbc..ab63e5653d73 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1910,7 +1910,6 @@
 			usb2-0 {
 				status = "okay";
 				mode = "otg";
-
 				vbus-supply = <&reg_usbo1_vbus>;
 			};
 
@@ -1918,7 +1917,6 @@
 			usb2-1 {
 				status = "okay";
 				mode = "host";
-
 				vbus-supply = <&reg_usbh_vbus>;
 			};
 
@@ -1926,7 +1924,6 @@
 			usb2-2 {
 				status = "okay";
 				mode = "host";
-
 				vbus-supply = <&reg_usbh_vbus>;
 			};
 
-- 
2.14.4

