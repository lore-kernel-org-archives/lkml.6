Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeD1WD7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 18:03:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46496 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeD1WD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 18:03:57 -0400
From: Colin King <colin.king@canonical.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] dmaengine: stm32-mdma: fix spelling mistake: "avalaible" -> "available"
Date: Sat, 28 Apr 2018 23:03:52 +0100
Message-Id: <20180428220352.19601-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message text and make
channel plural.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 1ac775f93d9e..90d9f6bd905b 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1521,7 +1521,7 @@ static struct dma_chan *stm32_mdma_of_xlate(struct of_phandle_args *dma_spec,
 
 	c = dma_get_any_slave_channel(&dmadev->ddev);
 	if (!c) {
-		dev_err(mdma2dev(dmadev), "No more channel avalaible\n");
+		dev_err(mdma2dev(dmadev), "No more channels available\n");
 		return NULL;
 	}
 
-- 
2.17.0
