Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E598AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2EF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbfAPLUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:20:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732570AbfAPLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:20:08 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjjEs-000604-Mv; Wed, 16 Jan 2019 12:20:06 +0100
Message-Id: <20190116111058.444514201@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 16 Jan 2019 12:10:58 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [patch 0/3] perf: Convert to SPDX license identifiers
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series converts the files in kernel/events to SPDX license
identifiers.

Thanks,

	tglx

---
 callchain.c     |    3 +--
 core.c          |    3 +--
 hw_breakpoint.c |   15 +--------------
 ring_buffer.c   |    3 +--
 uprobes.c       |   15 +--------------
 5 files changed, 5 insertions(+), 34 deletions(-)

