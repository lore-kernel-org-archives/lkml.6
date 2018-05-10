Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966452AbeEJQdt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:33:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45690 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:33:47 -0400
Subject: Re: [RFC PATCH 2/2] wait: add a keyword to indicate a diagram code
 block on a kernel-doc
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <2ac6e3da22119f714406925139e40f4d835d11a4.1525962971.git.mchehab+samsung@kernel.org>
 <dfe40a6f75e9bd445ea36218dbcf367090b2367b.1525962971.git.mchehab+samsung@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f0c8a649-5304-b9e9-975e-e80fa3a4c44e@infradead.org>
Date: Thu, 10 May 2018 09:33:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <dfe40a6f75e9bd445ea36218dbcf367090b2367b.1525962971.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 07:38 AM, Mauro Carvalho Chehab wrote:
> When handling code-blocks, usual parsing should be disabled.
> Indicate it by using the keyword disagram.

                                   diagram.

Please add such keyword(s) to one of Documentation/doc-guide/{kernel-doc,sphinx}.rst.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  include/linux/wait.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index d9f131ecf708..653814475ee9 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -101,7 +101,7 @@ init_waitqueue_func_entry(struct wait_queue_entry *wq_entry, wait_queue_func_t f
>   * lead to sporadic and non-obvious failure.
>   *
>   * Use either while holding wait_queue_head::lock or when used for wakeups
> - * with an extra smp_mb() like:
> + * with an extra smp_mb() as shown in this diagram:
>   *
>   *      CPU0 - waker                    CPU1 - waiter
>   *
> 


-- 
~Randy
