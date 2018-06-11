Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VYkgO69kHlsLCQAAmS7hNA
	; Mon, 11 Jun 2018 12:02:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1ACFC607A4; Mon, 11 Jun 2018 12:02:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89570601C3;
	Mon, 11 Jun 2018 12:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89570601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933095AbeFKMCC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:02:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50114 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932834AbeFKMCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:02:00 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 23FF7804DE; Mon, 11 Jun 2018 14:01:59 +0200 (CEST)
Date: Mon, 11 Jun 2018 14:01:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mark Brown <broonie@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com
Subject: Re: handling voice calls in ALSA soc (on Droid 4)
Message-ID: <20180611120158.GA21745@amd>
References: <20180611102529.GA1272@amd>
 <20180611111011.GA11580@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20180611111011.GA11580@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-06-11 12:10:11, Mark Brown wrote:
> On Mon, Jun 11, 2018 at 12:25:30PM +0200, Pavel Machek wrote:
>=20
> > ...and also. What is right interface for this? Mixer component that
> > says if voice call is active or not?
>=20
> Your modem should be represented as a component in the system and have
> an input and an output representing the input and output on the cell
> network.  See speyside for an example of how this can look in software
> though there's a bunch of different ways modems can appear so you might
> not have a fully digital link like that.

Thanks for the pointer.

With setup like that, how does userland tell kernel that the baseband
<-> microphone/speaker connection should be activated?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlseZLYACgkQMOfwapXb+vLTKgCePk3alYN445NsOHmo+vsZuR+N
8ncAn2Srh+HDZ8pQNncr6xWcW6+zAWf9
=pkOF
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
