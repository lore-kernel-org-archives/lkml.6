Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeESHm4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 03:42:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39092 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeESHmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 03:42:55 -0400
X-Google-Smtp-Source: AB8JxZrA+t+Rj5PG/5znjpXnhk1NaI7kUtLRxSjGobG41TpQzRh24pRbDb4CnEnuArvACRKog0iDdg==
Date: Sat, 19 May 2018 09:42:51 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v3 1/6] x86/stacktrace: do not unwind after user regs
Message-ID: <20180519074251.GA2952@gmail.com>
References: <20180518064713.26440-1-jslaby@suse.cz>
 <20180518065547.GA18262@gmail.com>
 <20180518224125.w2ty35wngxbzx6kv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518224125.w2ty35wngxbzx6kv@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Fri, May 18, 2018 at 08:55:47AM +0200, Ingo Molnar wrote:
> > 
> > * Jiri Slaby <jslaby@suse.cz> wrote:
> > 
> > > Josh pointed out, that there is no way a frame can be after user regs.
> > > So remove the last unwind and the check.
> > > 
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: x86@kernel.org
> > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > Josh: an Acked-by or Reviewed-by for the whole series from you would be nice.
> 
> The patches look good, but I want to run it through some testing before
> I give them an ACK.

Sure thing and thanks!

	Ingo
