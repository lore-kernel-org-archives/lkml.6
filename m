Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeA3ItB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:49:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45496 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeA3Is6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:48:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5940601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <CAE=gft7hEc1GGJeYk0LRq1FAZyZhujfPWAnc=y+-HLzLKbVgtw@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <201dcf54-768d-6928-5997-94157e6adb98@codeaurora.org>
Date: Tue, 30 Jan 2018 14:18:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft7hEc1GGJeYk0LRq1FAZyZhujfPWAnc=y+-HLzLKbVgtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/27/2018 02:01 AM, Evan Green wrote:
> Hi Rajendra,
> 
> On Thu, Jan 25, 2018 at 8:32 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts  |  13 ++
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi |  11 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi     | 308 +++++++++++++++++++++++++++++++
>>  4 files changed, 333 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 55ec5ee7f7e8..c57701bed084 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8916-mtp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-bullhead-rev-101.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += msm8994-angler-rev-101.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += msm8996-mtp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) += sdm845-mtp.dtb
> 
> Minor nit: This should be a tab before the += to be consistent.

thanks, will fix when I respin.

> 
> (Unfortunately I don't have the expertise quite yet to comment on the
> rest of this).
> 
> -Evan
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
