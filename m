Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeB0Wwo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:52:44 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:39584 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeB0WwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:52:01 -0500
X-Google-Smtp-Source: AG47ELt7kxFcy5nTmCpvjyJKXn9++6EfIp+oUVex+oVSiPD/31MOff04UUkrKQEl6bGpN28trp2C8A==
From: Matt Porter <mporter@konsulko.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: add tda7419 audio processor binding
Date: Tue, 27 Feb 2018 17:51:27 -0500
Message-Id: <20180227225128.17815-2-mporter@konsulko.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180227225128.17815-1-mporter@konsulko.com>
References: <20180227225128.17815-1-mporter@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DeviceTree binding for the tda7419 audio processor.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 Documentation/devicetree/bindings/sound/tda7419.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt

diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
new file mode 100644
index 000000000000..919318315600
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda7419.txt
@@ -0,0 +1,15 @@
+TDA7419 audio processor
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "st,tda7419"
+- reg : the I2C address of the device.
+
+Example:
+
+ap: tda7419@44 {
+	compatible = "st,tda7419";
+	reg = <0x44>;
+};
-- 
2.11.0
