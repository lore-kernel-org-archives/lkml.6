Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD0CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7726217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550572988;
	bh=8hqRiS4Gm2hcnPTBDuWtPgIMPRj8QDMLVkkufrWeTC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eB0cKE6LcLK8NoRDyx39NzuqDKb1OCxGd7Exe5eH3tbYCDgfjSh5dg1PZ/sI8mZAJ
	 +pQBTjxAVy5DhLsRxwJoWabaT1KdxtfoeGtYmRgHRNwrAZli8RCsjk3yJTRW6/rJP4
	 zu9/eILbNJkRYCqe6aIj71fydQmZStoeFM51Zxig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfBSKnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:43:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33154 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBSKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8hqRiS4Gm2hcnPTBDuWtPgIMPRj8QDMLVkkufrWeTC4=; b=SnePacyKxWo464O6GG24glrVR
        U/qXM3kE++NbwYM+0zSHD98DuOWN36Mg9OYKIB+rmIyyBMlT1YU412aOoAsTM927x81qQyJeoNY+r
        mxQ2k1Bgm2ZqhO2v3HH8OFr1PAhZQbYeNCI8273ybCC/DtNecg0XIp3uobWiZ+EobVqfc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw2ra-0007vW-2I; Tue, 19 Feb 2019 10:42:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 68F81112841D; Tue, 19 Feb 2019 10:42:57 +0000 (GMT)
Date:   Tue, 19 Feb 2019 10:42:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 6/8] regulator: stpmic1: Change buck1 voltage range
Message-ID: <20190219104257.GA6319@sirena.org.uk>
References: <1550570647-9555-1-git-send-email-p.paillet@st.com>
 <1550570647-9555-7-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <1550570647-9555-7-git-send-email-p.paillet@st.com>
X-Cookie: Do not exceed recommended dosage.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 19, 2019 at 10:04:34AM +0000, Pascal PAILLET-LME wrote:
> Change buck1 voltage range to be conform with the data-sheet.

This is a bug fix so it should've gone at the start of the series to
make it easier to apply and send to Linus as a fix.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxr3bAACgkQJNaLcl1U
h9AMkQf+N2Iy/0bBdB1WS1fToVshGDV5kAXEiyK9b0yxIHSwCxxBLRqDr3NwAM0h
f4qpBCDF3DUbgl/CE7thOa7Zyz4xm6bwM5/9QJO+qv/ryJj/1v59gFMa22nULHrs
Z3KD3R60kgCcKk2mENHpvyyNFyhGtw7+bhpQagGOyJXTc/Cv275itfosq3CB9B+7
dwzHejJUJY7OcefHiLGF6Y2X4hoHEJQlYgoyj7ZjKJddvub4XRGwKAf+OO/jWf0C
4IybyQkJ2KK6o42qGhcwLX/8ODmE6qiVH1O1u/cTq5gKljab+l82Sen6FxYHSzSg
UEyyJocK6t9jDkqHH7bRj0wZHfNfLQ==
=fCnH
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
