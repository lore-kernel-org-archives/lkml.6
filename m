Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeCPHzj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:55:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54963 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPHzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:55:38 -0400
Date: Fri, 16 Mar 2018 08:55:13 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: linux-next: build warning after merge of the tip tree
In-Reply-To: <20180316163716.5525294f@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.1803160854470.1598@nanos.tec.linutronix.de>
References: <20180316163716.5525294f@canb.auug.org.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the tip tree, yesterday's linux-next build (x86_64 allnoconfig)
> produced this warning:
> 
> kernel/cpu.c:129:13: warning: 'cpuhp_is_ap_state' defined but not used [-Wunused-function]
>  static bool cpuhp_is_ap_state(enum cpuhp_state state)
>              ^~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")

Fix is queued already. Did not make it into the branch you pull yet.

Thanks,

	tglx
