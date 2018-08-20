Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AD0C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5592154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5592154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeHTRXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:23:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42337 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeHTRXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:23:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B944520703; Mon, 20 Aug 2018 16:07:46 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id 89F7C204AE;
        Mon, 20 Aug 2018 16:07:36 +0200 (CEST)
Date:   Mon, 20 Aug 2018 16:07:37 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Emmanuel Vadot <manu@freebsd.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Message-ID: <20180820140737.xmqhu5ndqzehvkql@flea>
References: <20180804070355.14857-1-manu@freebsd.org>
 <20180820111755.rzg7l2lznmbpuf2e@flea>
 <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dfblawrkuzgtn55u"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dfblawrkuzgtn55u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 07:41:22AM -0600, Rob Herring wrote:
> On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > This patch adds documentation for Device-Tree bindings for the Allwin=
ner
> > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > >
> > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> >
> > I'm not going to merge a binding for a device that doesn't have any
> > driver implemented at the moment in Linux.
>=20
> I'll take it then. Linux is not the only DT client.

Then don't complain if we ever have to break the ABI. We never tested
that hardware, never had any code running on it, and it *will* cause
some issues. For example, the calibration data have never been used
and how they should be represented have never been described, since no
one ever actually tried to use it.

And sure, Linux is not the only DT client. Just like FreeBSD isn't.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--dfblawrkuzgtn55u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6yygACgkQ0rTAlCFN
r3Sy1w/+OamHTodVCKCQSHPZ8BlltgfldcvvWSDZQSAGyaNvyQPxDx9R5CZSmBwc
Xl/xvrz9wDKg3TQOl2KSfMwFoHyhMmKaWIWHOi2KJNdfDzflNvsMBN8Vo0RL/W5J
J7rVy1q8VZz2IQ5q+lSq81vqaV9cu7g4gAEDCzyFtZJU7oEXV3zLgC32ONKVVhIP
1tBP+QcTTq4zyFkQrwCN8W1PWLDUFh1+HUMf5TeNcI13DekGIOQiyWLOK7c7ORXN
2qLo153ZlTiqWP8vjI4eFA4RvfpKvHFd2F6h8FNm9pxPWdegMme5RPdrBxshzap3
4sn0EN/AFrygrSqyFmKf+8KHqBq+Jxx4ho3ZrMmKQSD2Kd525vtqzPO6QSLlEo6A
dCnpAq5uImcthubuotRn+R4NX0FLkDXSxX/xnhID4OYetyX6thldnaMFol8453a1
E73kV5JwkQ9VYnkx9vWSlbSyNsn+RP5xfCTepbPc8ziPI5gspqL49b5icJpdy9hx
bNyEhYmTvViAOP09hnx+APCK4Lg9E+09RI9dF1UwoDa4LfmgIs3/jIcfiahzmZIx
RuIIfCAJQL14pGawOsKdT1EjIUrfkqtVwoTTN4Ri5XZIt+5v7wvPfCxn+gPbxR6w
fYqmFW3g7j+gPKAuHDB8g4SRQI3XQTfyfGu7Sgu+629a3eYDH0E=
=oSp1
-----END PGP SIGNATURE-----

--dfblawrkuzgtn55u--
