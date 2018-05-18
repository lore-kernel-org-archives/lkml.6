Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeERPn0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:43:26 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:38654 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:43:23 -0400
X-Google-Smtp-Source: AB8JxZpsh8lP5tD1ZaWOWAXsrsQwsehGYHSpLehkZWKdeG+6YC6KaljvHojwDwj4jXwf/irxecXbPWCN99Y84y27SD0=
MIME-Version: 1.0
In-Reply-To: <187e8a53-a1a8-60f9-811c-1e85beeac1f9@arm.com>
References: <1493389435-2525-1-git-send-email-vincent.guittot@linaro.org>
 <20180518093638.GL12198@hirez.programming.kicks-ass.net> <187e8a53-a1a8-60f9-811c-1e85beeac1f9@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 18 May 2018 17:43:02 +0200
Message-ID: <CAKfTPtBAcxpimoXbbDSjG5ApdqTfPt3x=DMi0mGyw9xRkZ-3-Q@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: update scale invariance of PELT
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Yuyang Du <yuyang.du@intel.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 May 2018 at 17:16, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 05/18/2018 10:36 AM, Peter Zijlstra wrote:
>>
>>
>> Replying to the latest version available; given the current interest I
>> figure I'd re-read some of the old threads and look at this stuff again.
>>
>> On Fri, Apr 28, 2017 at 04:23:55PM +0200, Vincent Guittot wrote:
>
>
> [...]
>
>> What happened to the proposed changes here:
>>
>>    https://marc.info/?l=linux-kernel&m=149383148721909&w=2
>>
>> to deal with the load scaling issues?
>
>
> They are not in this v3 version. I haven't tested them back then. I assume
> that Vincent will incorporate that bit into his update.

Yes I will integrated all pending changes in the next version. I have
some changes that I haven't fully tested yet

>
>
