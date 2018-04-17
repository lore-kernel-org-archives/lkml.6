Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeDQRLI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeDQRLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:11:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8272175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 17 Apr 2018 14:10:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] tracing/x86: Update syscall trace events to handle new
 x86 syscall func names
Message-ID: <20180417171059.GE7775@kernel.org>
References: <20180417115440.2145f7f5@gandalf.local.home>
 <20180417163527.GA7775@kernel.org>
 <20180417124019.1e4350d5@gandalf.local.home>
 <20180417125723.6506e1d1@gandalf.local.home>
 <20180417170821.GD7775@kernel.org>
 <20180417131016.0c924b40@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417131016.0c924b40@gandalf.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 01:10:16PM -0400, Steven Rostedt escreveu:
> On Tue, 17 Apr 2018 14:08:22 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > > I get all the syscalls back. I'll make another patch.  
> > 
> > Argh, rebuilding the world, since lots of places include ftrace.h...
> 
> "make localmodconfig" is your friend.

I'm using that.

- Arnaldo
