Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F641C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D874A2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D874A2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeKTLDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:03:08 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:34350 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbeKTLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:03:08 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAK0Zrwk046076;
        Tue, 20 Nov 2018 09:35:53 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Tue, 20 Nov 2018 09:35:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.2] (199.247.151.153.ap.dti.ne.jp [153.151.247.199])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAK0ZqC5046071
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 20 Nov 2018 09:35:52 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] clk: rockchip: fix ID of 8ch clock of I2S1 for rk3328
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181118041802.11660-1-katsuhiro@katsuster.net>
 <12656761.yaB328pSP6@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <c0f4e568-3941-3fae-a259-88661c4715f1@katsuster.net>
Date:   Tue, 20 Nov 2018 09:35:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12656761.yaB328pSP6@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for applying my patch and sorry for mistake...

On 2018年11月19日 22:43, Heiko Stuebner wrote:
> Am Sonntag, 18. November 2018, 05:18:02 CET schrieb Katsuhiro Suzuki:
>> This patch fixes mistakes in HCLK_I2S1_8CH for running I2S1
>> successfully.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   include/dt-bindings/clock/rk3328-cru.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/clock/rk3328-cru.h b/include/dt-bindings/clock/rk3328-cru.h
>> index a82a0109faff..bcaa4559ab1b 100644
>> --- a/include/dt-bindings/clock/rk3328-cru.h
>> +++ b/include/dt-bindings/clock/rk3328-cru.h
>> @@ -172,13 +172,14 @@
>>   #define PCLK_HDCP		232
>>   #define PCLK_DCF		233
>>   #define PCLK_SARADC		234
>> +#define PCLK_ACODECPHY		235
> 
> I've dropped this unrelated change and applied the
> real id fix from the rest of the patch for 4.21
> 
> 
> Thanks
> Heiko
> 
> 
> 

Best Regards,
---
Katsuhiro Suzuki
