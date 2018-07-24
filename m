Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A04120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A04120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbeGXLtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:25 -0400
Received: from mout.perfora.net ([74.208.4.197]:60745 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388578AbeGXLtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:25 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MPnwS-1fcyqG3row-004zoy; Tue, 24 Jul 2018 12:43:23 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 04/15] ARM: tegra: apalis-tk1: reorder padctl properties
Date:   Tue, 24 Jul 2018 12:42:58 +0200
Message-Id: <20180724104309.21741-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:5F0aeTPGgSJ+FqL0zMONwSnkm1q0y2S8Hcv8ZxrO3CwG3ddekxL
 y/7HIQ1W/BDXfumCAq2viF3vQ4t6EuPS/stZ9AohJAnwtCZVgwa6uJTi+iU5C4glXRV++G5
 x5ouWxKLGC5H02h5ybOuEWz0YNZJxU3s2ypmKbcJddYvTTMYPK54BZ+zF3DGIxjQIj+btGf
 yapERfDLzfnPFSoEn24KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+WCnsGf4Zgs=:tV4O6Wne3F5OQN5FBy5TG5
 F8maMhocELYEnThPsLBCHxOkzCWmvgo8sOFNV7hKEL5TVcYg7o/DGtHJd5PKvGMfKsUZZH1Gy
 1zRHIQ+865z4p9Qg4MAAHbITJB/RqfZRgt7NRJKePEfgLX1l6hyCyRaDL7sConV4SwnlXD2lW
 17D3o4ypjmNuf5L6d7g7EnkDn4KCyDChiAGP7Eq9VPdVolH2e7LA11KlDp/CI6ZJuXzx4kjCv
 XlfcwZvuOgSc0W3xuK7IgRCmP/mfrXDt/v7XoUMsEGwVPLCDZ484lEgILp2GiCgH+lHm1uYOe
 uYa/dcBvuqw0PFkZ+UBZOGxvZU6QpE4pchF9AYDNyM5of6vdZomxjZJ8TNFgBUadRgsPE32xE
 np8J1Da4N2QjulwQx94/MBnDwpnxgRDF3OGZFRnB4HEB3weYC+s/tPDHVsGBXy6UAXP9PajbD
 avoGB1sHMTR6ID7AAmTDaOs686OEi2tLZuDsJo0y+f9NDdYYKmL1F9cxpwGU6rkHxiQcqUg0I
 FZGK4AH333s3ovIC2YNNMSk9d3hMvIlEGMpcojLZF4pqr4f+EOZ4Ly+XXUPr7Ha9Mvy+a57x1
 fiMK83HiW1aZw+/IN/sbmO6krWR9hxOdro49/7bJdnVndUapBdJEitI6Pqh4hkL9rH2m2EyCA
 D08GCtvjcmLpnbhfhdnrvO4Ek7pdoJGMaA7ql15Qc2ya/zVoIqPyWuCE6cAEzuCZjDGQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder padctl properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 22 +++++++++++-----------
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 22 +++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 9ea65723c40c..fe74dd73a572 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1815,18 +1815,18 @@
 
 				lanes {
 					usb2-0 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 
 					usb2-1 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 
 					usb2-2 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 				};
 			};
@@ -1836,28 +1836,28 @@
 
 				lanes {
 					pcie-0 {
-						nvidia,function = "usb3-ss";
 						status = "okay";
+						nvidia,function = "usb3-ss";
 					};
 
 					pcie-1 {
-						nvidia,function = "usb3-ss";
 						status = "okay";
+						nvidia,function = "usb3-ss";
 					};
 
 					pcie-2 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 
 					pcie-3 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 
 					pcie-4 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 				};
 			};
@@ -1867,8 +1867,8 @@
 
 				lanes {
 					sata-0 {
-						nvidia,function = "sata";
 						status = "okay";
+						nvidia,function = "sata";
 					};
 				};
 			};
@@ -1900,13 +1900,13 @@
 			};
 
 			usb3-0 {
-				nvidia,usb2-companion = <2>;
 				status = "okay";
+				nvidia,usb2-companion = <2>;
 			};
 
 			usb3-1 {
-				nvidia,usb2-companion = <0>;
 				status = "okay";
+				nvidia,usb2-companion = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 69ca362c1ef3..3fc41e25b5e8 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1844,18 +1844,18 @@
 
 				lanes {
 					usb2-0 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 
 					usb2-1 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 
 					usb2-2 {
-						nvidia,function = "xusb";
 						status = "okay";
+						nvidia,function = "xusb";
 					};
 				};
 			};
@@ -1865,28 +1865,28 @@
 
 				lanes {
 					pcie-0 {
-						nvidia,function = "usb3-ss";
 						status = "okay";
+						nvidia,function = "usb3-ss";
 					};
 
 					pcie-1 {
-						nvidia,function = "usb3-ss";
 						status = "okay";
+						nvidia,function = "usb3-ss";
 					};
 
 					pcie-2 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 
 					pcie-3 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 
 					pcie-4 {
-						nvidia,function = "pcie";
 						status = "okay";
+						nvidia,function = "pcie";
 					};
 				};
 			};
@@ -1896,8 +1896,8 @@
 
 				lanes {
 					sata-0 {
-						nvidia,function = "sata";
 						status = "okay";
+						nvidia,function = "sata";
 					};
 				};
 			};
@@ -1929,13 +1929,13 @@
 			};
 
 			usb3-0 {
-				nvidia,usb2-companion = <2>;
 				status = "okay";
+				nvidia,usb2-companion = <2>;
 			};
 
 			usb3-1 {
-				nvidia,usb2-companion = <0>;
 				status = "okay";
+				nvidia,usb2-companion = <0>;
 			};
 		};
 	};
-- 
2.14.4

