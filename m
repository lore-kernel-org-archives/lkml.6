Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCCKDD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 05:03:03 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:44375 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCCKDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 05:03:02 -0500
X-Google-Smtp-Source: AG47ELt4Nsbb3UnJPq6Sl2ahZVU50RBRMVKStu3voSQcTye/nGQqHJU1Zzw+d38k1QZCv+GTp1n8xw==
Date: Sat, 3 Mar 2018 11:02:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: "x86/boot/compressed/64: Prepare trampoline memory" breaks boot
 on Zotac CI-321
Message-ID: <20180303100257.hzrqtshcnhzy5spl@gmail.com>
References: <12357ee3-0276-906a-0e7c-2c3055675af3@gmail.com>
 <CAA42JLZRxCGSsW5FKpH3AjZGbaUyrcRPdVBtMQcc4ZcxKNuDQw@mail.gmail.com>
 <8c6c0f9d-0f47-2fc9-5cb5-6335ef1152cd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6c0f9d-0f47-2fc9-5cb5-6335ef1152cd@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiner Kallweit <hkallweit1@gmail.com> wrote:

> Am 03.03.2018 um 00:50 schrieb Dexuan-Linux Cui:
> > On Fri, Mar 2, 2018 at 12:57 PM, Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>> wrote:
> > 
> >     Recently my Mini PC Zotac CI-321 started to reboot immediately before
> >     anything was written to the console.
> > 
> >     Bisecting lead to b91993a87aff "x86/boot/compressed/64: Prepare
> >     trampoline memory" being the change breaking boot.
> > 
> >     If you need any more information, please let me know.
> > 
> >     Rgds, Heiner
> > 
> > 
> > This may fix the issue: https://lkml.org/lkml/2018/2/13/668
> > 
> > Kirill posted a v2 patchset 3 days ago and I suppose the patchset should include the fix.
> > 
> Thanks for the link. I bisected based on the latest next kernel including
> v2 of the patchset (IOW - the potential fix is included already).

Are you sure? b91993a87aff is the old patch-set - which I just removed from -next 
and which should thus be gone in the Monday iteration of -next.

I have not merged v2 in -tip yet, did it get applied via some other tree?

Thanks,

	Ingo
