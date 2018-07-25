Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA92C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBDA20890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBDA20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbeGYKYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:24:15 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:56098 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeGYKYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:24:14 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id F0AE5BFA4C;
        Wed, 25 Jul 2018 11:13:26 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 02E8CC0ED0; Wed, 25 Jul 2018 11:13:25 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 3D006C0EA1;
        Wed, 25 Jul 2018 11:12:48 +0200 (CEST)
Message-ID: <29a3dfaf8df43498a3886a49ce91db583707689e.camel@paulk.fr>
Subject: Re: [linux-sunxi] Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable
 H3 sid controller
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Emmanuel Vadot <manu@bidouilliste.com>
Cc:     embed3d@gmail.com, Kyle Evans <kevans@freebsd.org>,
        icenowy@aosc.io, Mark Rutland <mark.rutland@arm.com>,
        sean@mess.org, linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        clabbe.montjoie@gmail.com, pmeerw@pmeerw.net, lee.jones@linaro.org,
        lars@metafoo.de, edu.molinas@gmail.com,
        Russell King <linux@armlinux.org.uk>, krzk@kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
        rask@formelder.dk, devicetree <devicetree@vger.kernel.org>,
        mchehab@kernel.org, Rob Herring <robh+dt@kernel.org>,
        singhalsimran0@gmail.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        quentin.schulz@free-electrons.com, knaack.h@gmx.de,
        davem@davemloft.net, jic23@kernel.org
Date:   Wed, 25 Jul 2018 11:12:47 +0200
In-Reply-To: <20180725110512.b6fb81be76f66b07942e5af0@bidouilliste.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
         <20180128232919.12639-15-embed3d@gmail.com>
         <20180129095200.attg7cgvpifpchtn@flea.lan>
         <470ec61e-8b08-5193-ede1-01d02b2c865e@gmail.com>
         <CACNAnaGVSbk7czb+mcGTx1C=YwCWe1qqHQDQe9+PNifwEXovMw@mail.gmail.com>
         <F1D7126A-B6ED-4A83-A941-5F39CED472CE@aosc.io>
         <CACNAnaFMKDmvAUXJngKHWkeGLfjsgn5hhJszNk7Sg4BU98Oafw@mail.gmail.com>
         <0ab29bf0-b069-338e-f312-e533656fa0b6@gmail.com>
         <39b1eef01c2ed32f09ef30439c4f4297de009898.camel@paulk.fr>
         <20180725110512.b6fb81be76f66b07942e5af0@bidouilliste.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2018-07-25 at 11:05 +0200, Emmanuel Vadot wrote:

[...]

>  Hello Paul,
> 
>  I've sent a serie yesterday for SID on A64/H3/H5.
>  https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=761

Awesome, thanks for taking care of that :)

Cheers,

Paul

> > > On 19.04.2018 17:19, Kyle Evans wrote:
> > > > On Thu, Apr 19, 2018 at 10:13 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > > > > 
> > > > > 
> > > > > ? 2018?4?19? GMT+08:00 ??11:11:22, Kyle Evans <kevans@freebsd.org> ??:
> > > > > > On Mon, Jan 29, 2018 at 6:03 AM, Philipp Rossak <embed3d@gmail.com>
> > > > > > wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 29.01.2018 10:52, Maxime Ripard wrote:
> > > > > > > > 
> > > > > > > > On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
> > > > > > > > > 
> > > > > > > > > This patch enables the the sid controller in the H3. It can be used
> > > > > > > > > for thermal calibration data.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > > > > > > > > ---
> > > > > > > > >    arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
> > > > > > > > >    1 file changed, 7 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > > > b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > > > index 3f83f6a27c74..9bb5cc29fec5 100644
> > > > > > > > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > > > > > @@ -72,6 +72,13 @@
> > > > > > > > >                  };
> > > > > > > > >          };
> > > > > > > > >    +     soc {
> > > > > > > > > +               sid: eeprom@1c14000 {
> > > > > > > > > +                       compatible = "allwinner,sun8i-h3-sid";
> > > > > > > > > +                       reg = <0x01c14000 0x400>;
> > > > > > > > > +               };
> > > > > > > > > +       };
> > > > > > > > > +
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Shouldn't you also use a nvmem-cells property to the THS node?
> > > > > > > > 
> > > > > > > > Maxime
> > > > > > > > 
> > > > > > > 
> > > > > > > Oh seems like I forgot that.
> > > > > > > As related to the wiki [1] this should be 64 bit wide at the address
> > > > > > 
> > > > > > 0x34. I
> > > > > > > will add that in the next version.
> > > > > > > 
> > > > > > > 
> > > > > > > [1]: http://linux-sunxi.org/SID_Register_Guide#eFUSE
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Philipp
> > > > > > > 
> > > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > Any chance this will see a v3 soon? I'm kind of interested in sid node
> > > > > > for h3. =)
> > > > > 
> > > > > This patch is independent and can be easily sent out
> > > > > by its own.
> > > > > 
> > > > 
> > > > Right- I had considered doing so, but wanted to make sure I wasn't
> > > > going to collide with this series if a v3 is imminent.
> > > > 
> > > 
> > > 
> > 
> > -- 
> > Developer of free digital technology and hardware support.
> > 
> > Website: https://www.paulk.fr/
> > Coding blog: https://code.paulk.fr/
> > Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
> 
> 
-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

