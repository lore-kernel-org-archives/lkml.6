Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755112AbeCHBJr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:09:47 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36055 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755024AbeCHBJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:09:44 -0500
X-Google-Smtp-Source: AG47ELvt5AE/YiPsyW4iLdJaFx0mY35iIpqTnlwyCoEg0PEpwjKQJGtFflZQndYLQKHGMGnqiLlnQg==
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM64: dts: meson-axg: add sec_AO system controller
Organization: BayLibre
References: <20180215101207.19186-1-jbrunet@baylibre.com>
        <412132e7-904d-61c4-d09f-0239e07a92be@baylibre.com>
Date: Wed, 07 Mar 2018 17:09:42 -0800
In-Reply-To: <412132e7-904d-61c4-d09f-0239e07a92be@baylibre.com> (Neil
        Armstrong's message of "Thu, 15 Feb 2018 12:55:35 +0100")
Message-ID: <7hina7gyp5.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 15/02/2018 11:12, Jerome Brunet wrote:
>> add the secure AO system controller with chipid enabled
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 880e25b113c1..7f4c00216b82 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -836,6 +836,12 @@
>>  				};
>>  			};
>>  
>> +			sec_AO: ao-secure@140 {
>> +				compatible = "amlogic,meson-gx-ao-secure", "syscon";
>> +				reg = <0x0 0x140 0x0 0x140>;
>> +				amlogic,has-chip-id;
>> +			};
>> +
>>  			pwm_AO_ab: pwm@7000 {
>>  				compatible = "amlogic,meson-axg-ao-pwm";
>>  				reg = <0x0 0x07000 0x0 0x20>;
>> 
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.17/dt64,

Kevin
