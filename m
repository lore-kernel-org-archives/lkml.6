Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C153C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F70C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F70C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeKESiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:38:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46113 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:38:19 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7AF54807E4; Mon,  5 Nov 2018 10:19:30 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:19:32 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 02/14] dt-bindings: phy-pxa-usb: add bindings
Message-ID: <20181105091932.GF4439@amd>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <20180822204307.13251-3-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-22 22:42:55, Lubomir Rintel wrote:
> This is the PHY chip for USB OTG on PXA platforms.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/phy/phy-pxa-usb.txt     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
>=20
> diff --git a/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt b/Docu=
mentation/devicetree/bindings/phy/phy-pxa-usb.txt
> new file mode 100644
> index 000000000000..5b12ab44c9e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
> @@ -0,0 +1,17 @@
> +Marvell PXA USB PHY
> +-------------------
> +
> +Required properties:
> +- compatible: one of: "marvell,mmp2-usb-phy", "marvell,pxa910-usb-phy",
> +	"marvell,pxa168-usb-phy",
> +- #phy-cells: must be 0
> +
> +Example:
> +	usb-phy: usbphy@d4207000 {
> +		compatible =3D "marvell,mmp2-usb-phy";
> +		reg =3D <0xd4207000 0x40>;
> +		#phy-cells =3D <0>;
> +		status =3D "okay";
> +	};
> +This document explains only the device tree data binding. For general
> +information about PHY subsystem refer to Documentation/phy.txt

Add empty space between last paragraph?

Delete "only" and "data"?

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvgCyQACgkQMOfwapXb+vL/yACgv1MFtxXrWKXvNP3xKw8WYuOr
LQAAoJmIje6ccB4EM2TKjFEZgaSNDNO+
=weir
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
