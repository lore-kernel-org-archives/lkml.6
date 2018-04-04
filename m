Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeDDHTE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:19:04 -0400
Received: from mail.monom.org ([188.138.9.77]:49502 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeDDHRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:17:13 -0400
From: Daniel Wagner <wagi@monom.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        stable-rt@vger.kernel.org
Subject: [PATCH RT 1/7] locking: add types.h
Date: Wed,  4 Apr 2018 09:16:46 +0200
Message-Id: <20180404071652.24196-2-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404071652.24196-1-wagi@monom.org>
References: <20180404071652.24196-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

During the stable update the arm architecture did not compile anymore
due to missing definition of u16/32.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/spinlock_types_raw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index edffc4d53fc9..03235b475b77 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 #define __LINUX_SPINLOCK_TYPES_RAW_H
 
+#include <linux/types.h>
+
 #if defined(CONFIG_SMP)
 # include <asm/spinlock_types.h>
 #else
-- 
2.14.3
