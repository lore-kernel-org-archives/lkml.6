Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935197AbeBMNGN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:06:13 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51365 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754135AbeBMNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:06:12 -0500
X-Google-Smtp-Source: AH8x227PhnJAnOkqGZ+FN4EnDQcgIR38g76CoCwT7UC7MeSkWU8Q65ZYXXgKN3bpcTSDEqVzR4EN2w==
Date: Tue, 13 Feb 2018 14:06:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kangmin Park <l4stpr0gr4m@gmail.com>
Cc: tglx@linutronix.de, peterz@infradead.org, bigeasy@linutronix.de,
        paulmck@linux.vnet.ibm.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix a misspelling in kernel/cpu.c
Message-ID: <20180213130607.omsdyc7rkn4gl2ky@gmail.com>
References: <1517933521-10534-1-git-send-email-l4stpr0gr4m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517933521-10534-1-git-send-email-l4stpr0gr4m@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kangmin Park <l4stpr0gr4m@gmail.com> wrote:

> ---
>  kernel/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 53f7dc6..9a1ee53 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1336,7 +1336,7 @@ static struct cpuhp_step cpuhp_ap_states[] = {
>  		.teardown.single	= smpcfd_dying_cpu,
>  	},
>  	/* Entry state on starting. Interrupts enabled from here on. Transient
> -	 * state for synchronsization */
> +	 * state for synchronization */
>  	[CPUHP_AP_ONLINE] = {
>  		.name			= "ap:online",
>  	},

The comment style should be fixed too to match the rest of the kernel, plus a 
Signed-off-by is required as well.

Thanks,

	Ingo
