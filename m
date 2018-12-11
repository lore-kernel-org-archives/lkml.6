Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C75C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0620851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD0620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLKTt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:49:26 -0500
Received: from sauhun.de ([88.99.104.3]:45224 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeLKTtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:49:25 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id 1370E4C0E90;
        Tue, 11 Dec 2018 20:49:23 +0100 (CET)
Date:   Tue, 11 Dec 2018 20:49:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Message-ID: <20181211194922.h2ajgeos5mb2znwc@ninjato>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
 <20181130231915.GC860@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7eszim7jahxuojo"
Content-Disposition: inline
In-Reply-To: <20181130231915.GC860@kunai>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7eszim7jahxuojo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2018 at 12:19:15AM +0100, Wolfram Sang wrote:
> On Fri, Nov 23, 2018 at 01:51:38PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The "at," prefix was never correct for Atmel, so fix the few occurrences
> > that got it wrong. Use "atmel," instead.
> >=20
> > While at it, remove the at,24c08 compatible string from the list of
> > trivial devices because it is already documented in eeprom/at24.txt.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Applied to for-current, thanks!

Reconsidered (as discussed) and applied to for-next with
'trivial-devices' hunk droppend and Bartosz' patch squashed in.


--v7eszim7jahxuojo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQFMIACgkQFA3kzBSg
KbY66BAAirYq7JrIwgWUKeRfW662jWt3vMcd4Ef10RqrfboExoHcix6zHKJWo5PR
1exoAjs3eXdr0RDbBYGHYbKd/yK3Y34LYIaJy5NdaA1cPwO7I1htqgbM98fYSvU7
CWqAWqVkLAXxcYCABz0A5KKbz14i/rvKPGN1tPlSMl/B2JAKLmrO2xvp25priTv8
FLiXX/pC0YUqSuWAyyeRsJ98gsbI/+KC/GTpYYAqHbo45v9WSIN8y7TrCKuNb87I
JH7EVPmSkJIVeXTOS2OQVW5hJWkCAlK5CtLesB2Jjde8aOwl08oMHiWNQZS9CXRK
766aWrnpLJEPcLcTCqA2BT73Yh1e/IFF03bvwH+F7yMACJvrFSp9jbqeGrUjten9
VZnPbDYi7PQqiPgzIJ0DXHSrPAbEFpO+L6m5zNb7K1Vt47zFepfDa/zUi7ep87o0
YnkADYWo+zV6aeYzRzX++Vf4+rrPQEPBPXBQ3JPD+T1LtSP2RYZb0zRePaQEP0mI
+jw2HbuGrfZkBJ6VrO+4+LQavOo22FOD6UY4GEAXuV1DL7UbW4or9b7Cshjzk1Yn
eyYo2gIZ64YulvuMfnCV94mCBwS1OmTnVW92vDkuVE1XqlYyM8QDW21ThCd9kBD2
fVPOIcpxy94PxPon5WdD13lgjTfvVkEmHaSaFO9i/j/uOt1nh8M=
=2bIe
-----END PGP SIGNATURE-----

--v7eszim7jahxuojo--
