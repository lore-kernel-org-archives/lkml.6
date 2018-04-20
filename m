Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeDTCKf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 22:10:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753784AbeDTCKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 22:10:33 -0400
Subject: Re: [PATCH net-next] net-next/hinic: add arm64 support
To: David Miller <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoshaokai@huawei.com>
References: <20180418100739.12948-1-zhaochen6@huawei.com>
 <20180419.133455.1177084388633137150.davem@davemloft.net>
From: Zhao Chen <zhaochen6@huawei.com>
Message-ID: <773ec329-919e-5621-d33b-ddaf88abfb7c@huawei.com>
Date: Fri, 20 Apr 2018 10:09:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180419.133455.1177084388633137150.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.240.178]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/20 1:34, David Miller wrote:
> From: Zhao Chen <zhaochen6@huawei.com>
> Date: Wed, 18 Apr 2018 06:07:39 -0400
> 
>> This patch enables arm64 platform support for the HINIC driver.
>>
>> Signed-off-by: Zhao Chen <zhaochen6@huawei.com>
> 
> Applied, thank you.
> 
> .
> 
Thanks, David.
