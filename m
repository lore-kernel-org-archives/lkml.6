Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BCCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE0A24B78
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AsOccDaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE0A24B78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965348AbeGBKVP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:21:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965103AbeGBKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SdIZ461osA1fQJDgxWKnla6mNHOZy1ZkyIiwj20UOww=; b=AsOccDaDAJS6MnDfDQ+L/eeZw
        +SkSCHdIhYw+H/qfoqFJrVkAtx/ACkeaDbP5uvz2HqL48X/7JraKdhuS7EjJrzStpO9ZvDpS8rpil
        X8tS9wYrRcQG0JQCYR88Yl3CTU7eF9GJCuZzK0Z/FwQbuykk8JdC713BD3z6Sz9EW+jTo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvxI-00046I-Sh; Mon, 02 Jul 2018 10:21:12 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvxI-0007BQ-Fs; Mon, 02 Jul 2018 11:21:12 +0100
Date:   Mon, 2 Jul 2018 11:21:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: es7134: add support for the es7154
Message-ID: <20180702102112.GH18211@sirena.org.uk>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
 <20180629150924.18197-6-jbrunet@baylibre.com>
 <20180702100533.GD18211@sirena.org.uk>
 <1530526528.2900.145.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7SAgGoIHugoKhRwh"
Content-Disposition: inline
In-Reply-To: <1530526528.2900.145.camel@baylibre.com>
X-Cookie: A good memory does not equal pale ink.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7SAgGoIHugoKhRwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 02, 2018 at 12:15:28PM +0200, Jerome Brunet wrote:
> On Mon, 2018-07-02 at 11:05 +0100, Mark Brown wrote:
> > On Fri, Jun 29, 2018 at 05:09:24PM +0200, Jerome Brunet wrote:

> > >  	{ .compatible = "everest,es7134", .data = &es7134_chip },
> > >  	{ .compatible = "everest,es7144", .data = &es7134_chip },
> > > +	{ .compatible = "everest,es7154", .data = &es7154_chip },
> > >  	{ }

> > This needs to be added to the DT documentation.

> I believe I added this in patch 3 of this serie, which I'll resubmit.
> Shall I resubmit this patch along with it ?

Yes, please.

--7SAgGoIHugoKhRwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5/JcACgkQJNaLcl1U
h9AK/wf/aWLL6P8w0pVtvfLSuK7ceCaZq4UdHCdZgMbnTGGU+lz+r5uL2etaZZOp
6gAPuHEBfm15/7eE3M01hwnUVTJOVcBWYwj2xTpHC2OWeVnTfc4XiEn2iBQPw7i5
N6FgJZV7ZBhxmgooJSgAr6OqhtCZubx6infsqK2O3cHCauzdILmrBFWxe2GwkDAS
uUkGyLD8DrRcSdOaDtifhEkNMoL6QGRyjpWw4VCuTVOCVMeU7Ip8nsi0Z6wWkgH5
4SK5Ts5/DO1r4/Nm5/r2lCW4tS2AAhGgHImBAEJXL5jrXbXD75B5aM+SmAIdSX64
l6SzgojAkPiAK6uxwaORbBeMTdRtiw==
=geal
-----END PGP SIGNATURE-----

--7SAgGoIHugoKhRwh--
