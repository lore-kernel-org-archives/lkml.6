Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeDZUMn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:12:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55370 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeDZUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:12:41 -0400
X-Google-Smtp-Source: AB8JxZr/7+WtOIDhqshpVCbPuWRzBrizKl6ADbJt0i25XCnjg1B/3VbEHqt0FvfrxkdR25gZ0IE0Lw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] gpio: mockup: use the SPDX identifier and remove license boilerplate
Date: Thu, 26 Apr 2018 22:12:36 +0200
Message-Id: <20180426201236.9380-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the SPDX license identifier for GPLv2.0 or later and remove the
license boilerplate.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mockup.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 76c2fe91a901..d66b7a768ecd 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -1,15 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * GPIO Testing Device Driver
  *
  * Copyright (C) 2014  Kamlakant Patel <kamlakant.patel@broadcom.com>
  * Copyright (C) 2015-2016  Bamvor Jian Zhang <bamv2005@gmail.com>
  * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
  */
 
 #include <linux/init.h>
-- 
2.17.0
