Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCUKYT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:24:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44918 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeCUKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:24:18 -0400
From: Colin King <colin.king@canonical.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: dw-axi-dmac: fix spelling mistake: "catched" -> "caught"
Date: Wed, 21 Mar 2018 10:24:13 +0000
Message-Id: <20180321102413.29621-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index dbe7312c15c6..c4eb55e3011c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -574,7 +574,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
-		dev_err(chan2dev(chan), "BUG: %s catched DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
+		dev_err(chan2dev(chan), "BUG: %s caught DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
 			axi_chan_name(chan));
 		axi_chan_disable(chan);
 	}
-- 
2.15.1
