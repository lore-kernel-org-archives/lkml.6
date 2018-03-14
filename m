Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELs7tpq1tKR9fXX0n3rwpSLIn3PRYHZNzbqs79+x4kChFQOelnMApcCfP5Z0IsO4jFleITlg
ARC-Seal: i=1; a=rsa-sha256; t=1521062684; cv=none;
        d=google.com; s=arc-20160816;
        b=SF3EpwLZdEFrhBDH7OTEgplF0HEXj0bIfjDGqkLC6jiOXuHyYI47TO59Qgp/IibGDA
         05CPuVdJg/c07o+4CHTVil3XOa4J1aJq9ZSLPpAbGp3Te+9E84TtwnpfktxjQ9veI8wA
         91k6OVD4GDriwyvxx//6XL7D1thLuLWjxk0v5u55P7UKHG9z+lRAISmO0tf1uOG3Xk6v
         OzrC7/Nhlq1NSHlgCIlrcWd9F1LqLFKobhxZSJqeOopl4e/9U7YMPt8Zpg3N3cQtY6tC
         MmuDQYsg2n1zfCsJortIhIY/YktnePXdOXH89lnxtBqaGHW7efjtAnxQ1UQzSAXHpc4A
         wNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=VtZQBmgmZWGxO1SJxFAxVsD0PVrEKctIQnPMZ19CKNQ=;
        b=yX7e5AOi60upRx+fxMFJ7SxI5vHrj5f6YM1jSPUttV4NEcAbf96Vd/Nkn0/Di3knx8
         tvAFGt3bSyXGTJxwFEbArYnU+HaF6as/idTl/lw4jvFXEXbmce1wGmZz19WNBaWUQdJk
         KoxTfVbFAZqQj4yAQbzAbEMERUsTeRDGs8W8mIx0FUQsioSwBWabgmKWclBTzw7IjIOp
         dqBPR5L9JykXkoarXKvf86htgfldt0xDSWMzaxnHNdB8SyddxDyrqUrLEIQs/g9LmjmE
         xcrCuPgpwC5T0GgNk1qwhHBL+0Wa+8T7rlQZqccnLvJp8SfzsaBBLJGx0vZA045SInvB
         czGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180314212030.492674761@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 14 Mar 2018 22:15:17 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch 2/4] genirq/matrix: Cleanup SPDX identifier
References: <20180314211515.429128440@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=genirq--Cleanup-SPDX-identifiers.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949826087120291?=
X-GMAIL-MSGID: =?utf-8?q?1594949826087120291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the proper SPDX-Identifier format.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/matrix.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -1,8 +1,6 @@
-/*
- * Copyright (C) 2017 Thomas Gleixner <tglx@linutronix.de>
- *
- * SPDX-License-Identifier: GPL-2.0
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2017 Thomas Gleixner <tglx@linutronix.de>
+
 #include <linux/spinlock.h>
 #include <linux/seq_file.h>
 #include <linux/bitmap.h>
