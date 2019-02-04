Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0A9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18387217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfBDIv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:51:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:51:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148pEDT357432
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:51:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148pDlT357429;
        Mon, 4 Feb 2019 00:51:13 -0800
Date:   Mon, 4 Feb 2019 00:51:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-720e596a16cc170798a60dc7afa27146ec5fb14e@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, paulmck@linux.ibm.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, jolsa@redhat.com, kstewart@linuxfoundation.org
Reply-To: mingo@kernel.org, kstewart@linuxfoundation.org,
          peterz@infradead.org, jolsa@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com,
          torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
          paulmck@linux.ibm.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20190116111308.211981422@linutronix.de>
References: <20190116111308.211981422@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/uprobes: Convert to SPDX license identifier
Git-Commit-ID: 720e596a16cc170798a60dc7afa27146ec5fb14e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  720e596a16cc170798a60dc7afa27146ec5fb14e
Gitweb:     https://git.kernel.org/tip/720e596a16cc170798a60dc7afa27146ec5fb14e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 16 Jan 2019 12:11:01 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:46:13 +0100

perf/uprobes: Convert to SPDX license identifier

Replace the license boiler plate with a SPDX license identifier.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paul McKenney <paulmck@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190116111308.211981422@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/uprobes.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8aef47ee7bfa..affa830a198c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * User-space Probes (UProbes)
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
  * Copyright (C) IBM Corporation, 2008-2012
  * Authors:
  *	Srikar Dronamraju
