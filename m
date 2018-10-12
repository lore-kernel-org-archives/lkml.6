Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F02C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9AC21470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RtmiOLCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9AC21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeJMAdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:33:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46442 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMAdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5HqSFnjVbG2I9JEZ02TPw/X3tN6GLFKx+x0Ux7DbSyI=; b=RtmiOLCAG1ED1JEwODYj7V3Gl
        Jw8tV5+Lu0qS0BSH7/x4JCG8NxoEDM2i8oCXgoMrmfeZgNmMwNcrSoc1QlTf2MF9oFrvxVQi4p9le
        Dki3msZttLFa6V7gb3TVD8J8rUpwKqbHKeMxOvMnTRuRQGQheaWu0BUn+jKB3j+St7gYY=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0nD-0006dS-Fs; Fri, 12 Oct 2018 17:00:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6DC47440078; Fri, 12 Oct 2018 19:00:02 +0200 (CEST)
Date:   Fri, 12 Oct 2018 19:00:02 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Message-ID: <20181012170002.GJ2340@sirena.org.uk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
 <20181011142719.GE25351@sirena.org.uk>
 <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6iqOn7HZPWKXx18"
Content-Disposition: inline
In-Reply-To: <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
X-Cookie: He's dead, Jim.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6iqOn7HZPWKXx18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 07:59:15PM +0200, Lubomir Rintel wrote:
> On Thu, 2018-10-11 at 15:27 +0100, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.

> Thanks for the response.

> I'm a little confused here. Why I chose this subject line is because I
> did this:

>   git log --no-merges Documentation/devicetree/bindings/

Try Documentation/devicetree/bindings/spi instead :)

> to figure out what's the typical subject for the DT binding changes.

> I also believed that's the right way to get Rob Herring's and Mark
> Rutland's attention. Do the device tree binding documentation typically

There *is* some debate for the DT bindings unfortunately.

> go in with the associated drivers, or via their tree ("OPEN FIRMWARE
> AND FLATTENED DEVICE TREE BINDINGS" in MAINTIANERS)?

They usually go in with the drivers.  This one isn't so bad since it
does mention SPI, it's a worse problem when that's not present at all.

--d6iqOn7HZPWKXx18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvA0wgACgkQJNaLcl1U
h9C+/wf/SHmOue+GuQ4l/70jaDVkiGXd2VViu1AvPbMXSLSjt+FF+6Tuag1eyP2v
4RcuNedih8M3DD3vSEtJPT9vUj5H8pvxuBM1aZno+axfPv1dXDnPAck8+pJ7PfrF
jtnnZVxBcSIC/QX1DrmkMzvP+T38bQ2hA4wMSVOkH6t+/PkoS3hDUBp+CbqNRMPA
OOliuTtDUaPJt1QombMTDjAe9o+Tf93YE1QxaXBOy1Wj+m/MERloSws19bxDt+22
hDQxEQq0xgpNY+GN45hlkMvTlgKmPelc7gvLyGeMOtYbw33NgVD7G3aOT5NM3gH9
bxf76NSvtFG/O864dHnvw4mKxq+vjA==
=O9td
-----END PGP SIGNATURE-----

--d6iqOn7HZPWKXx18--
