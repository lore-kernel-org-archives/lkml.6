Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D83C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF78208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF78208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbeGJQW6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:22:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37012 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933359AbeGJQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:22:57 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fcvPg-0000yI-Hn; Tue, 10 Jul 2018 18:22:52 +0200
Date:   Tue, 10 Jul 2018 18:22:52 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH] cgroup/tracing: Move taking of spin lock out of trace
 event handlers
Message-ID: <20180710162252.j5ftyyp2fve64ppv@linutronix.de>
References: <20180709174854.74a30b57@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709174854.74a30b57@gandalf.local.home>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-09 17:48:54 [-0400], Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reported-by: Clark Williams <williams@redhat.com>
I just forwarded the report.

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I am in favour of this change.

Sebastian
