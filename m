Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F95ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959E520867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gr7dV53D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959E520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeIQX01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:26:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37084 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIQX01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bRBNSyPR+T/G5t9FUDkO/vuDboGwXdjK3VIcgjCLdDI=; b=gr7dV53DDcKvQ6WfKNItvVnma
        2qEzn7HHKTgMkh2a0cWqwYf02vHrdCDWLzQCMYgztmBbh0qRdtWO94GSHexjYyhrTuuV8RPJ0s1km
        JS/hgk5Qr9WDCQXZeF0MIgM0cCBNgqISKgA8rxvsi1Tj8N41R7orEnBx0OzcSjG06hm8c=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g1xmV-0008Tk-Mg; Mon, 17 Sep 2018 17:57:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 74BE7440078; Mon, 17 Sep 2018 18:57:53 +0100 (BST)
Date:   Mon, 17 Sep 2018 10:57:53 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Message-ID: <20180917175753.GE2471@sirena.org.uk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
 <20180917113559.11101-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20180917113559.11101-2-lkundrak@v3.sk>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 17, 2018 at 01:35:55PM +0200, Lubomir Rintel wrote:
> This is the SPI controller found on Marvel MMP2 and perhaps more
> platforms.

I'm missing patches 2 and 5 from this series.  What's going on with
them, are there any dependencies?

> Changes since v1:
> - s/ssp@d4035000/spi@d4035000/

As covered in SubmittingPatches please put inter-version changelogs
after the --- so they don't end up in the commits.

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluf6yAACgkQJNaLcl1U
h9DOQAf8Cv3fHKVpMtxvJzFX3pBXWcxF+8T6rJK1pzP5vPMEtdwL+liUyN2xbcyn
sa3gE6JVmJ5EdBSFX+GiAw0iCPobbIlTV+k4a1ggJIAuRM94LD/cIgcCbSxFW8/S
wskVlYdpdBlc2zis+99q7LAGVFnvbdQOe58PU4ZHRzlWSL3BGRitwL0lVrSvm3Yn
AK3AT+EO4/U9gPntJDnNHlEZFdPXEA+ji7Y1OFrx3x54QgTxjlXSnY/1MT2tlb6q
WUTtrcWBVVijOU3pZPUmgQTBEdekclIbjrfJZsZiIdcGBC5Msd1R6QP/yvp0tMGL
radg15LAoOSaw66F8Qf0lOMaG0lZzQ==
=g2nQ
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
