Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeA3Jgp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:36:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:36520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbeA3Jgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:36:42 -0500
Date: Tue, 30 Jan 2018 10:36:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Dave Young <dyoung@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@linux.intel.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kexec@lists.infradead.org
Subject: Re: [PATCH V2] print kdump kernel loaded status in stack dump
Message-ID: <20180130093640.r4a45m6eicmyeljc@pathway.suse.cz>
References: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
 <20180130085055.GA569@jagdpanzerIV>
 <20180130090729.GA2558@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130090729.GA2558@dhcp-128-65.nay.redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-01-30 17:07:29, Dave Young wrote:
> On 01/30/18 at 05:50pm, Sergey Senozhatsky wrote:
> > On (01/27/18 12:11), Dave Young wrote:
> > > It is useful to print kdump kernel loaded status in dump_stack() 
> > > especially when panic happens so that we can differenciate 
> > > kdump kernel early hang and a normal panic in a bug report.
> > > 
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > 
> > Looks OK to me.
> > 
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Same here:

Reviewed-by: Petr Mladek <pmladek@suse.com>

> > I agree with Steven, would be better to move the whole thing
> > to lib/dump_stack.c
> 
> If nobody has plan I can put it in my todo list, probably do it next
> week.

Sounds good.

JFYI, I would target these changes for 4.17. There was some discussion
about where and how to show the new information. IMHO, it would deserve
some gurgling in linux-next.

Best Regards,
Petr
