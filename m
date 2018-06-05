Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeFERym (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:54:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50760 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeFERyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:54:41 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>, Kees Cook <keescook@chromium.org>,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Subject: [PATCH v2 2/8] platform/chrome: pstore: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 19:54:23 +0200
Message-Id: <20180605175429.9072-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605175429.9072-1-enric.balletbo@collabora.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 drivers/platform/chrome/chromeos_pstore.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index b0693fdec8c6..4d3d3459e2f9 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -1,12 +1,7 @@
-/*
- *  chromeos_pstore.c - Driver to instantiate Chromebook ramoops device
- *
- *  Copyright (C) 2013 Google, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation, version 2 of the License.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Driver to instantiate Chromebook ramoops device.
+//
+// Copyright (C) 2013 Google, Inc.
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-- 
2.17.1
