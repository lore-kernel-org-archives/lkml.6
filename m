Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965590AbeBMSyD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:54:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965473AbeBMSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:54:02 -0500
Subject: Re: linux-next: Tree for Feb 13 (i386: apm_32.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>
References: <20180213151545.43e078ca@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <88ad6845-4350-d328-f5f4-c8486b962e79@infradead.org>
Date: Tue, 13 Feb 2018 10:54:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213151545.43e078ca@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 08:15 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180212:
> 
> Non-merge commits (relative to Linus' tree): 963
>  1297 files changed, 63627 insertions(+), 31515 deletions(-)
> 
> ----------------------------------------------------------------------------

on i386:

arch/x86/kernel/apm_32.o: In function `apm_init':
apm_32.c:(.init.text+0x47a): undefined reference to `cpuidle_poll_state_init'

drivers/cpuidle/ is not being built:

# CONFIG_CPU_IDLE is not set
CONFIG_ARCH_HAS_CPU_RELAX=y
obj-$(CONFIG_CPU_IDLE)		+= cpuidle/



-- 
~Randy
