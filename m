Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeBUKuV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:50:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36817 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeBUKuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:50:19 -0500
Date: Wed, 21 Feb 2018 11:50:08 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <fengguang.wu@intel.com>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, lkp@01.org
Subject: Re: [kernel/sofirq]  ffce8e6f93:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <20180221105008.o4ooqw6hoe5hh4m7@linutronix.de>
References: <20180215172042.31573-2-bigeasy@linutronix.de>
 <20180220174801.n6qexw4adb5hcd4m@inn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180220174801.n6qexw4adb5hcd4m@inn>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-21 01:48:01 [+0800], kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: ffce8e6f936e3d879910a76cf8ce6293d78a51e6 ("kernel/sofirq: consolidate common code in __tasklet_schedule() + _hi_")
> url: https://github.com/0day-ci/linux/commits/Sebastian-Andrzej-Siewior/kernel-sofirq-consolidate-common-code-in-__tasklet_schedule-_hi_/20180218-010957

yes, and this patch was superseded by

  https://lkml.kernel.org/r/20180216170836.ex2uxcgkk7gniwqi@linutronix.de

Sebastian
