Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeC0VO1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:14:27 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.96]:29785 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751088AbeC0VO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:14:26 -0400
Subject: Re: [PATCH] watchdog: wafer5823wdt: Mark expected switch fall-through
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180327193349.GA2547@embeddedgus>
 <346fdc4e-321b-33dc-3b6a-a2d3a0617743@roeck-us.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <67d43bcd-adc3-9b54-8ee2-ce438c9791da@embeddedor.com>
Date: Tue, 27 Mar 2018 16:14:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <346fdc4e-321b-33dc-3b6a-a2d3a0617743@roeck-us.net>
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
X-Exim-ID: 1f0vvF-000BBL-ON
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:38946
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/27/2018 04:05 PM, Guenter Roeck wrote:
> On 03/27/2018 12:33 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that in this particular case I replaced "Fall" with a proper
>> "Fall through" comment, which is what GCC is expecting to find.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks, Guenter.
--
Gustavo
