Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeDWIWg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:22:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbeDWIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:22:32 -0400
Date: Mon, 23 Apr 2018 01:22:18 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7010adcdd23527f7efef1e7bc0d8c458f6ec0dd2@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, mingo@kernel.org, pombredanne@nexb.com,
        jan.kiszka@siemens.com, corbet@lwn.net
Reply-To: corbet@lwn.net, pombredanne@nexb.com, hpa@zytor.com,
        mingo@kernel.org, jan.kiszka@siemens.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180422220832.815346488@linutronix.de>
References: <20180422220832.815346488@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/jailhouse: Fix incorrect SPDX identifier
Git-Commit-ID: 7010adcdd23527f7efef1e7bc0d8c458f6ec0dd2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7010adcdd23527f7efef1e7bc0d8c458f6ec0dd2
Gitweb:     https://git.kernel.org/tip/7010adcdd23527f7efef1e7bc0d8c458f6ec0dd2
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 23 Apr 2018 00:02:09 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 23 Apr 2018 10:17:28 +0200

x86/jailhouse: Fix incorrect SPDX identifier

GPL2.0 is not a valid SPDX identiier. Replace it with GPL-2.0.

Fixes: 4a362601baa6 ("x86/jailhouse: Add infrastructure for running in non-root cell")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Link: https://lkml.kernel.org/r/20180422220832.815346488@linutronix.de

---
 arch/x86/include/asm/jailhouse_para.h | 2 +-
 arch/x86/kernel/jailhouse.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/jailhouse_para.h b/arch/x86/include/asm/jailhouse_para.h
index b885a961a150..a34897aef2c2 100644
--- a/arch/x86/include/asm/jailhouse_para.h
+++ b/arch/x86/include/asm/jailhouse_para.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 /*
  * Jailhouse paravirt detection
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index fa183a131edc..a15fe0e92cf9 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Jailhouse paravirt_ops implementation
  *
