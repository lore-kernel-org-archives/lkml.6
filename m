Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeCNV1W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:27:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52273 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCNV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:27:21 -0400
Date: Wed, 14 Mar 2018 22:27:13 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: kbuild test robot <fengguang.wu@intel.com>
cc: "Tautschnig, Michael" <tautschn@amazon.co.uk>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Michael Tautschnig <tautschn@amazon.com>
Subject: Re: [tip:x86/urgent 2/2] include/linux/syscalls.h:194:18: error:
 conflicting types for 'sys_sigreturn'
In-Reply-To: <201803150455.fCJ6BtVM%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.21.1803142226120.1946@nanos.tec.linutronix.de>
References: <201803150455.fCJ6BtVM%fengguang.wu@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, kbuild test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> head:   1227b344de283f96c41de02cde4b26d5290f5302
> commit: 1227b344de283f96c41de02cde4b26d5290f5302 [2/2] x86/sigreturn: Use SYSCALL_DEFINE0
> config: i386-randconfig-x073-201810 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 1227b344de283f96c41de02cde4b26d5290f5302
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/kernel/signal.c:28:0:
> >> include/linux/syscalls.h:194:18: error: conflicting types for 'sys_sigreturn'
>      asmlinkage long sys_##sname(void)
>                      ^
> >> arch/x86/kernel/signal.c:605:1: note: in expansion of macro 'SYSCALL_DEFINE0'
>     SYSCALL_DEFINE0(sigreturn)
>     ^~~~~~~~~~~~~~~

Zapped the commit. Michael, can you please have a look?

Thanks,

	tglx
