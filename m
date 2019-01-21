Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE33CC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA56020663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAULXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:23:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfAULXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:23:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBNBK12493731
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:23:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBNBMj2493728;
        Mon, 21 Jan 2019 03:23:11 -0800
Date:   Mon, 21 Jan 2019 03:23:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-ad07c8ceb6631a83b62d405a61448bba92adac68@git.kernel.org>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        ink@jurassic.park.msu.ru, andrew.murray@arm.com,
        linux@armlinux.org.uk, s.hauer@pengutronix.de, rth@twiddle.net,
        will.deacon@arm.com, torvalds@linux-foundation.org,
        acme@kernel.org, mingo@kernel.org, mark.rutland@arm.com,
        benh@kernel.crashing.org, bp@alien8.de, peterz@infradead.org,
        paulus@samba.org, mattst88@gmail.com, hpa@zytor.com,
        shawnguo@kernel.org, tglx@linutronix.de
Reply-To: linux@armlinux.org.uk, s.hauer@pengutronix.de, rth@twiddle.net,
          will.deacon@arm.com, mpe@ellerman.id.au,
          linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru,
          andrew.murray@arm.com, hpa@zytor.com, shawnguo@kernel.org,
          tglx@linutronix.de, mingo@kernel.org, acme@kernel.org,
          torvalds@linux-foundation.org, benh@kernel.crashing.org,
          mark.rutland@arm.com, bp@alien8.de, peterz@infradead.org,
          paulus@samba.org, mattst88@gmail.com
In-Reply-To: <1547128414-50693-13-git-send-email-andrew.murray@arm.com>
References: <1547128414-50693-13-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Remove unused perf_flags
Git-Commit-ID: ad07c8ceb6631a83b62d405a61448bba92adac68
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

Commit-ID:  ad07c8ceb6631a83b62d405a61448bba92adac68
Gitweb:     https://git.kernel.org/tip/ad07c8ceb6631a83b62d405a61448bba92adac68
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Thu, 10 Jan 2019 13:53:34 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:01:31 +0100

perf/core: Remove unused perf_flags

Now that perf_flags is not used we remove it.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: robin.murphy@arm.com
Cc: suzuki.poulose@arm.com
Link: https://lkml.kernel.org/r/1547128414-50693-13-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/uapi/linux/perf_event.h       | 2 --
 tools/include/uapi/linux/perf_event.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9de8780ac8d9..ea19b5d491bf 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -445,8 +445,6 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
-#define perf_flags(attr)	(*(&(attr)->read_format + 1))
-
 /*
  * Ioctls that can be done on a perf event fd:
  */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 9de8780ac8d9..ea19b5d491bf 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -445,8 +445,6 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
-#define perf_flags(attr)	(*(&(attr)->read_format + 1))
-
 /*
  * Ioctls that can be done on a perf event fd:
  */
