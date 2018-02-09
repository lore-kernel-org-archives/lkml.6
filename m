Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeBIIkp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:40:45 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:42271 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeBIIkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:40:43 -0500
X-Google-Smtp-Source: AH8x227TXmf95rBN6ubl94GOJYzg50ndx47pHqZYUU4NLVjHRas2uLjF21mC/Eheibq/nv7oIZSDZg==
Date: Fri, 9 Feb 2018 14:10:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Message-ID: <20180209084039.GZ28462@vireshk-i7>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
 <20180209035143.GX28462@vireshk-i7>
 <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-18, 09:02, Claudio Scordino wrote:
> If I'm not wrong, at the hardware level we do have a physical rate limit (as we cannot trigger a frequency update when there is one already on-going).
> Don't know if this could somehow mitigate such effect.

Yeah, so in the worst case we will start a new freq-change right after
the previous one has finished.

-- 
viresh
