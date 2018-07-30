Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907CC16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012F3204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012F3204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeG3TG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:06:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40429 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeG3TG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:06:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7B1F780662; Mon, 30 Jul 2018 19:30:53 +0200 (CEST)
Date:   Mon, 30 Jul 2018 19:30:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API
 [ver #10]
Message-ID: <20180730173052.GA881@amd>
References: <20180730143104.GB24051@amd>
 <20180729113749.GA7333@amd>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271292330.9458.14583488053811372222.stgit@warthog.procyon.org.uk>
 <25489.1532953411@warthog.procyon.org.uk>
 <21165.1532964795@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <21165.1532964795@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-07-30 16:33:15, David Howells wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>=20
> > Well, I guess errors should have numbers, and catalog explaining what
> > error means what. That way userspace can translate, and it is what we
> > do with errno.
> >
> > I believe numbers are best. If you hate numbers, you can still use
> > strings, as long as you can enumerate them in docs (but it will be
> > strange design).
>=20
> Simply returning error numbers is *not* sufficient.  The messages need to=
 be
> parameterised.

Still userland needs a way to understand the errors.

One way is to pass ( "not enough pixie dust (%d too short) on device
%s in %s", 123, "foo", "warddrobe" ). But if you pass it as one
string, it becomes hard / impossible to parse. (For example if device
is named "foo in bar".)

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltfS0wACgkQMOfwapXb+vIk3wCfX+fZLbNSHOPD56IRl20NWUh9
n30AoLAjzvWAym6Q24Riu+oKZiPB6NUC
=i5V3
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
