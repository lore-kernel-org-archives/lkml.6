Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeDXPGp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbeDXPGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:06:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FDD20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 11:06:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] trace: fix missing tab for hwlat_detector
Message-ID: <20180424110639.175ad1f0@gandalf.local.home>
In-Reply-To: <20180315060639.9578-1-peterx@redhat.com>
References: <20180315060639.9578-1-peterx@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 14:06:39 +0800
Peter Xu <peterx@redhat.com> wrote:

> It's been missing for a while but no one is touching that up.  Fix it.

I just noticed this patch. I added it, thanks!

-- Steve

> 
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  kernel/trace/trace_entries.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index e954ae3d82c0..e3a658bac10f 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -356,7 +356,7 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
>  		__field(	unsigned int,		seqnum		)
>  	),
>  
> -	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llunmi-ts:%llu\tnmi-count:%u\n",
> +	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llu\tnmi-ts:%llu\tnmi-count:%u\n",
>  		 __entry->seqnum,
>  		 __entry->tv_sec,
>  		 __entry->tv_nsec,
