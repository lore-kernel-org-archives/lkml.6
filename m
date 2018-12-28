Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760CB218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeL1XdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:33:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeL1XdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:33:16 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BC9217F9;
        Fri, 28 Dec 2018 23:33:15 +0000 (UTC)
Date:   Fri, 28 Dec 2018 18:33:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     mingo@redhat.com, tom.zanussi@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Remove unused function
 ring_buffer_page_len()
Message-ID: <20181228183313.674ef6de@gandalf.local.home>
In-Reply-To: <20181228133847.106177-1-mbenes@suse.cz>
References: <20181228133847.106177-1-mbenes@suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 14:38:47 +0100
Miroslav Benes <mbenes@suse.cz> wrote:

> Commit 6b7e633fe9c2 ("tracing: Remove extra zeroing out of the ring
> buffer page") removed the only caller of ring_buffer_page_len(). The
> function is now unused and may be removed.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
> I am sorry if you received the patch more than once (hopefully not). For some
> strange reasons git send-email segfaulted, I tried to send from a different
> machine and made a mistake. Holiday mode *sigh*.
> 
>

No worries. I'm also in holiday mode. I marked the patch in my INBOX
and hopefully when I'm back to work it's not buried and lost for months.

Even if it is, I periodically purge my INBOX where I find missing
patches like these ;-)

So if it's not applied in a couple of weeks, just ping me about it.

-- Steve
