Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934383AbeEIIld (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:41:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50406 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934244AbeEIIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:41:29 -0400
Date: Wed, 9 May 2018 10:41:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx
 warnings
Message-ID: <20180509084120.GF12217@hirez.programming.kicks-ass.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 06:35:49AM -0300, Mauro Carvalho Chehab wrote:
> The flow diagram should be inside a code-block to avoid those
> warnings:
> 	./include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
> 	./include/linux/wait.h:113: WARNING: Unexpected indentation.
> 	./include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> This is easily done by using "::" instead of just ":".

And I'll voice my objection once again. This makes a regular comment
worse. This rst stuff is utter shit for making normal text files less
readable in your favourite text editor.

If this gets merged, I'll simply remove that spurious ':' the next time
I'm near that comment.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  include/linux/wait.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index d9f131ecf708..d907ed761a7f 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -101,7 +101,7 @@ init_waitqueue_func_entry(struct wait_queue_entry *wq_entry, wait_queue_func_t f
>   * lead to sporadic and non-obvious failure.
>   *
>   * Use either while holding wait_queue_head::lock or when used for wakeups
> - * with an extra smp_mb() like:
> + * with an extra smp_mb() like::
>   *
>   *      CPU0 - waker                    CPU1 - waiter
>   *
> -- 
> 2.17.0
> 
