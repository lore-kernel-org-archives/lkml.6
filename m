Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBUAD4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:03:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:9425 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751368AbeBUADx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:03:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,542,1511856000";
   d="scan'208";a="19064690"
From: Rajmohan Mani <rajmohan.mani@intel.com>
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH 0/3] Update TPS68470 PMIC drivers with SPDX tags
Date: Tue, 20 Feb 2018 15:54:06 -0800
Message-Id: <1519170849-28802-1-git-send-email-rajmohan.mani@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series update the TPS68470 PMIC drivers with SPDX license
identifiers, while removing the GPL v2 boilerplate license text.

Rajmohan Mani (3):
  mfd: Update to SPDX license identifier
  gpio: Update to SPDX license identifier
  ACPI / PMIC: Update to SPDX license identifier

 drivers/acpi/pmic/tps68470_pmic.c | 10 +---------
 drivers/gpio/gpio-tps68470.c      | 10 +---------
 drivers/mfd/tps68470.c            | 10 +---------
 include/linux/mfd/tps68470.h      | 17 +++--------------
 4 files changed, 6 insertions(+), 41 deletions(-)

-- 
1.9.1
