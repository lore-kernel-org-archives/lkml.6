Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D94AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D665E20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D665E20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIARRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:34 -0400
Received: from mout.perfora.net ([74.208.4.194]:38417 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbeIARRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:34 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MTR0D-1gNPW53a7z-00SQ6T; Sat, 01 Sep 2018 15:05:27 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 06/19] ARM: tegra: apalis-tk1: drop unused pinmux label
Date:   Sat,  1 Sep 2018 15:04:51 +0200
Message-Id: <20180901130504.14318-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:N+Yg3tsRzkNtfhs/xoHCPw9h2r3upWTZCXOcW0Ec/am3wktmifF
 rkeN2iC7b4ArgneYDpiAErnuFEaCrfEHHXDxa6Uswk0ofbub8TB1LReGWOpF2AW9uQ0IvBj
 ohDrJvHpKF1++cdH2EqW/tMHPz/pajoi7ypgONyQrRJual7fpOQRtUWrrdnO1Viudt8x6qP
 9bukXd3Vbv+EoNUUqf0Mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LYx//CgqBCA=:+yPCTVKr04amuQRVDiSSzw
 n+JnmC5Ed4RfUTMuSrLKbs9l+w2LP2NLH1ROajPGnTzMTKIRXAt7paStTJavLZFtK1l4sU84c
 tj7hD1sdSZAL8S7i/38azzMPhOIUHZXFO/lnquTaRW13l2mNs4odKdKBT1TMyXPlR04xEPqoD
 VXWmctt0lI73zPm9TQD4zwuP8XB70EEEODJnn+/CpN3k1hLw96bUOnOAL1M4s4CjpPRp9DpRK
 vL/6+Bdp1Qlgp8gyZKvK2HbcNmJPZSjtBU6crjhL5AE2bTC8xqu/Vqd0oh7W78RULqeZ5fnN8
 2xOzHT56GYzpKeCpK4LWcenBxUDIMG+jwXzuCHOYIFt655N79hAHVcj3zK7sfVYoCFSY7H9m8
 l6VrWj+48253WzUW1TlYpV+5XEmGnZ/kzTIE5Of1boRAmuiNLL2qgd5M5sujjObJLh6f/E0gs
 mZvorSMB2gGGVV7pvb7CYjLHvrFDdgdCf/XzoxwVBFZpG9v+l3PgHH3p+qcb7MjG9Ii0iczHB
 PYMizgq6M89aGF0rDHwUUQ1BMK4PW2hpaCAS/sE2r1bREF2gsT8yo7p0prC9AMf7uYzefrEru
 FtcYK2V2k+63TxLOR9RmTiqg3BuVV53w24AjVE5jFU5eH+RDO1j9LE2uyHcU3TZbhi6hpXrc0
 RgPVrwLR7Bh/RAMWH1DZVOuIDKAgP8e1J+QVwYXi1XVfOirU2yQRKfE1vuKMBm3sEctM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused pinmux label.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 00d5308c993f..aaedc83a11bc 100644
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
index 65a88d314fd2..208411692bdc 100644
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

