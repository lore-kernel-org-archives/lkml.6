Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeFBO1o (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:27:44 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44387 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbeFBO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:27:41 -0400
X-Google-Smtp-Source: ADUXVKJh9moGew8otStseu189sEUOuZRv2UUf9/uMikHH9OElXucvE6fc9PhS19sfL0M7WxGOcbr0g==
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        neil@brown.name, sankalpnegi2310@gmail.com
Subject: [PATCH v2 5/5] staging: mt7621-spi: Fix Coding style issues reported by checkpatch.pl.
Date: Sat,  2 Jun 2018 19:56:05 +0530
Message-Id: <20180602142605.6846-6-sankalpnegi2310@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180602142605.6846-1-sankalpnegi2310@gmail.com>
References: <20180601091553.GA5821@kroah.com>
 <20180602142605.6846-1-sankalpnegi2310@gmail.com>
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
