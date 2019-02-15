Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA92D222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbfBOX0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:26:03 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46814 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbfBOX0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:26:02 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4E31180455; Sat, 16 Feb 2019 00:25:54 +0100 (CET)
Date:   Sat, 16 Feb 2019 00:26:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190215232600.GA21591@amd>
References: <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
 <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <20190214122840.GA21860@amd>
 <6beed61c-1fc6-6525-e873-a8978f5fbffb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <6beed61c-1fc6-6525-e873-a8978f5fbffb@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-02-15 22:41:31, Jacek Anaszewski wrote:
> Hi Pavel,
>=20
> On 2/14/19 1:28 PM, Pavel Machek wrote:
> >Hi!
> >
> >Jacek, could we get you to comment here? I'd prefer "hardware" trigger...
>=20
> What prevents use from using pattern trigger with its hw_pattern file?
>=20
> Do you remember drivers/leds/leds-sc27xx-bltc.c and its breathing mode,
> for which pattern trigger was introduced?

Yes, we can do that.

But forget heartbeat and blinking now.

Problem I'm getting at is that this LED can either be software
controlled (showing for example disk activity) or it can show whether
the battery is charging (autonomously, in hardware, will work even
after kernel crash).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxnSogACgkQMOfwapXb+vIFEwCghiDqFaTxqIxtznmzoZHQnXrB
J2AAoLuDQcYHggxlTOlNt/WTMKUR/1MI
=Sc/n
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
