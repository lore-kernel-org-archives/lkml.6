Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeEaWqp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbeEaWqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:46:40 -0400
Date: Thu, 31 May 2018 18:46:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, trivial@kernel.org
Subject: Re: [PATCH] ftrace: use non-archaic spelling of failes
Message-ID: <20180531184638.01e99099@vmware.local.home>
In-Reply-To: <20180531121701.8972-1-cascardo@canonical.com>
References: <20180531121701.8972-1-cascardo@canonical.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 09:17:01 -0300
Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8d83bcf9ef69..b218cee1f18c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4788,7 +4788,7 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
>   * @reset - non zero to reset all filters before applying this filter.
>   *
>   * Filters denote which functions should be enabled when tracing is enabled
> - * If @ip is NULL, it failes to update filter.
> + * If @ip is NULL, it fails to update filter.
>   */
>  int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
>  			 int remove, int reset)
