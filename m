Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664C7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A0520866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeL1T5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:57:33 -0500
Received: from sauhun.de ([88.99.104.3]:39756 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbeL1T5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:57:33 -0500
Received: from localhost (unknown [151.217.32.66])
        by pokefinder.org (Postfix) with ESMTPSA id 38FAC3E4154;
        Fri, 28 Dec 2018 20:57:30 +0100 (CET)
Date:   Fri, 28 Dec 2018 20:57:29 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Elie Morisse <syniurge@gmail.com>
Cc:     linux-i2c@vger.kernel.org,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>, helgaas@kernel.org
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Message-ID: <20181228195729.GA18811@kunai>
References: <20181226232258.GA23526@syn-yoga530>
 <CAC_JBqpJ__Vsb5cLrpzjYXv9XERUrm5ATmoBBHQY+6P52EYdLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <CAC_JBqpJ__Vsb5cLrpzjYXv9XERUrm5ATmoBBHQY+6P52EYdLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> Nehal isn't responding, while the end of the merge window is closing
> in. I addressed his last requests, will this get merged?

It will get merged but not for this upcoming merge window. Last cycle,
Linus made clear to me that late merging of new drivers isn't as
accepted anymore as it used to be. But, your driver has a high priority
for the next merge window. That being said, really thanks for all your
efforts with this driver! Much appreciated!

   Wolfram

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwmgCUACgkQFA3kzBSg
Kba2VBAAtVvtqakbX93VQUlDtf9goPv5a6ymfxBwioZipikOLJU3PupXN6/Fona9
tLsIVmQQWLfZg5w2eF3De2W9X3jo7F1p3soaFQc7CPH8RhhFyUwkBQsw8S9lvQlb
QBUFou2Jc9TwKZ18FHF5SoVeTfrtslA7Egdxk6jC5yNXtP2kW2Y0AVbYE/IOwLxZ
jTczhFZ7i1vnMzm/Hmksvy3UxnPjrnpPLu8M9nwd5UyRbLK9ieJS63xngbhtY9M7
yKrj7oOB5TF24Emaqe6bJIAc2FBB3ITYL5pDfM0xCWn8klXhhkL0ez1QIwkwUTJE
kXjsj+t6uaX7r7gSdenZFBSBjuPbB365MfrW9uzoudjv/9DaYlvIDl4qM1tnH/GF
9ZghN3HSZB/2GzlWPbKVtR7t7U6hfKXo7jnW8hZPhVtnUwo8BOJJcRrkcC60+4Py
x4bW7nFnFQAh83OFxy30knOAyDfcw25OBeKz9NpLvzmBvWUYtOpE3x/LcGLad/m7
FHInGNEHfVuix0Pzqoftek6T6C9sKoFuaJmfHsdduM1GJHEjSH7Mgd4aooDGCVdP
/7Y9L/gjxtHOZS0O/HC7s8dvbJMR06sDpU0bz5T52xhNCxsNtGFAyHsal3W6bsMS
aN5NYHoMgbKVJDbSTCM8f7oerHBg+irpJbddiwNQSVspc87/Qb8=
=alZ6
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
