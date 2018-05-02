Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeEBJ5N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:57:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36080 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeEBJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:57:09 -0400
X-Google-Smtp-Source: AB8JxZrYrYCmzAQQA+/8hDNtqfzz4V5zQUM2/yfT+GhRDJFMMNtmSoSip/SXjWKDnl86WSkzYCR98w==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Suman Anna <s-anna@ti.com>, Aparna Balasubramanian <aparnab@ti.com>,
        Kevin Hilman <khilman@kernel.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] remoteproc/davinci: common clock framework related fixes
Date: Wed,  2 May 2018 11:56:56 +0200
Message-Id: <20180502095659.3626-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Bjorn,

this series contains the patches from my previous remoteproc series[1]
which are safe to apply on top of 4.17-rc1. They contain fixes needed
for the driver to work once we're done converting to using the CCF for
DaVinci.

The last remoteproc patch will be sent later once the platform parts
are applied.

All the patches are reviewed and tested.

[1] https://lkml.org/lkml/2018/4/17/1000

Bartosz Golaszewski (3):
  remoteproc/davinci: add the missing retval check for clk_enable()
  remoteproc/davinci: prepare and unprepare the clock where needed
  remoteproc/davinci: use octal permissions for module_param()

 drivers/remoteproc/da8xx_remoteproc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.17.0
