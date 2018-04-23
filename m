Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754955AbeDWMbK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:31:10 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.95]:36108 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754829AbeDWMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:31:08 -0400
X-Authority-Reason: nr=8
Subject: Re: Smatch check for Spectre stuff
To: Peter Zijlstra <peterz@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, dan.j.williams@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180419051510.GA21898@mwanda>
 <20180420120044.GN4064@hirez.programming.kicks-ass.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <fb72fc65-085b-65dc-c965-492d6d0902ea@embeddedor.com>
Date: Mon, 23 Apr 2018 07:31:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420120044.GN4064@hirez.programming.kicks-ass.net>
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
X-Exim-ID: 1fAacd-004FUw-GB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.48.65]:55366
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 04/20/2018 07:00 AM, Peter Zijlstra wrote:
> 
> Hi Dan,
> 
> awesome stuff...
> 
> So I fear that many are actually things we want to fix. Our policy was
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store.
> 
I wonder if there is any thread where I can read the discussion about 
that policy that you mention.

Could you share it here, please?

Thanks
--
Gustavo
