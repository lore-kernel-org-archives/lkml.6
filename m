Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbeCUXJm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:09:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:30924 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754404AbeCUXJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:09:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="26467400"
Message-ID: <1521673774.6961.4.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: linux-next: manual merge of the ftrace tree with the jc_docs
 tree
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>
Date: Wed, 21 Mar 2018 18:09:34 -0500
In-Reply-To: <20180322092108.0d821abc@canb.auug.org.au>
References: <20180321153127.23737f6e@canb.auug.org.au>
         <20180321153715.3a571e5b@canb.auug.org.au>
         <20180321091554.2b38ee57@gandalf.local.home>
         <1521665752.31081.10.camel@tzanussi-mobl.amr.corp.intel.com>
         <20180322092108.0d821abc@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, 2018-03-22 at 09:21 +1100, Stephen Rothwell wrote:
> Hi Tom,
> 
> On Wed, 21 Mar 2018 15:55:52 -0500 Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> >
> > Yeah, linux-next has changes to Documentation/trace/* that converts
> > those files to .rst, which linux-trace/frace/core doesn't have.
> > 
> > I've rebased the inter-event patches to linux-next/next-20180320 to
> > reflect those changes, which affect 9 of the files in the patchset.  The
> > updated patchset is here:
> > 
> > https://github.com/tzanussi/linux-trace-inter-event.git tzanussi/next-20180320-inter-event-v10                                               
> > https://github.com/tzanussi/linux-trace-inter-event/tree/tzanussi/next-20180320-inter-event-v10
> > 
> > I can repost the whole thing as v10, or whatever makes sense here.
> 
> Thanks, I assume that they apply on top of the jc_docs tree as well
> (git://git.lwn.net/linux.git#docs-next).  If so, then I can use them as
> merge resolutions, or Steve can rebase his tree (minus your old
> patches) on top of the (hopefully unchanging) jc_docs tree and then he
> could apply your patches there.
> 

Yes, just checked and they do apply on top of the jc_docs branch
mentioned.

Thanks,

Tom 
