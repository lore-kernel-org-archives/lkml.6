Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30695C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4922084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4922084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeJHOWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:22:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60775 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHOWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:22:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3E67E208C2; Mon,  8 Oct 2018 09:11:59 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id E750F206A2;
        Mon,  8 Oct 2018 09:11:48 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:11:48 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] AXP8x3 AC and battery power supply support
Message-ID: <20181008071148.ownj4qcnhcfomoxq@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i44lbaa3bc7msglc"
Content-Disposition: inline
In-Reply-To: <20181006211836.28253-1-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i44lbaa3bc7msglc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:30AM +0300, Oskari Lemmela wrote:
> AXP813 AC power supply support with input current and
> voltage limiting support.
>=20
> AXP803 AC and battery power supply support.
>=20

Great to see a new developer taking interest in those PMICs :)

I received the v2 patch series as answers of the v1 patch series, you
would want to fix that by sending a separate patch series. Using the
name of the cover letter of the patch series and the author, it's
usually good enough to find previous versions if we need to, you don't
need to send the new patch series as answers of the first patch series.

Thanks,
Quentin

--i44lbaa3bc7msglc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7AzQACgkQhLiadT7g
8aOYRhAAm3kvNqnB7Dtx1+jtEmkzB/mNr45+kkOD62HL7NFOVGG2MujW5tUx0coQ
d/ixFpzfZJSnqVLV+sEIX/DCA0DkfED7biIeHvjkfcc3btYx2BFOdAeZLoiMpkDz
mfz4rVNvci+U2LmCNpi24Zq75+xATt50i91M5ZIeeLDc0Wmi5Ttw56thmOY9mZ75
MBKdp9yXVZFq9S1TBVOeZbXJwUETfkJ6Bo32AKcZMMu3S5bAxSyLYmmxAllL1biB
k5unczXza3ZbzJ+FLj5JVPPkMyGonkyveo/3/zEGD9qmQpqNfmkfXV0mIodfbmP4
AjSL3rgF/8AUQl0t/TKSY/T7Q9JQgTvCZrQR4CxsbBnhEy2XyHZwsDmKSORGxKIo
hAH2SWFaGX1EsU/H66bLqxi7YP+D1J6uSjA0bgQDmq6Wlct2lii6gvUibDzS1AhA
0f+tGQgUnxM1t0qWffAQ7u3F75dhj2osGPLbjd3MYnHfRY9nglGcISCEe6/9Z0eD
m7rg/VRIqpu5Q832dfBPAvp9ysNxltRgGXtIEGHJ3b+sAPSLBmngUxBTVwuR5fZy
Bdr06Iw+zrdc3lgfC2Zeprb82W8QQCUYx/8dT3DymMo7uBN0cgl73eC3ooh+4tqs
55uoYqy0opzYDaGERBiYvJELt63w7oSEdY1Z9+Qcaz+DoxFBYBc=
=dhIy
-----END PGP SIGNATURE-----

--i44lbaa3bc7msglc--
