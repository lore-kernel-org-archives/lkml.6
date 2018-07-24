Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8FFECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAC320881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAC320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeGXLtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:18 -0400
Received: from mout.perfora.net ([74.208.4.194]:49823 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388413AbeGXLtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:17 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgGag-1gKbbI3prg-00ne1q; Tue, 24 Jul 2018 12:43:21 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 03/15] ARM: tegra: apalis-tk1: reorder host1x/hdmi properties
Date:   Tue, 24 Jul 2018 12:42:57 +0200
Message-Id: <20180724104309.21741-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:9JG9f+Oi71hjwwxS7mwUg3b1uvISs2N+wSWdUhh7f3Jk8Q5daxs
 giWMuojOPdGxr/dT8V2eldNS7N6FLx1cp/TAYxXutmInbz85F2JbSa7FT58XO/cWOhBQAh0
 6CK66UID7vgjjM0JWGz9cefzSZClEAe+asHFQTALEs15Zd+vziBhRUfUHQpk0SQ/ez6xvhK
 UZZ7NHW57RBHL738PF+ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q5zIDtbKZU0=:4bnWVpk8dCUhvBcpZvQ0As
 ++LwkbNWcHk7cE1oY60yDHYFFH/okt1sPQ5mqaJMXgpPv0tRBmbvLahGtyUisbu6dBp8VcOMW
 UxLnN/dXy5Icjc3Fo4KMlrFMYO2Z6ISdYGj3joo/ZI3W+t0PMiDfCe8Sug0PipIPTvaNjX5EZ
 zkNNV5iWfZQpbFVBGezdaPFDZ9Un5d0CE7UofwfIER2FlZ3iAuEJ6vv33n999Y4SGuecQVHxE
 kzXvicX+4RMNtPWf0DTpLl3ydJX5GQlqLtJVS2HnOwLPZ/rCUVey9CBl/KO4j3S8XbnPWuA55
 8gVaAXIbsqclnN6NRT1DPoGLKTb8KTZ9XA157+wtxxaVnC3/fyziDhbU0kHrEAlvxMfMcefYJ
 bH8TAbYJPv7QD6g6xa55hFE4g94NjbH5lOvkaWFj367OtgPyeI5e31hHApQ9n2q+INmNZUPK2
 +6/omXccKsi2UuuLWf5wcodH4QZYOS00jDP7CWfaTR0BTr/ovrdgHazsMl7zDXqB5ANGuJ/Bw
 qqACVSuZ+Kfbwcbg4L0VkAmYU+obsT+PazHEqb+7pasZVOTIztSIUEvjbcKuj3SCghM5fmR9j
 05t7Qabq53pLFYsYs/8WXyK8Es96bQtVK64UXQO9kRDn6TboPAB7Knx0SqaoF2+yAIgiWs4B2
 sfGScI5ZWMSXBGT/EGg0hhoOXwAshQ6CrpkmQFfHA+zjWme6qovDiDnqHGzWrzBPkpEI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder Host1x/HDMI properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 4 ++--
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index cb7e53c86408..9ea65723c40c 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -52,11 +52,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
-			vdd-supply = <&reg_3v3_avdd_hdmi>;
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index d73ee974648a..69ca362c1ef3 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -87,11 +87,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
-			vdd-supply = <&reg_3v3_avdd_hdmi>;
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
 		};
 	};
 
-- 
2.14.4

