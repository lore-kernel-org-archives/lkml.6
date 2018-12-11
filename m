Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1BBC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5D72084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5D72084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeLKLTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:19:53 -0500
Received: from sauhun.de ([88.99.104.3]:41602 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeLKLTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:19:52 -0500
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
        by pokefinder.org (Postfix) with ESMTPSA id C44264C0E8F;
        Tue, 11 Dec 2018 12:19:50 +0100 (CET)
Date:   Tue, 11 Dec 2018 12:19:50 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files
 with double quotes
Message-ID: <20181211111950.ewqhxaoitrrsxp7x@ninjato>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
 <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mwbqm27pd7bahvul"
Content-Disposition: inline
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mwbqm27pd7bahvul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:01:04PM +0900, Masahiro Yamada wrote:
> The Kconfig lexer supports special characters such as '.' and '/' in
> the parameter context. In my understanding, the reason is just to
> support bare file paths in the source statement.
>=20
> I do not see a good reason to complicate Kconfig for the room of
> ambiguity.
>=20
> The majority of code already surround file paths with double quotes,
> and it makes sense since the included file paths are constant string
> literals.
>=20
> Make it treewide consistent now.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--mwbqm27pd7bahvul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwPnVYACgkQFA3kzBSg
KbapthAAswtEQAelInCKg1PRZxmFeR9k5d7t4431idaQJttt0QpBw8aERjobozOf
9QrWod/rn7R82mtt9TkSm89JAgla/b7+o2EfCj5niTwt8qyJC3MmeeyJ1ZEMXky9
mu6ZYvA7+yIKO1kTGxaWj3FkeifJmYa9DSjvfk6YXCNjUEmwC71VBOz3kSriIaqp
s1zjn3UYZyKomGiCTsv6652a4lWiRicqIkPBAFkRZ1ZhHszBHXfoPnSIt4z3tJLm
LmRFjc5/J8M1lo/niOjbV9vnR4BerHDW3cO5tX/pt/jRnYmKxtI+wYk3M7jI98Du
kq0XYBwC/2Q6AKUXp27m/BvndNykBB9A3cm85oxaORKoPhS+ZChz18o0Tu6oBlFf
TZs9isju21V9ffcZWZHdmWt24UgRZl+OhRuvGREbNzoVKT+4vPJMzYlKnMNFWMxr
afbBlfGz7RiSD5C+f96hWBPQr8cdP75QLH6myWNY6Hi0G8oYgB81zr9kD2qTrXSB
B8rZiJhFbgnGbGBIcbCPRlOq4kQ5LZWBVCCsMZn7Rzwku7F+ZoVOqc8VKYx8ewUT
is3rtS9tKu6xve/mLWyHqM2Rp2Gid4oQlLqomzCA7PK+k7YxpvEao4AIG51JbujC
pUKib9TWNrPFCrIi6siIkbjlP4HOGTminSdOahxyGgK61Ev74U8=
=6+ar
-----END PGP SIGNATURE-----

--mwbqm27pd7bahvul--
