Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB421479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545223103;
	bh=gmzznf1tVQvXl/C8WaU7tzo4sZ5tvRaS+5YXuKMxZNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wnz4BLJ3i29X/QoQLi9JPSsUEgZqNP4TXpJ5Xf8KUQs1CGPfWgmzLM5dr1yKIDCDj
	 2mlPYrR6rI13c+rhvD2WT3azDIq1WHuuslXR0/UqFLrlkb/egPaFVqHdDE8KqXTn6l
	 e5seS/bZaenljtuoWhsCOUD37mQgIWxdmkEOweNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeLSMiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:38:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57286 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLSMiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gmzznf1tVQvXl/C8WaU7tzo4sZ5tvRaS+5YXuKMxZNs=; b=G92Apw0dGRuVpfrXo/fxu9LAv
        XjDWsBtjF3F8LvJ30ctogE4HSZLVnk3a6tj5BkL8WAOeyEWNZe9o6FhiZBQDjzWQSQzQTm/3sy+Qc
        nphXkjl6jf2Ixryxl2G1zO3JO0FP1ztRa5b9LqIltM3CHzxZGjJMRoUqfucas4yISpqiQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZb77-000431-4k; Wed, 19 Dec 2018 12:38:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B491511259E8; Wed, 19 Dec 2018 12:38:12 +0000 (GMT)
Date:   Wed, 19 Dec 2018 12:38:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     David Lechner <david@lechnology.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, tony@atomide.com, robh+dt@kernel.org,
        bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
Message-ID: <20181219123812.GC8130@sirena.org.uk>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com>
 <5C191770.9090804@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <5C191770.9090804@ti.com>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 18, 2018 at 05:51:12PM +0200, Roger Quadros wrote:

> We could combine control and debug into one iomap and use
> 2 regmap ranges. But this is really working around the
> regmap_mmio limitation of not being able to use more than one ioremaps.

> Mark, any suggestions?

If they're separate regions why not create separate regmaps for them?

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwaO7MACgkQJNaLcl1U
h9CPAAf+JAJfMczZd9xWyVAVv7Y2r8nFraMHd9wq/ySUeg1xb21Z/SQVmCUslHh7
9UU6yn6+/XyROW73zqXbP7zzT+3+mzquT+7KktzazB8xsFkBlnCAm+xZEhycxms8
NKpf41WNkJPsZW6WURLTP8m7A+7pCsPbvNBn2Q7WboKBQBO83+rcv0gO6h2w0wMd
7igarIg4CEWqgCKtEh1kJjbEOxvJEWe9GUuYIvEpbY4c4EZifMyOTjwUxmS5t6zZ
gf6t6SJ7JJZbCUn27apsktUSnCJEvuG7gZyHfhALtpJG3cTC5hd38qwD0iSH7AP9
Y8eIQLz2+hpUjd+K7BLhCF0VDv1O2A==
=ZgHj
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
