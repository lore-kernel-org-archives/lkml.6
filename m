Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeCUOCN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:02:13 -0400
Received: from gateway23.websitewelcome.com ([192.185.47.80]:37003 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751796AbeCUOCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:02:09 -0400
Subject: Re: [PATCH] mac80211: aes-cmac: remove VLA usage
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180321134247.GA1275@embeddedgus>
 <1521640094.2645.29.camel@sipsolutions.net>
 <b367cf76-e6c5-3d6d-5d81-a68ae245e6b9@embeddedor.com>
 <1521640687.2645.30.camel@sipsolutions.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ab698dc1-55bc-11db-893b-eb1d8a25400c@embeddedor.com>
Date: Wed, 21 Mar 2018 09:02:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521640687.2645.30.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1eyeJb-000c7F-IT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:45450
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2018 08:58 AM, Johannes Berg wrote:
> On Wed, 2018-03-21 at 08:57 -0500, Gustavo A. R. Silva wrote:
>>
>> SHA_DESC_ON_STACK is currently being used in multiple places. But, yeah,
>> I think we can define multiple macros of the same kind and adjust to the
>> characteristics of each the component.
>>
>> How big do you think tfm can get?
> 
> I have no idea, I guess you'll have to take that with Herbert.
> 
> johannes
> 

I see. I'll contact him then.

Thanks for the feedback.
--
Gustavo
