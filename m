Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeCISdb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:33:31 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.224]:11870 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751231AbeCISda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:33:30 -0500
Subject: Re: [PATCH] pktgen: Remove VLA usage
To: David Miller <davem@davemloft.net>, gustavo@embeddedor.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180309054340.GA14439@embeddedgus>
 <20180309.115810.954232560207995724.davem@davemloft.net>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <c118fc1c-99fc-db64-5065-e26f8d4432ed@embeddedor.com>
Date: Fri, 9 Mar 2018 12:33:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309.115810.954232560207995724.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euMpd-003dRw-Pw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:59112
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2018 10:58 AM, David Miller wrote:
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> Date: Thu, 8 Mar 2018 23:43:40 -0600
> 
>> In preparation to enabling -Wvla, remove VLA usage and replace it
>> with a fixed-length array instead.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> David,
>>
>> I'm not sure how often this function is being called and,
>> depending on the frequency it may be worth to use
>> dynamic memory allocation instead?
> 
> It happens every time a config setting is made via the sysfs
> files when debug is enabled.
> 
> This is not something that happens often.
> 

I got it.

> So your patch is fine, applied to net-next, thanks.
> 

Awesome.

Thanks, David.
--
Gustavo
