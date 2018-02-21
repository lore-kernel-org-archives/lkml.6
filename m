Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937407AbeBUOFl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:05:41 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44269 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933135AbeBUOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:05:38 -0500
X-Google-Smtp-Source: AH8x227iyIfYTa7zcQSXLLFFBSpVOsgxu4IJI4gsBzdyXawcfuScWr7ANn/IPg0vL92bqlD33W/iHA==
Date: Wed, 21 Feb 2018 11:05:33 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio:dummy: Fix coding style in simple_dummy and evgen
Message-ID: <20180221140533.lll6vbwg3gyjrlvi@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warnings:

drivers/iio/dummy/iio_simple_dummy.c:603: WARNING: Block comments should
align the * on each line
drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
'S_IWUSR' are not preferred. Consider using octal permissions '0200'...
drivers/iio/dummy/iio_simple_dummy.c:693: CHECK: Please use a blank line
after function/struct/union/enum declarations

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/iio/dummy/iio_dummy_evgen.c  | 20 ++++++++++----------
 drivers/iio/dummy/iio_simple_dummy.c |  3 ++-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index efd0005f59b4..16ea547f79f0 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -148,16 +148,16 @@ static ssize_t iio_evgen_poke(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(poke_ev0, S_IWUSR, NULL, &iio_evgen_poke, 0);
-static IIO_DEVICE_ATTR(poke_ev1, S_IWUSR, NULL, &iio_evgen_poke, 1);
-static IIO_DEVICE_ATTR(poke_ev2, S_IWUSR, NULL, &iio_evgen_poke, 2);
-static IIO_DEVICE_ATTR(poke_ev3, S_IWUSR, NULL, &iio_evgen_poke, 3);
-static IIO_DEVICE_ATTR(poke_ev4, S_IWUSR, NULL, &iio_evgen_poke, 4);
-static IIO_DEVICE_ATTR(poke_ev5, S_IWUSR, NULL, &iio_evgen_poke, 5);
-static IIO_DEVICE_ATTR(poke_ev6, S_IWUSR, NULL, &iio_evgen_poke, 6);
-static IIO_DEVICE_ATTR(poke_ev7, S_IWUSR, NULL, &iio_evgen_poke, 7);
-static IIO_DEVICE_ATTR(poke_ev8, S_IWUSR, NULL, &iio_evgen_poke, 8);
-static IIO_DEVICE_ATTR(poke_ev9, S_IWUSR, NULL, &iio_evgen_poke, 9);
+static IIO_DEVICE_ATTR(poke_ev0, 0200, NULL, &iio_evgen_poke, 0);
+static IIO_DEVICE_ATTR(poke_ev1, 0200, NULL, &iio_evgen_poke, 1);
+static IIO_DEVICE_ATTR(poke_ev2, 0200, NULL, &iio_evgen_poke, 2);
+static IIO_DEVICE_ATTR(poke_ev3, 0200, NULL, &iio_evgen_poke, 3);
+static IIO_DEVICE_ATTR(poke_ev4, 0200, NULL, &iio_evgen_poke, 4);
+static IIO_DEVICE_ATTR(poke_ev5, 0200, NULL, &iio_evgen_poke, 5);
+static IIO_DEVICE_ATTR(poke_ev6, 0200, NULL, &iio_evgen_poke, 6);
+static IIO_DEVICE_ATTR(poke_ev7, 0200, NULL, &iio_evgen_poke, 7);
+static IIO_DEVICE_ATTR(poke_ev8, 0200, NULL, &iio_evgen_poke, 8);
+static IIO_DEVICE_ATTR(poke_ev9, 0200, NULL, &iio_evgen_poke, 9);
 
 static struct attribute *iio_evgen_attrs[] = {
 	&iio_dev_attr_poke_ev0.dev_attr.attr,
diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 62052479c349..fcfc38d4bd93 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -599,7 +599,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 * indio_dev->dev.parent = &client->dev;
 	 */
 
-	 /*
+	/*
 	 * Make the iio_dev struct available to remove function.
 	 * Bus equivalents
 	 * i2c_set_clientdata(client, indio_dev);
@@ -690,6 +690,7 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
 
 	return 0;
 }
+
 /**
  * module_iio_sw_device_driver() -  device driver registration
  *
-- 
2.16.2
