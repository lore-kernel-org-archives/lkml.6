Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeFBSi6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 14:38:58 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34358 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeFBSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 14:38:55 -0400
X-Google-Smtp-Source: ADUXVKLjT+vZYnw5J4xPAKlfNcKFWVpgTznZViRCFH/125jdIFDCtu9scNYuMRXWfdqxEwfci/DtWQ==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v3 3/5] staging: mt7621-spi: Use tabs for indentation instead of spaces.
Date: Sun,  3 Jun 2018 00:07:29 +0530
Message-Id: <20180602183731.12395-4-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180602183731.12395-1-sankalpnegi2310@gmail.com>
References: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com>
 <20180602183731.12395-1-sankalpnegi2310@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes following checkpatch.pl issue:
ERROR : code indent should use tabs where possible

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index 910dbdb8a003..f7620a988a08 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -105,7 +105,7 @@ static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
 	int cs = spi->chip_select;
 	u32 polar = 0;
 
-        mt7621_spi_reset(rs, cs);
+	mt7621_spi_reset(rs, cs);
 	if (enable)
 		polar = BIT(cs);
 	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
-- 
2.11.0
