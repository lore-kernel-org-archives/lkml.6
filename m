Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166718AbeBOSjA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:39:00 -0500
Received: from gateway36.websitewelcome.com ([192.185.179.26]:23170 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162805AbeBOSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:38:56 -0500
Subject: Re: [PATCH] i40evf/i40evf_main: Fix variable assignment in
 i40evf_parse_cls_flower
To: jeffrey.t.kirsher@intel.com,
        "Ramamurthy, Harshitha" <harshitha.ramamurthy@intel.com>,
        David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20180215174435.GA19969@embeddedor.com>
 <1518717442.29950.1.camel@intel.com> <1518718272.6698.2.camel@intel.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <102e09cf-a090-d6c2-8b10-5190644203cc@embeddedor.com>
Date: Thu, 15 Feb 2018 12:38:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518718272.6698.2.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1emOQp-001xbM-L1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.4.238]:46994
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/15/2018 12:11 PM, Jeff Kirsher wrote:
> On Thu, 2018-02-15 at 09:56 -0800, Ramamurthy, Harshitha wrote:
>> On Thu, 2018-02-15 at 11:44 -0600, Gustavo A. R. Silva wrote:
>>> It seems this is a copy-paste error and that the proper variable to
>>> use
>>> in this particular case is _src_ instead of _dst_.
>>>
>>> Addresses-Coverity-ID: 1465282 ("Copy-paste error")
>>> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>>
>> Thanks for the patch!
>>

Glad to help. :)

>> Acked-by:Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> Dave, no need for me to pick this patch up and then push to you.  You
> can circumvent me and pick this up.
> 
>>> ---
>>>   drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks guys.
--
Gustavo
