Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCWGJb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 02:09:31 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34512 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCWGJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 02:09:29 -0400
X-Google-Smtp-Source: AG47ELuMnLz2Jw2BUeUTwXW3eOawU3lBHXs6Gxq9kyWiK3aUtAT+fvgQ3FpLZyb/k4hTwHg0e6IcjA==
Date: Fri, 23 Mar 2018 07:09:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: linux-next: manual merge of the tip tree with the pm tree
Message-ID: <20180323060924.jeppeix62c3wza6l@gmail.com>
References: <20180323132001.7da7f3c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323132001.7da7f3c4@canb.auug.org.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in:
> 
>   kernel/sched/cpufreq_schedutil.c
> 
> between commit:
> 
>   0953feed3400 ("cpufreq: schedutil: rate limits for SCHED_DEADLINE")

Rafael, could you please send that to the scheduler tree?

Thanks,

	Ingo
