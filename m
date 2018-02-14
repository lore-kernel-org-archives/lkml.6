Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031712AbeBNWHy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:07:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031658AbeBNWHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:07:51 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Wed, 14 Feb 2018 23:07:38 +0100
Message-Id: <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motorola CPCAP is a PMIC with audio functionality, that can be
found on Motorola Droid 4 and probably a few other phones from
Motorola's Droid series.

This adds the DT binding for the codec sub-module found inside
the PMIC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../bindings/sound/motorola,cpcap-audio-codec.txt       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt b/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
new file mode 100644
index 000000000000..a6b64132b545
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
@@ -0,0 +1,17 @@
+Motorola CPCAP audio CODEC
+--------------------------
+
+This module is part of the CPCAP. For more details about the whole
+chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
+
+Required properties:
+
+  - compatible : "motorola,cpcap-audio-codec"
+
+Example:
+
+&cpcap {
+	audio-codec {
+		compatible = "motorola,cpcap-audio-codec";
+	};
+};
-- 
2.15.1
