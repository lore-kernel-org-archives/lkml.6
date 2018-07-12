Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB62320BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB62320BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbeGLNKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbeGLNKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:10:08 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA31E20BF2;
        Thu, 12 Jul 2018 13:00:39 +0000 (UTC)
Date:   Thu, 12 Jul 2018 09:00:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring_buffer: Update logging to use single line output
Message-ID: <20180712090038.7529d473@gandalf.local.home>
In-Reply-To: <86e887cec9ce67b4ea55eec7ffca4cd902a84068.camel@perches.com>
References: <cover.1525964381.git.joe@perches.com>
        <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
        <20180510122843.0b69b41a@gandalf.local.home>
        <24f146a8726f391736bc79306e64b204435eb4ec.camel@perches.com>
        <20180711225745.6e66c10f@vmware.local.home>
        <86e887cec9ce67b4ea55eec7ffca4cd902a84068.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 21:42:53 -0700
Joe Perches <joe@perches.com> wrote:

> > I just noticed this patch. Please don't send patches Cc'd to other
> > threads. They need to start a new thread, otherwise, like this one, it
> > will most likely be lost.
> > 
> > If you want this applied still, please resend it properly.  
> 
> An email sent directly to you should not be lost by you.

OK, it was ignored.

-- Steve
