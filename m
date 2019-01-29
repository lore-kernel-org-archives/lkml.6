Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530AFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4A21848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785218;
	bh=lZsyeKPDO32qFCT+lIFlsfvxHdRiiyZpzf8HFZbsGnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rC2E91coieRUeIv4Hmjylw5urOWv6JytB2UPcBVM8GJd2FpG/HYZocodUCQrdgil9
	 lBDdMwt21ubdAp0TG8jo+oPjfkbrOdm3e6x+ImeXZMcKBvLjpz8kUeQM9rtlM7RD37
	 Uiqfj6vEj3Q6aSfHC8buQdPayBr/btRTIEmM3jZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfA2SG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:06:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfA2SGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lZsyeKPDO32qFCT+lIFlsfvxHdRiiyZpzf8HFZbsGnw=; b=jvlamFr74h3JDqJNcs58KtuIA
        zKVBSBlLm8uNl4zKaGbEyXE5g/yysM6/cBRTn61IvTT+guGdmtMgZBJ5KdgqavLoM8ZqRWLpt1e+O
        jOp/Zn4M1M+u4boy1FW4ocV1qfyqoaxo7Cdz600zuP/tO1BQd/KG5ncJLod+F977x74zU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goXmd-0000wF-FS; Tue, 29 Jan 2019 18:06:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 024911127D50; Tue, 29 Jan 2019 18:06:50 +0000 (GMT)
Date:   Tue, 29 Jan 2019 18:06:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] spi: support inter-word delay requirement for
 devices
Message-ID: <20190129180650.GJ10524@sirena.org.uk>
References: <20190129083844.20572-1-jonas@norrbonn.se>
 <20190129083844.20572-2-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline
In-Reply-To: <20190129083844.20572-2-jonas@norrbonn.se>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 09:38:43AM +0100, Jonas Bonn wrote:
> Some devices are slow and cannot keep up with the SPI bus and therefore
> require a short delay between words of the SPI transfer.

This doesn't apply against current code, please rebase against for-next
and resend.

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQljoACgkQJNaLcl1U
h9CoJAf+PUI9OL1C/VRVWhC7zzQ1+rRKldjD0Qb/Mkd+aUCCswh4g+ziFtSGpd68
RQYKnHjsuzl2APPcWj/tBjMgwb77pzP/1krmXsEhSNT03Npl351BVLwcYccm8Ns5
g+F8lIsTRPQFXkGkQ7Janp5HB2Kkchwi8272WsEcawsdCcmunnrEM8HHC5jk4h1r
NME9jPc5YX48bJIdWumSrWP158JQpF2clp4IokMTBawFPfvSbVvFUfAKcRt6Kb3v
8yZUPBBysCJRVcvEXOWi+ZH6IgyjLbWsEyRf60W7aO+uqYz9YaZHtHz6kn+S1Ea2
rOomMbNnVzDribZPDUVoEoGVsZjZ3Q==
=63oV
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
