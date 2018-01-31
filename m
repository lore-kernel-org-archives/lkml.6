Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeAaHm5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:42:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45290 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753141AbeAaHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:42:52 -0500
X-UUID: da0fefc8d3c84ce9878f66c82b619306-20180131
From: Ryder Lee <ryder.lee@mediatek.com>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Garlic Tseng <garlic.tseng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/5] clk: mediatek: update missing clock data for MT7622 audsys
Date: Wed, 31 Jan 2018 15:42:41 +0800
Message-ID: <ec2dfe750291a996c54cc8aaeafafa333b992c4f.1515639336.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1515639336.git.ryder.lee@mediatek.com>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing clock data 'CLK_AUDIO_AFE_CONN' for MT7622 audsys.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c  | 1 +
 include/dt-bindings/clock/mt7622-clk.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index fad7d9f..13f752d 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -106,6 +106,7 @@
 	GATE_AUDIO1(CLK_AUDIO_INTDIR, "audio_intdir", "intdir_sel", 20),
 	GATE_AUDIO1(CLK_AUDIO_A1SYS, "audio_a1sys", "a1sys_hp_sel", 21),
 	GATE_AUDIO1(CLK_AUDIO_A2SYS, "audio_a2sys", "a2sys_hp_sel", 22),
+	GATE_AUDIO1(CLK_AUDIO_AFE_CONN, "audio_afe_conn", "a1sys_hp_sel", 23),
 	/* AUDIO2 */
 	GATE_AUDIO2(CLK_AUDIO_UL1, "audio_ul1", "a1sys_hp_sel", 0),
 	GATE_AUDIO2(CLK_AUDIO_UL2, "audio_ul2", "a1sys_hp_sel", 1),
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 3e514ed..e9d77f0 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -235,7 +235,8 @@
 #define CLK_AUDIO_MEM_ASRC3		43
 #define CLK_AUDIO_MEM_ASRC4		44
 #define CLK_AUDIO_MEM_ASRC5		45
-#define CLK_AUDIO_NR_CLK		46
+#define CLK_AUDIO_AFE_CONN		46
+#define CLK_AUDIO_NR_CLK		47
 
 /* SSUSBSYS */
 
-- 
1.9.1
