Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeCUOap (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:30:45 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42132 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbeCUOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:30:36 -0400
X-Google-Smtp-Source: AG47ELsGqKh0LOFxyQFCTOvFesJlyrEylPTDK7x00HybCHm9VKlOywhdfmpYp1OkAglh1JH/NAfiRQ==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 10/11] staging: iio: ad7746: Rename sysfs attrs to comply with the ABI
Date: Wed, 21 Mar 2018 11:28:58 -0300
Message-Id: <1521642539-4845-11-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index b6b99e2..c1f76fc 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -336,16 +336,16 @@ static ssize_t ad7746_start_gain_calib(struct device *dev,
 				  AD7746_CONF_MODE_GAIN_CAL);
 }
 
-static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
-		       0200, NULL, ad7746_start_offset_calib, CIN1);
-static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
-		       0200, NULL, ad7746_start_offset_calib, CIN2);
-static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
-		       0200, NULL, ad7746_start_gain_calib, CIN1);
-static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
-		       0200, NULL, ad7746_start_gain_calib, CIN2);
-static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
-		       0200, NULL, ad7746_start_gain_calib, VIN);
+static IIO_DEVICE_ATTR(in_capacitance0_calibbias, 0200, NULL,
+		       ad7746_start_offset_calib, CIN1);
+static IIO_DEVICE_ATTR(in_capacitance1_calibbias, 0200, NULL,
+		       ad7746_start_offset_calib, CIN2);
+static IIO_DEVICE_ATTR(in_capacitance0_calibscale, 0200, NULL,
+		       ad7746_start_gain_calib, CIN1);
+static IIO_DEVICE_ATTR(in_capacitance1_calibscale, 0200, NULL,
+		       ad7746_start_gain_calib, CIN2);
+static IIO_DEVICE_ATTR(in_voltage0_calibscale, 0200, NULL,
+		       ad7746_start_gain_calib, VIN);
 
 static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
 					      int val)
@@ -388,11 +388,11 @@ static IIO_CONST_ATTR(in_capacitance_sampling_frequency_available,
 		       "91 84 50 26 16 13 11 9");
 
 static struct attribute *ad7746_attributes[] = {
-	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
-	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_calibbias.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_calibscale.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_calibscale.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_calibbias.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_calibscale.dev_attr.attr,
 	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
 	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.attr,
 	NULL,
-- 
2.7.4
