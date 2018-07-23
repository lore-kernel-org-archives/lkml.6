Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB066ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0E820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0E820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbeGWNil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:41 -0400
Received: from mout.perfora.net ([74.208.4.197]:60599 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389178AbeGWNik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:40 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MBCpX-1fp2Lp42c9-00AE5g; Mon, 23 Jul 2018 14:37:33 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 14/26] ARM: tegra: colibri_t30: further lm95245 temperature sensor annotation
Date:   Mon, 23 Jul 2018 14:36:45 +0200
Message-Id: <20180723123658.980-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:AJgXZu+0Il3Rw37Roii+SMAqtx6ath4XIJHQpXMC+u0YMcR8LYO
 UBOi3IY0DvOZ9S/HapZkevurXQp8rzpm0KDfyg9L/M2mj/n387ud89qI8DIzDGdXL2xzD2s
 n7C3QHosdc4j2B2n4f9Y9+6uyIt0l38gZU7K6DXj2FwER0abhAyvBxiagRbBtih+UjaA7Op
 6uT9y40uetEW3hxMWr8iA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N7gNoEe9LRw=:4lrjfKFeVG0U5g97SITH7Y
 WV3knp8dYIb9j0/RB/Zy7IKL+ZBeIw2+yvJqtXkXfYpy8cjVji5zahLOIoIOqQMmftz5Z9yaT
 iPJyiWEx5KFW+HDGTvyh44K05l3Rd54tvQGis0ifXOv8tyh1DTEuKQNxduE7C1Iem2kM7sBHT
 bbsYYhlies0e8zKOi+HaCEXiaAckikbCI1rw6VBt3I0fPeDFSTqu8WromMuO9NTCa3uzRHvD3
 7vlF2p7i1aNyWpUkT5O7PtdHUohlsmXv+uyPoyvjtBy8dS0E8rQuOnepw0+veud8QfeMq915Z
 9vZODLOyZlMEl9Z6Fw68K1FuSkwB675/HALkyRji7zDT70Z4wgPZtzj6azJfxumFyrN6hfhNC
 HhJ4dcU+9YeYTwcitcDXO9jHR036Fps1MEkkku4n9H/UlaLv2IHmsyZw5OYn4huAKC+Rm0wpi
 hc54aRK/b3wObBKyOs5kT6hNZdcwT+DRoBSlSY5LOWsumBcJf1Nk0T5PkSxg4+8jSXLij8kds
 HCLAJ2RqMo9FdLDS/khdIjM6bnyybQS2rHKOrD/yG7Fh+crB2e+SnF2YsrQjoc0bCyu6YHHTB
 77FVN6DB1SCd5ToKKSTH0Bedj5y1vqB3KbnuKc0H+BvC9XNkk+oE35T7KOkA9uoM0jhWrRgTx
 K/ePYv+x/II26k2uukAb9l+N+t4yvh3DLUHBPEfFkjOovnEWXe6dj+L/Rf4Xl00OnnL8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Further LM95245 temperature sensor annotation.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index ace72a53186a..8266e42e1630 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -870,7 +870,7 @@
 
 		/*
 		 * LM95245 temperature sensor
-		 * Note: OVERT_N directly connected to PMIC PWRDN
+		 * Note: OVERT1# directly connected to TPS65911 PMIC PWRDN
 		 */
 		temp-sensor@4c {
 			compatible = "national,lm95245";
-- 
2.14.4

