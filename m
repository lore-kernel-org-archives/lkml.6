Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B063C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D0320645
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBSHl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:41:58 -0500
Received: from mx.socionext.com ([202.248.49.38]:33558 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfBSHl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:41:58 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Feb 2019 16:41:56 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 4F3AE180C10;
        Tue, 19 Feb 2019 16:41:56 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 19 Feb 2019 16:41:56 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id CBC4C40340;
        Tue, 19 Feb 2019 16:41:55 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id B78F2121B6C;
        Tue, 19 Feb 2019 16:41:55 +0900 (JST)
Subject: Re: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
 <20190218195247.GA9690@bogus>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <c111792a-397e-4018-fa94-ff03f06fa23a@socionext.com>
Date:   Tue, 19 Feb 2019 16:41:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218195247.GA9690@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/02/19 4:52, Rob Herring wrote:
> On Fri, Feb 08, 2019 at 09:26:04PM +0900, Sugaya Taichi wrote:
>> This adds a DT binding documentation for the M10V and its evaluation
>> board.
> 
> Most boards/soc bindings are using DT schema (yaml) now. We're not
> requiring that just yet, but I'd like to not add more. So can you
> convert this to schema.
> 

Probably yes. I try to convert with looking at references.

Thanks,
Sugaya Taichi

> Rob
> 
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt
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

