Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeDEI4f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:56:35 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39848 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeDEI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:56:32 -0400
X-Google-Smtp-Source: AIpwx48QKSQAwBGNySc2Nw5AFvLJcEBZ4r+eM1TlwgYiZLgtGZtM/9J0DmqiRAdNMpeU5uV231NeWQ==
Date: Thu, 5 Apr 2018 10:56:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Luck, Tony" <tony.luck@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Norbert Manthey <nmanthey@amazon.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Message-ID: <20180405085628.5ylxwxyr2duslvop@gmail.com>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
 <20180403073706.GV4082@hirez.programming.kicks-ass.net>
 <20180403185829.yteixqsb5zazmav6@agluck-desk>
 <3908561D78D1C84285E8C5FCA982C28F7B3C2F5D@ORSMSX110.amr.corp.intel.com>
 <20180404072513.GF4082@hirez.programming.kicks-ass.net>
 <20180404163855.3obxjshmrlppzhdp@agluck-desk>
 <20180404165310.GJ4082@hirez.programming.kicks-ass.net>
 <20180405080521.GG4129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405080521.GG4129@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 04, 2018 at 06:53:10PM +0200, Peter Zijlstra wrote:
> > Awesome, I'll go get it merged, even though I don't understand where it
> > went wobbly.
> 
> Ingo, could you magic this in?
> 
> ---
> Subject: sched: Force alignment of struct util_est
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Apr  5 09:56:16 CEST 2018

Sure, done!

Thanks,

	Ingo
