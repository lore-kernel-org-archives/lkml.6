Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE98FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A04253DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A04253DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeFYC7S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 22:59:18 -0400
Received: from mx.socionext.com ([202.248.49.38]:32484 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbeFYC7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 22:59:16 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Jun 2018 11:59:15 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 60A586006F;
        Mon, 25 Jun 2018 11:59:15 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 25 Jun 2018 11:59:15 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id D5D3440064;
        Mon, 25 Jun 2018 11:59:14 +0900 (JST)
Received: from DESKTOPFLNNJ4T (unknown [10.213.132.95])
        by yuzu.css.socionext.com (Postfix) with ESMTP id ABE7F12030A;
        Mon, 25 Jun 2018 11:59:14 +0900 (JST)
From:   "Katsuhiro Suzuki" <suzuki.katsuhiro@socionext.com>
To:     "'Masahiro Yamada'" <yamada.masahiro@socionext.com>,
        =?UTF-8?B?U3V6dWtpLCBLYXRzdWhpcm8v6Yi05pyoIOWLneWNmg==?= 
        <suzuki.katsuhiro@socionext.com>
Cc:     "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "DTML" <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20180619041153.6668-1-suzuki.katsuhiro@socionext.com> <CAK7LNATB-oa+K47z+egfV2iSKoD3x2tyMNXQp1ukS2f1Yek54g@mail.gmail.com>
In-Reply-To: <CAK7LNATB-oa+K47z+egfV2iSKoD3x2tyMNXQp1ukS2f1Yek54g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: uniphier: add headphone detect gpio for LD20 global board
Date:   Mon, 25 Jun 2018 11:59:11 +0900
Message-ID: <001a01d40c30$7e3d3110$7ab79330$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHUB4OoJX1XF2vEp06reh/Q7ox0ZKRso8sAgAOt1kA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yamada-san,

> -----Original Message-----
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> Sent: Saturday, June 23, 2018 12:47 PM
> To: Suzuki, Katsuhiro/鈴木 勝博 <suzuki.katsuhiro@socionext.com>
> Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; DTML
> <devicetree@vger.kernel.org>; Masami Hiramatsu <masami.hiramatsu@linaro.org>;
> Jassi Brar <jaswinder.singh@linaro.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/2] arm64: dts: uniphier: add headphone detect gpio for LD20
> global board
> 
> 2018-06-19 13:11 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> > This patch adds GPIO for headphone detection on LD20 global board.
> >
> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> > ---
> >  arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> > index 6a074a20c924..38b75998e2dd 100644
> > --- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> > +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
> > @@ -60,6 +60,7 @@
> >                         &i2s_port4
> >                         &spdif_port0
> >                         &comp_spdif_port0>;
> > +               hp-det-gpio = <&gpio UNIPHIER_GPIO_PORT(15, 0) GPIO_ACTIVE_LOW>;
> 
> 
> When you use irq-capable gpio pin (XIRQ0),
> please write like follows for consistency.
> 
> 
>              hp-det-gpio = <&gpio UNIPHIER_GPIO_IRQ(0) GPIO_ACTIVE_LOW>;
> 
> 
> See uniphier-ld20-ref.dts for example.

Thank you for reviewing!

I'll fix it and post v2.

Regards,
--
Katsuhiro Suzuki


> 
> 
> 
> >         };
> >
> >         spdif-out {
> > --
> > 2.17.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada


