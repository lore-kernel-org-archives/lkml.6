Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBRS32 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 13:29:28 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46933 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeBRS30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 13:29:26 -0500
X-Google-Smtp-Source: AH8x225HaZNW2ClZFnYAbTQVGlxNQpgokRCICnfL3ImQibr+GNU19sDLBtnl6mFOWGqvUAPP4gBHiQ==
Subject: Re: [PATCH v1 2/2] ARM: dts: tegra30: Add video decoder node
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1518973069.git.digetx@gmail.com>
 <6ac145a1259566f85c88bd29be9c8b3e44e53bcf.1518973069.git.digetx@gmail.com>
 <4cf77dcd-0921-dec2-e5cd-ed8b5dc2fb7c@suse.de>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <94cb9746-2421-aece-3767-dc42435d4bd3@gmail.com>
Date: Sun, 18 Feb 2018 21:29:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4cf77dcd-0921-dec2-e5cd-ed8b5dc2fb7c@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.2018 21:03, Andreas Färber wrote:
> Am 18.02.2018 um 18:01 schrieb Dmitry Osipenko:
>> Add device tree node for the Video Decoder Engine found on Tegra30 SoC's.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/boot/dts/tegra30.dtsi | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
>> index 1fb0c421a9d8..8ae72ffe0048 100644
>> --- a/arch/arm/boot/dts/tegra30.dtsi
>> +++ b/arch/arm/boot/dts/tegra30.dtsi
>> @@ -17,6 +17,11 @@
>>  		#address-cells = <1>;
>>  		#size-cells = <1>;
>>  		ranges = <0 0x40000000 0x40000>;
>> +
>> +		vde_pool: vde {
>> +			reg = <0x400 0x3fc00>;
> 
> vde@400 then, to avoid dtc warnings.

Indeed by default kernels DTC silences such warnings, thank you for the suggestion.
