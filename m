Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeFBO1M (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:27:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36763 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeFBO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:27:11 -0400
X-Google-Smtp-Source: ADUXVKLXanGbbO7AiSVhje6wOrXRBU/1dXyqv6RuzeyYIZAx/O8yWyE44RJC5C3jkq4cGVTwHkVb9Q==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v2 1/5] staging: mt7621-spi: Fix Coding style issues reported by checkpatch.pl.
Date: Sat,  2 Jun 2018 19:56:01 +0530
Message-Id: <20180602142605.6846-2-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180602142605.6846-1-sankalpnegi2310@gmail.com>
References: <20180601091553.GA5821@kroah.com>
 <20180602142605.6846-1-sankalpnegi2310@gmail.com>
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
