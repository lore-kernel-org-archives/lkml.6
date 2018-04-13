Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637504; cv=none;
        d=google.com; s=arc-20160816;
        b=UTUjoVR0QZ3Ns8UjGiH87lbVw/LnLjObX5mTl/GwcXLhZSpJr5G02ENHkVwW3tYMEx
         SIgh6ge+aITFKcFIsJ36/aGTLfXGJtTktLohKBTOXSTycFA79prInYnG2HjICRgMvVk/
         EoBmUcho+bLALYk3Fs18AgFGI9q4BjFzIDKU1cKa/Wg4pGnzCZwdiqtYniGrJi0j4fhO
         gAfl/D7e1XkSo0nIuTKkSp2n6L9blqCi66QKL5oPlrWu1kCnpYpt+ZDrr6sDLNbidb+T
         v6aNdS++MIxs6j/DKByOay5YaLdf8OgYJFz2gEWloNhUWcKUky99nj3+W4TklMgVMJnK
         kMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=55xgRXM2dPdkR45O6cLT3rlu9dkWrcUuZxkQn60EN8o=;
        b=TZtZjrO3ILjk2xkEy7IbQ18pyE/HyVrFjpD6xSXhRzqBGjvLFXe4OQKOGjBVubONKD
         vstIqOKf1gtoNwEWjZXInWio5fmfx0Cow75zsUaFrYiNpxTTpgtF6uJmq6UuNvhftR4V
         OBwmzZVzINApdCLXKJp1jOIk2AL7uYoG7bBOoEWT0z9rWd6GBQ8PV738brR8saAkb4m4
         ThQsPgLOa13q1XCcWIsiCObwxELk2cKy+IJmaQZfQEPCEOTNfjvRgRzxX7DB8BkDsVxY
         lWeRyRJ4JeMyedXV6gdzomdniSGBAufJy2AAOX3mh4niUvj6PXE/gd3TwP2+RGCMBKyL
         YMdw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=Kd81A6bN;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=Kd81A6bN;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx49nsDXPpjmsDkSZcdNno+lmJ0BkQKQeVQmDdKAvVvZB8/UaBwvU46qpzsbeFmQpSzMFQ1/6gg==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 07/14] staging: iio: ad7746: Remove unused defines
Date: Fri, 13 Apr 2018 13:36:44 -0300
Message-Id: <1523637411-8531-8-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649719888371800?=
X-GMAIL-MSGID: =?utf-8?q?1597649719888371800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 7 -------
 drivers/staging/iio/cdc/ad7746.h | 5 -----
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index f53612a..d39ab34 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -25,7 +25,6 @@
  * AD7746 Register Definition
  */
 
-#define AD7746_REG_STATUS		0
 #define AD7746_REG_CAP_DATA_HIGH	1
 #define AD7746_REG_VT_DATA_HIGH		4
 #define AD7746_REG_CAP_SETUP		7
@@ -38,12 +37,6 @@
 #define AD7746_REG_CAP_GAINH		15
 #define AD7746_REG_VOLT_GAINH		17
 
-/* Status Register Bit Designations (AD7746_REG_STATUS) */
-#define AD7746_STATUS_EXCERR		BIT(3)
-#define AD7746_STATUS_RDY		BIT(2)
-#define AD7746_STATUS_RDYVT		BIT(1)
-#define AD7746_STATUS_RDYCAP		BIT(0)
-
 /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
 #define AD7746_CAPSETUP_CAPEN		BIT(7)
 #define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
index ea8572d..2fbcee8 100644
--- a/drivers/staging/iio/cdc/ad7746.h
+++ b/drivers/staging/iio/cdc/ad7746.h
@@ -13,11 +13,6 @@
  * TODO: struct ad7746_platform_data needs to go into include/linux/iio
  */
 
-#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
-#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
-#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
-#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
-
 struct ad7746_platform_data {
 	unsigned char exclvl;	/*Excitation Voltage Level */
 	bool exca_en;		/* enables EXCA pin as the excitation output */
-- 
2.7.4
