Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755161AbeCHBKW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:10:22 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44569 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755139AbeCHBKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:10:19 -0500
X-Google-Smtp-Source: AG47ELvfiTnFO6Ogw80Bi1Sgvh7P26PrceipVA+laL2C2pFATGv/gTDxrbbAgO1ksBHwjGnz3xBEhw==
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM64: dts: meson-axg: fix pwm_AO_cd compatible
Organization: BayLibre
References: <20180215101031.18934-1-jbrunet@baylibre.com>
        <9a161f47-3e4a-d1ed-f829-d6989191583a@baylibre.com>
Date: Wed, 07 Mar 2018 17:10:16 -0800
In-Reply-To: <9a161f47-3e4a-d1ed-f829-d6989191583a@baylibre.com> (Neil
        Armstrong's message of "Thu, 15 Feb 2018 12:55:19 +0100")
Message-ID: <7hd10fgyo7.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 15/02/2018 11:10, Jerome Brunet wrote:
>> The compatible in pwm_AO_cd is wrong and does not match anything.
>> Correct this with the correct compatible string
>> 
>> Fixes: 4a81e5ddfb43 ("ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index a7cc9e401a92..880e25b113c1 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -844,7 +844,7 @@
>>  			};
>>  
>>  			pwm_AO_cd: pwm@2000 {
>> -				compatible = "amlogic,axg-ao-pwm";
>> +				compatible = "amlogic,meson-axg-ao-pwm";
>>  				reg = <0x0 0x02000  0x0 0x20>;
>>  				#pwm-cells = <3>;
>>  				status = "disabled";
>> 
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.17/dt64,

Kevin
