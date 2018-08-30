Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B438BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7420658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A7420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeHaBus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:50:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39484 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeHaBus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:50:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CA065275ADD
Date:   Thu, 30 Aug 2018 23:46:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, angus.ainslie@puri.sm,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add the BQ25896 charger IC
Message-ID: <20180830214630.4mqnqlllnqrv77pu@earth.universe>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731174909.9392-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tyhv7vpy24npt4i4"
Content-Disposition: inline
In-Reply-To: <20180731174909.9392-1-angus@akkea.ca>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tyhv7vpy24npt4i4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 31, 2018 at 11:49:05AM -0600, Angus Ainslie (Purism) wrote:
> Changes since v3:
>=20
> Corrected reviewed-by tags.
> Fix typos.
> Clarify desscriptions of patches.
>=20
> Changes since v2:
>=20
> Remove additional un-used table entries.
> Use the exsisting compitble string for the new part.
> Voltage now doesn't depend on state "online".

Thanks, queued.

-- Sebastian

> Angus Ainslie (Purism) (4):
>   power: bq25890_charger.c: Add debugging output of failed
>     initialization
>   power: bq25890_charger.c: Remove unused table entries
>   power: bq25890_charger.c: Add the BQ25896 part
>   power: bq25890_charger.c: Read back the current battery voltage
>=20
>  .../bindings/power/supply/bq25890.txt         |  3 +
>  drivers/power/supply/bq25890_charger.c        | 62 ++++++++++++++-----
>  2 files changed, 50 insertions(+), 15 deletions(-)
>=20
> --=20
> 2.17.1
>=20

--tyhv7vpy24npt4i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluIZa4ACgkQ2O7X88g7
+pq9ABAAicydsx1uBq5osJO8Q7prWE3tfvEUsB6oj87fzSanq05A0Yc6diizLv8G
sQqTnDkFcdgkTgUQ4vvGEpX3cTkvAvpJypWvnmMSipUw7jvEF85Op0OR3SqQDeXX
spEXWezKcTDM9bW54IscRY0QSZLQq87nSNh267z04ORbEqIanT2/IwxQAr0VkYRo
1Olc1YkXR5hPRObOiDbWvLPMqqCCMA7qQ9CxY1QDx1kX1LQW76lsZhV5XZLLnV6M
/Nnqdj6P/g3P+cvAMXlRjg77n37EbRkUvWLj/rSAT8pikFm2+ovvHvIMM+DG7qrx
K5honNTmOPb1JRl88G1zFZxbMgUBh6HhJCm49Ae4k6QEGbl/BPoHHIXOYmUCu6fM
rBedPdeUK5DhSZN3k/6curGHB7A9okAtmPuoRr9swL+52j0HXJ/JhzyD9RJELUZz
0QPdohPhgzrtnQ8Nwk0XszL3+7A5oT5Brscbp7LJmzAwMmzYNlndzUoJn+lKLBC9
0mJFskFJebSHe1rhPqoXYS1s06RSXPMV7s+9SUYReozHSKc43Yxf87wA73+ES4Jh
RvJ7qCSZ8TJAOKUq7aGCzlAOBvLfD1oup4SZOfGj9e7h2urQhuoCYnygcC5kloIC
YrZPx8ERX46qAYZihkUxJhX+TseWN+CvMh4eNshizNHB1iC/Vgk=
=n10L
-----END PGP SIGNATURE-----

--tyhv7vpy24npt4i4--
