Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8896DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480722082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480722082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJJTjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:39:03 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:39:03 -0400
Received: from [192.168.178.69] ([109.104.41.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRTIx-1gLz0X2I8j-00NOgB; Wed, 10 Oct 2018 14:16:56 +0200
Received: from [192.168.178.69] ([109.104.41.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRTIx-1gLz0X2I8j-00NOgB; Wed, 10 Oct 2018 14:16:56 +0200
Subject: Re: [Question] directory for SoC-related DT binding
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Rob Herring <robh@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
 <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
 <93cd9c43-6fe3-c691-005b-e27cf101c7d6@i2se.com>
 <20181010120955.GQ30658@n2100.armlinux.org.uk>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <af9eec6f-cb31-f23e-61b4-da1364ea7ba5@i2se.com>
Date:   Wed, 10 Oct 2018 14:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010120955.GQ30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:y5QkTeVl3lfMR16ZQMCsFm9BLC9dYYTrrelOCo1ZM9Q1Z+p8Klr
 cm4Qct8VWTOUbmE+WwiMK1AXx65CgHr71WxTPErzbuodhe5zeE42oYMEyq6i3x5TbU8oaJj
 EyPzVyqK850p4tzOKjfYUPCbKxR3KjchfqzqHOaGn9nizIoWSYReERQBwMWnAhDdKjtFH2a
 cy80uxjy1KQSNms2B4bqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1PsGH+vt7rw=:+f1GK9FNHuk2bRWA/L4mog
 MVo3iQThdMKYyU3AusxG6/q7koRsiSB/NpIc535NvFPG8MQKcGnRcoQb+nDCd1ETXXtMAdKJP
 TV+65KjGXIgr9eA0uSOFxv9oKheyjMhElzZRoDGC8sVceTfTEW7IDH0ZZR8rfKc4j3H3sisLa
 yJ7iGku7m6wlelesP+rul1i1xb3mKu2hQJ835ZGxMB5UJ9dDF2P9EuZer+a1U99md4Dfa6aDz
 P7AODGK4cTO1jUd65EnYbz4LK9UL6VdcFLEK8pHS36mC0CNdIA4dUgwLArVzOaN7uRXKU4w8E
 KNny9D0Joe0XjHbGUmf5oBGB/s3whRux0aQ/XnxJieqwFDPgWdtp3BCXiKdx2TGCWzo7xuxYU
 mYwlSw9davpXfN8q2HKiqvpGugpgJd6vecZ3qhamL8FTxkDqvVKbUzHgEZy7vgYy5n/P/jAE0
 NueWkYUJ0Ztku4JnrZ8uVIl0zcdkbQcfsnU23bTyBuPT+qXwi84kJ9s+fQ5//DrA+usyTheSX
 j0LpofoaC2NjgNyZ9vO3QyoYDLa+Z2qIVWK3/8lHiYTrkGpww61vH4KVzmpdynfyNyMeQWJit
 44tcSjFFqJpMLUxqQrvtuu8k+F9pHMXGWrs4byOXgjzdO2fBQDrkA2mfxmVu90AVpqcKbMqok
 0w+kt0gHWxQmQ/02p5ELEHzsV661k9mfquQm8sO2DOQlHG2HULYEp1Emd1PUmQHOZkCfEiMR0
 fsWCiRZEeNdeQdvb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.10.2018 um 14:09 schrieb Russell King - ARM Linux:
> On Wed, Oct 10, 2018 at 02:04:14PM +0200, Stefan Wahren wrote:
>> Hi,
>>
>> Am 10.10.2018 um 13:19 schrieb Rob Herring:
>>> On Wed, Oct 10, 2018 at 6:08 AM Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> Hi,
>>>>
>>>>
>>>> I see a bunch of vendor (or SoC) names in
>>>> Documentation/device/bindings/arm/
>>>>
>>>> ./Documentation/devicetree/bindings/arm/altera
>>>> ./Documentation/devicetree/bindings/arm/amlogic
>>> Yeah, it's kind of a mixture of board/soc bindings mostly with some
>>> ARM architecture, ARM, Ltd. IP, and SoC system reg bindings.
>>>
>>> Eventually, I'd like to not split board bindings by arch and maybe we
>>> should move all the system/misc reg bindings out.
>>>
>>> [,,,]
>>>
>>>> I also see some vendor names in
>>>> Documentation/device/bindings/soc/
>>>>
>>>> ./Documentation/devicetree/bindings/soc/bcm
>>>> ./Documentation/devicetree/bindings/soc/dove
>>>> ./Documentation/devicetree/bindings/soc/fsl
>>>> ./Documentation/devicetree/bindings/soc/mediatek
>>>> ./Documentation/devicetree/bindings/soc/qcom
>>>> ./Documentation/devicetree/bindings/soc/rockchip
>>>> ./Documentation/devicetree/bindings/soc/ti
>>>> ./Documentation/devicetree/bindings/soc/xilinx
>>>> ./Documentation/devicetree/bindings/soc/zte
>>> This I believe is mostly SoC system reg bindings though there's
>>> probably a few other things.
>>>
>>>> Confusingly, I see bcm, mediatek, rockchip
>>>> in both locations.
>>>>
>>>> Is there any rule to choose one than the other?
>>> Top-level SoC/board bindings in arm/ and anything else elsewhere ideally.
>> in case of Documentation/devicetree/bindings/soc/bcm the directory
>> contains SoC / board bindings, cpu-enable and a firmware binding.
> I think you're confused there...
>
> $ ls -1 Documentation/devicetree/bindings/soc/bcm/
> brcm,bcm2835-vchiq.txt
> raspberrypi,bcm2835-power.txt
>
> Doesn't look like SoC/board bindings to me...
>
> whereas:
>
> $ ls -1 Documentation/devicetree/bindings/arm/bcm/
> brcm,bcm11351-cpu-method.txt
> brcm,bcm11351.txt
> brcm,bcm21664.txt
> brcm,bcm23550-cpu-method.txt
> brcm,bcm23550.txt
> brcm,bcm2835.txt
> brcm,bcm4708.txt
> brcm,bcm63138.txt
> brcm,brcmstb.txt
> brcm,cygnus.txt
> brcm,hr2.txt
> brcm,ns2.txt
> brcm,nsp-cpu-method.txt
> brcm,nsp.txt
> brcm,stingray.txt
> brcm,vulcan-soc.txt
> raspberrypi,bcm2835-firmware.txt
>
> does fit with your description, except for the directory path...

sorry, my fault i copied the wrong path. I actually thought of
Documentation/devicetree/bindings/arm/bcm/

Thanks for pointing out
