Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C2BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AED20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AED20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbeGXLtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:36 -0400
Received: from mout.perfora.net ([74.208.4.196]:38299 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbeGXLtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:36 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MGyFo-1floXh1jla-00DlFM; Tue, 24 Jul 2018 12:43:39 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 12/15] ARM: tegra: apalis-tk1: add toradex,apalis-tk1-v1.2 compatible
Date:   Tue, 24 Jul 2018 12:43:06 +0200
Message-Id: <20180724104309.21741-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:T+L7V9bMSFZq8BW3vHP3ZjElY5hRl2S39mRzFldI2IWnJOHmPHk
 SUkb5/jzfQBcyjWnfri4F5tCXdQ/YnmmEm1ViYMEQk5WCxNUC5qwhlLW6sSRfogFBLB1GTX
 WFu1aOceKRrEwxC+g4SN99qt8bIAfl1VMBIq7RG5+sQDIUVxlovzsO8xx8FWx/9bg9O0lE+
 nYONOW2F6agBA31Yijfdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3SI+0m3Q6d4=:mLwYC15sno4ZfHkgVg9GMn
 jlQYgApPdNRE9skH1MMoLqAkXNVI7cpE5BDLcnpw6THH8cFG7098kdEa61AMQS6tdbX04hKX2
 uRkeAKMz5N7DVZK54WeL1uLEwx8fB4SpEz4CfuIUSnotj2FLqRT5Kp3iYgd45/w1fWmpJNIRd
 Zmc+1r7REzDWcIztTlZDggatVLfGGhDIKTBHHI76MK5lC/ypjIhOeD1w+puPxpj9R+hLZMUGu
 lOPe6M7okbPXAmMrmBnkxvxk0hFwq7EwDqNCnDo5P4F4VicApfwl++riOeODm2xiooWjiv1vM
 lhL2VaAVHwdfbT+skQjT9XSZBR0uAsWY3GWgqQi1xZxAJATP/ZqxW4UBN+QBQhPg25FC7EnxF
 Oay0l90eIRqHyfK1VaH3KPwbJ8g4UwMAwdqAYVIC+xNNz2gdgzN/1VpOJd9/uQ8g4xguhWHLP
 gtYcW6zH/NxSgWwQGhFU3Ts6jQa4loJlr8nLffFsPFdBXjDTcI6Mdl3LsyxNWshjRsm8mDHo2
 a82J/xsef31kxYaVyoktly0/CUUjtyruXsQ74+T4yZMj1jF8aF7bL4UYkJZLups9NNDOPCrOQ
 DbaYsvaPDW/NY+FkeeTEKuz+FTRAtOaHmtGYRtFAHjK5I3I3/VxUF/NW79la+SVvCSxxWC7ke
 CUl4Kjs/33++sP3yJ38zwQu3DxQHtRFcC2jsebgHGD5p0HzxglMtulx56ErWLDO33Jxo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add toradex,apalis-tk1-v1.2 compatible.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 Documentation/devicetree/bindings/arm/tegra.txt | 2 ++
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index 1073a5e66122..1c90cb32da19 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -51,6 +51,8 @@ board-specific compatible values:
   toradex,apalis_t30-v1.1-eval
   toradex,apalis-tk1
   toradex,apalis-tk1-eval
+  toradex,apalis-tk1-v1.2
+  toradex,apalis-tk1-v1.2-eval
   toradex,colibri_t20-512
   toradex,colibri_t30
   toradex,colibri_t30-eval-v3
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index aafaf2c3e195..89783fe76f65 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -11,7 +11,8 @@
 / {
 	model = "Toradex Apalis TK1 on Apalis Evaluation Board";
 	compatible = "toradex,apalis-tk1-v1.2-eval", "toradex,apalis-tk1-eval",
-		     "toradex,apalis-tk1", "nvidia,tegra124";
+		     "toradex,apalis-tk1-v1.2", "toradex,apalis-tk1",
+		     "nvidia,tegra124";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-- 
2.14.4

