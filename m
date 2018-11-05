Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B622C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CAA20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CAA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeKESTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:19:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57326 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbeKESTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:19:33 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 51558207B0; Mon,  5 Nov 2018 10:00:52 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1A4EC206A1;
        Mon,  5 Nov 2018 10:00:42 +0100 (CET)
Date:   Mon, 5 Nov 2018 10:00:42 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/3] Allwinner H6 Ethernet support
Message-ID: <20181105090042.u5x2h6rek4nyaghc@flea>
References: <20181103123238.4665-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tg23n6htzoo3f5qs"
Content-Disposition: inline
In-Reply-To: <20181103123238.4665-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tg23n6htzoo3f5qs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 03, 2018 at 08:32:35PM +0800, Icenowy Zheng wrote:
> This patchset introduces Allwinner H6 Ethernet support with code already
> available for A64.
>=20
> As the EMAC on H6 is similar to A64 ones, support for them are directly
> reused, by using fallback compatible strings.
>=20
> Patches about system controller in v1 is sent by Jernej Skabrec as part
> of his H6 display patchset, and already gets applied.
>=20
> NOTE: This patchset targets the final version of Pine H64, and also
> supports the early sample of Pine H64 model B. However, it's not
> compatible with the early sample of Pine H64 model A. Please DO NOT test
> this patchset on the Pine H64 model A samples.

Applied thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tg23n6htzoo3f5qs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+AGugAKCRDj7w1vZxhR
xU3yAP9MqILXYjRDYrZ6Tcr+9q3wmubfZhvB1YvUK1G46CKKQgEA3qq4F3blV9r9
SjmheEMcyEyQAX2BHV773+nW0NL+1gY=
=6teA
-----END PGP SIGNATURE-----

--tg23n6htzoo3f5qs--
