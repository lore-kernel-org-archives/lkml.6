Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827F0C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472C620874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472C620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeGVRrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:37 -0400
Received: from mout.perfora.net ([74.208.4.196]:53143 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbeGVRrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:37 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M5O2r-1fwKD92G2p-00zZDc; Sun, 22 Jul 2018 18:50:09 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 12/28] ARM: tegra: apalis_t30: white-space clean-up
Date:   Sun, 22 Jul 2018 18:49:20 +0200
Message-Id: <20180722164936.20581-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:7a2F5JV3CoyUEL8gNwz3FOJGkSEZq71XHG0UfbRaXugGQo7z+i7
 WsljEGUjjtTBS0ijRb4POMxnPYWkY6tKsXtIV0AStvh9+cWrUJi8qz1nySpI7dJ1SFnT7o2
 d0/xFrn8nta6C48dURnwZu9E2PQ69wSfSTTmEHF9C2jtztoIvbdglwt2UfxJYVvnXPN7oVs
 UytYeHEhSK2weGuF8Y9/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:srZywXd/gvA=:cRrH12tGY6d4GjuN7Z+zj2
 cxeVLd9XDRPR7552gdXQjfg5fm9LtaiEAQZzwjLVw+uTtRCmPQiR8tx4i9YkxbG6pSkOKLJKC
 WDQ+9kk4PjTrpBjO3Su4FVNfmyWTwqV5K8H4LZKjEEz7tGfOWRnSFKZ2mHPnGOXZrwIF/+1tY
 PR4cDyZMKHWsKJb+qtqbbW1Dj4mb2THlquynax9f5KK+WJa48SDaTExmcnw4lY4C7PsSx/x5L
 ejGSrOZV5yNkm0OfemArlcjRjtXxOaHC8M1eRrWsKck6eCqw+pzU4judfNJR+guyhwsmV992z
 vAJZRr/P7nPD6EFsetdBCv7ybGOUpZhDvbvJ9jKFg56cfn/7IQri1ToKsVT9MyiMi5TRhjvEa
 AfwSpeh9xOju95PQlJ/x0M4832ydD2wfhCUXdXajtWHpjTlMu3BpjUAifg4vY80f6pGG5/ZHl
 GRC0zdyAPhXAMy2EtvVZUt63oqc3qEhth7TDDjDDJUaQNHZOu7K1IrCphbEPkk2mPYfPSmERp
 RnHFY4mxLi6TDlkmpqKBbVBU6v5bAOBtRr86zee8NqmVjckA6X47ZZqX3Fp3wZkNzH/0xZfRk
 mohQEJoj4T425P4RLT5bksy99HwJRn2OB8PqWDFAzl5+RZx6wocMoy4QekMpspJx6gosPZ7rU
 IxmivgWEa1rN9y6ljJUo5c+3CLgj2PrGFq4k3Shm3F3TcSNnw39DU2LOBGoL+VlRmcK0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

White-space clean-up.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index ba178632d82c..74d588561d9f 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -118,6 +118,7 @@
 	spi@7000d400 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
+
 		spidev0: spidev@1 {
 			compatible = "spidev";
 			reg = <1>;
@@ -129,6 +130,7 @@
 	spi@7000dc00 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
+
 		spidev1: spidev@2 {
 			compatible = "spidev";
 			reg = <2>;
@@ -189,7 +191,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-
 		/* PWM_BKL1 */
 		pwms = <&pwm 0 5000000>;
 		brightness-levels = <255 231 223 207 191 159 127 0>;
@@ -217,7 +218,6 @@
 		 * edt,et070080dh6: EDT 7.0" LCD TFT
 		 */
 		compatible = "edt,et057090dhu", "simple-panel";
-
 		backlight = <&backlight>;
 		power-supply = <&reg_3v3>;
 	};
-- 
2.14.4

