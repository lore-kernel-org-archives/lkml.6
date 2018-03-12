Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeCLTMU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:12:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37218 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932457AbeCLTJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:09:17 -0400
X-Google-Smtp-Source: AG47ELvAO7Yllvlxfn5t5jLHs5B1bf3gUHo4sdzRNjRZ+RZa0Qp3s5USY0mZnjQ+EldgL7Npae8Y6Q==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] platform/chrome: chromeos_laptop - add SPDX identifier
Date: Mon, 12 Mar 2018 12:08:57 -0700
Message-Id: <20180312190907.174301-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
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
2.16.2.660.g709887971b-goog
