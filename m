Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeE0XF4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 19:05:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752551AbeE0XFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 19:05:55 -0400
Date: Mon, 28 May 2018 01:05:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Gabriel C <nix.or.die@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: smpboot seems to be confused on dual EPYC system
Message-ID: <20180527230550.GD6349@zn.tnic>
References: <CAEJqkgjMdeeiF+apcAGKdOJQRvaq8SLFsS2dvpuapY1DQn6oTA@mail.gmail.com>
 <20180527200707.GC6349@zn.tnic>
 <CAEJqkggtUvpfRjUUxQDx8tgV50NHayc=2nRTDNeWq83pZThsUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEJqkggtUvpfRjUUxQDx8tgV50NHayc=2nRTDNeWq83pZThsUQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 11:22:18PM +0200, Gabriel C wrote:
>  The problem is that being wrong ..
> 
>   >[    0.562171] smpboot: Max logical packages: 4
> 
>   These are max 2 not 4.

So the whole "problem" is that it miscounts max packages. Which means we
waste a couple of KBs of memory, tops.

Any other, real problems you're experiencing?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
