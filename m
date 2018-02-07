Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032893; cv=none;
        d=google.com; s=arc-20160816;
        b=N90+7jSeVj5vllMvxQw+5pojplADb/CzVqqtS4DDA9yR0zq6VVz2Ne38KEHV0/B8y6
         bYDZfavWbU8Petq42hCe6Oo4Csnka18RxxjjDq5hyb5wv5ZmlEoNte5sRQezTSPg6I+u
         u91Aq21MmwnIbSrcvE4wls0+E9S/dfcbOLHzVxFjSehqQsLjRkqatD1J6jBWfWDHo8Sp
         TXQQ3YjJGYyhGjuu2QU256jGaofCtfcXdeqwVFO8b7tXyR1aD7vfTxiPdoIEQmmu2nB7
         XY/cg2DyYEauFJsK++8K8DCpgm36cpRiLXO7q/PquSuqUyhQEPQz0BH8ibee2W3gVxCG
         hpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=CsyXrtxSIX0w0QyGUXWn99ZJzmef0KVTBU37Ecj31pA=;
        b=fyNUBzixhSj84ssXUstK/a0EQTeZOnjANQhkTwq4Ike8NFjGWfc4GFmoxyIkO242eu
         94vxPulgE5UTmw1nWjvSO+7MEdCJqbKvRqYXL1OlxdHQhVQaWgtvzBVm0pcOxvQ9GTra
         6COvUIgckVdemsw5pXbIIgrbIbRz8ZHzBAOpHrEPAAqB+CiO9Hdzr1XsS9M21KBTrCdo
         nKfhr6uHKXJB5pec6UyeqsxMynulAnLYVKItfA4xk8Jc8K5PSkjt7myx4sK4owIQF4kH
         iribJ22AAexbXdAL9PD/NJVFsRpsVvpxJdERFvmFYhvxDNVWl3tgUcct2utNyIEWggBV
         oyDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rXEMYzzE;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rXEMYzzE;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226evdX4ObJppZcSnmfZscYYWjYAYxs9BO3KNaCB/S45z+O7U0Ki/hxewKhQEUsC5VqqL2XuRA==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 11/12] parport: Replace short License header by SPDX identifier
Date: Wed,  7 Feb 2018 19:47:58 +0000
Message-Id: <1518032879-5844-11-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772858967406219?=
X-GMAIL-MSGID: =?utf-8?q?1591772858967406219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

No functional changes involved.

Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index d141e31..4f8b260 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -1,20 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Support for common PCI multi-I/O cards (which is most of them)
  *
  * Copyright (C) 2001  Tim Waugh <twaugh@redhat.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- *
  * Multi-function PCI cards are supposed to present separate logical
  * devices on the bus.  A common thing to do seems to be to just use
  * one logical device with lots of base address registers for both
  * parallel ports and serial ports.  This driver is for dealing with
  * that.
- *
  */
 
 #include <linux/interrupt.h>
-- 
2.7.4
