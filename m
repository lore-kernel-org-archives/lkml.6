Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517ADC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B90222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbfBMIf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:35:26 -0500
Received: from sauhun.de ([88.99.104.3]:42372 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733255AbfBMIf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:35:26 -0500
Received: from localhost (p54B33842.dip0.t-ipconnect.de [84.179.56.66])
        by pokefinder.org (Postfix) with ESMTPSA id 4D5522C2EF8;
        Wed, 13 Feb 2019 09:35:23 +0100 (CET)
Date:   Wed, 13 Feb 2019 09:35:20 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkarthik@nvidia.com" <mkarthik@nvidia.com>,
        "smohammed@nvidia.com" <smohammed@nvidia.com>,
        "talho@nvidia.com" <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Message-ID: <20190213083519.tynjs3ef6tnvvsms@ninjato>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <de27b8f8-ba8e-fca7-6bdc-cdd580d959e6@axentia.se>
 <cdb66da2-4886-e3ba-e78e-264bd4b5b73c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mq2ttdhzzwepa5vi"
Content-Disposition: inline
In-Reply-To: <cdb66da2-4886-e3ba-e78e-264bd4b5b73c@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mq2ttdhzzwepa5vi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > "^ Header removal should be mentioned in the commit message, I think."
> > - Wolfram Sang [0]
> >=20
> > Cheers,
> > Peter
> >=20
> > [0] https://lkml.org/lkml/2019/2/11/375
> >=20
>=20
> It could make sense to adjust the comment only if there will be
> anything else worthwhile a new revision, otherwise it is
> not-so-important.=20

Not quite. Addressing review comments and proper commit messages are
both important. So, it needs to be fixed. Yes, I can fix this small
issue locally here (and I will do this, so no need to resend), but this
is ultimately my decision (which you can surely ask for but not
rely on).

I'll apply this series later today.


--mq2ttdhzzwepa5vi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxj1sQACgkQFA3kzBSg
KbaxNA//ahfn70SFTuWNC06WH3CmxOELccKUpXziV4mM1i38ljYSbzMGNPKWEtUA
OhJ+2ZgIVcavuinuw6TlXswfcWe081BZywhSJYylKWID5pIPJf1DuGVSEWdmvlui
f7TMZzpSLjUztq9y/inRHzPTF8vfiPJPfhGNZSbXNyoXLelQY7kp/ffF5GLqpd8b
EtTi065Dhb76vsdOJXFgqH96w2os+6mVpeKLpnmvJqTZ7Xu+3qzT5ICehYGdQE3C
jaux7tbWzy4JJntRN3bNorBvE0vYgO9EVOQ/7Jot0q+qbf+UI8iv48Lg3XUT9w/t
g/2DwKmL9Hy2hdsfo3yhVc0dUqm218SqQC1JZgsgujjX4XtSBlUa4txjqu6se7qn
lieRegzRSTGueuJad3dlP1ZyNtGNQxCV7ySjWEXBDHJtW/VF1cKrac8bI6WmPHCC
q6nniai9Woz65+VMiycZzshVwYB6Rf3HoC9jADhyv2EvjnKZnGePNPw4Lo3GJ2E2
S14axbfr2i19jXSGoBl/ZAy6pkvr5T8L9fRMELmja+cbKzqxQVLlppsXh9BJ3+HZ
BHkORi8yry9Vrcbz0seGXtGM0DjymKPAKZZHvZs7o6ZJxOb1IrOEHkfG89nd8awo
jgyb7fTcTsyJySDAjYyfd1h90Qaf+BtjAmUY3eOWQ+B+tinzcm4=
=u57D
-----END PGP SIGNATURE-----

--mq2ttdhzzwepa5vi--
