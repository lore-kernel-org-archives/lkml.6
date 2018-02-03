Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeBCLoY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 06:44:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39234 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeBCLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 06:44:16 -0500
Date: Sat, 3 Feb 2018 12:43:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Stafford Horne <shorne@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <20180203114356.GV2269@hirez.programming.kicks-ass.net>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
 <201802030203.kIXRmGUe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201802030203.kIXRmGUe%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 03:14:01AM +0800, kbuild test robot wrote:
> Hi Peter,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on asm-generic/master]
> [also build test ERROR on v4.15 next-20180202]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Zijlstra/asm-generic-Disallow-no-op-mb-for-SMP-systems/20180203-000108
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> config: mn10300-asb2364_defconfig (attached as .config)
> compiler: am33_2.0-linux-gcc (GCC) 7.2.0

David, this one is yours :-) Does that mn10300 thing really have
sequentially consistent SMP (no store buffers or anything?)
