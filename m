Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C3DA1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E2020896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E2020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965820AbeFOL0J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:26:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34064 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965641AbeFOL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:26:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 89C338051F; Fri, 15 Jun 2018 13:26:06 +0200 (CEST)
Date:   Fri, 15 Jun 2018 13:26:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180615112606.GA3986@amd>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20180608111057.4wxpg7m7nm7suf6n@pali>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hi! With up-to-date thinkpad_acpi.ko driver on ThinkPad T480s I'm seeing
> a strange behavior of LEDs which are integrated into mic mute (Fn+F4)
> and mute (Fn+F1) keys.
>=20
> When thinkpad_acpi.ko is not loaded, then mute key is working fine. When
> pressed, it correctly generates KEY_MUTE on AT Translated Set 2 keyboard
> input device and also turn on/of mute led. But when micmute key is
> pressed then, nothing happen. No key event is reported and also led is
> not turned on/off.
>=20
> On the other hand, when thinkpad_acpi.ko is loaded, then both buttons
> mute and micmute correctly generates input events; mute via AT keyboard
> and micmute via ThinkPad Extra Buttons. But led is not changed. When
> thinkpad_acpi.ko is loaded it turn off both leds (mute and micmute) and
> leds after pressing any of those buttons, leds are not turned on again.

With thinkpad_acpi.ko loaded, kernel should handle the LEDs, right? Do
we have a support for that? Do they have directories in
/sys/class/leds? What are the triggers there?

With thinkpad_acpi.ko unloaded, hardware drives the LEDs, so nothing
for us to do...

       	     	      	     	   	    	     	 	   Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsjok4ACgkQMOfwapXb+vJTEACfbG5HQU4kYLOq3fbpLGJAooAw
QNMAn2o8gm/YhsNRC6XLsbg3KgkvBr/t
=tPqh
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
