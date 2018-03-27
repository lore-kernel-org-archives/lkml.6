Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeC0Bcf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:32:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39063 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751489AbeC0Bcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:32:33 -0400
X-UUID: 9e3b00208360457ebea809f88188ef25-20180327
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alsa-devel@alsa-project.org>,
        "Garlic Tseng" <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] ASoC: mediatek: remove "simple-mfd" in the example
Date: Tue, 27 Mar 2018 09:32:25 +0800
Message-ID: <79b79aa29ea14e6f851ad01ed1f5a33543b05040.1522114156.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23744.000
X-TM-AS-Result: No-0.891200-8.000000-10
X-TMASE-MatchedRID: Cd0SClLzsE8INDt+6yf1XG3NvezwBrVmFuNF4lJG6xtcU0dNErOD+ugV
        4TkxLE0x4vM1YF6AJbbGJQ3BiiLAggtuKBGekqUpm+MB6kaZ2g6qJYCGOgfgK0NqTLiQLGdVotj
        xVwMB0QkCv/Cfpb0atxTUT+FklfEsdEGrDUQz9jy3MjlpMfzU113TthyZ8eNaTL2vK69m107kA8
        OrYHdwDGfYlY/yoV/0Up6EHOb2+c7kHZDO53QSwjflzkGcoK72
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.891200-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23744.000
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove compatible string "simple-mfd" in the example as we have
already added devm_of_platform_populate() in the parent driver.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 6df87b9..e2f7f49 100644
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
1.9.1
