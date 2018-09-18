Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFA8ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4972150F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4972150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeISAuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:50:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34274 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbeISAuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:50:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B333C80721; Tue, 18 Sep 2018 21:16:14 +0200 (CEST)
Date:   Tue, 18 Sep 2018 21:16:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>, Chris Mason <clm@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lxom.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180918191613.GD4501@amd>
References: <20180917114852.hzo36b2fewdzqc4t@wunner.de>
 <20180917122430.GA3320@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
In-Reply-To: <20180917122430.GA3320@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-17 14:24:30, Greg Kroah-Hartman wrote:
> On Mon, Sep 17, 2018 at 01:48:52PM +0200, Lukas Wunner wrote:
> > Seriously though, I read this to know what I need to be aware of but od=
dly
> > the language of this paragraph says it doesn't apply to me:  I'm not us=
ing
> > an official project e-mail address nor an official social media account,
> > nor has anyone appointed me as representative.  I can live with that, I=
'm
> > just wondering what the benefit of a document is that only seems to app=
ly
> > to a tiny fraction of the community.
>=20
> I do not think you are reading the document correctly.  As an example,
> it should cover any emails sent to this list.  That is not a "tiny
> fraction" by my last count :)

In typical "being nice but not really honest", you failed to answer
the other question in this comment.

Lukas asked:

> > to a tiny fraction of the community.  Has this CoC been discussed
> > anywhere?
> > I'm not seeing it in the LKML or ksummit-discuss archive.

And yes, I see problems with this CoC. You seriously expect "all
maintainers" to ban Al Viro for commenting in his usual funny way?

Derogatory comments are now prohibited, so what you do now when
receiving bad code? Ignore it completely? _That_ is evil.

What is wrong with =E2=80=99s in the document? Normal ascii is '. Same mist=
ake
was in Linus' announcement. Does it have same author?

Publishing email address without explicit permission is now
prohibited. WTF? How does that interact with signoffs? Merging GPLed
code is no longer allowed when the original author can not be reached?

Who is author of the document? First signoff is by Chris Mason (is
that signoff chain real?) but Greg is listed as author.

The document does not describe current practices. It was not
discussed. Yet it states that contributors pledge... and it tries to
speak for me? That does not exactly sound like a positive environment
to me.

No thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluhTv0ACgkQMOfwapXb+vIYPQCgl/M7QVHFrztM7YHTemb0mcjx
SLAAn3fBtBl+a4Vxsbk1edFD+6mT10D6
=3Hlu
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
