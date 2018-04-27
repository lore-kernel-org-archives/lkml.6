Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758498AbeD0Plt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:41:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47796 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752471AbeD0Pls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:41:48 -0400
Date: Fri, 27 Apr 2018 17:41:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tony.luck@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>, linux-edac@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: stack out-of-bounds write in mce-inject.c
Message-ID: <20180427154115.GF15229@pd.tnic>
References: <CACT4Y+Ys9bKFNaBm7YuCvk04jcZ2SnLiDSxgCojZMwtb2PKVBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Ys9bKFNaBm7YuCvk04jcZ2SnLiDSxgCojZMwtb2PKVBg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 05:24:24PM +0200, Dmitry Vyukov wrote:
> Hi,
> 
> Opening /sys/kernel/debug/mce-inject/flags overwrites stack:
> 
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in vsnprintf+0x1b23/0x1b40 lib/vsprintf.c:2365
> Write of size 1 at addr ffff8800627b7abb by task egrep/4309

How do you trigger this exactly?

You grep it for something apparently...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
