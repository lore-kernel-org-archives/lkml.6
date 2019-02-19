Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D67820855
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfBSIS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:18:58 -0500
Received: from mx.socionext.com ([202.248.49.38]:34145 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfBSIS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:18:58 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Feb 2019 17:18:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 511526117D;
        Tue, 19 Feb 2019 17:18:56 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 19 Feb 2019 17:18:56 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 030CA404DC;
        Tue, 19 Feb 2019 17:18:56 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id E2159121B6C;
        Tue, 19 Feb 2019 17:18:55 +0900 (JST)
Subject: Re: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK7LNARTX4_phfcXRXUKGp_V0k_q_RKjL6A3Kz=Hxyqj6VXW+Q@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <e28fd693-8ec9-3e89-7f98-62661c80e42b@socionext.com>
Date:   Tue, 19 Feb 2019 17:18:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARTX4_phfcXRXUKGp_V0k_q_RKjL6A3Kz=Hxyqj6VXW+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/19 10:25, Masahiro Yamada wrote:
> On Fri, Feb 8, 2019 at 9:26 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> This adds a DT binding documentation for the M10V and its evaluation
>> board.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt
> 
> 
> 
> I added uniphier SoC/board binding into
> 
> Documentation/devicetree/bindings/arm/socionext/uniphier.txt
> 
> 
> You can milbeaut.txt to the socionext directory as well.
> 

Thank you for informing. I found the directory there.
I will add the "milbeaut.txt(yaml)" there.

Thanks,
Sugaya Taichi

> 
> 
> 
>> new file mode 100644
>> index 0000000..9fd053a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/milbeaut.txt
>> @@ -0,0 +1,6 @@
>> +Milbeaut platforms device tree bindings
>> +---------------------------------------
>> +
>> +- Milbeaut M10V Evaluation Board
>> +    Required root node properties:
>> +      - compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
>> --
>> 1.9.1
>>
> 
> 

