Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeCUOaN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:30:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36999 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeCUOaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:30:04 -0400
X-Google-Smtp-Source: AG47ELv5b3aWFPjqxijbIOzZo4TRzB+VwT0q+gKIoyKR4jyLFH6NpKhAl3d5Fd37zCIXmNsPATyl8Q==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 03/11] staging: iio: ad7746: Reorder includes alphabetically
Date: Wed, 21 Mar 2018 11:28:51 -0300
Message-Id: <1521642539-4845-4-git-send-email-hernan@vanguardiasur.com.ar>
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
 drivers/staging/iio/cdc/ad7746.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 557ed4d..86919e8 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -6,15 +6,15 @@
  * Licensed under the GPL-2.
  */
 
-#include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/i2c.h>
-#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/stat.h>
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.7.4
