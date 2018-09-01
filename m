Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A2FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD7620843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD7620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeIARR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:57 -0400
Received: from mout.perfora.net ([74.208.4.194]:48619 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbeIARR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:57 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgXZb-1fbNMW3pOn-00nv1n; Sat, 01 Sep 2018 15:05:50 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 18/19] ARM: tegra: apalis-tk1: shorten temperature-sensor node
Date:   Sat,  1 Sep 2018 15:05:03 +0200
Message-Id: <20180901130504.14318-19-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:7+8L43f6lwUf0QI8u0MSjU9Lmm7YGii5RpVwThM8lYAe7DwxfEp
 rsibWKI/TqSGi5VtopVyDXR3dqEnHEAEJGwei8RiN34aIOJWyBZkq+KoDGXPysueeABEzRg
 jYqcMv2mH0mmAmorSYmbJ0C6Ic2R9OMbimnENxVx27ucpCJTsX2j+TnT6Y0CSBqORuDV0Yq
 uIgxEG2RgyQ6Ruocq1IBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mNeRb/K/3q0=:bkven2qmZc8rUPnFI5Vymj
 3DKxHex4ahiIrFAjXF6+r9/OQ4/baH2PQDYJcA7Iz1GtthkC6EbFHf81SvSxFnjIGg3LGf5UZ
 TM+62Q1nDAg/f936sBknmJjR3NibL0pLWUiGQYb+pXinI1YqrdcqJ4jDkrRi/qHFoiegYE+An
 z8Y/LjYJiy+zIm9eoqYA5vfENwwTZDIa2XfhlG18/KNi+5l3tSDiIyBH2XNzFuikZ8iBpvDFh
 iPAiN9ksgspWQBRJpKPkAtPZ9r4WypfhZ3THd4A3ioft8N7hU3HCpfvP5/bHdqX4YLhLd85+O
 /U1+u9MiGIwQECKb4+SKrLonZ7wt+WqKKToTVdHIOa98duBjSN9C8tLsWEjanWCSH9pHM9eC9
 NjpnUE/MWzk1eiqVg1j5aG6SEC1hSbd/7tbFx+l3eJIYmbwGWJSkmhrWbMARtG+GQx9I6MYFU
 vDU5jYJrtKbEjV3yTlhl4QSa1nOIsErHYirYo/Dc9S3kNfwB/k7xzE6KbI81nSCZNBAKkjB2s
 B2YdfsP5OSPM6PCFmcP1Z0O26wnUHiEieijqrMWak6gNSnM2JZ6hNJGJHyqUoIz+bjEQU2t5/
 gT6J1iPA5J2SzrmseltPDjfvr6QHry02J0Ap269KcYpNwlD6wG51UfA+RqLRTlXaoGitbEi7I
 foDh70NeAYech7dBF5l5eiNauQZHXqVMDBfR4nFqP21G4fq5J2Zro7HZpZa8lNejUv2M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Shorten temperature-sensor node to just temp-sensor as suggested
in the binding documentation.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 7fe61f1baadd..367eb8c86098 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1745,7 +1745,7 @@
 		 * TMP451 temperature sensor
 		 * Note: THERM_N directly connected to AS3722 PMIC THERM
 		 */
-		temperature-sensor@4c {
+		temp-sensor@4c {
 			compatible = "ti,tmp451";
 			reg = <0x4c>;
 			interrupt-parent = <&gpio>;
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 62af3dc97ede..13c93cd507d8 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1775,7 +1775,7 @@
 		 * TMP451 temperature sensor
 		 * Note: THERM_N directly connected to AS3722 PMIC THERM
 		 */
-		temperature-sensor@4c {
+		temp-sensor@4c {
 			compatible = "ti,tmp451";
 			reg = <0x4c>;
 			interrupt-parent = <&gpio>;
-- 
2.14.4

