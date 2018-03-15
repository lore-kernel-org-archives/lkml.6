Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeCOTXs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:23:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCOTXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:23:47 -0400
Date: Thu, 15 Mar 2018 20:23:38 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: kbuild test robot <fengguang.wu@intel.com>
cc: Palmer Dabbelt <palmer@sifive.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:irq/core 12/14] arch/arm/kernel/entry-armv.S:26:10: fatal
 error: mach/entry-macro.S: No such file or directory
In-Reply-To: <201803160358.5DjrLA3T%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.21.1803152022400.1520@nanos.tec.linutronix.de>
References: <201803160358.5DjrLA3T%fengguang.wu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, kbuild test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> head:   d9af5838180359c6be1c07989c91b28eee93d7e7
> commit: 886d70aac148f6015ae3d1379c81b98af3e70981 [12/14] ARM: irq: Convert to GENERIC_IRQ_MULTI_HANDLER
> config: arm-ep93xx_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 886d70aac148f6015ae3d1379c81b98af3e70981
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/arm/kernel/entry-armv.S:26:10: fatal error: mach/entry-macro.S: No such file or directory
>     #include <mach/entry-macro.S>
>              ^~~~~~~~~~~~~~~~~~~~
>    compilation terminated.

Palmer,

I zapped the arm/arm64/openrisc commits for now from the irq/core
branch. Can you please have a look?

Thanks,

	tglx
