Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeEPGtx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:49:53 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54373 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeEPGts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:49:48 -0400
X-Google-Smtp-Source: AB8JxZpynPrHcD4X4iMXGswXiYTh/Hd2qVqwjt8BHZ4jpeejUVyx3/cEXwjCi7sCZvI/nHJQvmwn0A==
Date: Wed, 16 May 2018 08:49:43 +0200
From: Juri Lelli <juri.lelli@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net,
        x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 00/10] Intel_pstate: HWP Dynamic performance
 boost
Message-ID: <20180516064943.GA28366@localhost.localdomain>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 15/05/18 21:49, Srinivas Pandruvada wrote:

[...]

> 
> Peter Zijlstra (1):
>   x86,sched: Add support for frequency invariance

Cool! I was going to ask Peter about this patch. You beat me to it. :)

I'll have a lokk at the set. BTW, just noticed that you Cc-ed me using
my old address. Please use juri.lelli@redhat.com. ;)

Best,

- Juri
