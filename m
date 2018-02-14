Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967233AbeBNKml (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:42:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38264 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967089AbeBNKmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:42:40 -0500
Date: Wed, 14 Feb 2018 10:42:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RESEND2] regulator: fixed, gpio: dt: regulator-name is
 required property
Message-ID: <20180214104235.GA9804@sirena.org.uk>
References: <1518532988-10990-1-git-send-email-harald@ccbib.org>
 <20180213154530.GF5988@sirena.org.uk>
 <E1eltrI-0000Kv-W3@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <E1eltrI-0000Kv-W3@stardust.g4.wien.funkfeuer.at>
X-Cookie: Support wildlife -- vote for an orgy.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2018 at 11:00:12AM +0100, Harald Geyer wrote:
> Mark Brown writes:

> > No, a content free ping is when you just send a reply saying something
> > to the effect of "hey, what's going on with this?".

> Well, I did quote the entire patch and gave a summary of the status
> as far as I know it. So I really don't understand why I got the
> "no content free pings" response ...

Which just boils down to a "what's going on with this" message.

> > As I said in my
> > reply best case the answer is going to be "I have no idea, you need to
> > resend since I'll need the patch to do anything with it" and worst case
> > it just won't get seen at all if the thing really did get buried
> > somehow.

> So you are saying you don't want pings as followups to patches at all, if
> the patch is old enough that it probably got lost?

> I guess that would make sense too, but again it's not obvious to read
> the canned response that way.

No, I'm saying don't send pings at all.  Resend patches if you think
they've got lost, and as normal when you're sending a patch it should
start off a new thread.  The goal is to send something that can be
directly acted on when it's seen rather than requring another round of
mails.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqEEpsACgkQJNaLcl1U
h9DVTQf/bMdvugDYsrcHN5R15sh6pn8pr9OFoNDDXPdLxr7X6VjnuWP8Nw++rKaf
2AxzSYU/kRA1hR2aUSusNqqaYuWtCVkGoM2cfIFnF0w3akOrbL8S4XP4sCO2LJQX
BsqlrpjQAiD3UA6XjSN8H229xjHANdh3xgZoiR7UVTBHwiTOCOC1untkiPFt+zxm
wRM6OTt9Y3+cIWH0mp9s+44nDimnoqRrKuL7KAvaeMTmynODgZkAAdDYgZWWZ+jk
JrfngHPfeeZmrWYeJN5KYINOAH/ZlSNV1hDT9jC8Rq9+oZdC+WzhXnA0QYljtRdq
MBFSVmTO/J3mrHFI4ZSeyykYMsLnJQ==
=Uflm
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
