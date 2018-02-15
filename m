Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbeBOKMQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:12:16 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41020 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeBOKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:12:14 -0500
X-Google-Smtp-Source: AH8x226AnDe6kaHx4EHHJcW/RQ+gXq4sUOz0GjmQwMb8E2KAS8uuBAL1KO1sLhxqepIYmj2spQfx9Q==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-axg: add sec_AO system controller
Date: Thu, 15 Feb 2018 11:12:07 +0100
Message-Id: <20180215101207.19186-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the secure AO system controller with chipid enabled

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 880e25b113c1..7f4c00216b82 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -836,6 +836,12 @@
 				};
 			};
 
+			sec_AO: ao-secure@140 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x140 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
 			pwm_AO_ab: pwm@7000 {
 				compatible = "amlogic,meson-axg-ao-pwm";
 				reg = <0x0 0x07000 0x0 0x20>;
-- 
2.14.3
