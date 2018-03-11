Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932311AbeCKUBA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 16:01:00 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:55013 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932163AbeCKUA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 16:00:59 -0400
Date: Sun, 11 Mar 2018 21:00:56 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jesper Nilsson <jespern@axis.com>, Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-cris-kernel@axis.com, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>, Greentime Hu <green.hu@gmail.com>,
        Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Vincent Chen <deanbo422@gmail.com>, Dave Young <dyoung@redhat.com>
Subject: Re: [GIT PULL] CRIS: Drop support for the CRIS-port
Message-ID: <20180311200056.GY17177@axis.com>
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
 <20180308155116.GW17177@axis.com>
 <20180311110551.GX17177@axis.com>
 <20180312011344.6071896c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312011344.6071896c@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 01:13:44AM +1100, Stephen Rothwell wrote:
> Hi Jesper,
> 
> On Sun, 11 Mar 2018 12:05:51 +0100 Jesper Nilsson <jesper.nilsson@axis.com> wrote:
> >
> > As promised, pull the below tag for the removal of the CRIS-port.
> 
> I guess the easiest thing for me to do is just remove the cris tree
> from linux-next at this point?

Yeah, that's probably the way to go.

> Cheers,
> Stephen Rothwell

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
