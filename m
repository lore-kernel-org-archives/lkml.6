Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755494AbeEaPRD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:17:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755134AbeEaPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:17:00 -0400
Date: Thu, 31 May 2018 12:16:54 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Subject: Re: [PATCH] ftrace: use non-archaic spelling of failes
Message-ID: <20180531151653.GA3903@calabresa>
References: <20180531121701.8972-1-cascardo@canonical.com>
 <993c7040bd1e5251abd70ff3aa7e3141f28b3505.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993c7040bd1e5251abd70ff3aa7e3141f28b3505.camel@perches.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:15:45AM -0700, Joe Perches wrote:
> On Thu, 2018-05-31 at 09:17 -0300, Thadeu Lima de Souza Cascardo wrote:
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> []
> > @@ -4788,7 +4788,7 @@ ftrace_set_addr(struct ftrace_ops *ops, unsigned long ip, int remove,
> >   * @reset - non zero to reset all filters before applying this filter.
> >   *
> >   * Filters denote which functions should be enabled when tracing is enabled
> > - * If @ip is NULL, it failes to update filter.
> > + * If @ip is NULL, it fails to update filter.
> >   */
> >  int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
> >  			 int remove, int reset)
> 
> Perhaps fix it treewide?
> 
> $ git grep -w -i failes | wc -l
> 8
> 

I sent patches to the respective maintainers for all of these.

Cascardo.
