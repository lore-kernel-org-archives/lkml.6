Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA01C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B901F2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B901F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeIELu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:50:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35000 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeIELu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:50:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8FCFA20787; Wed,  5 Sep 2018 09:22:06 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 62583206F6;
        Wed,  5 Sep 2018 09:22:06 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:22:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 09/11] dt-bindings: sun4i-drm: add HDMI VCC supply
 property for sun8i-dw-hdmi
Message-ID: <20180905072205.63qmmqr45323xllc@flea>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-10-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rlpbalzc2vivwqzf"
Content-Disposition: inline
In-Reply-To: <20180904044053.15425-10-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rlpbalzc2vivwqzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 12:40:51PM +0800, Icenowy Zheng wrote:
> Allwiner SoCs with DesignWare HDMI controller all come with a "HVCC"
> pin, which is the VCC of HDMI part.
>=20
> Add a supply property to specify HVCC's regulator in the device tree.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rlpbalzc2vivwqzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluPhBwACgkQ0rTAlCFN
r3SXZg/6A3RU2hgIonPIwzbtmVglv3hKt4gvJyi4jPNZ/ktv1ZaQMjVOzqs3so09
rs100I6BzKjPjiDdt6MKm9KVxZqjkhvIEVCLFPudCig/ODGCrsJOs+A5TpAByaQH
dUP8HdGDed0kS+vqnZCm8hQLXi4gERU1tx0JK3vXMvjZtggMZsNmM3Vi8np5n9PN
kiPvHwZwQcUC8tdvOiJAl/TukRmAINfpMvc15iUIGPBVyArF60FuUHz0kb8Z5O/C
LwX/Unj19pBaZIkvUBxP6Ind6ywOgy9Z/uFeVBObHQ6hMYFW1VcmnYL6K9lwWGwR
yUcy3gwV6QmUjsLGN+ao58b8zpVO5JBtNs/cqsuZFa1HBjFX40Ua8xOocOvtyJ4h
zcN4fUvxT37D8OvbFSAY+A8eb2pengRr9rLKesT4BT5B41C9PKpwnWS8SQQvr6uO
3oCse3a9GvIJFA1JUJziQNG9ckLkoBqRaW+gWuF3RRkW5UyrW8UgL6dsJWVBfzr4
S1ZwTN+ypuKhcctIBwDCa4WwXVGB2JLyOuAocC6QJ8EXaYD+Xk9XZ0YtyrjkD87G
QXo5/rUvsPB6bhiBodQyfnLokzkbAKqpCXjDr4zWbabij+PNeB6fe+7hXRkNvuT4
MlP1oOhFa5ikKsc4kHnbsl2CsRyyzq2v0mX1s+CdYBSpz3/+/pE=
=i6OQ
-----END PGP SIGNATURE-----

--rlpbalzc2vivwqzf--
