Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866CCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5664B222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfBMFKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 00:10:54 -0500
Received: from mx.socionext.com ([202.248.49.38]:17543 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfBMFKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 00:10:54 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Feb 2019 14:10:52 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 544B8180081;
        Wed, 13 Feb 2019 14:10:52 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 13 Feb 2019 14:10:52 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 2C8A940389;
        Wed, 13 Feb 2019 14:10:52 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 14789120459;
        Wed, 13 Feb 2019 14:10:52 +0900 (JST)
Subject: Re: [PATCH v2 11/15] dt-bindings: pinctrl: milbeaut: Add Milbeaut
 M10V pinctrl description
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <1549629187-3177-1-git-send-email-sugaya.taichi@socionext.com>
 <CACRpkdYgTWffL3RcW7Xs7ve=9HhYyndth7RDX7sedeXytCZC1g@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <00b70c95-362c-e286-a7cf-1b38d6de7993@socionext.com>
Date:   Wed, 13 Feb 2019 14:10:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYgTWffL3RcW7Xs7ve=9HhYyndth7RDX7sedeXytCZC1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2019/02/08 22:32, Linus Walleij wrote:
> Hi Sugaya,
> 
> thanks for your patch!
> 
> On Fri, Feb 8, 2019 at 1:32 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>> Add DT bindings document for Milbeaut M10V pinctrl.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> 
> (...)
>> +- interrupts: three interrupts specifer.
>> +- interrupt-names: corresponds "interrupts" factor.
> (...)
>> +               interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
>> +                               <0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
>> +                               <0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
>> +                               <0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
>> +               interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
>> +                               "pin-52", "pin-53", "pin-54", "pin-55",
>> +                               "pin-56", "pin-57", "pin-58", "pin-59",
>> +                               "pin-60", "pin-61", "pin-62", "pin-63";
> 
> As mentioned in the review of the driver, don't do this.
> 
> This is a hierarchical interrupt controller, so these
> GIC-offset-to-GPIO-interrupt-offests should be hardcoded in
> the driver.
> 
> If these interrupt offsets differ between difference instances of
> this pin controller, they should have different compatible strings.
> 
> Yours,
> Linus Walleij
> 

I understand.
I am sure the content of bindings will change as a whole as driver changes.
Try it.

Thanks,
Sugaya Taichi

