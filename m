Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE0liA4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB25C60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeFFEnF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 00:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbeFFEnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 00:43:03 -0400
Date: Wed, 6 Jun 2018 13:42:58 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH -tip v5 06/27] arm64: kprobes: Remove jprobe
 implementation
Message-Id: <20180606134258.9f75aab9fa4bfd50d0cca96d@kernel.org>
In-Reply-To: <20180605153420.GA26352@arm.com>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812748464.10068.10380156315388629319.stgit@devbox>
        <20180605153420.GA26352@arm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018 16:34:21 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Tue, Jun 05, 2018 at 12:51:24AM +0900, Masami Hiramatsu wrote:
> > Remove arch dependent setjump/longjump functions
> > and unused fields in kprobe_ctlblk for jprobes
> > from arch/arm64.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/include/asm/kprobes.h   |    1 -
> >  arch/arm64/kernel/probes/kprobes.c |   68 ------------------------------------
> >  2 files changed, 69 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thank you Will!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
