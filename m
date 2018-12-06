Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC28C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A94208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A94208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbeLFKoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:44:24 -0500
Received: from sauhun.de ([88.99.104.3]:55506 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFKoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:44:23 -0500
Received: from localhost (p54B332AE.dip0.t-ipconnect.de [84.179.50.174])
        by pokefinder.org (Postfix) with ESMTPSA id B01003E409B;
        Thu,  6 Dec 2018 11:44:21 +0100 (CET)
Date:   Thu, 6 Dec 2018 11:44:21 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: use correct vendor prefix for atmel's
 at24 EEPROMs
Message-ID: <20181206104421.a6njveg72dcguckp@katana>
References: <20181206094550.18082-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="frabkcsks3ptsucc"
Content-Disposition: inline
In-Reply-To: <20181206094550.18082-1-brgl@bgdev.pl>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--frabkcsks3ptsucc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 10:45:50AM +0100, Bartosz Golaszewski wrote:
> This is a follow-up to Thierry's patch which missed a few occurences.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Since I dropped Thierry's original patch, I wonder if it is okay with
you to simply squash these hunks into it?


--frabkcsks3ptsucc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwI/YQACgkQFA3kzBSg
KbYeQg//W8XFZYMc3vaOP7feUAcyLJvscCHna+LcDwfm+2obDWOX42aMuKHNzcYz
fzoS1xIprZNAOBOfzA99qf5KQarbgK3dYO/rtdz4YD7v8Nqd+nFNIqUjlqqjPc9t
8JHYbxcDvKNabLRpoKcXpvmWAnRKdsZE6fEQKfEUb9E4OYqpFqOp/+kYGiocBbhN
i3lEwXDEv0bf5PLrBsZp8L2GQT64abRUoX8Z/05ioq5g9rlc/EnqQgzUwSPYA6iA
LXfMtBW7QddHCG1+EUAPh4ezZwmhOrPdaTxUQ4vvJGs8qYYhasTrkEg1Dpf971kI
FJ8mDfOfgZWRwuSgDWjgGASJEYnGLCTApo1F9zB84qTaVyxft1UiBNXDZ2VQutvl
fdsbmK69MRPlIg44uxfYPHzU5gslXMpbNud0AYItGQ/M6rPu3JdKrMNCkPYQM8Uf
WJBJWo8zptVpZ9dgW9Od695XWcZiMc528HLhnu8cHPmp2mXWQEWkvL4zEN3/hLRk
Z4suJ21Q17Dlj8+XdUXgzt6w1o+/D7RJ8h8KrpM1ow6vebV/YdyGkGaTHur06R1U
VUO6KPlsbgSP7TO5q+EAHMaLSmlkrKk4AeR37VnKr6bhAsjE0hoaIyMLOFQydlQP
uAu8VmoW9VtbjrhcsBhE9XC63Nc88GU3a0H9gq4aJfdEP9vdCxA=
=znMD
-----END PGP SIGNATURE-----

--frabkcsks3ptsucc--
