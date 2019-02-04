Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ABF20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549304609;
	bh=6r18eJ5LwnBT4xFc3Bx+r2FSFaHtpdyIBcm66RDdLao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sJcHUXi2avIwD4a0REUGzW4qx99rDtzc/U6fvbXaXu8rfIk+lfpN4cERhtbq7d359
	 MBhuq3JTXbR0YpZnuaFfSt6TU2Qo4uybvjGJ6bopu7Tvsg47I1zRt8KuzRG/eB3vns
	 Olp8GrGnOP/k0SqAAwKXCigjMEKaZCdGkfLERhhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfBDSX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:23:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfBDSX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xrlcnkLDQpHobHcP2z1C52CiJeD9X7WIgTcjK8a3H2w=; b=ZMHXkjB/pejcQI0WvSBb+eC35
        h5pwJZB+YrHxhSzt4QS3TQ5Afy3BWhfEZXC2bCEOzsmn1K/h6sKSfIrY7InrOgNqAOhhKASwYh/vh
        1t+1/9chie8uoCr779oYs9HCDYfXeuhVqR4MxQFGETY25sh8YRHTx67R65n46XYW2Q+d4=;
Received: from [109.236.136.146] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqitu-0005Hm-GU; Mon, 04 Feb 2019 18:23:22 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C80F8440082; Mon,  4 Feb 2019 18:23:21 +0000 (GMT)
Date:   Mon, 4 Feb 2019 19:23:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcs404: evb: Fix voltages for s5 and l3
Message-ID: <20190204182321.GH23441@sirena.org.uk>
References: <20190125232954.26166-1-bjorn.andersson@linaro.org>
 <32b8136d-3acb-66e9-948c-ee8903b91401@linaro.org>
 <20190129224652.GB11349@centauri.lan>
 <20190204104347.GD23441@sirena.org.uk>
 <20190204160337.GG2387@tuxbook-pro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline
In-Reply-To: <20190204160337.GG2387@tuxbook-pro>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 08:03:37AM -0800, Bjorn Andersson wrote:

> We have a regulator that is described as 1.05V in the schematics for the
> board we're working on and we have the USB block wanting 1.05V on one of
> its pins.  But the particular regulator works in steps of 8mV, and the
> adjacent steps are 1.048V and 1.056V.

> A) If we describe the min-microvolt = max-microvolt = 1.05V then the
> regulator frameworks adjusts the min value to 1.056V, per the steps, and
> fail as min > max.

Right, because that constraint isn't satisifiable on the board, an exact
value has been asked for which can't be delivered.  We *could* try to
allow some fudge factor for tolerance but that feels risky, it'd be
better if the constraints were written to be satisfiable.

> B) The USB driver that we inherited was written to request min/max of
> 1.05V/1.05V, so pointing this to a regulator with min/max of e.g.
> 1.05V/1.06V we're outside the adjusted range of 1.056V/1.06V.

This is just very bad practice on the part of the USB driver, if it is
not varying the voltage it should not be setting the voltage and let the
machine figure things out.  It is completely pointless for the driver to
be setting an exact value that it never varies, this is the sort of
thing machine constraints are for as it leads to trouble like this.
This is one of the many unfortunate practices in the Qualcomm BSP code
sadly.

> So the question is, should the board dts be written with
> min/max-microvolt adjusted to match the hardware steps? Or could the

Well, it is definitely unwise of the board to request a specific
voltage if the board can't physically set it, that's asking for trouble,
so I'd have expected the board should pick the value it wants.

> regulator framework be made to round down to the previous valid step
> instead of up?

We definitely don't want to round voltages down, it is vastly more
common for devices to experience problems like brownouts if they go
under voltage so it'd be more likely to cause harm than good.

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYgxYACgkQJNaLcl1U
h9AaFQf/SvrQP9sXF235FC/gkj+AF6i4fv4/vGBY4XsXb908c8PfFKaNNersjsky
bcXdRd8CsREiUGR9aj2H3jiDYeyIFH4jabFkzaCtu+1yEvYCT16sWkEJIbBTWq/M
HzEHamVvnWVMy6UgZWl6xzKo3J17bEQcV60DEOxAjHWpngWxWE2g7JXwbAqg8gYW
yNms1aza6iThWY75jX5VdFuqHrdcCyZvk0EVntmGUgX+81qiYXwrGLIu0NwklDBz
Hhac17dl0uHE4SaqZRGJiERlFf3oVWGY+fDRjdYFXqoFlh2HE4vVlVUkfoLgm8EG
PygEYvcH9LRs/F4TvxCxxHmLop0xDA==
=Y1HY
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--
