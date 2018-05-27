Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeE0X0X (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 19:26:23 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:51546 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeE0X0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 19:26:20 -0400
X-Google-Smtp-Source: ADUXVKIAvJEHmu5FwbIOz4Sr3ccSQe9tjYMp3SI3vBp3Mz4V8GWwSLDSwiqQOQOc110yscr0VSwoCSrATC3yr8Pgu3w=
MIME-Version: 1.0
In-Reply-To: <20180527231636.GE6349@zn.tnic>
References: <CAEJqkgjMdeeiF+apcAGKdOJQRvaq8SLFsS2dvpuapY1DQn6oTA@mail.gmail.com>
 <20180527200707.GC6349@zn.tnic> <CAEJqkggtUvpfRjUUxQDx8tgV50NHayc=2nRTDNeWq83pZThsUQ@mail.gmail.com>
 <CAEJqkghh0_kiRu3xaBSfaNSoJTDgNp1ep-03+XTiF2-_cFjASA@mail.gmail.com> <20180527231636.GE6349@zn.tnic>
From: Gabriel C <nix.or.die@gmail.com>
Date: Mon, 28 May 2018 01:25:49 +0200
Message-ID: <CAEJqkgjCzgE-xKHxVLDU3dCOpwJ4P6DwOY7n9tU_xD7e_fdtYw@mail.gmail.com>
Subject: Re: smpboot seems to be confused on dual EPYC system
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-28 1:16 GMT+02:00 Borislav Petkov <bp@alien8.de>:
> On Mon, May 28, 2018 at 12:51:17AM +0200, Gabriel C wrote:
>> 128CPUs for sure not possible and for sure no way to have '2' CPUs installed.
>
> With that last "'2' CPUs" you mean, two physical processors and thus two
> sockets, right?

Yes.

>
> In any case, this info is what we've gotten from the BIOS so if that
> BIOS tells us this way...

Sure .. not the first time BIOSes lies about things :)

I never said that being an kernel bug I just noticed
something is getting confused.

>
> Again, you don't see any other issues besides the misrepresenting of max
> packages or?
>

Right no other issues.
