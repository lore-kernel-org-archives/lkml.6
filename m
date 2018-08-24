Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D98FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501CB21564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501CB21564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeHXQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:22:22 -0400
Received: from sauhun.de ([88.99.104.3]:40386 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXQWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:22:22 -0400
Received: from localhost (p54B33931.dip0.t-ipconnect.de [84.179.57.49])
        by pokefinder.org (Postfix) with ESMTPSA id 1C57C305899;
        Fri, 24 Aug 2018 14:47:50 +0200 (CEST)
Date:   Fri, 24 Aug 2018 14:47:49 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: remove deprecated attach_adapter callback
Message-ID: <20180824124749.4vgufcqbrc5oarqh@ninjato>
References: <20180821150240.19964-1-wsa@the-dreams.de>
 <20180821150240.19964-3-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="phvp76g7usouniqu"
Content-Disposition: inline
In-Reply-To: <20180821150240.19964-3-wsa@the-dreams.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phvp76g7usouniqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 05:02:40PM +0200, Wolfram Sang wrote:
> There aren't any users left. Remove this callback from the 2.4 times.
> Phew, finally, that took years to reach...
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--phvp76g7usouniqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt//nUACgkQFA3kzBSg
KbY5MhAAkIydzhA4RGkQclsMYfRc6a2M3pfJYab18eknTzlb2ffROHkpwtXPGdOt
8pRsy5B+uKbe20k5J3/x8O3RHmXc1oRF4E0YmtFTHKoHJr0otC6GXVtk5ZR30ABh
OG499NAhNQ1grFvuZtV1BG1J8di0dTTJFjdAWwoGHcMarCsRDZzg608FUTuJJ892
VWtd+8QDidXQYVWoIWICzvWGlrbhAmBSCRfZAMBdV53f7FjTVwsZJjzY5eQPTIU9
nbcyTJrsOwkJBJfawYPdLqrqwWgnAf5rguyMEHaD9IfjLoT2YpknvwYiRUbaNZyv
WC0pijebOICPSUlzmerUqtmnP4YV+fZ8QtPJkkuz1PPDQsHD/fDh0oDgVXiJYKMA
mCKzAKG3FolDosTq5d2wxbFpTGmjMg8L5ymnoL8eyFI0tR8oZB2DwjSJdIIwyMnU
JLhWHWRWlV82RaJ0bVd75T8A7Cwsdo78ssboFjdRTAxFH881YTsB9LX/obVolPfz
d6ylhNDYPyuwJVPH2OH/ID/6UEHNcUxle2AjOHDqMlmEgkWWWSu3lpZuCf0+PVuY
Q7RRp6pLGVB/y2lNTmNgfduYYjlqx5y5FhZpwu5ITMj09Tgi915MycyB+b5Cy2Ms
V7DkyzyZsw1mpRPgg/uHBxA85Oae3D3PoVZUGOxM+YpHLXJMz8A=
=VOCr
-----END PGP SIGNATURE-----

--phvp76g7usouniqu--
