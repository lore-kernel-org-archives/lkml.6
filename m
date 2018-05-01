Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756652AbeEAS7c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:59:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43314 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756727AbeEAS6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:48 -0400
X-Google-Smtp-Source: AB8JxZqNwYMUylvAGbYAcIeo/YS1Dvn3xyu5FYQSVYFPb2VgHeLiwF78xWjfuVcvF/gAOF1b8oIaVg==
From: Anand Moon <linux.amoon@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM64: dts: meson-gxbb: odroidc2: enable sdcard UHS modes
Date: Wed,  2 May 2018 00:29:01 +0530
Message-Id: <20180501185902.3556-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable UHS modes for sdcard, on odroidc2.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 54954b314a45..c90f8b46c60c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -258,6 +258,11 @@
 	cap-sd-highspeed;
 	max-frequency = <100000000>;
 	disable-wp;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
-- 
2.17.0
