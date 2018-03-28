Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeC1CUc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:20:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC1CUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:20:31 -0400
From: Mark Brown <broonie@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Garlic Tseng <garlic.tseng@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: remove "simple-mfd" in the example" to the asoc tree
In-Reply-To: <79b79aa29ea14e6f851ad01ed1f5a33543b05040.1522114156.git.ryder.lee@mediatek.com>
Message-Id: <20180328022017.BA9C844007A@finisterre.ee.mobilebroadband>
Date: Wed, 28 Mar 2018 03:20:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: remove "simple-mfd" in the example

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

>From de2404701469a7e8d557b8d7b4d35bda5b262cac Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Tue, 27 Mar 2018 09:32:25 +0800
Subject: [PATCH] ASoC: mediatek: remove "simple-mfd" in the example

Remove compatible string "simple-mfd" in the example as we have
already added devm_of_platform_populate() in the parent driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 6df87b97f7cb..e2f7f4951215 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -53,7 +53,7 @@ See ../arm/mediatek/mediatek,audsys.txt for details about the parent node.
 Example:
 
 	audsys: audio-subsystem@11220000 {
-		compatible = "mediatek,mt2701-audsys", "syscon", "simple-mfd";
+		compatible = "mediatek,mt2701-audsys", "syscon";
 		...
 
 		afe: audio-controller {
-- 
2.16.2
