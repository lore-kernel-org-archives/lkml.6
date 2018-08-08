Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD418C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860E621729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="J0LntI1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860E621729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHNOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:14:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41250 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHNOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zTpZOen06YxZ2fupwAXpMJ57ON9S1UNmdYCev2PtnEs=; b=J0LntI1z/Q+uo7/6//oSqF6iX
        /0PIhAzwLQaxbBNWHsl5HhgY3dO3rDqjCuX3e0X0oN2+k1Olml4fLQCoA3NznbxSiToo5K8uRA3WU
        5udE1PBLjv/JKw+F6/kiyw/oojdcIkYVc4+ECKbjPwfn0gJb6lDCq4OUXdLe81iWqFMVA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnM7A-0001lj-3Z; Wed, 08 Aug 2018 10:54:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ACEF81124340; Wed,  8 Aug 2018 11:54:51 +0100 (BST)
Date:   Wed, 8 Aug 2018 11:54:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Message-ID: <20180808105451.GE9346@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk>
 <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk>
 <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
> On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:

> > Right, I don't think we added this yet (if we did I can't see it).  I'd
> > add a new field to spi_transfer for this, then other controllers with
> > the same support can implement it as well and drivers can start using
> > it too.

> OK. So I will name the new filed as 'word_delay', is it OK for you?

Sounds good, yes.

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltqy/oACgkQJNaLcl1U
h9BSngf+O6aFSOfDpXwr5AddxQgIlIyX7YbAzjK2EdVa4i8i9tK4gZS7S1sBeDpI
HA4xqVsac/HiSLr1ZdJbggoTV0Cq0IHFGH6vZ7/u+MPYi6XVIBy6Xmj3QlRRmX3b
zjYCuobVsSrGAK+/nUjJyhtfYb+eSfucKWhn4cWrX6D8d/cB4EBMRKwXMWaL8P8v
IMCmvLJpAWU8PADkZ0LIaUaUo7irzrIHOQRT/dfTa+4+SJ7MD/K6DPD5qfRMKmdW
y389qijvn3iKyi0Vqz6PbQ7/MkKE9/Yf4NsCILkdax+9DVCqEDxSSkchgt7d3KwE
adBUmgVEmc2i9yP8JjSI5SdBBnfU2w==
=9Hur
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
