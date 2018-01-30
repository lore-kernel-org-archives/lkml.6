Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeA3JHk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:07:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751744AbeA3JHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:07:37 -0500
Date: Tue, 30 Jan 2018 17:07:29 +0800
From: Dave Young <dyoung@redhat.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH V2] print kdump kernel loaded status in stack dump
Message-ID: <20180130090729.GA2558@dhcp-128-65.nay.redhat.com>
References: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
 <20180130085055.GA569@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130085055.GA569@jagdpanzerIV>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/18 at 05:50pm, Sergey Senozhatsky wrote:
> On (01/27/18 12:11), Dave Young wrote:
> > It is useful to print kdump kernel loaded status in dump_stack() 
> > especially when panic happens so that we can differenciate 
> > kdump kernel early hang and a normal panic in a bug report.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> 
> Looks OK to me.
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 

Thank you Sergey

> 
> I agree with Steven, would be better to move the whole thing
> to lib/dump_stack.c

If nobody has plan I can put it in my todo list, probably do it next
week.

> 
> 	-ss

Thanks
Dave
