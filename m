Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031784AbeBNWID (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:08:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51842 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031715AbeBNWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:07:58 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 3/4] ARM: dts: motorola-cpcap-mapphone: add audio-codec
Date: Wed, 14 Feb 2018 23:07:40 +0100
Message-Id: <20180214220741.28306-4-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for audio-codec to its DT file.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index 4d61e5b1334a..69ff53e5702d 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -68,6 +68,11 @@
 			};
 		};
 
+		cpcap_audio: audio-codec {
+			#sound-dai-cells = <1>;
+			compatible = "motorola,cpcap-audio-codec";
+		};
+
 		cpcap_rtc: rtc {
 			compatible = "motorola,cpcap-rtc";
 
-- 
2.15.1
