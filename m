Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7YfWMvCfGluaYgAAmS7hNA
	; Fri, 08 Jun 2018 15:26:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF5E0608B8; Fri,  8 Jun 2018 15:26:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2EE8460590;
	Fri,  8 Jun 2018 15:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EE8460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeFHP0B (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:26:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46391 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbeFHPZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:25:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9B0A680548; Fri,  8 Jun 2018 17:25:58 +0200 (CEST)
Date: Fri, 8 Jun 2018 17:25:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ernesto =?iso-8859-1?Q?A=2E_Fern=E1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Cc: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
Message-ID: <20180608152557.GB11958@amd>
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20180603184955.zrowxp4y3ij66y5n@eaf>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-06-03 15:49:56, Ernesto A. Fern=E1ndez wrote:
1;2802;0c> Hi, thank you for your report.
>=20
> On Sun, Jun 03, 2018 at 06:52:19PM +0300, Anatoly Trosinenko wrote:
> > How to reproduce:
> > 1. Take kernel source v4.17-rc7
> > 2. Compile it with the config attached
> > 3. Unpack and mount the attached FS image as hfsplus.
>=20
> We are aware of this issue and I've sent some patches [1][2]. It's hard
> to get reviewers interested in hfsplus, so I don't know when it will be
> fixed.

I guess Anatoly can still test the patches, and add Tested-by tags if
they help. No guarantees, but that may make it easier to get the patches
merged.

Thanks,
								Pavel

> [1] https://www.spinics.net/lists/linux-fsdevel/msg125241.html
> [2] https://www.spinics.net/lists/linux-fsdevel/msg126499.html

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsaoAUACgkQMOfwapXb+vIm9wCfYdrFCIQhJR8D6UtHGDHHgR+I
BiEAn20/yDUkDePzddWw1QxB76AtJmr9
=NkPS
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
