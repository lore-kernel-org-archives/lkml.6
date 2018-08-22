Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3E6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA71C20936
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA71C20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeHVXCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:02:21 -0400
Received: from sauhun.de ([88.99.104.3]:53356 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeHVXCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:02:21 -0400
Received: from localhost (p54B3399D.dip0.t-ipconnect.de [84.179.57.157])
        by pokefinder.org (Postfix) with ESMTPSA id 5D8CA2DCF27;
        Wed, 22 Aug 2018 21:36:07 +0200 (CEST)
Date:   Wed, 22 Aug 2018 21:36:03 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Fabio Estevam <festevam@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/11] can: rcar: use SPDX identifier for Renesas drivers
Message-ID: <20180822193603.e27diao5nhuiarv6@katana>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-6-wsa+renesas@sang-engineering.com>
 <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
 <20180822063005.535lytz7hl32rsha@katana>
 <CAOMZO5BiAyDMSR=2Y-4-1ftNuVtRS59sSJd_cdFmzX=0kgF0Bw@mail.gmail.com>
 <CAOFm3uF9_rbELx0aYLDXpDnZfi2Z11V1Z4Ktw+DDJT62o2S1kQ@mail.gmail.com>
 <20180822193133.GA1613@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cuvtzae5euf5uwje"
Content-Disposition: inline
In-Reply-To: <20180822193133.GA1613@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cuvtzae5euf5uwje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > IMHO we should always treat and use the
> > Documentation/process/license-rules.rst as the reference and not SPDX
> > proper who moves at its own pace and evolves its specs and license ids
> > independently of where we stand in the kernel.
> > If this is not right Doc patches are welcomed!
> > In this is very specific case this has been discussed on list a few
> > times. If I recall correctly Thomas also had an opinion on this...
> > So you are correct and this should be for now:
> > // SPDX-License-Identifier: GPL-2.0+
>=20
> That is correct, stick with that format/version for now please.

OK, will fix.


--cuvtzae5euf5uwje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt9ux8ACgkQFA3kzBSg
KbbiRxAAlhkmV25yoF3Y+2aYMAerBVNfqJI43ETS9UoOoOEhr40sD6ER5DeYEd5A
SppRU23pFHEGhALZOZJ6seB7h9aOIr97POfCuvPJltUw4NOd9Bh/Vz+M3yDHpYv0
giWuF+i+UOUDl9TF83Q536xL+UFyS27oNSk3S5WAM+9KFk1Krr92oZZQz46X/NqA
K8WUcEdF4bloQ6AhV1IWX4goCq+/v0OV94QVYdh3EoYICY6S905sY+angWu5ap89
QLKxAeNbsvqN4CMod0D2to3MvOtL9UkJn4YTi/tJTY+qc7WPuK1LmNwHcy5ZyS9b
qp3LID7GjWGQ+aPYhhnldyLm1fgtWAoqTjeMw8mKTP9Phi01A6q0HguW+WNfYY1u
ZU9XMa2pwZKP00gkNZ6X0HqQAWQv6qhUVD+YaLBNL6WNA3Q2lsPVaEqTfY88lLkO
F/+CQbjpnUM92u/FUOB7gEHafdL1Svx3Ay7o2dtnlBqwx6R3SMP/r8uOmjUoLl1V
gbZFjXhygkK+hcXEcdWi/NfYSsnfb9rZaqOLqEfjg9GCFSPmxqD+CKR6lWEVrXN7
7q97N3LfHsy5ghz3VCkefCfffbOCBigcrNCN2+QQepu8MRb5Lz4iKGV/Cg/mbcgC
2+tdecT4t2NHlxIvybfrLna1bTIteWss9P6Sx4NdtU+nzL8Q2E0=
=IaDB
-----END PGP SIGNATURE-----

--cuvtzae5euf5uwje--
