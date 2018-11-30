Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817412145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817412145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeLAGve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLAGve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:51:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B034620868;
        Fri, 30 Nov 2018 19:41:12 +0000 (UTC)
Date:   Fri, 30 Nov 2018 14:41:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH RFC 14/15] lib: replace **** with a hug
Message-ID: <20181130144111.067d447e@gandalf.local.home>
In-Reply-To: <20181130192737.15053-15-jarkko.sakkinen@linux.intel.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
        <20181130192737.15053-15-jarkko.sakkinen@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 11:27:23 -0800
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> In order to comply with the CoC, replace **** with a hug.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  lib/vsprintf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 37a54a6dd594..b7a92f5d47bb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -6,7 +6,7 @@
>  
>  /* vsprintf.c -- Lars Wirzenius & Linus Torvalds. */
>  /*
> - * Wirzenius wrote this portably, Torvalds fucked it up :-)
> + * Wirzenius wrote this portably, Torvalds hugged it up :-)

Since the code has been greatly modified since that comment was added,
I would say the comment is simply out of date.

Just nuke the comment, and that will be an accurate change with or
without CoC.

-- Steve

>   */
>  
>  /*

