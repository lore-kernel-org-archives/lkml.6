Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeFBSip (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 14:38:45 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33051 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeFBSim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 14:38:42 -0400
X-Google-Smtp-Source: ADUXVKIJLzHa4POM01xMF6P0GFjZlmqkv36ON4jcaCYQ94jAOnlUfIMb6RkuDF1G7OFTp6tFifmqrw==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v3 1/5] staging: mt7621-spi: Indent case labels and switch at the same level.
Date: Sun,  3 Jun 2018 00:07:27 +0530
Message-Id: <20180602183731.12395-2-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180602183731.12395-1-sankalpnegi2310@gmail.com>
References: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com>
 <20180602183731.12395-1-sankalpnegi2310@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes following checkpatch.pl issue:
ERROR : switch and case should be at the same indent

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index 37f299080410..b268084b6cd1 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -138,17 +138,17 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 
 	reg &= ~(MT7621_CPHA | MT7621_CPOL);
 	switch(spi->mode & (SPI_CPOL | SPI_CPHA)) {
-		case SPI_MODE_0:
-			break;
-		case SPI_MODE_1:
-			reg |= MT7621_CPHA;
-			break;
-		case SPI_MODE_2:
-			reg |= MT7621_CPOL;
-			break;
-		case SPI_MODE_3:
-			reg |= MT7621_CPOL | MT7621_CPHA;
-			break;
+	case SPI_MODE_0:
+		break;
+	case SPI_MODE_1:
+		reg |= MT7621_CPHA;
+		break;
+	case SPI_MODE_2:
+		reg |= MT7621_CPOL;
+		break;
+	case SPI_MODE_3:
+		reg |= MT7621_CPOL | MT7621_CPHA;
+		break;
 	}
 	mt7621_spi_write(rs, MT7621_SPI_MASTER, reg);
 
-- 
2.11.0
