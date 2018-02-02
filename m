Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeBBVJ3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:09:29 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:36988 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752341AbeBBVJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:09:21 -0500
Date: Fri, 2 Feb 2018 21:08:20 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Stafford Horne <shorne@gmail.com>, Will Deacon <will.deacon@arm.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <20180202210820.48ed7f87@alans-desktop>
In-Reply-To: <20180202202549.GT2269@hirez.programming.kicks-ass.net>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
        <201802030326.M4zaX4v1%fengguang.wu@intel.com>
        <20180202202549.GT2269@hirez.programming.kicks-ass.net>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018 21:25:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Feb 03, 2018 at 04:00:35AM +0800, kbuild test robot wrote:
> > Hi Peter,
> > 
> > I love your patch! Yet something to improve:  
> 
> Seriously? Bots have feelings?
> 
> > [auto build test ERROR on asm-generic/master]
> > [also build test ERROR on v4.15 next-20180202]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Peter-Zijlstra/asm-generic-Disallow-no-op-mb-for-SMP-systems/20180203-000108
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> > config: m32r-usrv_defconfig (attached as .config)
> > compiler: m32r-linux-gcc (GCC) 7.2.0  
> 
> Awesome, another broken architecture.. and this one is Orphaned :-(
> No maintainer to bug..

Renesas claim to still support the processor family so perhaps they can
provide a maintainer if you instead submit a patch to remove it from the
tree ;-)

>From the documentation however the processor only does explicit dual
issue instructions, and the SMP is cache coherent so I'm not convinced
there is a problem with it.


Alan
