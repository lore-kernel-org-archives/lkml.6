Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932575AbeEaAXb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:23:31 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33058 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932450AbeEaAX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:23:28 -0400
X-Google-Smtp-Source: ADUXVKLLs/q5No1zATpywgTA32QfVwIIAVmD7LTdBvzfc9Yixbw/L4LYLKOpmMM0ZVJEH+vgVmn32Q==
Subject: Re: [PATCH 2/3] clk: bcm: Update and add tingray clock entries
To: Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pramod Kumar <pramod.kumar@broadcom.com>
References: <1527266717-8406-1-git-send-email-ray.jui@broadcom.com>
 <1527266717-8406-3-git-send-email-ray.jui@broadcom.com>
 <152772366322.144038.12289577935853704907@swboyd.mtv.corp.google.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <25bd1449-b0f6-aecb-b326-a00af1dc4e90@broadcom.com>
Date: Wed, 30 May 2018 17:23:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152772366322.144038.12289577935853704907@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 5/30/2018 4:41 PM, Stephen Boyd wrote:
> Subject is missing an 's' on stringray?
>

Yes, will fix this.


> Quoting Ray Jui (2018-05-25 09:45:16)
>> Update and add Stingray clock definitions and tables so they match the
>> binding document and the latest ASIC datasheet
>>
>> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> 
> Otherwise it looks ok, but maybe Pramod should be the author?
> 

Will fix this for all commits in this series.

I'll fix the above and send out v2.

Thanks,

Ray
