Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3603520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfAQXP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:15:29 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48007 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQXP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:15:26 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkGsa-0000xj-U2; Fri, 18 Jan 2019 00:15:21 +0100
Message-Id: <20190117231501.254152158@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 18 Jan 2019 00:14:21 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ondrej Mosnacek <omosnacek@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch 5/9] crypto: morus - Convert to SPDX license identifiers
References: <20190117231416.111952141@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license boiler plate text is not ideal for machine parsing. The kernel
uses SPDX license identifiers for that purpose, which replace the boiler
plate text.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ondrej Mosnacek <omosnacek@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---

P.S.: This patch is part of a larger cleanup, but independent of other
      patches and is intended to be picked up by the maintainer directly. 

---
 crypto/morus1280.c |    6 +-----
 crypto/morus640.c  |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

--- a/crypto/morus1280.c
+++ b/crypto/morus1280.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * The MORUS-1280 Authenticated-Encryption Algorithm
  *
  * Copyright (c) 2016-2018 Ondrej Mosnacek <omosnacek@gmail.com>
  * Copyright (C) 2017-2018 Red Hat, Inc. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #include <asm/unaligned.h>
--- a/crypto/morus640.c
+++ b/crypto/morus640.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * The MORUS-640 Authenticated-Encryption Algorithm
  *
  * Copyright (c) 2016-2018 Ondrej Mosnacek <omosnacek@gmail.com>
  * Copyright (C) 2017-2018 Red Hat, Inc. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  */
 
 #include <asm/unaligned.h>


