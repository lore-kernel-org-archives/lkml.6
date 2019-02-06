Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA43C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF9E20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfBFQyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:54:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfBFQyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:54:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23CC20823;
        Wed,  6 Feb 2019 16:54:21 +0000 (UTC)
Date:   Wed, 6 Feb 2019 11:54:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     mingo@redhat.com, tom.zanussi@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Remove unused function
 ring_buffer_page_len()
Message-ID: <20190206115420.424e587f@gandalf.local.home>
In-Reply-To: <alpine.LSU.2.21.1902061723490.30584@pobox.suse.cz>
References: <20181228133847.106177-1-mbenes@suse.cz>
        <20181228183313.674ef6de@gandalf.local.home>
        <alpine.LSU.2.21.1902061723490.30584@pobox.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 17:24:45 +0100 (CET)
Miroslav Benes <mbenes@suse.cz> wrote:


> > No worries. I'm also in holiday mode. I marked the patch in my INBOX
> > and hopefully when I'm back to work it's not buried and lost for months.
> > 
> > Even if it is, I periodically purge my INBOX where I find missing
> > patches like these ;-)
> > 
> > So if it's not applied in a couple of weeks, just ping me about it.  
> 
> Gentle ping...

Thanks for the reminder. My INBOX blew up again, and this was lost in
the noise once more.

I'll take a look at it today.

-- Steve
