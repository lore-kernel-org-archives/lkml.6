Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9500C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524C720874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524C720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbeGXQFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388522AbeGXQFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:05:38 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C65420856;
        Tue, 24 Jul 2018 14:58:45 +0000 (UTC)
Date:   Tue, 24 Jul 2018 10:58:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH v1] tracing: Trivia spelling fix containerof() ->
 container_of()
Message-ID: <20180724105844.0ce62f1e@gandalf.local.home>
In-Reply-To: <20180723083159.82112-1-andriy.shevchenko@linux.intel.com>
References: <20180723083159.82112-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018 11:31:59 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This is the only location on kernel that has wrong spelling
> of the container_of() helper. Fix it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/trace_printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
> index 50f44b7b2b32..3cd7b0fcacc6 100644
> --- a/kernel/trace/trace_printk.c
> +++ b/kernel/trace/trace_printk.c
> @@ -114,7 +114,7 @@ static int module_trace_bprintk_format_notify(struct notifier_block *self,
>   * section, then we need to read the link list pointers. The trick is
>   * we pass the address of the string to the seq function just like
>   * we do for the kernel core formats. To get back the structure that
> - * holds the format, we simply use containerof() and then go to the
> + * holds the format, we simply use container_of() and then go to the
>   * next format in the list.
>   */
>  static const char **

