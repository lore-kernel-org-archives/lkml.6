Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33C8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EAF2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EAF2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeGOUjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:39:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47042 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbeGOUjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:39:24 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BE27580227; Sun, 15 Jul 2018 22:15:18 +0200 (CEST)
Date:   Sun, 15 Jul 2018 22:15:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Message-ID: <20180715201518.GA19675@amd>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <20180501220228.GD7397@sasha-vm>
 <20180502043017.GA11938@1wt.eu>
 <20180502194139.GA18390@sasha-vm>
 <20180502200229.GA12729@1wt.eu>
 <20180714173812.xhfwtcijlxebmn2k@devuan>
 <20180715085403.GA21992@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20180715085403.GA21992@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-07-15 10:54:03, Greg KH wrote:
> On Sat, Jul 14, 2018 at 07:38:12PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > > The way I see it, if a commit can get one or two tested-by, it's a =
good
> > > > alternative to a week in -next.
> > >=20
>=20
> Pavel, I "love" how you fail to point out that you are responding to a 2
> month old thread :(
>=20
> And that thread was beaten to death, and still you want to revise it,
> which is odd to me, perhaps you just don't like stable releases?  Given
> that you never mark any of the patches for your subsystem for stable
> releases, why do you care about how they are maintained?

I do mark patches -- acording to stable kernel rules. But you are
apparently using different rules, not written anywhere, and I get
complains when I don't mark patches according to _those_.

But this was supposed to be about testing.

And I'd like to see Tested: no/compile headers, instead.

[And yes, motivation for this was that broken LED patches were merged
to stable without any testing, and when that was questioned, I was
told that testing was not performed because it would require unusual
hardware called "USB keyboard".]

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltLq1YACgkQMOfwapXb+vJ/4ACgsOGbawFAbEXJ2EfBdN5W5Ltq
rtsAn2oKuVsakR8nWQM97UFoBtsYEH8A
=akRE
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
