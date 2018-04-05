Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeDEQdT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:33:19 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.43]:26146 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751251AbeDEQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:33:18 -0400
Subject: Re: [PATCH] qtnfmac: pearl: pcie: fix memory leak in
 qtnf_fw_work_handler
To: Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180405154949.GA32223@embeddedor.com>
 <20180405163100.cuaedftds47pxdrn@bars>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <123880c0-25f0-f53e-8c75-2a01c2756b4e@embeddedor.com>
Date: Thu, 5 Apr 2018 11:33:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405163100.cuaedftds47pxdrn@bars>
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
X-Exim-ID: 1f47p7-000cPm-7b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:59050
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On 04/05/2018 11:31 AM, Sergey Matyukevich wrote:
> Hello Gustavo,
> 
>> In case memory resources for fw were succesfully allocated, release
>> them before jumping to fw_load_fail.
>>
>> Addresses-Coverity-ID: 1466092 ("Resource leak")
>> Fixes: c3b2f7ca4186 ("qtnfmac: implement asynchronous firmware loading")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Thanks for the patch!
> 

Glad to help. :)

> Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
> 

Thanks
--
Gustavo
