Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B78C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80F120843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80F120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeIARRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:43 -0400
Received: from mout.perfora.net ([74.208.4.194]:53455 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeIARRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:41 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LxMyK-1fouZe35vm-016xRk; Sat, 01 Sep 2018 15:05:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 07/19] ARM: tegra: apalis-tk1: white-space clean-up
Date:   Sat,  1 Sep 2018 15:04:52 +0200
Message-Id: <20180901130504.14318-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:FQAm+kIBo7f+p0rqSPIdiHswijRghiSTPuJlXKrgBUzP34iPUmk
 Cm/v4ky+aQO/tVnd2jc1Pw4LZzl18O3xm3ooux5eaP178xI9lpBgPomM/Zd8E+atFRC3emH
 u/6xf67W6lr+PpUVzpJUVAlhtkCthmZGUgnDtOyP3BXFZUkbDQ7VlW9gY7QaTsPXFl85qz+
 9MGLDb67ilsGtD/b7k3Ww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+/mfKyDYfVY=:YoMlFfxiJ/MgD5tVqz1++4
 Fq7z9hkEkeJyE/u3AEcOFwDmDekEsoCjG4JqiO+tyZMiYoTc1rBUqnDwReC6Y/SrtHnUoZ1F4
 v1R9APBo4885rYuPJry/gb0EB27LYB1FbkD19ZK1EMGL/VJu4lVIFf7QionriP6Bi1xAJbHw2
 kwRBg2nIMRBJcSjBEg1zWa5ztMhSyk7P5wkNNsCiEiNBrfd5ydZdxZRTz+TMdaVIv+X9B1cNt
 EWubql4M+e34zOdWEzZnxwpSAWKBpkW60jmSpBWiotXSl3XyvJjUusYk/9OFRQRHWRwmt/D3F
 u1A9oFhC21SDg6OsU6eWzwYhwz2065z6pZg5OSMZdWU4xnJej2ktMKZLk6CQeFcyOnYhuGhuy
 W88Ampzm72tnGiDmphEl+YM5qQZawRnKUe7nG1CzEwwrjKe/AWAGX78Tbubcfr+ukpdl8MsXz
 6XMLtELGvxXasFlGQjpG7QbvDe7qXXiEFmhndAqVVOB6vuU7LBWHddyMB0vnFXZ9+KsGp9OQb
 hO324cdGcWUoUXCfe725khKOiDg8Cb78WB1CPdIpgOqzIFgMx04E+wgK1Mwvl1M/YPVQ+0NqZ
 /skz7rW88PxTc0+WZO0gzg7BhpkSSwT7m05tlNC/8AWUw/UYTt+pO00OSnIkBdWz/Ck+MzUhm
 JY1EqjRaAfbyen1bFxwBuunCaq65EDMzmBy5WRmlBBK/TBefZqkxnGDg83o/cUstpbDw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

White-space clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 3 ---
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index aaedc83a11bc..14114bc43e38 100644
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
index 208411692bdc..955adebc9e90 100644
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

