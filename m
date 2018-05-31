Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeEaUib (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754479AbeEaUia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:38:30 -0400
X-Google-Smtp-Source: ADUXVKI9U/dxWEsBwwh8+4RZwgnrAtF823znXRvlsOrqy+PjV8TLVgTcbKgb1qNi5T8/tNu/CZeRGVxktpLQ0wjjhPE=
MIME-Version: 1.0
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
 <1527789525-8857-3-git-send-email-chang.seok.bae@intel.com>
 <CALCETrX3wXJM9=i1K_winBLygPHCJj2=Ebdsf_7y5xMo-kSrQw@mail.gmail.com> <7A65BD11-6A84-4CDF-9FF7-34303BABBDD1@zytor.com>
In-Reply-To: <7A65BD11-6A84-4CDF-9FF7-34303BABBDD1@zytor.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 31 May 2018 13:38:17 -0700
X-Gmail-Original-Message-ID: <CALCETrUCciDnNyEvK2nQC1dbjYVnL3arK_+CvC3DnUFR1nRW5w@mail.gmail.com>
Message-ID: <CALCETrUCciDnNyEvK2nQC1dbjYVnL3arK_+CvC3DnUFR1nRW5w@mail.gmail.com>
Subject: Re: [PATCH V2 02/15] x86/fsgsbase/64: Make ptrace read FS/GS base accurately
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 1:31 PM <hpa@zytor.com> wrote:
>
> On May 31, 2018 1:14:59 PM PDT, Andy Lutomirski <luto@kernel.org> wrote:
> >On Thu, May 31, 2018 at 10:58 AM Chang S. Bae
> ><chang.seok.bae@intel.com> wrote:
> >>
> >> From: Andy Lutomirski <luto@kernel.org>
> >>
> >> ptrace can read FS/GS base using the register access API
> >> (PTRACE_PEEKUSER, etc) or PTRACE_ARCH_PRCTL.  Make both of these
> >> mechanisms return the actual FS/GS base.
> >>
> >> This will improve debuggability by providing the correct information
> >> to ptracer (GDB and etc).
> >
> >LGTM.
>
> LGTM?

Looks good to me.
