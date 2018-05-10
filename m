Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeEJT3W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:29:22 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46626 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEJT3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:29:20 -0400
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
To: Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, kernel-team@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180510163701.28936-1-guro@fb.com>
 <20180510183224.GP2368884@devbig577.frc2.facebook.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <a652ce44-07f9-d229-70d4-4376bfbafa40@kernel.org>
Date: Thu, 10 May 2018 13:29:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510183224.GP2368884@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 12:32 PM, Tejun Heo wrote:
> On Thu, May 10, 2018 at 05:37:01PM +0100, Roman Gushchin wrote:
>> Cgroups are used for controlling the physical resource distribution
>> (memory, CPU, io, etc) and often are used as basic building blocks
>> for large distributed computing systems. Even small differences
>> in the actual behavior may lead to significant incidents.
>>
>> The codebase is under the active development, which will unlikely
>> stop at any time soon. Also it's scattered over different
>> kernel subsystems, which makes regressions more probable.
>>
>> Given that, the lack of any tests is crying.
>>
>> This patch implements some basic tests for the memory controller,
>> as well as a minimal required framework.
>> It doesn't pretend for a very good coverage, but pretends
>> to be a starting point.
>>
>> Hopefully, any following significant changes will
>> include corresponding tests.
>>
>> Tests for CPU and io controllers, as well as cgroup core
>> are next in the todo list.
> 
> This is great.  Applying to cgroup/for-4.18.
> 
> Thanks a lot.
> 

Don't pull them yet. If Roman can redo the patches on linux-kselftest next,
he can pick up the SKIP changes.

thanks,
-- Shuah
