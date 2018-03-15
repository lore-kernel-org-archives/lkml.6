Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeCORet (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752284AbeCORcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9937720779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 15 Mar 2018 13:31:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: changbin.du@intel.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, yan.y.zhao@intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: __print_array should print hex format
 instead of dec
Message-ID: <20180315133156.3389b762@vmware.local.home>
In-Reply-To: <20180315132025.5825df8c@vmware.local.home>
References: <1520937557-24895-1-git-send-email-changbin.du@intel.com>
        <20180313142732.GA29837@kernel.org>
        <20180315132025.5825df8c@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 13:20:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 13 Mar 2018 11:27:32 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Tue, Mar 13, 2018 at 06:39:17PM +0800, changbin.du@intel.com escreveu:  
> > > From: Changbin Du <changbin.du@intel.com>
> > > 
> > > The token '__print_array' is to print the array in hex format, but not
> > > decimal numbers. The implementation of __print_array in kernel side is:
> > > __print_array()->trace_print_array_seq()
> > > 
> > > This patch align the perf's behavior with kernel so we have a consistent
> > > event format.    
> > 
> > Look ok, i.e. makes the userspace formatting do what the equivalent
> > kernel code does, Rostedt, Ack?
> >   
> 
> Thanks for sending this to me. I'll see how it affects trace-cmd, and
> let you know.
>

Looks good!

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
