Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBC9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA4D21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeLROjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:39:48 -0500
Received: from mail.ltec.ch ([95.143.48.181]:40364 "EHLO mail.ltec.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeLROjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:39:48 -0500
Received: from nebula.ltec ([172.27.11.2] helo=vm64.ltec)
        by mail.ltec.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <fb@ltec.ch>)
        id 1gZGX9-0005FQ-8e; Tue, 18 Dec 2018 15:39:43 +0100
From:   Felix Brack <fb@ltec.ch>
To:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tony@atomide.com, bcousson@baylibre.com, mpfj@newflow.co.uk,
        mark.rutland@arm.com, robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, Felix Brack <fb@ltec.ch>
Subject: [PATCH: linux-next] ARM: dts: am33xx: Remove unnecessary properties
Date:   Tue, 18 Dec 2018 15:39:31 +0100
Message-Id: <20181218143931.4151-1-fb@ltec.ch>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary properties #address-cells and #size-cells
of node pinmux as there are no child-nodes with property reg.

Signed-off-by: Felix Brack <fb@ltec.ch>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 7b818d9d2eab..e957370f8aec 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -288,8 +288,6 @@
 				am33xx_pinmux: pinmux@800 {
 					compatible = "pinctrl-single";
 					reg = <0x800 0x238>;
-					#address-cells = <1>;
-					#size-cells = <0>;
 					#pinctrl-cells = <1>;
 					pinctrl-single,register-width = <32>;
 					pinctrl-single,function-mask = <0x7f>;
-- 
2.17.1

