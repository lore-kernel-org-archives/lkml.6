Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeEFK2S (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 06:28:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeEFK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 06:28:14 -0400
Date: Sun, 6 May 2018 03:28:02 -0700
From: tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-f2173356e26c4da2ddecf9bf3d58a6a2ff56b11d@git.kernel.org>
Cc: jannh@google.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: jannh@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180504175935.104085-1-jannh@google.com>
References: <20180504175935.104085-1-jannh@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Remove unused file
Git-Commit-ID: f2173356e26c4da2ddecf9bf3d58a6a2ff56b11d
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

Commit-ID:  f2173356e26c4da2ddecf9bf3d58a6a2ff56b11d
Gitweb:     https://git.kernel.org/tip/f2173356e26c4da2ddecf9bf3d58a6a2ff56b11d
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 4 May 2018 19:59:35 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:22:31 +0200

x86/vdso: Remove unused file

commit da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
left this file behind; nothing is using it anymore.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: luto@amacapital.net
Link: https://lkml.kernel.org/r/20180504175935.104085-1-jannh@google.com

---
 arch/x86/entry/vdso/vdso32/vdso-fakesections.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso32/vdso-fakesections.c b/arch/x86/entry/vdso/vdso32/vdso-fakesections.c
deleted file mode 100644
index 541468e25265..000000000000
--- a/arch/x86/entry/vdso/vdso32/vdso-fakesections.c
+++ /dev/null
@@ -1 +0,0 @@
-#include "../vdso-fakesections.c"
