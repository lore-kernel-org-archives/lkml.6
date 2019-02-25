Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CBAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2A820842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfBYP6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:58:00 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49843 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727638AbfBYP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:57:59 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PFuc2M003031;
        Mon, 25 Feb 2019 16:57:45 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvtwtqgq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Feb 2019 16:57:45 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D65338;
        Mon, 25 Feb 2019 15:57:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 01D435244;
        Mon, 25 Feb 2019 15:57:44 +0000 (GMT)
Received: from [10.48.0.160] (10.75.127.47) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Feb
 2019 16:57:44 +0100
Subject: Re: [PATCH v1 2/3] ARM: dts: stm32: enable Vivante GPU support on
 stm32mp157c-ed1 board
To:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1550246316-9747-1-git-send-email-pierre-yves.mordret@st.com>
 <1550246316-9747-3-git-send-email-pierre-yves.mordret@st.com>
 <1550247269.2546.58.camel@pengutronix.de>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <2cf49be6-474d-350b-8dfd-3fe1bf38af3a@st.com>
Date:   Mon, 25 Feb 2019 16:57:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550247269.2546.58.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 2/15/19 5:14 PM, Lucas Stach wrote:
> Am Freitag, den 15.02.2019, 16:58 +0100 schrieb Pierre-Yves MORDRET:
>> Enable Vivante GPU driver for stm32mp157c-ed1 board.
>>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>  arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts
>> b/arch/arm/boot/dts/stm32mp157c-ed1.dts
>> index 98ef7a0..792f402 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
>> @@ -20,6 +20,17 @@
>>  		reg = <0xC0000000 0x40000000>;
>>  	};
>>  
>> +	reserved-memory {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		gpu_reserved: gpu@f8000000 {
>> +			reg = <0xf8000000 0x8000000>;
>> +			no-map;
>> +		};
>> +	};
>> +
> 
> I don't think you need this. The GPU driver uses very little contig dma
> memory. Most of the GPU memory is ordinary paged memory, so setting
> aside a private memory region of this size is a waste of memory. Most
> likely you can just allow the GPU driver to use the system global CMA
> region.

That's correct, but this memory area is also used for U-BOOT splash screen
rendering.
Moreover, even if we lack of proof as for today, it turns out performances are
better with this region as reduces MMU accesses (with Vivante driver)
Eventually using Android framework application is started more gently whatever
previous application and CMA status(fragmentation).
Provided this memory, CMA region is decreased accordingly.

Hope it clarifies.

Regards
> 
> Regards,
> Lucas
> 
> 
>>  	aliases {
>>  		serial0 = &uart4;
>>  	};
>> @@ -53,6 +64,11 @@
>>  	status = "okay";
>>  };
>>  
>> +&gpu {
>> +	contiguous-area = <&gpu_reserved>;
>> +	status = "okay";
>> +};
>> +
>>  &i2c4 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&i2c4_pins_a>;
