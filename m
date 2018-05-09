Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935497AbeEIQfQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:35:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48278 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935485AbeEIQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:35:12 -0400
Subject: Re: [RFC] sched: Distinguish between idle_cpu calls based on desired
 effect
To: Peter Zijlstra <peterz@infradead.org>
Cc: matt@codeblueprint.co.uk, mingo@kernel.org, dhaval.giani@oracle.com,
        subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
References: <1525736477-8184-1-git-send-email-rohit.k.jain@oracle.com>
 <20180509085105.GG12217@hirez.programming.kicks-ass.net>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <64ec7411-8d88-5531-72e2-8ac69f163b76@oracle.com>
Date: Wed, 9 May 2018 09:34:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509085105.GG12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=996
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,


On 05/09/2018 01:51 AM, Peter Zijlstra wrote:
> On Mon, May 07, 2018 at 04:41:17PM -0700, Rohit Jain wrote:
>> In commit 247f2f6f3c706b40b5f3886646f3eb53671258bf we distinguish
>> between idle_cpu when the vcpu is not running for scheduling threads.
>> However, idle_cpu function is used at other places for actually checking
>> whether the state of the CPU is idle or not. Hence splitting the use of
>> that function based on the desired return value.
> Yes, that looks OK.

Great! Let me change the comment and send out v2.

>
> for your gitconfig:
>
> [core]
> 	abbrev = 12
> [alias]
>          one = show -s --pretty='format:%h (\"%s\")'
>
> $ git one 247f2f6f3c706b40b5f3886646f3eb53671258bf
> 247f2f6f3c70 ("sched/core: Don't schedule threads on pre-empted vCPUs")
>
> which gives the normal commit quote style.
>

Thanks! updated :)

Regards,
Rohit
