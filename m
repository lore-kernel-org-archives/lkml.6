Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeC2OzM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:55:12 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:39403 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeC2OzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:55:10 -0400
X-Google-Smtp-Source: AIpwx494AaJlqL24dkZI24v0xx20omIaLnoS1KQDPjOEF/MaVvIArocX7Of/nDp9Of11Uzw/83pMuA==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: slongerbeam@gmail.com, mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: todor.tomov@linaro.org, nicolas.dechesne@linaro.org,
        dragonboard@lists.96boards.org, loic.poulain@linaro.org,
        daniel.thompson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH] Add pixel clock support to OV5640 camera sensor
Date: Thu, 29 Mar 2018 20:24:59 +0530
Message-Id: <1522335300-13467-1-git-send-email-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the camera subsystems like camss in Qualcommm MSM chipsets
require pixel clock support in camera sensor drivers for proper functioning.
So, add a default pixel clock rate of 96MHz to OV5640 camera sensor driver.

According to the datasheet, 96MHz can be used as a pixel clock rate for
most of the modes.

This patch has been validated on Dragonboard410c with OV5640 connected
using D3 Camera Mezzanine.

Manivannan Sadhasivam (1):
  media: i2c: ov5640: Add pixel clock support

 drivers/media/i2c/ov5640.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.7.4
