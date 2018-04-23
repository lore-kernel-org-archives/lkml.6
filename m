Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755237AbeDWNJ1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:09:27 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.60]:35412 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754887AbeDWNJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:09:25 -0400
X-Authority-Reason: nr=8
Subject: Re: Smatch check for Spectre stuff
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        dan.j.williams@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180419051510.GA21898@mwanda>
 <20180420120044.GN4064@hirez.programming.kicks-ass.net>
 <fb72fc65-085b-65dc-c965-492d6d0902ea@embeddedor.com>
 <20180423124552.GY4064@hirez.programming.kicks-ass.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <db67acd5-ecc6-ff2c-cd10-e2e1fdf8822f@embeddedor.com>
Date: Mon, 23 Apr 2018 08:08:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423124552.GY4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.48.65
X-Source-L: No
X-Exim-ID: 1fAbDf-000Pxs-20
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.48.65]:55876
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/23/2018 07:45 AM, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 07:31:03AM -0500, Gustavo A. R. Silva wrote:
>> Hi Peter,
>>
>> On 04/20/2018 07:00 AM, Peter Zijlstra wrote:
>>>
>>> Hi Dan,
>>>
>>> awesome stuff...
>>>
>>> So I fear that many are actually things we want to fix. Our policy was
>>> to kill the speculation on the first load and not worry if it can be
>>> completed with a dependent load/store.
>>>
>> I wonder if there is any thread where I can read the discussion about that
>> policy that you mention.
>>
>> Could you share it here, please?
> 
> I think it was somewhere in the many spectre variant1 threads when Linus
> Alexei and Dan W were hashing out the mitigation thing. I cannot quickly
> find the specific email.
> 
> Clarifying that position was one reason for the patches I did, Linus and
> Dan W are on Cc and I figure that if they all agree we should maybe add
> a little something to Documentation/speculation.txt.
> 


Yeah. I think it's important to mention that, so everybody is on the 
same page. In particular now that is very likely that many people will 
start writing patches to fix the rest of the issues Dan reported.

Thanks
--
Gustavo
