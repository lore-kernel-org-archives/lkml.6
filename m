Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A30AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E11C20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E11C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbeHAUpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:45:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35071 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbeHAUpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:45:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C8BBE806CB; Wed,  1 Aug 2018 20:58:33 +0200 (CEST)
Date:   Wed, 1 Aug 2018 20:58:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: v4.18-rc2 on droid4: screen turns red
Message-ID: <20180801185829.GD26087@amd>
References: <20180630131812.GA549@amd>
 <20180711102655.GA6864@amd>
 <20180717062608.GY99251@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <20180717062608.GY99251@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > After longer inactivity, attempt to wake up the screen results in
> > > screen being completely red. Not too useful. I can still connect over
> > > ssh.
> >=20
> > Still there in -rc4 :-(. But happens only once in a few days for me...
> >=20
> > When X is shut down, text console works ok.
>=20
> FYI, I've been chasing an occasional hang with lapdock and it might
> be related to the usb phy switching between usb and uart mode
> spontaneously. And then the usb traffic can cause a sysrq trigger
> potentially when the glitch happens. Not sure yet why it happens, it
> might be related to lost cpcap interrupts still.
>=20
> Anyways, so far looks like doing the following may have prevented
> it. Well at least for about four days of uptime now:
>=20
> # echo 0 > /proc/sys/kernel/sysrq
>=20
> And no red screens here yet either. Care to check if this might
> somehow also prevent your red screen issue?

Looks like red screens are pretty seldom :-(. I did not see it since
that report. (But I stopped using Droid 4 as my primary phone after it
lost some SMS.)

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltiAtUACgkQMOfwapXb+vIZTQCghGff94B8JikA+58iqOLxTm5o
QrkAoLs1NDygSxNGMadSDUdsY4DRsEfs
=4APA
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
