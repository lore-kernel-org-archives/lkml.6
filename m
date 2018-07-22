Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2D4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F4520881
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F4520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeGVRrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:42 -0400
Received: from mout.perfora.net ([74.208.4.194]:59915 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:42 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Md5Iy-1fQIuI2fVi-00IHFN; Sun, 22 Jul 2018 18:50:17 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 16/28] ARM: tegra: apalis_t30: reorder backlight properties
Date:   Sun, 22 Jul 2018 18:49:24 +0200
Message-Id: <20180722164936.20581-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Yu9dkdDuZvpTSNxPZlpDEa1qNuwAxYGbFXB8aT4e82ccLD+bT6J
 NaTpcouEieG0lhGQb9rLr2X+SgxAF9nNzKKA/r7HL4hXfz3yLbxv2mfKKXxnafTlBSxbZIK
 PUEoOIkLElyoy2C0rp98cgP0V9Ws47madPSsPfZDTTq5GeaHIG+n2s6Qge7ds6hfNiDhvZs
 giBrtsuwGpt8OGuw4KmGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bWbT96TH9Rk=:t45ibHB5hWy5GHYbQ9/0hv
 zsmUPboaphbNMdWoiZgyIW8AK8ugW5qqjJmLSiwsxsDjO+w7ewBCrIDpFrSoNaLDAXU00/jdt
 Yk9CdawfKFJisGgOLl0+69+aefPXqpbFWLEfFRCWCcEeLDNq3qXWB3nyy+8ad0Of8nlPeY0w6
 m1aENxx0p9US2cjMbYbDMQWbcdAAPP6yjWdp+Jy5OoohaRqn/jQrohwInIY/mwS814OpL8wd0
 CnaRvL+q4Bklajj7qplPMfva2UYCEBk01AeFcRJAnjAYrl9AdBY6LTFRbYh2bEy9GQI1i3ObM
 F3usDfz/ooVP6xwZk6uoVv9R/VJrT5fA/Tf2d8+qQ2agjneQg/t/c0MmZLQheghh/s/4oVPQo
 oNS29qyxw9H3dVviXOvR+N3CkBaV1upS2NWQUNWJnbNypCxZWNfa/3JHWDhgYz4i8p3JDSgsJ
 a3jJQr6+gY0f9oJVgTBZvKQ+a+htC6MyfVxncfmAk3bk0X/I6vjm3NYkQOwCr6+Fuiti7XDhO
 0bh2ZmInVOQLLsWUFlGy54bbQx6cEfsNrdbKjPcMptxVloehLCjZH6caScNEb+CdNAQmc4rTU
 ndIZOq/nXu+udpNDH/0JmnyGZp1mZMEf2FjBl+Ey0wDbt1uko4+sGLq/JGGxaaWfr3xVLQwOC
 w0HtJfTfOOsCPNMEDU5Z1Gjq1RMUE4Z0pgeW8XpK0rJG0Qb14QxUaHXQKXI5hqqFwhzs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder backlight properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 4bb571bffc7f..c4153e8e8b8c 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -193,13 +193,12 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		/* PWM_BKL1 */
-		pwms = <&pwm 0 5000000>;
 		brightness-levels = <255 231 223 207 191 159 127 0>;
 		default-brightness-level = <6>;
 		/* BKL1_ON */
 		enable-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_3v3>;
+		pwms = <&pwm 0 5000000>; /* BKL1_PWM */
 	};
 
 	gpio-keys {
-- 
2.14.4

