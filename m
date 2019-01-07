Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AC3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D78A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfAGTZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:25:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50240 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAGTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:25:01 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 24B13808ED; Mon,  7 Jan 2019 20:24:54 +0100 (CET)
Date:   Mon, 7 Jan 2019 20:24:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: Consistent capitalization of "device tree"?
Message-ID: <20190107192458.GG933@amd>
References: <20190107183711.GA5671@amd>
 <91bc4723-8e3a-4ed6-5104-36a614d6a6d2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <91bc4723-8e3a-4ed6-5104-36a614d6a6d2@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-01-07 11:06:27, Frank Rowand wrote:
>=20
> + Frank
>=20
> On 1/7/19 10:37 AM, Pavel Machek wrote:
> > Is it "Device Tree" or "device tree"?
> >    =20
> >  pavel@duo:/data/l/k/Documentation$ grep -r "Device Tree"  | wc -l
> >  235
> >  pavel@duo:/data/l/k/Documentation$ grep -r "device tree"  | wc -l
> >  595
> >    =20
> > I guess it would be nice to make it consistent. I guess "device tree"
> > is preffered?
> >=20
> > Should we do something like this?
> > 								Pavel
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >    =20
> > diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation=
/devicetree/overlay-notes.txt
> > index 725fb8d..cc5f507 100644
> > --- a/Documentation/devicetree/overlay-notes.txt
> > +++ b/Documentation/devicetree/overlay-notes.txt
> > @@ -8,7 +8,7 @@ companion document to Documentation/devicetree/dynamic-=
resolution-notes.txt[1]
> >  How overlays work
> >  -----------------
> > =20
> > -A Device Tree's overlay purpose is to modify the kernel's live tree, a=
nd
> > +A device tree's overlay purpose is to modify the kernel's live tree, a=
nd
> >  have the modification affecting the state of the kernel in a way that
> >  is reflecting the changes.
> >  Since the kernel mainly deals with devices, any new device node that r=
esult
> >=20
>=20
> Not a strong opinion, but I would prefer a third option of devicetree.  T=
hat
> makes it much easier to search for.

That one is much less popular at the moment -- according to my
searches... so it would be a bigger change.

(Which I'll gladly support if I won't have to do the work... as long
as it is consistent. But I believe that "device tree" is most common
here, makes sense, and is easiest change, so...)

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwzp4oACgkQMOfwapXb+vLEswCbBdm8IyiDQtOuQQ0KTBtyw36x
Rn8AoJx0B+t/4p+SF3GVwBh1YyRYJHsX
=V5r1
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
