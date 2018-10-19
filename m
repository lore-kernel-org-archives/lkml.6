Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136EAECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56E12087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WgvkyxeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56E12087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeJSUi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:38:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48924 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSUi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g9cwsdimZ3I/TpGxvngD8PrPYuFqL51STlFgfoSChpE=; b=WgvkyxeIPJJMlx3e5mve3jhvH
        VbwCcYeqMWP5zkgW+AWId8LtNjFUIcixik+slVm2U2WL/JQRBxkgkcvnDyRHvvQGY5PUjXjDbFkNp
        0gwAsSNJ44Xvc/AzFJyOCNDJI83y/0Z5b+0ZYONKjc41mD+geJsLuRvJjvLkB1V5AajTw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDTx8-000061-Lv; Fri, 19 Oct 2018 12:32:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4CA051122548; Fri, 19 Oct 2018 13:32:30 +0100 (BST)
Date:   Fri, 19 Oct 2018 13:32:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Applied "spi: pxa2xx: fix PCI dependency" to the spi tree
Message-ID: <20181019123230.GK5895@sirena.org.uk>
References: <20181017185128.2634666-1-arnd@arndb.de>
 <20181019123002.196D21122548@debutante.sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cN0A5YokcrYPGsSB"
Content-Disposition: inline
In-Reply-To: <20181019123002.196D21122548@debutante.sirena.org.uk>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cN0A5YokcrYPGsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 01:30:02PM +0100, Mark Brown wrote:
> The patch
>=20
>    spi: pxa2xx: fix PCI dependency
>=20
> has been applied to the spi tree at
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git=20

Sorry, I'll drop this one - I forgot it had already been applied when
it was pointed out that the stub function was added.

--cN0A5YokcrYPGsSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJzt0ACgkQJNaLcl1U
h9C51gf/a8e6IrR3tgcgkRkU+Y/jEok7Z2KGCF9qQwCwSkPYDQkkA0yau3+7F93e
f9QkRV8cWzAmH+3W0u7Cab0+t2M4T2wh6uNpXEg7ytkTRZ8nlGP4/ZCJdwvPSvQF
RUjnR9A9jcMpD4gihuUPdj6nW1Duybk/PMEbx8NiiPyG3GPN/1/2xNkYTOTE2jkb
VLHOhw7x0Ea6hoWFzcBI82cecmZHo7N3mUacjlWica/DODkwVzDvwKjXTEXpgRtD
5LD6q36tXNSj2CF46rhk+X2H73+pBHb6D+JWm83iurmgqC3ekQRvn6TpoKHGz8zJ
eultAMnFlM/cEa7eLT4V+iY5MAwjDQ==
=tqBu
-----END PGP SIGNATURE-----

--cN0A5YokcrYPGsSB--
