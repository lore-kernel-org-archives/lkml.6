Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F965C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54AE21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfABVCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:02:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43737 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfABVCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:02:09 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5890B808EC; Wed,  2 Jan 2019 22:02:02 +0100 (CET)
Date:   Wed, 2 Jan 2019 22:02:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk
Subject: Re: [regression from v4.19] Re: 4.20.0-rc6-next-20181210, v4.20-rc1:
 list_del corruption on thinkpad x220, graphics related?
Message-ID: <20190102210206.GA26989@amd>
References: <20181121115449.GA32455@amd>
 <154296105546.7930.1457928786446716358@jlahtine-desk.ger.corp.intel.com>
 <20181124152352.GA9548@amd>
 <20181208111346.GA5535@amd>
 <20181208112447.GA9663@amd>
 <64409c484c0601e7504ccc0cf8d211b3bb524ebe.camel@linux.intel.com>
 <20181212182902.GA7380@amd>
 <154468977288.4945.12937975200892746470@jlahtine-desk.ger.corp.intel.com>
 <20181227083439.GA30407@amd>
 <154642167000.6261.3235659892574932494@jlahtine-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <154642167000.6261.3235659892574932494@jlahtine-desk.ger.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > So if you could please try drm-tip reproducing AND open a bug in Bugz=
illa.
> > > If you are unwilling to do that, it is very difficult to help you
> > > more.
> >=20
> > Website says I have to read and agree to two different pieces of
> > legalesee, and I'd need to keep track of yet another password... so
> > you can "communicate" with me.
> >=20
> > But you can already communicate with me, over email.
>=20
> I've listed all the reasons why our bug handling process is what it is.
>=20
> If registering to the Bugzilla is too much of an effort for you, then I
> won't be able to help you further on this.

Actually I did register at the bugzilla. Only useful help there
was that CONFIG_DRM_I915_DEBUG_GEM might be useful. Unfortunately that
one seems to make it panic() and impossible to get anything useful.

https://bugs.freedesktop.org/show_bug.cgi?id=3D109175

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwtJs4ACgkQMOfwapXb+vJYBwCgh3mpSmkcqTtc6geKxgzs8C54
qq8AnA9hg+ykQ03pfDc9trrBICJlAWcH
=gwSn
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
