Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeFBSjE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 14:39:04 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45109 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeFBSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 14:39:01 -0400
X-Google-Smtp-Source: ADUXVKL4N1DhtNsRvn6csao5Y4ZkRuN3ipGN+sEHohEOKDBAIvs7gaJaEF8DgEybIdHHtdnzxR7Omg==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v3 4/5] staging: mt7621-spi: Add a space before open paranthesis.
Date: Sun,  3 Jun 2018 00:07:30 +0530
Message-Id: <20180602183731.12395-5-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180602183731.12395-1-sankalpnegi2310@gmail.com>
References: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com>
 <20180602183731.12395-1-sankalpnegi2310@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes following checkpatch.pl issue:
ERROR : space required before the open parenthesis

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index f7620a988a08..472f72479162 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -138,7 +138,7 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 		reg |= MT7621_LSB_FIRST;
 
 	reg &= ~(MT7621_CPHA | MT7621_CPOL);
-	switch(spi->mode & (SPI_CPOL | SPI_CPHA)) {
+	switch (spi->mode & (SPI_CPOL | SPI_CPHA)) {
 	case SPI_MODE_0:
 		break;
 	case SPI_MODE_1:
-- 
2.11.0
