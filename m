Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753714AbeDQRK0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeDQRKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:10:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7622175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 17 Apr 2018 13:10:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] tracing/x86: Update syscall trace events to handle new
 x86 syscall func names
Message-ID: <20180417131016.0c924b40@gandalf.local.home>
In-Reply-To: <20180417170821.GD7775@kernel.org>
References: <20180417115440.2145f7f5@gandalf.local.home>
        <20180417163527.GA7775@kernel.org>
        <20180417124019.1e4350d5@gandalf.local.home>
        <20180417125723.6506e1d1@gandalf.local.home>
        <20180417170821.GD7775@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 14:08:22 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > I get all the syscalls back. I'll make another patch.  
> 
> Argh, rebuilding the world, since lots of places include ftrace.h...

"make localmodconfig" is your friend.

-- Steve
