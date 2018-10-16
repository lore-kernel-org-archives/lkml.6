Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCCCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE342086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE342086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJPXsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:48:19 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPXsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:48:19 -0400
Received: from [192.168.178.69] ([109.104.35.93]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MTsu0-1g3kX32pF2-00QRHK; Tue, 16 Oct 2018 17:56:49 +0200
Received: from [192.168.178.69] ([109.104.35.93]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MTsu0-1g3kX32pF2-00QRHK; Tue, 16 Oct 2018 17:56:49 +0200
Subject: Re: [PATCH 6/9] ASoC: dt-bindings: bcm2835-rpi: add onboard audio
 bindings
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org
Cc:     eric@anholt.net, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, tiwai@suse.de
References: <20181016150228.16994-1-nsaenzjulienne@suse.de>
 <20181016150228.16994-7-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <4039d99c-5e57-c9d3-3af5-bc160e1adb57@i2se.com>
Date:   Tue, 16 Oct 2018 17:56:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016150228.16994-7-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:M8h8wd97nUDPG6AbvpytvBnYc3Oydrxl2/VfMosyEdFa8XYLf3T
 9wG3DWq7unxfvGWt10iS0mD25IIYh3BR6U8z0P1UxI2UjYs3Ss342anzJxcYY4UFEWcs5qD
 IrAArC3owakm/3QFuMS1bGVLEs8GtE/TbiYRj9ex69l7h0zI8NRcoUPjDngFshIRGwEBUvE
 Hv2hqTBgTdbk5tAhsG76A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3bFtnh4aac0=:DvK9tKRdsWdNTo3VxWwdUl
 hPqGWRDfVhabzVOplSu2pQOWuvYI7EfFQRMj9D8llPoC8Hl/Gt6jC641ndCCmDXRrgaS062Sy
 YkVtY6oLKCoTcpzna1Ww/BSsn5G88NdYDLjVCwQi3/HrMUtVXXJ7drok030xnrwBZUpI1Kjbh
 jCs00AdgAVOtXp3pjhyM+l6tf3ZbPHA50DedI3Ugb3lC0fdCd1xr+LCDNB7un6uwygMNSLb2s
 m0B9hHZXFzV2y2ri8fOHQmHJUToUNaUTGdCQ04b8vIUTIkbV1ysYK1THvpgRiJ/P13S20mo7d
 g9MB4rEGXA2czYUDbTMXJSz/xgDvQt7ntmT8T27lgV74COQ9PkI7u443AoPoOpC5WymiMg/sT
 ePzU87Fv5QwaMH059SAAM4FTrStOlqqV1+DOAyh+OKNikYcnZ7uvDyFfiMUx1xEmGGYbUf+tI
 d+b14heTdsdZy5WeU2IdDR5ExpTpuE0jsUXGmfb9wSd5JSgY8LAJcvvw0V8ZnRDFHY9kIQpgZ
 O7Y1WEVibJv4N156vQswbiKVEyPcASzn5W9JG6dwo1AyvANJtJ94Vi1tF6kyw8XMnn06IFpye
 fak60xCZsRi6TZ2rycdkxfCsRcl0iqW9a7I+IH4b08OgATGGa/nNb3kX/z3895F7HUlyl3uiv
 t8Sx0W6fJ3KD9d3vrt3h2Y1xJ/gkzBZQJIsqhK3W1a0mULaGz7dKLB7i8xPDahwLcAXerExaa
 2UKOBM86q26Ga8Sd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 16.10.2018 um 17:02 schrieb Nicolas Saenz Julienne:
> Adds a device tree binding file for Raspberry pi's Headphones and HDMI
> audio output devices.
>
> Based on raspberry's downstream kernel implementation:
> https://github.com/raspberrypi/linux/blob/rpi-4.14.y/arch/arm/boot/dts/bcm2708-rpi.dtsi
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../bindings/sound/brcm,bcm2835-audio.txt         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt
> new file mode 100644
> index 000000000000..ee6fa085aaa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-audio.txt
> @@ -0,0 +1,15 @@
> +Broadcom BCM283x audio device
> +
> +Required properties:
> +
> +- compatible: Should be "brcm,bcm2835-audio"
> +- brcm,pwm-channels: number of PWM channels, they are behind RPi's Video Core
> +		     IV, not actual Linux PWM devices.
> +
> +Example:
> +
> +audio: audio {
> +	compatible = "brcm,bcm2835-audio";
> +	brcm,pwm-channels = <8>;
> +};
> +

i apologize but it seems to me that the TODO mentioned in the cover
letter isn't update to date anymore.

Phil Elwell posted an important bugfix for vchiq before [1], but only
the driver part has been applied yet. After applying the DT changes i'm
not sure if it still works.

AFAIK the audio driver uses VCHIQ as a software interface and the
binding doesn't describe the real hardware.

Since the camera driver will be registered as a platform device [2], i
prefer this way for the audio driver, too.

I'm actually working on this here [3] (currently only compile tested).

Stefan

[1] - https://patchwork.ozlabs.org/cover/970434/
[2] - https://lore.kernel.org/patchwork/patch/904411/
[3] - https://github.com/anholt/linux/commits/bcm2835-audio
