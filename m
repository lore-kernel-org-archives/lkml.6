Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755282AbeEaNqs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:46:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755085AbeEaNqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:46:45 -0400
Date: Thu, 31 May 2018 08:46:42 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v3 1/6] x86/stacktrace: do not unwind after user regs
Message-ID: <20180531134642.sl2ezvng2cdsyklk@treble>
References: <20180518064713.26440-1-jslaby@suse.cz>
 <20180518065547.GA18262@gmail.com>
 <20180518224125.w2ty35wngxbzx6kv@treble>
 <20180519074251.GA2952@gmail.com>
 <20180522160609.yppbfdpfoigoyuxg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180522160609.yppbfdpfoigoyuxg@treble>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:06:09AM -0500, Josh Poimboeuf wrote:
> On Sat, May 19, 2018 at 09:42:51AM +0200, Ingo Molnar wrote:
> > 
> > * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > > On Fri, May 18, 2018 at 08:55:47AM +0200, Ingo Molnar wrote:
> > > > 
> > > > * Jiri Slaby <jslaby@suse.cz> wrote:
> > > > 
> > > > > Josh pointed out, that there is no way a frame can be after user regs.
> > > > > So remove the last unwind and the check.
> > > > > 
> > > > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > > Cc: x86@kernel.org
> > > > > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > 
> > > > Josh: an Acked-by or Reviewed-by for the whole series from you would be nice.
> > > 
> > > The patches look good, but I want to run it through some testing before
> > > I give them an ACK.
> 
> For the series:
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Ingo,

Any chance this can make the next merge window?

-- 
Josh
