Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755643AbeDWQcS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:32:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755165AbeDWQcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:32:15 -0400
Subject: Re: [PATCH v7 0/5] cpuset: Enable cpuset controller in default
 hierarchy
To: Mike Galbraith <efault@gmx.de>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>, Juri Lelli <juri.lelli@redhat.com>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
 <1524212601.11030.2.camel@gmx.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f1f02718-c7e7-f6b3-be7b-3d7c2f2ffa50@redhat.com>
Date: Mon, 23 Apr 2018 12:32:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1524212601.11030.2.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/2018 04:23 AM, Mike Galbraith wrote:
> On Thu, 2018-04-19 at 09:46 -0400, Waiman Long wrote:
>> v7:
>>  - Add a root-only cpuset.cpus.isolated control file for CPU isolation.
>>  - Enforce that load_balancing can only be turned off on cpusets with
>>    CPUs from the isolated list.
>>  - Update sched domain generation to allow cpusets with CPUs only
>>    from the isolated CPU list to be in separate root domains.
> I haven't done much, but was able to do a q/d manual build, populate
> and teardown of system/critical sets on my desktop box, and it looked
> ok.  Thanks for getting this aboard the v2 boat.
>
> 	-Mike

Thank for the testing.

Cheers,
Longman
