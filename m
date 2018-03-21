Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeCUNQA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeCUNP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:15:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCBD21716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 21 Mar 2018 09:15:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: linux-next: manual merge of the ftrace tree with the jc_docs
 tree
Message-ID: <20180321091554.2b38ee57@gandalf.local.home>
In-Reply-To: <20180321153715.3a571e5b@canb.auug.org.au>
References: <20180321153127.23737f6e@canb.auug.org.au>
        <20180321153715.3a571e5b@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 15:37:15 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Wed, 21 Mar 2018 15:31:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the ftrace tree got a conflict in:
> > 
> >   Documentation/trace/ftrace.txt
> >   (converted to Documentation/trace/ftrace.rst)  
> 
> There was another conflict involving
> 
>   Documentation/trace/events.{txt,rst}
> 
> Unfortunately, I accidentally deleted the report email before sending
> it :-(
> 

Ug yeah. All the histogram code was ripped out of the events.txt and
a new file was created called histogram.txt. I'm guessing that should
also be converted into an .rst file.

-- Steve
