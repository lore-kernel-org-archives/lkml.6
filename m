Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF572C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F312146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBUAh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:37:58 -0500
Received: from mx.socionext.com ([202.248.49.38]:12425 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfBUAh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:37:57 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 21 Feb 2019 09:37:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B94296117D;
        Thu, 21 Feb 2019 09:37:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 21 Feb 2019 09:37:55 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 7605C1A04E1;
        Thu, 21 Feb 2019 09:37:55 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 5E8D2121B6C;
        Thu, 21 Feb 2019 09:37:55 +0900 (JST)
Subject: Re: [PATCH v3 3/9] dt-bindings: Add documentation for Milbeaut SoCs
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        soc@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1550648622-10541-1-git-send-email-sugaya.taichi@socionext.com>
 <CAL_JsqK-8iBaF92GpXdoZwBEaT_mQAjO_4URR9iPJqAiy=YW=w@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <f31aa3e4-9f86-124f-6636-d2c2b4763cca@socionext.com>
Date:   Thu, 21 Feb 2019 09:37:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK-8iBaF92GpXdoZwBEaT_mQAjO_4URR9iPJqAiy=YW=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/20 22:33, Rob Herring wrote:
> On Wed, Feb 20, 2019 at 1:43 AM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
>>
>> This adds a DT binding documentation for the M10V and its evaluation
>> board.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../bindings/arm/socionext/milbeaut.yaml           | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
>> new file mode 100644
>> index 0000000..522396f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
>> @@ -0,0 +1,22 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/milbeaut.yaml#
>> +$schema: http://devicetree.org/meta-schemas/milbeaut.yaml#
> 
> This line is wrong. All DT schema should be:
> http://devicetree.org/meta-schemas/core.yaml#
> 

Ah, OK. Fix it soon.

Thanks,
Sugaya Taichi

>> +
>> +title: Milbeaut platforms device tree bindings
>> +
>> +maintainers:
>> +  - Taichi Sugaya <sugaya.taichi@socionext.com>
>> +  - Takao Orito <orito.takao@socionext.com>
>> +
>> +properties:
>> +  $nodename:
>> +    const: '/'
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - socionext,milbeaut-m10v-evb
>> +          - const: socionext,sc2000a
>> +...
>> --
>> 1.9.1
>>

