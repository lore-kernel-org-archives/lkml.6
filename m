Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D992FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD0C20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD0C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeLAKaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:30:11 -0500
Received: from sauhun.de ([88.99.104.3]:34494 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAKaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:30:11 -0500
Received: from localhost (p54B334EC.dip0.t-ipconnect.de [84.179.52.236])
        by pokefinder.org (Postfix) with ESMTPSA id 918AE2E3542;
        Sat,  1 Dec 2018 00:19:15 +0100 (CET)
Date:   Sat, 1 Dec 2018 00:19:15 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Message-ID: <20181130231915.GC860@kunai>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20181123125138.22489-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 01:51:38PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The "at," prefix was never correct for Atmel, so fix the few occurrences
> that got it wrong. Use "atmel," instead.
>=20
> While at it, remove the at,24c08 compatible string from the list of
> trivial devices because it is already documented in eeprom/at24.txt.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied to for-current, thanks!


--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBxXIACgkQFA3kzBSg
KbZd4hAAn9iOT2AqhOm5aB5oAWave42zCqrQIf/9Z6kZCnhN8curi3WesgUjwfOr
M5WcMptWlveZwE8FOAx1K0EYqyWYOgOc2H8Qoi/kdiRYSC6cH2BN93otB49VBg2W
cIwLnxrxRcZjGTRElADUpUosF73aG2V2okYn6Ryz5EdiPAl1J+DJaevbZv+KOOlS
4giqL1/zRRxzFMsYQIC0Bz2DHj7UalX48E3gQBLlrY3vMPOR6QWLLwdTzVcN6Fwy
09LfsKgNOE27F5q2RMk6g/b5NVIA36ufSetKA15SgYiZWrRBhLLq7mz07yC+m11N
80crbo3tMpvJiEy8pOA6bVUZfG05v16nvKHA0YLsjwRNwK+5rDIiQ21q/+JulIIv
y+04Ed8vTu26NbpWJ5HDeYdAsuuysp9AQA1JR6qX0juiNIHfslTkNRPgceFnlN68
OMRllBHAoy2l7Lc55RDtZkmBNnLg6esejZHocqFsKI9otn1YnkNX9J9PdnOroWNI
1DPyK+sGJizHiSOQHMuD40XiS8hOZs+G9oUnaF38vFyhPcho5Im+Vf1ennw9akWQ
lZmEI6pt+VzFLvWe0EEPATtL5MUqH56jZQaFaGIyESJDm8aGOaRPRZaomJlry5FN
Dy6GCMBkVq6bCbaz1QzjM+xdwlKvGrx0xGVR2PlglymQ+WBcOXo=
=hme5
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
