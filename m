Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D048C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D7221736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 02:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D7221736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeHNF1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 01:27:32 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:50432 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeHNF1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 01:27:32 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171])
        by mwinf5d43 with ME
        id NqiS1y0033iTc1M03qiSSN; Tue, 14 Aug 2018 04:42:27 +0200
X-ME-Helo: mail-qt0-f171.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Aug 2018 04:42:27 +0200
X-ME-IP: 209.85.216.171
Received: by mail-qt0-f171.google.com with SMTP id h4-v6so19698678qtj.7;
        Mon, 13 Aug 2018 19:42:26 -0700 (PDT)
X-Gm-Message-State: AOUpUlHo5fqi2Gp6xG8QajTWLF4ZSozLvWfiQRuRL9sfMGIM19ZdMkVK
        bt7nD/BgiHOVgS533EQtAa9QjL1C4ZCWQ3k2XOQ=
X-Google-Smtp-Source: AA+uWPwwi8ntt+Yvp6AcdnOIa2zdUGJFLS/G7iLD+nFe/Z1AyZXPwtJbM/Bqgfoq/0M+SrkP/ekZxZzZvPxi845FXYo=
X-Received: by 2002:ac8:725a:: with SMTP id l26-v6mr19547708qtp.181.1534214546043;
 Mon, 13 Aug 2018 19:42:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:278a:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 19:42:25
 -0700 (PDT)
In-Reply-To: <20180813190721.GA27621@rob-hp-laptop>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-3-maxi.jourdan@wanadoo.fr> <20180813190721.GA27621@rob-hp-laptop>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Tue, 14 Aug 2018 04:42:25 +0200
X-Gmail-Original-Message-ID: <CAHStOZ5i_SzamBsWk-b+X2n_gxdNJUPCHL1U0M-d6rdJgXkzrg@mail.gmail.com>
Message-ID: <CAHStOZ5i_SzamBsWk-b+X2n_gxdNJUPCHL1U0M-d6rdJgXkzrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: amlogic: add meson-canvas documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-13 21:07 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Wed, Aug 08, 2018 at 12:00:09AM +0200, Maxime Jourdan wrote:
>> DT bindings doc for amlogic,meson-canvas
>>
>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>> ---
>>  .../soc/amlogic/amlogic,meson-canvas.txt      | 36 +++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
>> new file mode 100644
>> index 000000000000..5f0351717bee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
>> @@ -0,0 +1,36 @@
>> +Amlogic Canvas
>> +================================
>> +
>> +A canvas is a collection of metadata that describes a pixel buffer.
>> +Those metadata include: width, height, phyaddr, wrapping, block mode
>> +and endianness.
>> +
>> +Many IPs within Amlogic SoCs rely on canvas indexes to read/write pixel data
>> +rather than use the phy addresses directly. For instance, this is the case for
>> +the video decoders and the display.
>> +
>> +Amlogic SoCs have 256 canvas.
>> +
>> +Device Tree Bindings:
>> +---------------------
>> +
>> +Canvas Provider
>> +--------------------------
>> +
>> +Required properties:
>> +- compatible: "amlogic,canvas"
>> +
>> +Parent node should have the following properties :
>> +- compatible: "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd"
>
> Is this documented somewhere? One child function is not a reason for an
> MFD and child nodes. And child nodes like this with no resources are
> unnecessary.
>

Hi Rob, this was done to follow the same path as other buses on the
platform that have sysctrls in order to provide regmaps to the
devices.

I can see how it's not really necessary here though, would it be okay
with you if I turned "canvas" into a simple bus subnode, using __iomem
in the device ?

>> +- reg: base address and size of the DMC system control register space.
>> +
>> +Example:
>> +
>> +sysctrl_DMC: system-controller@0 {
>> +     compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
>> +     reg = <0x0 0x0 0x0 0x1000>;
>> +
>> +     canvas: canvas-provider@0 {
>> +             compatible = "amlogic,canvas";
>> +     };
>> +};
>> --
>> 2.18.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
