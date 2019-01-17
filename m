Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50797C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2072D20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfAQOxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQOxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:53:19 -0500
Received: from vmware.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFD820652;
        Thu, 17 Jan 2019 14:53:18 +0000 (UTC)
Date:   Thu, 17 Jan 2019 09:53:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: uprobes: fix typo in pr_fmt string
Message-ID: <20190117095316.303dafc2@vmware.local.home>
In-Reply-To: <20190117133023.19292-1-andreas.ziegler@fau.de>
References: <20190117133023.19292-1-andreas.ziegler@fau.de>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami,

Can you give an Acked-by?

Thanks!

-- Steve


On Thu, 17 Jan 2019 14:30:23 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> The subsystem-specific message prefix for uprobes was also
> "trace_kprobe: " instead of "trace_uprobe: " as described in
> the original commit message.
> 
> Fixes: 7257634135c24 ("tracing/probe: Show subsystem name in messages")
> Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
> ---
>  kernel/trace/trace_uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index e335576b9411..19a1a8e19062 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -5,7 +5,7 @@
>   * Copyright (C) IBM Corporation, 2010-2012
>   * Author:	Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>   */
> -#define pr_fmt(fmt)	"trace_kprobe: " fmt
> +#define pr_fmt(fmt)	"trace_uprobe: " fmt
>  
>  #include <linux/ctype.h>
>  #include <linux/module.h>

