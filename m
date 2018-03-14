Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELs2acUwf6iXsYn1DzTGSqSvciEeANQKUGbRNEGcZYXBU2s6d1DwUxg4XN3woOJD8lW9gl5Q
ARC-Seal: i=1; a=rsa-sha256; t=1521062688; cv=none;
        d=google.com; s=arc-20160816;
        b=iy6XYLFL2lVt/a6aIPEwDMVj15dM6A2Ik67hQ2UGFNDbFxqh4WPU7hy5zF9UkpKsGW
         ehGUJwpta8YUyG2bqMSErkzLGuGjnkXPTPvxJjyij0KRCBBM0fGxXDUbTNk8+6mrdnF5
         +zzZcQsxKg5nsPZZTtY/oOnKEAEPHCOhMkXgUOXwW/6JyZ80sVMDF5yYj6c1L2YW02F7
         pXBi20uKjmhSRn1Ra1YAgYn2U5PqbiHRUcFzU1W65KRvmPMUivp6HPJC2iB8ovxlfK1o
         uAjta1C/2y8P1C4bxkqhWrJYRNMp1gcsZ6asgK9YscMM+wpHOfmi7fZAYOADXnKYoXzU
         MySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=r5nm1eQfZ18g19SuwFIZUdJd7wXHqGY33tgKToBVwJ0=;
        b=0ppg4ZREIVYNFCuEm8XVLQsHJ/OQK8RoLWhgUCvBGph8cpN4VsUXAMvt5lbhPzfB2a
         svl3Vlgz2PE4a9JMIVgei/L4KKoGmxRCY66ckK3pdWLNm87BugOXwlcY+6rEQU7sOKGN
         7vM2u4uGOGUjzv72x29J+UCfBKUhw4BboZ6opptTB5PjhgMCSW+x3HPdwOvUPJ7rGcS4
         rKY4seBb5rIrVzgJDENPA+86G3eh7A6jGA1n5Dxrjsqv6p/eUAJp+1R5TzaCMfrvtv7R
         CD9MDdYmp8Qs/+Lmz7B2MTIirHay97bXKntnsEh2DSjzhjyrpkNIzHzfn5UPkbqLruyG
         PI7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180314212030.571811184@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 14 Mar 2018 22:15:18 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Bartosz Golaszewski <brgl@bgdev.pl>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch 3/4] genirq: Convert various GPL references to SPDX
References: <20180314211515.429128440@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=genirq--Convert-various-GPL-references-to-SPDX.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949829799092079?=
X-GMAIL-MSGID: =?utf-8?q?1594949829799092079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain various forms of boilerplate language and sloppy GPL
references.

Replace all of them with the proper SPDX identifiers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 kernel/irq/cpuhotplug.c |    5 +----
 kernel/irq/debugfs.c    |    8 +++-----
 kernel/irq/irq_sim.c    |   10 ++--------
 kernel/irq/msi.c        |    3 +--
 kernel/irq/timings.c    |   11 +++--------
 5 files changed, 10 insertions(+), 27 deletions(-)

--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic cpu hotunplug interrupt migration code copied from the
  * arch/arm implementation
  *
  * Copyright (C) Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/interrupt.h>
 #include <linux/ratelimit.h>
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -1,8 +1,6 @@
-/*
- * Copyright 2017 Thomas Gleixner <tglx@linutronix.de>
- *
- * This file is licensed under the GPL V2.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2017 Thomas Gleixner <tglx@linutronix.de>
+
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/uaccess.h>
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -1,11 +1,5 @@
-/*
- * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
 
 #include <linux/slab.h>
 #include <linux/irq_sim.h>
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Intel Corp.
  * Author: Jiang Liu <jiang.liu@linux.intel.com>
  *
- * This file is licensed under GPLv2.
- *
  * This file contains common code to support Message Signalled Interrupt for
  * PCI compatible and non PCI compatible devices.
  */
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -1,11 +1,6 @@
-/*
- * Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
