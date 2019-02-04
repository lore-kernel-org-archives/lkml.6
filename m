Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76907C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447092176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277048;
	bh=uwF00SCu0FpBDhAap/j6o2LVWdW33VteVawgKO6v/UQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l/4h43Rx49CboUSBACCzter3bvszlHALnih/zTSlwtEVOLQl4tcaYCUs+rhB/SqT4
	 GKBGFxsm6rACO3WohSyXWQzTRJIcCILgyCcSq8BMlD2WlhNuxbi6w7FL6h+P/zG0Jr
	 /u3oc2mvmbYuSpV2mwvl1asg608WbKVHE37kzgRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfBDKoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:44:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60822 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbfBDKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K6MQylCFmKghmGxD0GP9p79Hlo3+pe/FdR7xH3fGBS8=; b=W29c6OB+eeSHXmOGCf3ESnR6Y
        wsOBNtS1xhWRxXs1DasET3ob6Y3+HWvZmFCiLUXMXUIaqMn+O5lRNXhZcdJZutciNGrXtOaLx2TcY
        nqlaF9FdeUa4wWzUpAI8GsqK3kC4yd7rGvU6MsezC7hpAoVlUUIN6l2mxo4xgUMCi31p4=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqbjF-0001r9-EX; Mon, 04 Feb 2019 10:43:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 477B5440082; Mon,  4 Feb 2019 10:43:47 +0000 (GMT)
Date:   Mon, 4 Feb 2019 11:43:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcs404: evb: Fix voltages for s5 and l3
Message-ID: <20190204104347.GD23441@sirena.org.uk>
References: <20190125232954.26166-1-bjorn.andersson@linaro.org>
 <32b8136d-3acb-66e9-948c-ee8903b91401@linaro.org>
 <20190129224652.GB11349@centauri.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <20190129224652.GB11349@centauri.lan>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 11:46:52PM +0100, Niklas Cassel wrote:

> Adding Mark Brown on CC.

It really helps if you ask a specific question when doing something like
this rather than just have a big quoted mail - it makes it much easier
to find what's relevant rather than trying to find things, especially
when they're buried behind several layers of quoting.

> On Tue, Jan 29, 2019 at 10:58:47PM +0100, Jorge Ramirez wrote:
> > On 1/26/19 00:29, Bjorn Andersson wrote:

> > the question is, should this property contain only hardware achievable
> > values? or should drivers only request hardware achievable values? the
> > way the constrains are implemented it has to be one of the two (I think
> > the former would be more intuitive - ie if the dts
> > regulator-min-microvolt is a valid value)

Drivers should not be coded with a specific regulator or board in mind
and should just request whatever they need.  This will then be matched
with whatever the board is actually able to deliver.  Similarly there is
no requirement that machine constraints be written with specific
reference to what the physical regulator on the board is able to do, for
example the constraints will come from electrical engineering
restrictions like the specifications of the parts connected to the
regulator rather than from what the regulator can actually do so people
should feel free to just write down the actual physical constraint and
let the regulator API ensure that the constraint is met.

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYF18ACgkQJNaLcl1U
h9Au6Qf+LpdYqVbelJRtzkiY7hM8KnLPW22HxU3sbgDRIo8tyQ1HY3hWhY63+cmE
XLTH4I5sv+tJsk4sEVYGHHH81DYdVlMEg3FnHqUU3YLWqULlEtmCTvs+alKAR2TA
IgXdRs4oG8A4iC0lAN+umBokj1xXDl0sSs/Uf/kAAVN6zoymThziFVrpI868+e01
fmo+lILI1d1DLqB6epeNkaDoIjitZ/4H5ycYr6yFIJvspZC0rrSJwKxsvyubUKTW
Athu41csXgHdmri1WM2toON7zpPslVLpxBslGwWngGFjgaDE+ohLic4sZ1Q8uLjS
XeB8tsDpt6XWCdvZt8ltbeeDpoZWkQ==
=RsID
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
