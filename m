Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeERPQp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:16:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54816 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeERPQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:16:42 -0400
Subject: Re: [PATCH v3] sched/fair: update scale invariance of PELT
To: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        Morten.Rasmussen@arm.com, yuyang.du@intel.com, pjt@google.com,
        bsegall@google.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1493389435-2525-1-git-send-email-vincent.guittot@linaro.org>
 <20180518093638.GL12198@hirez.programming.kicks-ass.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <187e8a53-a1a8-60f9-811c-1e85beeac1f9@arm.com>
Date: Fri, 18 May 2018 16:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518093638.GL12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 10:36 AM, Peter Zijlstra wrote:
> 
> Replying to the latest version available; given the current interest I
> figure I'd re-read some of the old threads and look at this stuff again.
> 
> On Fri, Apr 28, 2017 at 04:23:55PM +0200, Vincent Guittot wrote:

[...]

> What happened to the proposed changes here:
> 
>    https://marc.info/?l=linux-kernel&m=149383148721909&w=2
> 
> to deal with the load scaling issues?

They are not in this v3 version. I haven't tested them back then. I 
assume that Vincent will incorporate that bit into his update.
