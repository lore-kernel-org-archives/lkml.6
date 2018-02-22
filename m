Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeBVKYO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:24:14 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46233 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbeBVKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:24:12 -0500
X-Google-Smtp-Source: AH8x225PjjYOXjwPBGZq2nvCP/5zA9/b84muhqZ0zRcUgheH+kXQ/4DiyDNYhz82EikH2hnRJlU7NA==
From: Rui Miguel Silva <rmfrfs@gmail.com>
X-Google-Original-From: Rui Miguel Silva <rui.silva@linaro.org>
To: mchehab@kernel.org, sakari.ailus@linux.intel.com, hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH 0/2] media: Introduce Omnivision OV2680 driver
Date: Thu, 22 Feb 2018 10:23:36 +0000
Message-Id: <20180222102338.28896-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver and bindings for the OV2680 2 megapixel CMOS 1/5" sensor, which has
a single MIPI lane interface and output format of 10-bit Raw RGB.

Features supported are described in PATCH 2/2.

Cheers,
    Rui

Rui Miguel Silva (2):
  media: ov2680: dt: Add bindings for OV2680
  media: ov2680: Add Omnivision OV2680 sensor driver

 .../devicetree/bindings/media/i2c/ov2680.txt       |   34 +
 drivers/media/i2c/Kconfig                          |   13 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/ov2680.c                         | 1189 ++++++++++++++++++++
 4 files changed, 1237 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov2680.txt
 create mode 100644 drivers/media/i2c/ov2680.c

-- 
2.16.2
