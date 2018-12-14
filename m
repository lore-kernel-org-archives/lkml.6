Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC76C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E6920892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544787225;
	bh=s5nf5yTMBDLfB5B6ZmSpbB7l9JUNEF9taiuEHq3YbYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jxw8IflfNSo0DJ/n3be6ia9PUOhqCMcsQ5WiZwhzsZGZ3giFiWnsL/C4ROZTWGjBd
	 i0ocD28HHHLYspbCUu7u76IUDuFMvqP7i2+g22cEBMaS2k6yqPyNlyFxUkUvdN5bQb
	 XahD6x2xoLFWOyoWb0uzJBIUqnILOYuHaTvilSuc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E6920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeLNLdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:33:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeLNLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s5nf5yTMBDLfB5B6ZmSpbB7l9JUNEF9taiuEHq3YbYM=; b=mRRrWgKT1+n1avmj7NTNBi9wI
        tdxJJWcDAAAx/tuOSLmy9hsk89h/pevYwNTBrfUmk/1TqtcLdXJGL04DszOr7Z5Nt+UK49bs12CZV
        6czjDnL+aQM/pDut5gNJb8KxTdvwbK2ssZ258ICO9ygESw9fwAg5vwF15e5XhIB0a2i3s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXlio-0006VA-Lo; Fri, 14 Dec 2018 11:33:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2895F11258A1; Fri, 14 Dec 2018 11:33:34 +0000 (GMT)
Date:   Fri, 14 Dec 2018 11:33:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Olliver Schinagl <oliver@schinagl.nl>, linux-kernel@vger.kernel.org
Subject: Re: Applied "regulator: axp20x: add support for set_ramp_delay for
 AXP209" to the regulator tree
Message-ID: <20181214113334.GA6467@sirena.org.uk>
References: <20181213181142.A5F3911254D1@debutante.sirena.org.uk>
 <20181214080820.mkukiqdcr5rk32y3@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20181214080820.mkukiqdcr5rk32y3@plaes.org>
X-Cookie: To stay youthful, stay useful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2018 at 08:08:20AM +0000, Priit Laes wrote:

> Unfortunately, one error crept in, please see below:

Please send an incremental patch with any fixes that are required.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwTlQ0ACgkQJNaLcl1U
h9D/xwf/UKhaw4I0T9sfLXSL/U/Vv3mCqAacPQUjugMRl8EZU+Rivynrfy5+7J3X
QutPLSKmnWdi2NKimwRaFc63QPNWjwzviSy7H9A09IKnFR8GpSg2K60+u3c/u4tz
THH2boUrTD0uuBAVeReR503zszMN8Nce6gJuxkeIOoZuEjVcscVgh6k5ysMtHUIy
Q3weAHsSHRknfEgrxVOl2gwi4CVadT4hyPnbGU6SrV0AoFaXh88wl6ib2b5draaY
7lnDV8c6W4jZh6Fe33iWsZHqG2AiBbMbqkJ8KiapNcRZt7+NkEtG2tkSSCIUnj8j
0TlcWAMlx2UergFGDF4MZVVwfJYqsA==
=yeHc
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
