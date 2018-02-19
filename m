Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeBSNqn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:46:43 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36006 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752753AbeBSNqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:46:11 -0500
X-Google-Smtp-Source: AH8x227gHChwtJuPers114lksZOojDzOnMK4YIoVb85qNYUspm0yDTY/TUkQCr+0TfHiC8rlbpzm0A==
From: Neil Armstrong <narmstrong@baylibre.com>
To: broonie@kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] ASoC: Add DT bindings documentation for max9759 amplifier
Date: Mon, 19 Feb 2018 14:45:57 +0100
Message-Id: <1519047958-22583-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519047958-22583-1-git-send-email-narmstrong@baylibre.com>
References: <1519047958-22583-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings documentation for Maxim MAX9759
speaker amplifier.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/sound/maxim,max9759.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9759.txt b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
new file mode 100644
index 0000000..737a996
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
@@ -0,0 +1,18 @@
+Maxim MAX9759 Speaker Amplifier
+===============================
+
+Required properties:
+- compatible : "maxim,max9759"
+- shutdown-gpios : the gpio connected to the shutdown pin
+- mute-gpios : the gpio connected to the mute pin
+- gain-gpios : the 2 gpios connected to the g1 and g2 pins
+
+Example:
+
+max9759: analog-amplifier {
+	compatible = "maxim,max9759";
+	shutdown-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+	mute-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+	gain-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>,
+		     <&gpio3 25 GPIO_ACTIVE_LOW>;
+};
-- 
2.7.4
