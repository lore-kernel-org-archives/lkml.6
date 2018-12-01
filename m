Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC0AC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA49E20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA49E20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeLBAXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:23:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53624 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeLBAXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:23:07 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9B87F80A3E; Sat,  1 Dec 2018 14:10:33 +0100 (CET)
Date:   Sat, 1 Dec 2018 14:10:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Olof Johansson <olof@lixom.net>, Felipe Balbi <balbi@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/20] USB: phy-mv-usb: use phy-pxa-usb
Message-ID: <20181201131036.GB31631@amd>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-20-lkundrak@v3.sk>
 <20181130234205.nejqtrsvwtocpq2t@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20181130234205.nejqtrsvwtocpq2t@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-30 15:42:05, Olof Johansson wrote:
> On Wed, Nov 28, 2018 at 06:53:23PM +0100, Lubomir Rintel wrote:
> > Use a proper PHY driver, instead of hooks to a board support package.
> >=20
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Tested-by: Pavel Machek <pavel@ucw.cz>
>=20
> These should have an ack from the USB PHY maintainer before we apply them.
> I don't see him cc:d on these patches though (Felipe)?

I put him into cc now.

USB PHY LAYER
M:      Felipe Balbi <balbi@kernel.org>
L:      linux-usb@vger.kernel.org
T:      git
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
S:      Maintained
F:      drivers/usb/phy/

I guess linux-usb list should be cc-ed, too...
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwCiEwACgkQMOfwapXb+vJo9QCdHREFW+AjF1wKGFileqnwWQJx
PDYAoITADyOFXavZYNPtesk80BVKrAKN
=fKd0
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
