Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4134C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6831D208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6831D208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeG3Twv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:52:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41701 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeG3Twv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:52:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B2F0880668; Mon, 30 Jul 2018 20:16:37 +0200 (CEST)
Date:   Mon, 30 Jul 2018 20:16:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180730181637.GC2416@amd>
References: <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <20180730143104.GB24051@amd>
 <20180730180842.GA5544@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20180730180842.GA5544@bombadil.infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 11:08:42, Matthew Wilcox wrote:
> On Mon, Jul 30, 2018 at 04:31:04PM +0200, Pavel Machek wrote:
> > Well, I guess errors should have numbers, and catalog explaining what
> > error means what. That way userspace can translate, and it is what we
> > do with errno.
> >=20
> > I believe numbers are best. If you hate numbers, you can still use
> > strings, as long as you can enumerate them in docs (but it will be
> > strange design).
>=20
> Have you looked at how gettext() works?  It uses the english text as
> a search string and replaces it with the localised string.  This is
> a very common design!

Yes, and it needs ("foo %s %d", "bar", 3) as base. Not ("foo bar 3").

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfVgUACgkQMOfwapXb+vKc1gCglpZQ6AA69dqgXs7N2XB0Cvni
iXsAoL6VQoDipLg3eHhaAWLH1Ywf1RXu
=/g0O
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
