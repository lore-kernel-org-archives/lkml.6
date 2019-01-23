Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952F2C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E3520870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548264561;
	bh=YOFNuL5V9xmJWih53628u54IfpillMxhs4YavDpbH8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2FUOvflS26h3Z5LqREjk4m+xLo8J3CsncKs86TRTb/Fzg9BSyrgjwSMNwhdQyCdmv
	 xhuoEa0srr3Lp+d8e9Y2PGJzyFIhlGhCbXLJ+GNt1FOYpzXUQJAo1Z32jd2Z6sx6nP
	 JTgO+QMLUwpRjUpF1ijF2OMCVdI0dDpy9CfEjk3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfAWR3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:29:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54310 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWR3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ucniJVHoVXntYH7Faf+Kz0hGhM5tUmJN7wC1AND91CI=; b=SPVjXKEqMI0+7m1tWfbbR2fcE
        s3i+m4IaASJQUxVmEteiOSRdKgks+Dlqi/5afcL2KxYbDurcgjqrWrs+4EOInqvvDlb09DcR56jjy
        xgoq3flTRyFO0dEfEP/1FbCfoe1Qtz5XY/yZFgIh6mO+JuQtlxBoWLZJd2+sKNfRXCKJQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMKv-0006e6-59; Wed, 23 Jan 2019 17:29:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 885AB1127ABA; Wed, 23 Jan 2019 17:29:12 +0000 (GMT)
Date:   Wed, 23 Jan 2019 17:29:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, thierry.reding@gmail.com,
        boris.brezillon@free-electrons.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regulator: pwm: suppress EPROBE_DEFER error message
Message-ID: <20190123172912.GF7503@sirena.org.uk>
References: <20190121183723.25231-1-martin.blumenstingl@googlemail.com>
 <20190121183723.25231-2-martin.blumenstingl@googlemail.com>
 <20190123160405.GD7503@sirena.org.uk>
 <afa9ed378b7fa62e81662363fdaf7543@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <afa9ed378b7fa62e81662363fdaf7543@codethink.co.uk>
X-Cookie: A couch is as good as a chair.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 23, 2019 at 04:14:49PM +0000, Ben Dooks wrote:
> On 2019-01-23 16:04, Mark Brown wrote:

> > This also cleans up the kernel log in the case where you've not got a
> > driver enabled that you need (or it's not loading for some reason) which
> > isn't super helpful when you're trying to figure out why the driver
> > won't probe.  There's not even anything at debug level, that would
> > probably be fine.

> > The ideal thing here would be to work on setting up the dependency
> > information based on DT and using that to try to sort initialization
> > order so we try things in an order that minimizes the number of failed
> > tries.

> Hmm, would it be useful to have a devfs file which holds the last probe
> code?

You really also want the bit that says why it's deferring - "failed to
get clock X" or whatever.

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIpGcACgkQJNaLcl1U
h9Bd9Af+PkGTbTa3YfJpdWimXdj/2tU2uqKtxKx9uIg6/6IKCqZktIeGacUi7FWO
zm/kLm+KThwOUBGde6/gGe+xgR0dIs7CgGFowdkKgt82mVYXeUrz9RlLL0fjA7VL
ZJuH5KVzppqZ/AzwIYmondQLRa78wm4n1XQ15kvckDd+QLVigUAR+TSU3zaQ6EdU
ocv/NZz4AzJZakil6qm2QGjjssNDdbl3J72eJCRGfq0fl8+lA4YT0jgMg4nUnvEo
Y1X8REscqdePK20vL0qYOUl6xp/WbwrSWNFHa15c3skhjhMsdn9d+9/OMkaiAZdB
RhIJURJar5C3Idww05p3lr9J/L+dWQ==
=4QIo
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
