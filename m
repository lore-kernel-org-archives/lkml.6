Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeCDWVR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 17:21:17 -0500
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:34154 "EHLO
        5.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeCDWVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 17:21:16 -0500
From: Florent Flament <contact@florentflament.com>
To: andy.shevchenko@gmail.com
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Florent Flament <contact@florentflament.com>
Subject: [PATCH v2 0/1] Logitech K290: Add driver for the Logitech K290 USB keyboard
Date: Sun,  4 Mar 2018 23:14:24 +0100
Message-Id: <20180304221425.28611-1-contact@florentflament.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304170004.26553-1-contact@florentflament.com>
References: <20180304170004.26553-1-contact@florentflament.com>
X-Ovh-Tracer-Id: 8062569235239762591
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrjeehgdduheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
* Using SPDX ID instead of licence statement
* Removed unnecessary includes (linux/moduleparam.h and linux/mod_devicetable.h)

ps: Sorry for having broken the previous thread and sent the previous
mail without proper versioning of the patch.

Florent Flament (1):
  HID: Logitech K290: Add driver for the Logitech K290 USB keyboard

 drivers/hid/Kconfig             |  18 ++++++++
 drivers/hid/Makefile            |   1 +
 drivers/hid/hid-ids.h           |   1 +
 drivers/hid/hid-logitech-k290.c | 100 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 drivers/hid/hid-logitech-k290.c

-- 
2.14.3
