Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeCUO35 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:29:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41456 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbeCUO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:29:51 -0400
X-Google-Smtp-Source: AG47ELt4OlBCgPN1c0zQo6SPDlVKZNHDDe2I30Vn9kA1tWxSpYMuSQ6LeqKLxbUIZGkFsUeXcM01Tw==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 01/11] staging: iio: ad7746: Adjust arguments to match open parenthesis
Date: Wed, 21 Mar 2018 11:28:49 -0300
Message-Id: <1521642539-4845-2-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear two more checkpatch.pl CHECKS.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 4882dbc..02e3164 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -463,7 +463,8 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 		ret = i2c_smbus_write_word_data(chip->client,
-				AD7746_REG_CAP_OFFH, swab16(val));
+						AD7746_REG_CAP_OFFH,
+						swab16(val));
 		if (ret < 0)
 			goto out;
 
@@ -556,7 +557,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		/* Now read the actual register */
 
 		ret = i2c_smbus_read_i2c_block_data(chip->client,
-			chan->address >> 8, 3, &chip->data.d8[1]);
+						    chan->address >> 8, 3,
+						    &chip->data.d8[1]);
 
 		if (ret < 0)
 			goto out;
-- 
2.7.4
