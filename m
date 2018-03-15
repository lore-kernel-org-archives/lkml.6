Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeCORt4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752078AbeCORty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:49:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A618B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Mar 2018 14:49:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, yan.y.zhao@intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: __print_array should print hex format
 instead of dec
Message-ID: <20180315174950.GF3690@kernel.org>
References: <1520937557-24895-1-git-send-email-changbin.du@intel.com>
 <20180313142732.GA29837@kernel.org>
 <20180315132025.5825df8c@vmware.local.home>
 <20180315133156.3389b762@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315133156.3389b762@vmware.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 15, 2018 at 01:31:56PM -0400, Steven Rostedt escreveu:
> On Thu, 15 Mar 2018 13:20:25 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 13 Mar 2018 11:27:32 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > Em Tue, Mar 13, 2018 at 06:39:17PM +0800, changbin.du@intel.com escreveu:  
> > > > From: Changbin Du <changbin.du@intel.com>
> > > > 
> > > > The token '__print_array' is to print the array in hex format, but not
> > > > decimal numbers. The implementation of __print_array in kernel side is:
> > > > __print_array()->trace_print_array_seq()
> > > > 
> > > > This patch align the perf's behavior with kernel so we have a consistent
> > > > event format.    
> > > 
> > > Look ok, i.e. makes the userspace formatting do what the equivalent
> > > kernel code does, Rostedt, Ack?
> > >   
> > 
> > Thanks for sending this to me. I'll see how it affects trace-cmd, and
> > let you know.
> >
> 
> Looks good!
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

thanks, applying
