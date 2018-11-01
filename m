Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D235D205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D235D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeKBEs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeKBEs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:48:27 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FFF205F4;
        Thu,  1 Nov 2018 19:44:04 +0000 (UTC)
Date:   Thu, 1 Nov 2018 15:44:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, trivial@kernel.org,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ring-buffer: fix small typo
Message-ID: <20181101154403.03c918d2@gandalf.local.home>
In-Reply-To: <20181101154640.23162-1-tiny.windzz@gmail.com>
References: <20181101154640.23162-1-tiny.windzz@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


Jiri,

Is trivial still maintained?

-- Steve


On Thu,  1 Nov 2018 11:46:40 -0400
Yangtao Li <tiny.windzz@gmail.com> wrote:

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/trace/ring_buffer_benchmark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
> index ffba6789c0e2..0564f6db0561 100644
> --- a/kernel/trace/ring_buffer_benchmark.c
> +++ b/kernel/trace/ring_buffer_benchmark.c
> @@ -362,7 +362,7 @@ static void ring_buffer_producer(void)
>  			hit--; /* make it non zero */
>  		}
>  
> -		/* Caculate the average time in nanosecs */
> +		/* Calculate the average time in nanosecs */
>  		avg = NSEC_PER_MSEC / (hit + missed);
>  		trace_printk("%ld ns per entry\n", avg);
>  	}

