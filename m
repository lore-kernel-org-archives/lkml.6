Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B042086D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBTPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBTPqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:46:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8282086D;
        Wed, 20 Feb 2019 15:46:37 +0000 (UTC)
Date:   Wed, 20 Feb 2019 10:46:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix spelling mistake: "analagous" ->
 "analogous"
Message-ID: <20190220104636.19dbcb8e@gandalf.local.home>
In-Reply-To: <20190217223222.16479-1-colin.king@canonical.com>
References: <20190217223222.16479-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 22:32:22 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the mini-howto help text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied. Thanks!

-- Steve

> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f380139e972c..4dd8a52a71e0 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4740,7 +4740,7 @@ static const char readme_msg[] =
>  	"\t    unchanged.\n\n"
>  	"\t    The enable_hist and disable_hist triggers can be used to\n"
>  	"\t    have one event conditionally start and stop another event's\n"
> -	"\t    already-attached hist trigger.  The syntax is analagous to\n"
> +	"\t    already-attached hist trigger.  The syntax is analogous to\n"
>  	"\t    the enable_event and disable_event triggers.\n"
>  #endif
>  ;

