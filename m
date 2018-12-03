Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EA4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846EF20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846EF20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLCMQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:16:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44395 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCMQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:16:09 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1E7C18092F; Mon,  3 Dec 2018 13:15:17 +0100 (CET)
Date:   Mon, 3 Dec 2018 13:15:19 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] code-of-conduct: Remove explicit list of
 discrimination factors
Message-ID: <20181203121519.GA7478@amd>
References: <20181202093257.3918-1-geert@linux-m68k.org>
 <20181203110506.GA7485@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20181203110506.GA7485@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-12-03 12:05:06, Greg Kroah-Hartman wrote:
> On Sun, Dec 02, 2018 at 10:32:57AM +0100, Geert Uytterhoeven wrote:
> > Providing an explicit list of discrimination factors may give the false
> > impression that discrimination based on other unlisted factors would be
> > allowed.
> >=20
> > Furthermore, this list is already overly long, polarizing,
> > politically-laden, and reinstating the concept of human races.
> > None of these is related to the goals of the Linux kernel project.
> >=20
> > Avoid any ambiguity or political undertone by removing the list, to
> > ensure "a harassment-free experience for everyone", period.
>=20
> I understand the reason you and others are proposing this change,
> however for now, let us stick with the text that we have.  As Linus and
> I said just over a month ago, let's sit with the text we have until
> something comes up that requires a change to happen.
>=20
> Also, I recommend you work with the upstream developers of this text to
> see if they agree with your changes here.  If they do, and update their
> version, I will be glad to revisit this text at that time.

> But everyone, please note that there are very specific reasons for
> listing things like this.  You might not agree with those reasons,

So what are the reasons?

You marked yourself as a maintainer (and I do not think community
agreement exists that you should be maintaining this), yet you refuse
to take changes, pointing that there's "upstream".

> many other people do so each "camp" can not be happy in the end.  As we
> did have 3 years without such a list of factors, perhaps it is time to
> have 3 years with the list to provide a fair balance. :)

What kind of argumentation faul is this?
Aha. https://en.wikipedia.org/wiki/Argument_to_moderation=20

> So I'm not going to accept this patch at this point in time, sorry.

Linus, I don't think Greg is doing good job maintaining this. Can you
take the patch? (Or explain what is going on here, because I don't
think public has full story).

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwFHlcACgkQMOfwapXb+vLG+gCgsCzEOCgkrssfSD8rr1Wi2j6a
0YgAoLh5kKJ7KXGG4rb8se0dkDn7JYVh
=v40D
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
