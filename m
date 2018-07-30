Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4184013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E3320873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E3320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeG3QGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:06:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35703 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeG3QGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:06:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C632A8063F; Mon, 30 Jul 2018 16:31:04 +0200 (CEST)
Date:   Mon, 30 Jul 2018 16:31:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180730143104.GB24051@amd>
References: <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <25489.1532953411@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 13:23:31, David Howells wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > Hmm, so kernel now returns messages in english? Not sure that is
> > reasonable, as that is going to cause problems with translations...
>=20
> The problem is that if there's no explicit logging route attached, the
> messages get dumped via printk() instead, so they really need to be print=
able
> strings.

Well, I guess errors should have numbers, and catalog explaining what
error means what. That way userspace can translate, and it is what we
do with errno.

I believe numbers are best. If you hate numbers, you can still use
strings, as long as you can enumerate them in docs (but it will be
strange design).

But anything else is not suitable, I'm afraid.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfIScACgkQMOfwapXb+vKg4ACfZaW20eGyJG54agyIfU1Cxd1z
zb0AoJIeEfzVO7Pkz1IsbW1YF+9dX+A/
=Lt0B
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
