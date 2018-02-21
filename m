Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937570AbeBUOtU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:49:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54830 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbeBUOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:49:18 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@chromium.org, gwendal@chromium.org
Subject: [PATCH 0/3] platform/chrome: cros_ec debugfs and sysfs updates
Date: Wed, 21 Feb 2018 15:49:06 +0100
Message-Id: <20180221144909.13461-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is another recopilation of some patches that were send
before but never merged.

First patch was already sent [1] but did not receive feedback so I am
resending it. Needs to go throught platform/chrome tree and can be
picked without dependencies.

The second patch is new, like the first needs to go throught
platform/chrome tree and can be picked without dependecies.

Finally, the third patch was already sent [2] but now needed to be
reworked due the split of the cros_ec_devs in 2 parts [3]. This patch
touches platform/chrome and mfd so we will probably need an immutable
branch when is ok.

Best regards,
  Enric

[1] https://patchwork.kernel.org/patch/9894655/
[2] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1488891.html
[3] https://lkml.org/lkml/2017/11/20/408
 
Gwendal Grignou (2):
  platform/chrome: cros_ec_sysfs: Modify error handling
  platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wake
    lid angle

Shawn Nematbakhsh (1):
  platform/chrome: cros_ec_debugfs: Add PD port info to debugfs

 drivers/mfd/cros_ec_dev.c                 |  19 +++---
 drivers/platform/chrome/cros_ec_debugfs.c |  86 ++++++++++++++++++++++--
 drivers/platform/chrome/cros_ec_sysfs.c   | 108 ++++++++++++++++++++++++------
 include/linux/mfd/cros_ec.h               |   1 +
 4 files changed, 180 insertions(+), 34 deletions(-)

-- 
2.16.1
