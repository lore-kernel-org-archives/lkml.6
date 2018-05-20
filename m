Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbeETGuj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 02:50:39 -0400
Received: from sauhun.de ([88.99.104.3]:41450 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeETGui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 02:50:38 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] don't check number of I2C messages in drivers
Date: Sun, 20 May 2018 08:50:32 +0200
Message-Id: <20180520065035.7920-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core does it now, we can simplify drivers.

Wolfram Sang (2):
  i2c: ibm_iic: don't check number of messages in the driver
  i2c: opal: don't check number of messages in the driver

 drivers/i2c/busses/i2c-ibm_iic.c | 3 ---
 drivers/i2c/busses/i2c-opal.c    | 4 ----
 2 files changed, 7 deletions(-)

-- 
2.11.0
