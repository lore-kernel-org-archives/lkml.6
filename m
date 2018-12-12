Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF0AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7E720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7E720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeLLMQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:16:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48655 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeLLMQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:16:07 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 75271806A6; Wed, 12 Dec 2018 13:16:01 +0100 (CET)
Date:   Wed, 12 Dec 2018 13:16:04 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] leds: trigger: Add pattern initialization from
 Device Tree
Message-ID: <20181212121604.GA11088@amd>
References: <1544434201-14190-1-git-send-email-krzk@kernel.org>
 <be526095-5af9-38bb-7c72-629a82d318e0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <be526095-5af9-38bb-7c72-629a82d318e0@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-12-10 22:03:18, Jacek Anaszewski wrote:
> Hi Krzysztof,
>=20
> Thank you for the update.
>=20
> On 12/10/18 10:29 AM, Krzysztof Kozlowski wrote:
> >Hi,
> >
> >I rebased on top of Jacek's patches and, as I could not find them on git=
 kernel
> >tree, I included them here. Also with small fixup.
> >
> >Changes since v1:
> >1. Rebase on Jacek's patches.
>=20
> Made following amendments to 2/5:
>=20
> - removed extra empty line
> - fixed language in the commit message as proposed by Pavel
>=20
> >2. Add patch 3/5 for fixup of Jacek's solution.
> >3. Drop first two patches from the series (applied).
> >4. Patch 5/5: Use LED_INIT_DEFAULT_TRIGGER (suggested by Jacek Anaszewsk=
i).
> >5. Patch 5/5: Return-on-error and log warning (suggested by Pavel Machek)
> Applied to the for-next branch of linux-leds.git, thanks.
>=20
> Pavel - I'm still awaiting your acks, just wanted to have
> the patch set in linux-next quicker, taking into account that
> merge window is imminent.

Ok, let me take a look. But this really should have Rob's acknowledge,
so...

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwQ/AQACgkQMOfwapXb+vKCwgCfTQH49a52KNzJN45oXo7Z+s78
oVAAni2YJQfVPZAUcHPe5tYJxsu6N8sL
=mLtb
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
