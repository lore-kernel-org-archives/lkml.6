Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeFBSjK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 14:39:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32853 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeFBSjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 14:39:07 -0400
X-Google-Smtp-Source: ADUXVKLd6ad/NoEDfkXoRip7m4YLgB277mItUqSRDMTxmkPDdlaD6Uq85atnfaui3KC8yMvf3gDrCw==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v3 5/5] staging: mt7621-spi: Remove unnecessary braces {} from single statement if block.
Date: Sun,  3 Jun 2018 00:07:31 +0530
Message-Id: <20180602183731.12395-6-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180602183731.12395-1-sankalpnegi2310@gmail.com>
References: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com>
 <20180602183731.12395-1-sankalpnegi2310@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes following checkpatch.pl issue:
WARNING : braces {} are not necessary for single statement blocks

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index 472f72479162..cf5b5d7c3cf9 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -165,9 +165,8 @@ static inline int mt7621_spi_wait_till_ready(struct spi_device *spi)
 		u32 status;
 
 		status = mt7621_spi_read(rs, MT7621_SPI_TRANS);
-		if ((status & SPITRANS_BUSY) == 0) {
+		if ((status & SPITRANS_BUSY) == 0)
 			return 0;
-		}
 		cpu_relax();
 		udelay(1);
 	}
-- 
2.11.0
