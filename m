Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeBII1v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:27:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750925AbeBII1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:27:51 -0500
Date: Fri, 9 Feb 2018 16:27:43 +0800
From: Dave Young <dyoung@redhat.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] printk: move dump stack related code to lib/dump_stack.c
Message-ID: <20180209082743.GA14845@dhcp-128-65.nay.redhat.com>
References: <20180209080624.GA2607@dhcp-128-65.nay.redhat.com>
 <20180209081604.GE689@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209081604.GE689@jagdpanzerIV>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/18 at 05:16pm, Sergey Senozhatsky wrote:
> Hi,
> 
> On (02/09/18 16:06), Dave Young wrote:
> [..]
> > +void __init dump_stack_set_arch_desc(const char *fmt, ...)
> ..
> > +void dump_stack_print_info(const char *log_lvl)
> ..
> > +void show_regs_print_info(const char *log_lvl)
> ..
> 
> Seems that those functions are still defined in printk header.
> Did you test !CONFIG_PRINTK build?

!CONFIG_PRINTK will use the dummy functions in printk.h, I did not test
the build, doing it now to double confirm..

Thanks
Dave

> 
> 	-ss
