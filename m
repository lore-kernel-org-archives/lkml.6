Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB75FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6BC2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6BC2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeK2BYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2BYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:24:15 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1F920832;
        Wed, 28 Nov 2018 14:22:25 +0000 (UTC)
Date:   Wed, 28 Nov 2018 09:22:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] arm64: ftrace: Fix to enable syscall events on arm64
Message-ID: <20181128092223.2a100448@gandalf.local.home>
In-Reply-To: <20181128120502.GC24868@arm.com>
References: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
        <154333618522.27355.8094935453351562295.stgit@devbox>
        <20181127165848.GA19569@arm.com>
        <20181127131859.79ce7da9@gandalf.local.home>
        <20181128085555.a8987cbe18aa6d1d1f0a827e@kernel.org>
        <20181128120502.GC24868@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 12:05:02 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Ok! Then please add a comment to arch_syscall_match_sym_name() along those
> lines, and you can add my ack:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Shouldn't this go through your tree?

-- Steve
