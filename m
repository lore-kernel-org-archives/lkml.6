Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D235FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E6121477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E6121477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeJRXOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeJRXOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:14:09 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377CB21473;
        Thu, 18 Oct 2018 15:12:41 +0000 (UTC)
Date:   Thu, 18 Oct 2018 11:12:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     joel@joelfernandes.org, tglx@linutronix.de, mingo@kernel.org,
        frederic@kernel.org, paulmck@linux.vnet.ibm.com,
        alexander.levin@verizon.com, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] softirq: modify comments about PF_MEMALLOC in
 __do_softirq
Message-ID: <20181018111239.17abadee@gandalf.local.home>
In-Reply-To: <20181018142133.12341-1-tiny.windzz@gmail.com>
References: <20181018142133.12341-1-tiny.windzz@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I don't know if the trivial tree is dead or not, but this would be a
prime candidate.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


On Thu, 18 Oct 2018 10:21:33 -0400
Yangtao Li <tiny.windzz@gmail.com> wrote:

> ---
>  kernel/softirq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 6f584861d329..6193e1d1b30d 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -257,7 +257,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	int softirq_bit;
>  
>  	/*
> -	 * Mask out PF_MEMALLOC s current task context is borrowed for the
> +	 * Mask out PF_MEMALLOC as current task context is borrowed for the
>  	 * softirq. A softirq handled such as network RX might set PF_MEMALLOC
>  	 * again if the socket is related to swap
>  	 */

