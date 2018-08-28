Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04012087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="npk00/Jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04012087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH2ALM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:11:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47056 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2ALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OzG6Sz2IYRQ+hnP/6CGLVrJdfVgj8w0kLQJfhlzevl4=; b=npk00/JdvHsHhKjgtUqUy1yTE
        8xiAxmDbgDlYBOHqeTA4yOJifUQXi2EZgAk9UIo+MgPzQvR4xmkcUXs2pDgiZPsvEAcuHhewM9lMz
        7wt1Rj9sYcdbUgzQr0R1fgRE5rOBMWs16PZdoWE78vSelqVBZ5rMLI9GyvqsF0uIpyNPQ=;
Received: from 92.40.248.93.threembb.co.uk ([92.40.248.93] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fukQw-0007fT-Sn; Tue, 28 Aug 2018 20:17:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7FE83440078; Tue, 28 Aug 2018 21:12:05 +0100 (BST)
Date:   Tue, 28 Aug 2018 21:12:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kosta Zertsekel <zertsekel@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: Re: [PATCH v4] spi: orion: cosmetics - alias long direct_access
 variables
Message-ID: <20180828201205.GR2414@sirena.org.uk>
References: <20180815190449.23738-1-zertsekel@gmail.com>
 <CADxo8W+JMKJvf8LUdH7_2EXqfi8KvrSPAYa=CZV1eMq2VrQ5rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KZa8Qkr7Zx+i11wB"
Content-Disposition: inline
In-Reply-To: <CADxo8W+JMKJvf8LUdH7_2EXqfi8KvrSPAYa=CZV1eMq2VrQ5rg@mail.gmail.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KZa8Qkr7Zx+i11wB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2018 at 11:55:18PM +0300, Kosta Zertsekel wrote:
> Guys,
>=20
> Any additional comments?
> Or the patch is ready to be merged?
>=20
> Thanks,
> --- Kosta Z.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

--KZa8Qkr7Zx+i11wB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFrJQACgkQJNaLcl1U
h9Chwgf/S0WfLuTLVQKehjtMmzolwlmo+BqKNn3qCiuY8yeUdaI2XS7XO4wGMVgX
rtovb0be9jkKqdlK0CYFRUPLIzeU530OeRCz6GiK9na4uRXNTPVR8X3GumZNZu1I
WcjYdMkPH1zNQeiBS1iht6PBxJuvCTBwg2hmvm5XlI5XWu8IXW7UDcD++RdYfY91
WmtQ+yCNiswrxD9KdRRgqRsgKmBm6lT4x6G1k00BrhVgTphX0TZ3pc/sa18aDHQW
dtGknhXM6OMo8ReNAZRZ4rEtYWSE8FZS9u98zvj5aamvH+26uznSILWCjECjMegx
YUF8w/O5GaF/luvN4c2KJwJBAxffBw==
=7OSz
-----END PGP SIGNATURE-----

--KZa8Qkr7Zx+i11wB--
