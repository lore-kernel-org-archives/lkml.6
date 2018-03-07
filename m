Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbeCGL04 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:26:56 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46224 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeCGL0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:26:51 -0500
X-Google-Smtp-Source: AG47ELvefNbL/9Ajc8Y6UcqADzzDdI0GNDxSYDiezUu1eHNZloou82o9Xpcm9k+yIMwnOxE1HnWoEJaxmmQ4xo7EBHU=
MIME-Version: 1.0
In-Reply-To: <CAOh2x=k6aXd=pPaNKhd-fna58wk4mNcMWgy1Eb=VYwECRtqLaA@mail.gmail.com>
References: <cover.1520398076.git.amit.kucheria@linaro.org>
 <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
 <4d134dee2154ae3fa56b375aaed9568e21b1a777.1520398076.git.amit.kucheria@linaro.org>
 <CAOh2x=k6aXd=pPaNKhd-fna58wk4mNcMWgy1Eb=VYwECRtqLaA@mail.gmail.com>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Wed, 7 Mar 2018 16:56:50 +0530
Message-ID: <CAP245DU-VO9S7jh9d8gZNgM6Hr29P=Uzi4kxb_T8QLqbuQwFig@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: msm8916: Add cpu cooling maps
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 10:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Wed, Mar 7, 2018 at 10:30 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> From: Rajendra Nayak <rnayak@codeaurora.org>
>>
>> Add cpu cooling maps for cpu passive trip points. The cpu cooling
>> device states are mapped to cpufreq based scaling frequencies.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> index e468277..66b318e 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> @@ -15,6 +15,7 @@
>>  #include <dt-bindings/clock/qcom,gcc-msm8916.h>
>>  #include <dt-bindings/reset/qcom,gcc-msm8916.h>
>>  #include <dt-bindings/clock/qcom,rpmcc.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>
>>  / {
>>         model = "Qualcomm Technologies, Inc. MSM8916";
>> @@ -115,6 +116,7 @@
>>                         cpu-idle-states = <&CPU_SPC>;
>>                         clocks = <&apcs 0>;
>>                         operating-points-v2 = <&cpu_opp_table>;
>> +                       #cooling-cells = <2>;
>
> LGTM.

Can I take that as a Reviewed-by?
