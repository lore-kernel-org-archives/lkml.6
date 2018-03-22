Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755199AbeCVNlW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbeCVNlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:41:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25212177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 22 Mar 2018 09:41:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>
Subject: Re: linux-next: manual merge of the ftrace tree with the jc_docs
 tree
Message-ID: <20180322094117.37f3a2fd@gandalf.local.home>
In-Reply-To: <20180322092108.0d821abc@canb.auug.org.au>
References: <20180321153127.23737f6e@canb.auug.org.au>
        <20180321153715.3a571e5b@canb.auug.org.au>
        <20180321091554.2b38ee57@gandalf.local.home>
        <1521665752.31081.10.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180322092108.0d821abc@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018 09:21:08 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > I can repost the whole thing as v10, or whatever makes sense here.  
> 
> Thanks, I assume that they apply on top of the jc_docs tree as well
> (git://git.lwn.net/linux.git#docs-next).  If so, then I can use them as
> merge resolutions, or Steve can rebase his tree (minus your old
> patches) on top of the (hopefully unchanging) jc_docs tree and then he
> could apply your patches there.

Too late for a rebase. I've already run it through my tests and posted,
I don't rebase anything that goes to linux-next unless there's a really
good reason to do so. I don't think this is one.

I'll just make sure Linus knows about it and have a link to point to
the proper end results. He's stated he's fine with those kinds of
solutions. And since this is only a documentation conflict, we don't
need to worry about mistakes causing subtle behavior with the kernel.

-- Steve
