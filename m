Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AG47ELvN+gB+0VT21r9pdboZJtvnjNeRjIOCXJc/aZEbBFsre6D+h8U9cqu5/W6sPpFf0Gmk9gKb
ARC-Seal: i=1; a=rsa-sha256; t=1521552518; cv=none;
        d=google.com; s=arc-20160816;
        b=HdWkBSctgdcgWjncvaV+G2X4xf89I3ZaILBytCc6u5chOr5fh9nXTQbcVXyjsKjt/N
         wFnNe6lBLLljR2q5y3IvSfjS+y0jS8fcQYWey1NOa27y8/VnYd7v8RxOxzG/aSbjn/zc
         20jp+ThmBtJ5sxOyS2W5PYBtSoEXYVk8LFcqWLIOvCXlCXbfoDQhspzjliO5tLEIEqe+
         5nnxXKSAODomPIJAJy7IsuVH5TWdbIfZJsg/kfZ4hN5VkgsJlgW4JC10qm26JnvM7Qt7
         JylC3gi3aoeCCoNKn/VaxP9jdnRMkr19Z5ciywBGoeTdgKoc/Ox6kLonVlJNkamw/DDE
         KqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=q/jHzE5dmzoOEO82wjPNhj32meS2mSdSPRRCECpBbGI=;
        b=XdSzNq4oXmv0w4ffxLB+2D1Tk+vUm3N2AqNWlFwGbEXag2fxC+ZjBJPH2f0QSOQwj8
         ICfr5NEI1TVtN6awiaW8VSW4UyV6gvcqU3aFxXgW72/heA6yTxOK+RFxyPPZ7mfGbGKJ
         UmNxTs3hR5aFsaveQNzJoGRrP6CL8F3Dx3wJoMK3sKe4lC8cXzcDZu9tpZE+tlcAluqQ
         q+RegHXFQGA/cOmwBDByzBszS8ANae2dXokcvHRmXzBHURtxVISnjR4HqnMHZ2bzJK2E
         eLaJ52iIsKodgm/RzwraoLqExSaPdO8eAJp45d32CRYKOLERBETOLe8lHc8/UfTrT8Su
         bA9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 20 Mar 2018 06:28:28 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-90cafdd521721eb588a738fae17ac70e50675686@git.kernel.org>
Cc: marc.zyngier@arm.com, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, mingo@kernel.org, marc.zyngier@arm.com
In-Reply-To: <20180314212030.492674761@linutronix.de>
References: <20180314212030.492674761@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/matrix: Cleanup SPDX identifier
Git-Commit-ID: 90cafdd521721eb588a738fae17ac70e50675686
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949826087120291?=
X-GMAIL-MSGID: =?utf-8?q?1595463453486688851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  90cafdd521721eb588a738fae17ac70e50675686
Gitweb:     https://git.kernel.org/tip/90cafdd521721eb588a738fae17ac70e50675686
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 14 Mar 2018 22:15:17 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 20 Mar 2018 14:23:28 +0100

genirq/matrix: Cleanup SPDX identifier

Use the proper SPDX-Identifier format.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Link: https://lkml.kernel.org/r/20180314212030.492674761@linutronix.de

---
 kernel/irq/matrix.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 4c5770407031..5092494bf261 100644
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
