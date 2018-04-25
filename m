Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbeDYEVP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:21:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19163 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751336AbeDYEUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:20:09 -0400
X-UUID: 34d1f1704c8e40b2aaa247395d6650e6-20180425
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Garlic Tseng <garlic.tseng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 5/6] ASoC: mediatek: add MT7622 AFE compatible in documentation
Date: Wed, 25 Apr 2018 12:19:58 +0800
Message-ID: <43bf5fcef0edefef2524122e64400785243f4fdf.1524628914.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
References: <07e845c2e7eb06c5f284d1bae3acbccba42e48fa.1524628914.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT7622 AFE which shares the same binding with MT2701.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index e2f7f49..560762e 100644
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
1.9.1
