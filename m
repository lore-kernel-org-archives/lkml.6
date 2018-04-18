Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeDRPaY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeDRPaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:30:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0312E2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 18 Apr 2018 11:30:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Wang Nan <wangnan0@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180418113020.56ace21b@gandalf.local.home>
In-Reply-To: <20180418152536.GD10084@kernel.org>
References: <20180417130702.01575029@gandalf.local.home>
        <20180417172236.GA17342@light.dominikbrodowski.net>
        <20180417180430.GF3625@kernel.org>
        <20180417181304.GA2895@kernel.org>
        <20180417174128.0f3457f0@gandalf.local.home>
        <20180418125322.GB2895@kernel.org>
        <20180418103606.4118b35f@gandalf.local.home>
        <20180418150212.GA10084@kernel.org>
        <20180418151716.GC10084@kernel.org>
        <20180418112033.65632fef@gandalf.local.home>
        <20180418152536.GD10084@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 12:25:36 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, Apr 18, 2018 at 11:20:33AM -0400, Steven Rostedt escreveu:
> > On Wed, 18 Apr 2018 12:17:16 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >   
> > > This does the trick, by not using the main syscall routine, but one
> > > called from it and not renamed, should work with older kernels.
> > > 
> > > This test should be improved to look if the desired routine is in place,
> > > if not just skip the test and tell about the unavailability of the
> > > wanted function, but that is for later.  
> > 
> > Does this mean you can give me a "Tested-by" for that last patch?  
> 
> Here it is, just written down:
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 

Thanks!

-- Steve
