Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeE0XQl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 19:16:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752420AbeE0XQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 19:16:40 -0400
Date: Mon, 28 May 2018 01:16:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Gabriel C <nix.or.die@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: smpboot seems to be confused on dual EPYC system
Message-ID: <20180527231636.GE6349@zn.tnic>
References: <CAEJqkgjMdeeiF+apcAGKdOJQRvaq8SLFsS2dvpuapY1DQn6oTA@mail.gmail.com>
 <20180527200707.GC6349@zn.tnic>
 <CAEJqkggtUvpfRjUUxQDx8tgV50NHayc=2nRTDNeWq83pZThsUQ@mail.gmail.com>
 <CAEJqkghh0_kiRu3xaBSfaNSoJTDgNp1ep-03+XTiF2-_cFjASA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEJqkghh0_kiRu3xaBSfaNSoJTDgNp1ep-03+XTiF2-_cFjASA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 12:51:17AM +0200, Gabriel C wrote:
> 128CPUs for sure not possible and for sure no way to have '2' CPUs installed.

With that last "'2' CPUs" you mean, two physical processors and thus two
sockets, right?

In any case, this info is what we've gotten from the BIOS so if that
BIOS tells us this way...

Again, you don't see any other issues besides the misrepresenting of max
packages or?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
