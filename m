Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCTWbx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:31:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36903 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeCTWbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:48 -0400
X-Google-Smtp-Source: AG47ELusokkjglY1aDqSErntY9365OvZIsDTSkdh3U8Gitp6U0PBerqzLwnWNIT1HjAYC7cRXoRBpg==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] platform/chrome: chromeos_laptop - add SPDX identifier
Date: Tue, 20 Mar 2018 15:31:28 -0700
Message-Id: <20180320223138.234724-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the original license statement with the SPDX identifier.
Add also one line of description as recommended by the COPYING file.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 27 +++++------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index d8599736a41a2..54a13c70e1d8f 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -1,25 +1,8 @@
-/*
- *  chromeos_laptop.c - Driver to instantiate Chromebook i2c/smbus devices.
- *
- *  Author : Benson Leung <bleung@chromium.org>
- *
- *  Copyright (C) 2012 Google, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Driver to instantiate Chromebook i2c/smbus devices.
+//
+// Copyright (C) 2012 Google, Inc.
+// Author: Benson Leung <bleung@chromium.org>
 
 #include <linux/dmi.h>
 #include <linux/i2c.h>
-- 
2.16.2.804.g6dcf76e118-goog
