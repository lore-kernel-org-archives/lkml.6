Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeENRQB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:16:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33628 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754242AbeENRP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:15:57 -0400
From: Colin King <colin.king@canonical.com>
To: Wolfram Sang <wsa@the-dreams.de>, Moritz Fischer <mdf@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-i2c@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: xiic: fix spelling mistake: "unexpexted" -> "unexpected"
Date: Mon, 14 May 2018 18:15:52 +0100
Message-Id: <20180514171552.25094-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in dev_dbg messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i2c/busses/i2c-xiic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index c80527816ad0..92def988d3c7 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -415,7 +415,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 		clr |= XIIC_INTR_RX_FULL_MASK;
 		if (!i2c->rx_msg) {
 			dev_dbg(i2c->adap.dev.parent,
-				"%s unexpexted RX IRQ\n", __func__);
+				"%s unexpected RX IRQ\n", __func__);
 			xiic_clear_rx_fifo(i2c);
 			goto out;
 		}
@@ -470,7 +470,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 
 		if (!i2c->tx_msg) {
 			dev_dbg(i2c->adap.dev.parent,
-				"%s unexpexted TX IRQ\n", __func__);
+				"%s unexpected TX IRQ\n", __func__);
 			goto out;
 		}
 
-- 
2.17.0
