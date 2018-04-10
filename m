Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeDJNMX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:12:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39990 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeDJNMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:12:22 -0400
X-Google-Smtp-Source: AIpwx48ASYJQ/ZG3YNpDHt39ty3m2RC3sgY8wISNNgCvfp/VxhnamwHzZE567mu+8zd959kJXAq4Zg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/4] eeprom: at24: last bits of the big refactoring
Date: Tue, 10 Apr 2018 15:12:02 +0200
Message-Id: <20180410131206.25760-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to the big series merged for 4.17. The patches
contain some bits and pieces that were missing in the last submission
or depend on some new features merged this merge window.

Bartosz Golaszewski (4):
  eeprom: at24: don't assign the i2c ID table to at24_driver
  eeprom: at24: use devm_nvmem_register()
  eeprom: at24: provide and use a helper for releasing dummy i2c clients
  eeprom: at24: provide a separate routine for creating dummy i2c
    clients

 drivers/misc/eeprom/at24.c | 70 ++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 26 deletions(-)

-- 
2.17.0
