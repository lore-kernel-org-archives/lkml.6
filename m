Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C5C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D702086B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D702086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeIBOZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:37 -0400
Received: from mout.perfora.net ([74.208.4.196]:59307 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIBOZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:37 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lh4nx-1faUKV1ZDD-00oNB6; Sun, 02 Sep 2018 12:10:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 32/37] ARM: tegra: colibri_t20: rename i2c_ddc to hdmi_ddc
Date:   Sun,  2 Sep 2018 12:09:01 +0200
Message-Id: <20180902100906.25792-33-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:ZmdHG7kBt3hkmBXHuthkadXVtX7nY2at1WS4OoBLw/R+dN/olQz
 hkzdeUWEkFs81krBNfxpSicXlXyei8acSMRWZPJ+t0xHUQpTcyWAS0Ib67Iq241JnFpP+qt
 xlcT/cSr/+3gWlk0gvLSEoPstn7Qz2zvn7yOYV46dUlaYHnUpSOREdmtz6z8fi8CYmvPF4a
 q1ydU7wqLfkIIGYqJdhog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9ol6k8EK6Ko=:p/spS9TBL14wDubL51CY3+
 GTVx8d+ftBuPsczYNiL2+9PC8Lveo9Kve6fNxh8qgJ2iRua8VWMWi6qCUurKkQ/Bc8xsSv9yG
 S5VnfQBQ+rcLS9x4I/AI4P/ruPQSwBpdICrPPTxCRA+zKS47B/rY6yDH+/wIHa1WE2dhG9elB
 d0B2uC7w1ZYiGMSgfPJSQI/f7cgg9Ja+GJ9HUX69x5TwvQI9a3/Tk5Lm1+H08uMomn/SQpPCZ
 pOQH1nqZYYY3019AdBO3zm78gcbP4TDPjEHBifJGqmYM4MDLBqstbMFvWYFn8hMuhiaMRyTV3
 0Lwj9SjckOJ9lCh6zgV7cgY4+Ym0DDi9Xy+ssi7f3REp2efhNkz571WPbFS9wU1Qvk9MenMOW
 taq1T5ER9P1RxXsoZ7Aj1guQs41/zbCFxYGSYUFE2y3EowmE1SnKSzGVK7frcpVJaSwi0psQu
 6G77tJOdW0Pz57gndwqg8l/OU+tgffNWGjJNER53AUS5CJJQ4l87CNxlWQ9xZZKNtTH67H5pg
 DygXuBEBCvdScdKkKDvfQ4CXbpiZvCelVQi92GFtMLh2I4o3ofiJH2TiczIoji8H3G46UYT/p
 cKcZ9OSoQmiiR0l7xbtC89DFIHzqpgA6KntfI+22jVfbwPuhClS505RLWuHrlZR56CmHhCN5J
 rRmbSdhP4XRJ4tv+OfInh/wVcPc81XLX7mB+88n9aH2zvIr0Y/h9xE8iFdCz4wQJsVbA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename i2c_ddc to hdmi_ddc to be more in-line with other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra20-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index b4d429f672da..36463fb3c0b3 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -19,7 +19,7 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			nvidia,ddc-i2c-bus = <&i2c_ddc>;
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
 			pll-supply = <&reg_1v8_avdd_hdmi_pll>;
@@ -459,7 +459,7 @@
 	};
 
 	/* DDC_SCL/SDA on X3 pin 15/16 (e.g. display EDID) */
-	i2c_ddc: i2c@7000c400 {
+	hdmi_ddc: i2c@7000c400 {
 		clock-frequency = <10000>;
 	};
 
-- 
2.14.4

