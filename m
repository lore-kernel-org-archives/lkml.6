Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeC0Krt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:47:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32969 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeC0Krq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:47:46 -0400
X-Google-Smtp-Source: AG47ELtIWhKGw96ZjfdYCLrs/qlAVP1lBHo9/wILO1J8mHsbvtq1auhYw2EALM2SEv1CeFhmTB372A==
Subject: Re: [PATCH v6 0/6] Add MediaTek PMIC keys support
To: Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        jcsing.lee@samsung.com, linux-kernel@vger.kernel.org, krzk@kernel.org,
        javier@osg.samsung.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        eddie.huang@mediatek.com, Chen.Zhong@mediatek.com,
        beomho.seo@samsung.com, linux-rtc@vger.kernel.org
References: <1508937364-30054-1-git-send-email-chen.zhong@mediatek.com>
 <808b2029da224ab687fb0553cbc1c68e@mtkmbs08n1.mediatek.inc>
 <1521685073.28226.10.camel@mtkswgap22> <20180323185418.GD255819@dtor-ws>
 <20180327080507.pgil6pw2mn4y2f4d@dell>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <3ece050c-7573-ef4e-2c89-61645a243a33@gmail.com>
Date: Tue, 27 Mar 2018 12:47:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327080507.pgil6pw2mn4y2f4d@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/27/2018 10:05 AM, Lee Jones wrote:
> On Fri, 23 Mar 2018, Dmitry Torokhov wrote:
>> On Thu, Mar 22, 2018 at 10:17:53AM +0800, Sean Wang wrote:
>>> Hi, Dmitry and Lee
>>>
>>> The series seems not being got merged. Are they good enough to be ready
>>> into the your tree?
>>>
>>> Recently I've tested the series with focusing on pwrkey event generated
>>> through interrupt when push and release the key on bpi-r2 board and then
>>> finally it's working fine. but for homekey it cannot be found on the
>>> board and thus I cannot have more tests more about it.
>>>
>>> Tested-by: Sean Wang <sean.wang@mediatek.com>
>>
>> You have my Ack on the input patch; I expect it go through Lee's tree as
>> there are some dependencies on mfd core piece.
> 
> Are you happy for me to merge the Input dt-bindings without your Ack?
> 

They got both Acked in v5, but the commit message was not updated:
https://patchwork.kernel.org/patch/9973721/
https://patchwork.kernel.org/patch/9973723/

Regards,
Matthias
