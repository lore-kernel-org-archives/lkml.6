Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0FCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DAA2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfBFQYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:24:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:34348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726306AbfBFQYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:24:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12457AEB3;
        Wed,  6 Feb 2019 16:24:47 +0000 (UTC)
Date:   Wed, 6 Feb 2019 17:24:45 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     mingo@redhat.com, tom.zanussi@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Remove unused function
 ring_buffer_page_len()
In-Reply-To: <20181228183313.674ef6de@gandalf.local.home>
Message-ID: <alpine.LSU.2.21.1902061723490.30584@pobox.suse.cz>
References: <20181228133847.106177-1-mbenes@suse.cz> <20181228183313.674ef6de@gandalf.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018, Steven Rostedt wrote:

> On Fri, 28 Dec 2018 14:38:47 +0100
> Miroslav Benes <mbenes@suse.cz> wrote:
> 
> > Commit 6b7e633fe9c2 ("tracing: Remove extra zeroing out of the ring
> > buffer page") removed the only caller of ring_buffer_page_len(). The
> > function is now unused and may be removed.
> > 
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > ---
> > I am sorry if you received the patch more than once (hopefully not). For some
> > strange reasons git send-email segfaulted, I tried to send from a different
> > machine and made a mistake. Holiday mode *sigh*.
> > 
> >
> 
> No worries. I'm also in holiday mode. I marked the patch in my INBOX
> and hopefully when I'm back to work it's not buried and lost for months.
> 
> Even if it is, I periodically purge my INBOX where I find missing
> patches like these ;-)
> 
> So if it's not applied in a couple of weeks, just ping me about it.

Gentle ping...

Miroslav
