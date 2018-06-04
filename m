Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeFDIOn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:14:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47741 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeFDIOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:14:42 -0400
Subject: Re: [PATCH v2 02/21] mfd: omap-usb-host: use match_string() helper
To: Lee Jones <lee.jones@linaro.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-3-git-send-email-xieyisheng1@huawei.com>
 <20180604074453.GK25455@dell>
CC: <linux-kernel@vger.kernel.org>, <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <f9950977-2777-2836-b8f6-e967f7b1d851@huawei.com>
Date: Mon, 4 Jun 2018 16:13:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180604074453.GK25455@dell>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 2018/6/4 15:44, Lee Jones wrote:
> On Thu, 31 May 2018, Yisheng Xie wrote:
> 
>> match_string() returns the index of an array for a matching string,
>> which can be used instead of open coded variant.
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: linux-omap@vger.kernel.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>> v2:
>>  - add Acked-by and Reviewed-by tag.
>>
>>  drivers/mfd/omap-usb-host.c | 24 ++----------------------
>>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> I already applied this with the tags

Thanks
Yisheng
> 
