Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC62C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325DE20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325DE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeIJRbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:31:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:31:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ACbRrt1846496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 05:37:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ACbRNr1846493;
        Mon, 10 Sep 2018 05:37:27 -0700
Date:   Mon, 10 Sep 2018 05:37:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sasha Levin <tipbot@zytor.com>
Message-ID: <tip-1064ea494bb00519c6e34f791dcf17436f70592d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, alexander.levin@microsoft.com,
        Alexander.Levin@microsoft.com, hpa@zytor.com
Reply-To: peterz@infradead.org, alexander.levin@microsoft.com,
          Alexander.Levin@microsoft.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <20180813190527.16853-3-alexander.levin@microsoft.com>
References: <20180813190527.16853-3-alexander.levin@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] tools/lib/lockdep: Add empty nmi.h
Git-Commit-ID: 1064ea494bb00519c6e34f791dcf17436f70592d
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

Commit-ID:  1064ea494bb00519c6e34f791dcf17436f70592d
Gitweb:     https://git.kernel.org/tip/1064ea494bb00519c6e34f791dcf17436f70592d
Author:     Sasha Levin <Alexander.Levin@microsoft.com>
AuthorDate: Mon, 13 Aug 2018 19:05:38 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 13:48:23 +0200

tools/lib/lockdep: Add empty nmi.h

Required since:

  88f1c87de11a8 ("locking/lockdep: Avoid triggering hardlockup from debug_show_all_locks()")

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180813190527.16853-3-alexander.levin@microsoft.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/mach-imx/Makefile.boot => tools/include/linux/nmi.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile.boot b/tools/include/linux/nmi.h
similarity index 100%
copy from arch/arm/mach-imx/Makefile.boot
copy to tools/include/linux/nmi.h
