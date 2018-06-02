Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeFBSiv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 14:38:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39459 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeFBSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 14:38:49 -0400
X-Google-Smtp-Source: ADUXVKJMpKWvilqBc/YshZLf4ku6SKmSt4Vb6+EdmXWQ9USwiRtlzofhMROxg4ZBZjQm+xCbVtVlHQ==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v3 2/5] staging: mt7621-spi: Fix line over 80 characters by refactoring.
Date: Sun,  3 Jun 2018 00:07:28 +0530
Message-Id: <20180602183731.12395-3-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180602183731.12395-1-sankalpnegi2310@gmail.com>
References: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com>
 <20180602183731.12395-1-sankalpnegi2310@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes following checkpatch.pl issue:
WARNING : line over 80 characters

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index b268084b6cd1..910dbdb8a003 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -55,7 +55,8 @@
 #define MT7621_CPOL		BIT(4)
 #define MT7621_LSB_FIRST	BIT(3)
 
-#define RT2880_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH)
+#define RT2880_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA |		\
+				 SPI_LSB_FIRST | SPI_CS_HIGH)
 
 struct mt7621_spi;
 
-- 
2.11.0
