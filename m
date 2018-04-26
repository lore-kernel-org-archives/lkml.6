Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756554AbeDZOTc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:19:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40992 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756425AbeDZOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:19:28 -0400
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: add MT7622 AFE compatible in documentation" to the asoc tree
In-Reply-To: <43bf5fcef0edefef2524122e64400785243f4fdf.1524628914.git.ryder.lee@mediatek.com>
Message-Id: <E1fBhk4-00042f-DB@debutante>
Date: Thu, 26 Apr 2018 15:19:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: add MT7622 AFE compatible in documentation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eaeb4194de9c843742f421daa858f27e7c89a625 Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Wed, 25 Apr 2018 12:19:58 +0800
Subject: [PATCH] ASoC: mediatek: add MT7622 AFE compatible in documentation

Add support for MT7622 AFE which shares the same binding with MT2701.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index e2f7f4951215..560762e0a168 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -1,7 +1,9 @@
 Mediatek AFE PCM controller for mt2701
 
 Required properties:
-- compatible = "mediatek,mt2701-audio";
+- compatible: should be one of the followings.
+	      - "mediatek,mt2701-audio"
+	      - "mediatek,mt7622-audio"
 - interrupts: should contain AFE and ASYS interrupts
 - interrupt-names: should be "afe" and "asys"
 - power-domains: should define the power domain
-- 
2.17.0
