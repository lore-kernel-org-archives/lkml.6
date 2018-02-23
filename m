Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933414AbeBWUDT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:03:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38286 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbeBWUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:16 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv5 4/5] ARM: dts: motorola-cpcap-mapphone: add audio-codec
Date: Fri, 23 Feb 2018 21:02:53 +0100
Message-Id: <20180223200254.25685-5-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for audio-codec to its DT file.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index 4d61e5b1334a..ddc7a7bb33c0 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -68,6 +68,19 @@
 			};
 		};
 
+		cpcap_audio: audio-codec {
+			#sound-dai-cells = <1>;
+
+			port@0 {
+				cpcap_audio_codec0: endpoint {
+				};
+			};
+			port@1 {
+				cpcap_audio_codec1: endpoint {
+				};
+			};
+		};
+
 		cpcap_rtc: rtc {
 			compatible = "motorola,cpcap-rtc";
 
-- 
2.16.1
