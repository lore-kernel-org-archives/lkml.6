Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CFAECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C13214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C13214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeIRNK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:10:58 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIRNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:10:58 -0400
Received: from [192.168.178.69] ([109.104.37.4]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MJFpj-1gMqlY2bz1-00KhmO; Tue, 18 Sep 2018 09:38:23 +0200
Subject: Re: [PATCH 0/4] Add i.MX6ULZ SoC support
To:     Anson Huang <Anson.Huang@nxp.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        ping.bai@nxp.com, Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <e82e2894-2a0d-0084-913c-b7c6d966fc13@i2se.com>
Date:   Tue, 18 Sep 2018 09:38:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:t0QQVvYKhrPZ4vc45UgL6d4HVgWHW0/s0Ja+VdHkEWQvRCCbVQs
 x3G1m6J4NQLSQ1S6Y11KN012xGTE/Ry26og6T8de1M/qRf0LkW72dZ9MQy1g+DqXHeCNeAG
 bHBF6rkm0OcLDQ8cv4OO+czBAc5BSR5i3xljpGYQq/g8v8rbQPEyjxAlGquJVlqGPhgFfIW
 cQciNHxF2XQXXEkjlQSPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H6f4dZpQrL8=:025ntIO5hcVJTdM3z01BCZ
 0sFrCf0xf/Phi//62UeR7BFqzrk1S17vCvxlf/TC76+nM0Gd2P56zQyYitwMxuGWk2ND2AoRM
 19YDqA3+R5DCXftWz+LXktM1tpIyufZUsmo4M1WLuDFnBZ6VHs2B6wXp3m6bqesccaMisPWpb
 tj+QBXdxUw7w89W0ATHrUKmmvxpvxb03yUxSrCzSlbsAhvX9ETK+ajWE/c7dtM+iw7n/3gNzk
 SXjiMQWrH2YQzLOcPaeSmHBDx3Y4wgTs3u/VwInDa8u7bB12ZMPeYRvTM9qvbL01mXzH/VEKG
 gUwk0+/88HUEOc2gi7OjGuAKElgEEHIy2ApDwAr1u9NY+JVTXHFeNkzcFAd34SFuCVu6CfHUo
 tpIL/M3lJh1ghn1Os87OFZuNPqCr5ESJYHIYwclhWItXQWSXZWLymdGAYA4eGELtPyacgRiSN
 GX5hVTpjUJi5S56tVu37rRd6VzenfX28hKqbM2kE4g+dzPqQNqdT53zIwR0nOmo8MCwyaRBcf
 xLUjXyE9pl2W5+vYGy1KOw3k6UQqfdW9IgjKXalAVpcvSvaFjB3eSpIUBycN5sBuYMsZcggfz
 vaDECpwXqMWiKXdNG4RxO8Esr5KGHrjo9XT9CcshmJb9kQjuwZXIr1ljTy7uuERNSuELTA34b
 WE0LSf+2sM6ncP6mvsmCQ922cREDCPbG5K0au4vm+ixAvrMiR1/oHl9oZPcQOVnwOQ9KL4dF8
 OPu5R4wikSdAdcMJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

Am 18.09.2018 um 08:19 schrieb Anson Huang:
> This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
> i.MX6 family, compared to i.MX6ULL, it removes below modules:
>
>     - UART5/UART6/UART7/UART8;
>     - PWM5/PWM6/PWM7/PWM8;
>     - eCSPI3/eCSPI4;
>     - CAN1/CAN2;
>     - FEC1/FEC2;
>     - I2C3/I2C4;
>     - EPIT2;
>     - LCDIF;
>     - GPT2;
>     - TSC;
>
> And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is
> to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
> 1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
> just add the new CPU type and remove those non-exist modules from dtb.
>
> Anson Huang (4):
>   ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support
>   ARM: imx: add i.mx6ulz msl support
>   clk: imx6ul: add i.mx6ulz support
>   dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
>
>  

i recommend the following patch order:
ARM: imx: add i.mx6ulz msl support
clk: imx6ul: add i.mx6ulz support
dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

Stefan

