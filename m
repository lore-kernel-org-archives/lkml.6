Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeCUUz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:55:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:6263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753210AbeCUUzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:55:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="27740398"
Message-ID: <1521665752.31081.10.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: linux-next: manual merge of the ftrace tree with the jc_docs
 tree
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>
Date: Wed, 21 Mar 2018 15:55:52 -0500
In-Reply-To: <20180321091554.2b38ee57@gandalf.local.home>
References: <20180321153127.23737f6e@canb.auug.org.au>
         <20180321153715.3a571e5b@canb.auug.org.au>
         <20180321091554.2b38ee57@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 09:15 -0400, Steven Rostedt wrote:
> On Wed, 21 Mar 2018 15:37:15 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > On Wed, 21 Mar 2018 15:31:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the ftrace tree got a conflict in:
> > > 
> > >   Documentation/trace/ftrace.txt
> > >   (converted to Documentation/trace/ftrace.rst)  
> > 
> > There was another conflict involving
> > 
> >   Documentation/trace/events.{txt,rst}
> > 
> > Unfortunately, I accidentally deleted the report email before sending
> > it :-(
> > 
> 
> Ug yeah. All the histogram code was ripped out of the events.txt and
> a new file was created called histogram.txt. I'm guessing that should
> also be converted into an .rst file.
> 

Yeah, linux-next has changes to Documentation/trace/* that converts
those files to .rst, which linux-trace/frace/core doesn't have.

I've rebased the inter-event patches to linux-next/next-20180320 to
reflect those changes, which affect 9 of the files in the patchset.  The
updated patchset is here:

https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/next-20180320-inter-event-v10                                               
https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/next-20180320-inter-event-v10

I can repost the whole thing as v10, or whatever makes sense here.

Thanks,

Tom

> -- Steve
