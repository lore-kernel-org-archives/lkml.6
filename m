Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C137C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FBE20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FBE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439593AbeKWS21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:28:27 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60239 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbeKWS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:28:26 -0500
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D6FBD1BF214;
        Fri, 23 Nov 2018 07:45:15 +0000 (UTC)
Date:   Fri, 23 Nov 2018 08:45:14 +0100
From:   jacopo mondi <jacopo@jmondi.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v12 1/2] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
Message-ID: <20181123074514.GB6788@w540>
References: <1540887143-27904-1-git-send-email-yong.deng@magewell.com>
 <308184907.pMD7ZDI2dr@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <308184907.pMD7ZDI2dr@avalon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Yong,

On Tue, Oct 30, 2018 at 03:06:24PM +0200, Laurent Pinchart wrote:
> Hi Yong,
>
> Thank you for the patch.
>
> On Tuesday, 30 October 2018 10:12:23 EET Yong Deng wrote:
> > Add binding documentation for Allwinner V3s CSI.
> >
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Yong Deng <yong.deng@magewell.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> >  .../devicetree/bindings/media/sun6i-csi.txt        | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > b/Documentation/devicetree/bindings/media/sun6i-csi.txt new file mode
> > 100644
> > index 000000000000..443e18c181b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > @@ -0,0 +1,56 @@
> > +Allwinner V3s Camera Sensor Interface
> > +-------------------------------------
> > +
> > +Allwinner V3s SoC features a CSI module(CSI1) with parallel interface.
> > +
> > +Required properties:
> > +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> > +  - reg: base address and size of the memory-mapped region.
> > +  - interrupts: interrupt associated to this IP
> > +  - clocks: phandles to the clocks feeding the CSI
> > +    * bus: the CSI interface clock
> > +    * mod: the CSI module clock
> > +    * ram: the CSI DRAM clock
> > +  - clock-names: the clock names mentioned above
> > +  - resets: phandles to the reset line driving the CSI
> > +
> > +The CSI node should contain one 'port' child node with one child 'endpoint'
> > +node, according to the bindings defined in
> > +Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +
> > +Endpoint node properties for CSI
> > +---------------------------------
> > +See the video-interfaces.txt for a detailed description of these
> > properties. +- remote-endpoint	: (required) a phandle to the bus receiver's
> > endpoint +			   node
> > +- bus-width:		: (required) must be 8, 10, 12 or 16
> > +- pclk-sample		: (optional) (default: sample on falling edge)
> > +- hsync-active		: (required; parallel-only)
> > +- vsync-active		: (required; parallel-only)
> > +
> > +Example:
> > +
> > +csi1: csi@1cb4000 {
> > +	compatible = "allwinner,sun8i-v3s-csi";
> > +	reg = <0x01cb4000 0x1000>;
> > +	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +	clocks = <&ccu CLK_BUS_CSI>,
> > +		 <&ccu CLK_CSI1_SCLK>,
> > +		 <&ccu CLK_DRAM_CSI>;
> > +	clock-names = "bus", "mod", "ram";
> > +	resets = <&ccu RST_BUS_CSI>;
> > +
> > +	port {
> > +		/* Parallel bus endpoint */
> > +		csi1_ep: endpoint {
> > +			remote-endpoint = <&adv7611_ep>;
> > +			bus-width = <16>;
> > +
> > +			/* If hsync-active/vsync-active are missing,
> > +			   embedded BT.656 sync is used */

Am I confused? The properties description defines [v|h]sync-active as
required, but the example reports that they can be omitted to use
BT.656 synchronization.

Which one of the following is correct?
1) [h|v]sync-active are mandatory: no BT.656 support can be selected.
2) [h|v]sync-active are optional, and if not specified BT.656 is
   selected.
3) I am confused.

Thanks
   j

> > +			hsync-active = <0>; /* Active low */
> > +			vsync-active = <0>; /* Active low */
> > +			pclk-sample = <1>;  /* Rising */
> > +		};
> > +	};
> > +};
>
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb97AKAAoJEHI0Bo8WoVY87UAQALCDEE5QXjD6VY3sPb0SgeLj
t1VdmQHFsMedpHdLWo76ZVF/qSipirCk4a4wzAL/MqmTqgHLDw88ACYDW8JP3BaG
E7zw5ueM2higg8bfqqh8nFVQyLUFwvKxwnocRNvhmhVFsP8j/fJ25rQjKti3hvbP
djwdEzBT7fkNbgSQi4S19RNx84xjGmStVOBMaKCC/xwm0ausnTfooekw6loZRWA1
Tvk0JrRKA96OaXt3zzKDlp2YsgFUiEeCo81XFKfhTkdhLUBHUQNxfuxOqVzWdqCe
XLwXH2blajWAHYspLNKuPUshp6ptJ+W9k4QpXwt6f+/U+8FO/LXf8WT1FScrhYVX
Yxj4WVP/KeHDseKAgYN6I2/cLVFejOPq6qzSYWtu7TL5xg+oOPKjweDeIUAH7NAW
oifpXxxDPgigKyhTCJDu7hRRvQaiqYj87knCL46iMj5jElvAogb0jYTCOG/3kVMF
G2QNhk/4p0DoFvhRy624UY7fSqTIqvr1L5zZqwOkYFAKxp+EuDO36kg6mkBpKnnb
hIaKw3OsLf82wKlHW9DlL4Q/nnZzXCpxpoJUPV4Q/eE9zMGdCbIQhKmpMEsTrFSC
0wsSTqevi3rO2iN+bzQHXKuvXwKev2egVXb3XqUJ68wJNf9k6j4Ue5+e3MSt2XuG
QVgvv0V6jq3uFY7YLqkH
=L6Um
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
