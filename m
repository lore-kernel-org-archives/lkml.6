Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A025C208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A025C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeKKLQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:16:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42852 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbeKKLQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:16:14 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLeYs-0001Cv-RU; Sun, 11 Nov 2018 01:29:14 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLeYs-0003BG-Ma; Sun, 11 Nov 2018 01:29:14 +0000
Message-ID: <27c2f1efcd6d5bca1ce99b9798a6d42921361b32.camel@decadent.org.uk>
Subject: Re: Patch to consider for stable 3.18, 4.4 and 4.9
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Tomasz Kramkowski <tk@the-tk.com>, stable@vger.kernel.org
Cc:     Sasha Levin <Alexander.Levin@microsoft.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 11 Nov 2018 01:29:04 +0000
In-Reply-To: <20180305204341.GB4897@gaia.local>
References: <20180305204341.GB4897@gaia.local>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-CI7+mYzwBcamNAe4P9Z6"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CI7+mYzwBcamNAe4P9Z6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-03-05 at 20:43 +0000, Tomasz Kramkowski wrote:
> In September last year, Ben Hutchings submitted commit [9547837bdccb]
> for 3.16.48-rc1 and I informed him that it would be useless without
> [3f3752705dbd] (and that maybe [c3883fe06488] would be useful as well).
> Ben dropped the patch but suggested I email this list with the
> information of the other two patches but I never quite got around to it.
>=20
> Now I see Sasha Levin is submitting [3f3752705dbd] and [c3883fe06488]
> for 4.9, 4.4 and 3.18 it would now make sense to include [9547837bdccb].
> This patch fixes a minor problem where a certain USB adapter for Sega
> Genesis controllers appears as one input device when it has two ports
> for two controllers. I imagine some users of emulator distributions
> might use stable kernels and might benefit from this fix.
>=20
> I'm actually not entirely sure that patch is something suitable for
> stable but since it was already submitted once then I don't think it
> hurts to bring it up again (despite it breaking stable-kernel-rules as
> far as I understand it).
>=20
> Commits mentioned:
> [9547837bdccb]: HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI =
adapter
> [3f3752705dbd]: HID: reject input outside logical range only if null stat=
e is set
> [c3883fe06488]: HID: clamp input to logical range if no null state

I've finally queued these up for 3.16, thanks.

Ben.

> If the patch [9547837bdccb] is not relevant then feel free to ignore
> this email.
>=20
> Thanks,
>=20
--=20
Ben Hutchings
Reality is just a crutch for people who can't handle science fiction.



--=-CI7+mYzwBcamNAe4P9Z6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvnheAACgkQ57/I7JWG
EQml0g/+Pf+OXSLPvhl9LZd2YYf8Q9esdfeZPbbo2aZr8bFoqMgM9vo4XCalDEOk
XdVPAg7kM7DiwPX2YDAAg9Bip4DL74689YvZL6lMjH3VivtF151egGD7FpxXHt1N
gUGA05MZS9gqD8xKa6AO5YCM1yBCXydNiZXL3a+MQ/IWwAahKIpVCKTYcBg7vOrF
G9HFpBIJXFtl+2qyJ8dgLtN4i0OrhZr9cV1GxFuvJEy0+Uf2e8/aOaP3G2NdFmq1
PC1Se/AV82SARSb7VHWf8Y3xVhAF/mgPy9JX1s8cW7+5iXG3DgjQNTLDyAZvV6Qt
EFiIEEFC5CyyykCWc6oE4UHMliH5snjYCpjaFwmqQuD613lG7SBZI+abiFq+tqY7
L8l1SQc3lsHN29YQcC7YlPno85uac29URmo4iV4tCMrlfHTee4/HDliSbykHDaXs
Kmlw6j//ob2ilvlYD3zM+18l0RcY8rcHXNlPMEqnUrxE19gJtxOyGhaKsjW0eIBE
Vb0x0qvVZpoTQAr3FgV7Yp6m79VzYm9fHMc1BrmLhPAyWGoy/a0Z+XWmBwef0GUw
+UvRjRr5JNa2xHUQjpjFDZOO+8Wygcxh1UTqugTR3sWQYHETuAnau6tVjC37lB9a
QDLie5ZE2DDgvwY0piPNBVdZSeNu3zRkKRl6umC0GSJLqUcCt8A=
=OZFZ
-----END PGP SIGNATURE-----

--=-CI7+mYzwBcamNAe4P9Z6--
