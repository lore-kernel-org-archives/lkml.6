Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521DD20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521DD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeICRyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:54:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35437 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeICRyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:54:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 504D920799; Mon,  3 Sep 2018 15:34:00 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0E29520618;
        Mon,  3 Sep 2018 15:34:00 +0200 (CEST)
Date:   Mon, 3 Sep 2018 15:33:58 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v2 6/7] dt-bindings: net: phy: mscc: vsc8531:
 remove compatible from required properties
Message-ID: <20180903133358.b2zsdytyjpentnuj@qschulz>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
 <20180903084853.18092-6-quentin.schulz@bootlin.com>
 <20180903133020.GE4445@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hezqfp2ga7x4qn5u"
Content-Disposition: inline
In-Reply-To: <20180903133020.GE4445@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hezqfp2ga7x4qn5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Sep 03, 2018 at 03:30:20PM +0200, Andrew Lunn wrote:
> On Mon, Sep 03, 2018 at 10:48:52AM +0200, Quentin Schulz wrote:
> > Compatible isn't a required property for PHYs so let's remove it from
> > the binding DT of the VSC8531 PHYs.
>=20
> Hi Quentin
>=20
> It is actually a optional property. So you could move it into that
> section of the binding documentation. But removing it is also O.K.
>=20

It's a property that is already defined in
Documentation/devicetree/bindings/net/phy.txt

I don't think it's actually useful to redefine it there (on the same
principle that we don't redefine/re-explain the reg property).

What do we do? Do I put it in optional properties and refer to the
aforementioned doc or do I just remove it as it's done in this patch?

Thanks,
Quentin

--hezqfp2ga7x4qn5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAluNOEYACgkQhLiadT7g
8aMeYQ//bfFfqiuHWAzloS7a3NN50nCAhkAxl75esGMNBcKdDzptnxoO2iNEjjQA
0GxOWAn+ZWxYkiZbyxBkJ59R1RCvVk+qazByTZgQiRBAhn8OQQO5zfpt990radPN
J7x7uGfyygohsvq2sMtRZYQ/69OHJYigSmLO4ZtpIyl20zlgL/V7a0Ozz1FkJ43V
N7UPc3pR2vMaPQlulDrrqmc97UFDvbE5E2Ff990mM0qyoWtkO4Qby2O5MolKsiNd
GzOO5cxKeWfwV4TXqO02NEceJ8NbqNUg6FxmIMECLDYWDCX75ins3rTVVtI9HNI/
D5otmaQQg4OuHVfrdJbgLAHzw+Bk/0wftnlMGu8bfN/RNwLS8QZu7MxGxnqGulEb
Y7F7jdBhgdjoIOcxL+QpbpCkEwtthIqYUIicgDerQjbv9b9E7IN/PuUGMxrHpV2g
txq04iWZEggsOAwsYCzY6T8hslEpBZ+xcnAvscPVIHoBFRs6CJdJBCBcqifZN+PM
n4UC2ZBnfumaXYthjyiDYBYrUYnL+POH+KChhftMDZvdsk6GqAXudZ1I+DtPgvqH
AeFouYRf6sWDhC1NvhmDVGji1m0ElPpkc+tTkVS4xCHW1178Q/98rO2Zth+EPYOl
Zy5lJxgJy66x+qGASdEyLhgHbZ6ehv46a1SoqwP170ZwinbzLbE=
=aXVP
-----END PGP SIGNATURE-----

--hezqfp2ga7x4qn5u--
