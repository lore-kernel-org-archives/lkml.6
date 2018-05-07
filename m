Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbeEGUs5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:48:57 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:38543 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeEGUsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:48:55 -0400
X-Google-Smtp-Source: AB8JxZqGwoLcoHiaQZ5undXwYrEH3SV2YlJesFPif0rEQsVkuPYH7psWSRE17jZJPvH27VMFQ0CAhA==
Date: Mon, 7 May 2018 22:48:51 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario.Limonciello@dell.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 devices
Message-ID: <20180507204851.6y4rplcka4inzhsl@pali>
References: <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
 <20180506134733.zttaitnf6ej4tith@pali>
 <20180507084431.r2dipv32wt3vbx3k@pali>
 <20180507193306.GA31301@dtor-ws>
 <147aa25ad2d14bad975731a6c9cf9281@ausx13mpc124.AMER.DELL.COM>
 <20180507200733.s43zd2hfzw4f4wr2@pali>
 <6825f48ea6da41799979d83ed37adf73@ausx13mpc124.AMER.DELL.COM>
 <20180507202822.usgjneo7m35bsait@pali>
 <c4668ded2ef1432b94f8668220b1232f@ausx13mpc124.AMER.DELL.COM>
 <05cd71987d8f4a8e99cb1994218a8485@ausx13mpc124.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwptzylf2q3wlqyj"
Content-Disposition: inline
In-Reply-To: <05cd71987d8f4a8e99cb1994218a8485@ausx13mpc124.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwptzylf2q3wlqyj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 07 May 2018 20:32:16 Mario.Limonciello@dell.com wrote:
> > The items that show up in this structure are supposed to be dynamic
> > values but static addresses.  I was asking to check before bootup in
> > case this was a problem of Linux caching SMBIOS table information once.
> > The values I was referring to might be for older generation dock though,
> > I'll see if I can find anything else you can check.
>=20
> Can you check if structure type 08 or structure type 09 change based on
> dock being plugged in?  Again you might have to do it across a boot
> with/without dock in case of Linux kernel caches values.

The only difference is:

--- dmidecode_laptop_docked	2018-05-07 22:34:02.650325758 +0200
+++ dmidecode_laptop_undocked	2018-05-07 22:39:27.580306838 +0200
@@ -913,7 +913,7 @@ System Power Supply
 	Asset Tag: To Be Filled By O.E.M.
 	Model Part Number: To Be Filled By O.E.M.
 	Revision: To Be Filled By O.E.M.
-	Max Power Capacity: 90 W
+	Max Power Capacity: Unknown
 	Status: Present, OK
 	Type: Switching
 	Input Voltage Range Switching: Auto-switch

And this is in block Handle 0x003E, DMI type 39, 22 bytes - System Power
Supply. So looks like that DMI data are same.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rwptzylf2q3wlqyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWvC7qgAKCRCL8Mk9A+RD
UkgWAKCUg5BxwnxCFwzsCdnXGSE3hTCGCQCfVgQk+5BsztLyqAf0ytTKBMsh+5Q=
=Uj7j
-----END PGP SIGNATURE-----

--rwptzylf2q3wlqyj--
