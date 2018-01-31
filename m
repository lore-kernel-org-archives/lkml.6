Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeAaODA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:03:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:23030 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeAaOC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:02:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,440,1511856000";
   d="scan'208";a="30911554"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] auxdisplay: Move arm-charlcd binding to correct folder
Date: Wed, 31 Jan 2018 16:02:55 +0200
Message-Id: <20180131140255.50268-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up to the commit

  00846a4425d3 ("auxdisplay: Move arm-charlcd.c to drivers/auxdisplay folder")

for Device Tree binding.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/devicetree/bindings/{misc => auxdisplay}/arm-charlcd.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{misc => auxdisplay}/arm-charlcd.txt (100%)

diff --git a/Documentation/devicetree/bindings/misc/arm-charlcd.txt b/Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
similarity index 100%
rename from Documentation/devicetree/bindings/misc/arm-charlcd.txt
rename to Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
-- 
2.15.1
