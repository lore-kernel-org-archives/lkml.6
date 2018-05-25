Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967958AbeEYSOK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:14:10 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.234]:21491 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967649AbeEYSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:14:08 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] ath6kl: mark expected switch fall-throughs
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180524231322.GA22704@embeddedor.com>
 <060f93a0-7210-79b6-37a7-cd8900719d40@cogentembedded.com>
 <871sdzc16l.fsf@kamboji.qca.qualcomm.com>
 <e777af5c-8d56-aef7-a4b6-f93f12378049@embeddedor.com>
 <87k1rr8v3l.fsf@kamboji.qca.qualcomm.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b43bfff8-889d-c167-a902-bc44518bf1f3@embeddedor.com>
Date: Fri, 25 May 2018 13:14:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87k1rr8v3l.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fMHE6-003dnX-V2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:55514
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/25/2018 01:10 PM, Kalle Valo wrote:
>>> Yeah, I was wondering the same. Was there a particular reason for this?
>>>
>>
>> Sometimes people use this style for a one-line code block.
>>
>> I can change it to the traditional style. No problem.
> 
> I would prefer that. So if you can send v2 that would be great.
> 

Yep. No problem. I'll send it shortly.

Thanks
--
Gustavo
