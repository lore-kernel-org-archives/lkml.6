Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeFBO1g (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:27:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45875 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbeFBO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:27:34 -0400
X-Google-Smtp-Source: ADUXVKKkt2DA/Eitvnzcb8hTF9ZNuTe2PS3WFD9A3dRUyPu2nr6y5W2jkfiKSKEdS/suV2mpHpeLnw==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v2 4/5] staging: mt7621-spi: Fix Coding style issues reported by checkpatch.pl.
Date: Sat,  2 Jun 2018 19:56:04 +0530
Message-Id: <20180602142605.6846-5-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180602142605.6846-1-sankalpnegi2310@gmail.com>
References: <20180601091553.GA5821@kroah.com>
 <20180602142605.6846-1-sankalpnegi2310@gmail.com>
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
