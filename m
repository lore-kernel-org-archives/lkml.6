Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F227C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F18820652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547742172;
	bh=NBepFga32x0DrLh+UIr3j2ZCVIxDDg3ymGfrtzG3M04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XuW3VBF0GrCj/Tc+Bu16sQInjUYcfJBEOSEW+LrQmpmBnzEiqV55faFkfDPs6yDap
	 vTOhZxBVX8QhknB2l1sbbFHxY0fnu7R3f37U4MVhjdBStXYRNYpluqR+qsRXalo14G
	 87qpxcTLGKFzqkUSyetroPEY59Vn9YldUJdvYu4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfAQQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:22:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAQQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NBepFga32x0DrLh+UIr3j2ZCVIxDDg3ymGfrtzG3M04=; b=iOfqi42/rUa3N8tk5BXvICiii
        aARX/6+lI8wn9L/TtNzigXPHqi52/1pqRpDeXXFo01/aHWOLEZ3k51cSiEyL4qR5aEXXp96ZmUcz3
        rX6ZBmax7RSGMErajma+LwX3sOjk/jui0p2t3//p5r8I2/nJvUdDEYuFG4FW6fGuUocxI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkARI-00017T-Jl; Thu, 17 Jan 2019 16:22:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0EB381126FE3; Thu, 17 Jan 2019 16:22:44 +0000 (GMT)
Date:   Thu, 17 Jan 2019 16:22:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [RFC 1/7] devicetree: bindings: Document domains controller
 bindings
Message-ID: <20190117162244.GC7003@sirena.org.uk>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
 <20190114144202.27315-2-benjamin.gaignard@st.com>
 <20190116173018.GD7186@sirena.org.uk>
 <caeb0919-20ab-a27e-f2c1-10f97d868451@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <caeb0919-20ab-a27e-f2c1-10f97d868451@st.com>
X-Cookie: sillema sillema nika su
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 01:20:45PM +0000, Benjamin GAIGNARD wrote:
> On 1/16/19 6:30 PM, Mark Brown wrote:

> > I suspect this is going to need a few more words about what a Domains
> > Controller is.

> Does the description of the framework in the cover letter looks better=20
> for you ?

Yes, that looks reasonable to me.

> I'm not comfortable to put it in bindings file but maybe I'm wrong.

I can't see how someone will understand the binding document as a
standalone document - it's not like domains controllers are a widely
understood concept in the industry.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxAq9MACgkQJNaLcl1U
h9B7ngf+ITrp3lNoO4jTTr+sG3NzIAtgRmnkKq6ZA8Q0RocIAPDE2Z/tCfw7/uOe
DrYN2kliKZj8qJ0J6hiZ8eePHgiGboWYjkCDW1H5TgoeAQapgJxpB7q9iSNS1Eo1
6CrP3WFh2plXJrAhP8v4HwBrypuN2MoMJpFV9tnGUw4DvJa3b8A3G3+mOLH4l9mH
gKSsjTtS3y2Fw8biT2gR//31uh6Ch01KsVyOak/gdrlLCJNgTPv9pqF9prsot9L8
YxvbengraOBJNQ/xg9Nq4g4+kR77u1/9XrHq2fK5pJLgXubIr25tC0BVgc8to/HR
+XAz+dy9q2WVxf8igAOLzQJMCE0gMg==
=8b7E
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
