Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4224820850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544127910;
	bh=ZWljBTMvu89KKc3Vbgp6D2BHhdYap89DncF3FRAHoaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MRfYxCbath8BUX0CPj6V00s7px3lGUYJQq2ncvMg1xATkUWDBl6memJ4BX71WOwDP
	 3Eor+dd/WfbRfVvStOeLVUUQQnqebOMUXWIOAuzBHznYhdJKK9qfRkpPELJAa3UHQE
	 QWim3ZvwG3KM9nAjWNS+qWfRz9rlx89DhpqBMDZk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4224820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLFUZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:25:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35102 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZWljBTMvu89KKc3Vbgp6D2BHhdYap89DncF3FRAHoaM=; b=csbBH/Nmn+rKWX8b9zxrwWV2n
        7H/HNp0BJ+UCydivsUkiwdUKr3UaBIkWSiCOykSlFOiGHM6Z4ycRbr1x0QQ7eKKC4Ry04OaB950q9
        Vk4aedGvb2q4YYYUYnFkyTvm2WuHhmzL7qdcdunQMC3/6n+xLWoYePvCUsyYhfWW1Mu9g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV0Cp-0001fr-1P; Thu, 06 Dec 2018 20:25:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AF61611252F7; Thu,  6 Dec 2018 20:25:06 +0000 (GMT)
Date:   Thu, 6 Dec 2018 20:25:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/4] spi: lpspi: Add slave mode support
Message-ID: <20181206202506.GF3084@sirena.org.uk>
References: <20181130042753.28756-1-xiaoning.wang@nxp.com>
 <20181130042753.28756-3-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20181130042753.28756-3-xiaoning.wang@nxp.com>
X-Cookie: You will be successful in love.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 04:29:07AM +0000, Clark Wang wrote:
> Add slave mode support to the fsl-lpspi driver, only in PIO mode.
>=20
> For now, there are some limitations for slave mode transmission, which
> have been mentioned in cover-letter.

The cover letter doesn't end up in git, it would be better to include
this information here :(

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJhaEACgkQJNaLcl1U
h9BPFQf9H6drQEU8AddzQIyy1gN9Wcvo3cYwMpDs6HuWtjGgERbXyZ83HK8qLD1O
5JTciY6t2U8neNkyHC/JziMl4gs6eJ8ac1lZIAqsPAAXJHNk7es936T17EhHn5UL
2Ivanb5aDZqgrkzyVyNqOWLsBUaMdsBEDou2cf42qkLR6ey0b7Hnjc02DdgYqoVP
xAhUlGYEhjte5OwvzUm1ESQcPrMWkDnyxIcuJEaNensh49P5We1AMJXbM9hlFD8L
jWWgnL5JUtEOZM/k1S96UZAW3ubN6/DUTLJzW+I2y3muGQIyMKPs5BnUmm7rzkP9
BPwYEEARlkSoavo9LSZIwTBemG+YgA==
=rHPc
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
