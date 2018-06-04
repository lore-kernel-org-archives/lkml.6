Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeFDUu1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:50:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43266 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFDUuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:50:24 -0400
X-Google-Smtp-Source: ADUXVKJyFlyCnmK9UyB2AVnMlxv6M7qSS9aw2p1Cwn9AnUArIvROkptCCx0UhQ2xrqe8K/e92xF+MA==
Subject: [PATCH 1/2] MAINTAINERS: Add myself as a maintainer for SiFive's drivers
Date: Mon,  4 Jun 2018 13:50:10 -0700
Message-Id: <20180604205011.23086-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180604205011.23086-1-palmer@sifive.com>
References: <20180604205011.23086-1-palmer@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't actually any files in the tree that match these patterns
right now, but we've just started submitting our drivers so I thought it
would be good to make sure there's at least someone at SiFive who's
listed as maintaining them.  I'm leaving the RISC-V lists on here
because:

* As of today, all the RISC-V ASICs that people can actually buy are
  from SiFive -- though hopefully there'll be more soon!
* The RTL for many of our devices is open source, so I anticipate these
  devices might make they way chips from other vendors.
* We may standardize some of these devices as part of a RISC-V
  specification at some point in the future.

I'm a bit swamped right now so I might not be the most active maintainer
of these drivers, but I think it'd be good to make sure someone who has
hardware access gets CC'd on updates to our drivers just as a sanity
check.  Hopefully that's an OK way to handle this.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c125f705f78..a8f906d1d1e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12764,6 +12764,14 @@ F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/mmc/siano/
 
+SIFIVE DRIVERS
+M:	Palmer Dabbelt <palmer@sifive.com>
+L:	linux-riscv@lists.infradead.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
+S:	Supported
+K:	sifive
+N:	sifive
+
 SILEAD TOUCHSCREEN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
-- 
2.16.4
