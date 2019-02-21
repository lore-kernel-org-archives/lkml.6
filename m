Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D695C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF22148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550743966;
	bh=KJE3FP1qTQTiWqO6AeN86N1wc6uWQVg2UWOTrAeVfSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p4QprTT+wkBA578IK6fJbI9H/28q9GXAP8JYPK+K662D13iS+KdIluLrhw1sKlQ4j
	 bVclNqUHyiSKU8LrsBBz2gyU8mjNN+E+axdu1vcy6fsWAHyZqwAu4zAhR+ZetPqPFy
	 qRlbnyaXYapj5GBWGqiQdejJf3jTiXo7K0j1FlhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfBUKMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:12:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfBUKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CbdGlzgEbn0lfmLf4CzvzMym2fMa3q5299etdN+3GBM=; b=nkei0honqLKwaWbsiEhC/2m/m
        SjgtU48Ql7UTecnd33jAgLOip2V5frh5j4gpmkAf9lbaPuxueX1WHow5fgfJetjyfuHzyNsPxDPoF
        vzped8IRGGjVc+xZGUTyVY5TJc2vp090N+3D5nRhwKrxk2qm2LikCw+rqjmTZfFLV3vOQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwlLL-0002Vs-8L; Thu, 21 Feb 2019 10:12:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 97E871126F33; Thu, 21 Feb 2019 10:12:38 +0000 (GMT)
Date:   Thu, 21 Feb 2019 10:12:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v1] regulator: core: Log forbidden DRMS operation
Message-ID: <20190221101238.GB5970@sirena.org.uk>
References: <6e471922-2850-97b8-c555-34e1708cbc38@free.fr>
 <20190219163929.GA20883@sirena.org.uk>
 <5ad87a46-147f-0619-29b9-bd352810ade8@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <5ad87a46-147f-0619-29b9-bd352810ade8@free.fr>
X-Cookie: Garbage In -- Gospel Out.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 10:42:01AM +0100, Marc Gonzalez wrote:
> On 19/02/2019 17:39, Mark Brown wrote:
> > On Tue, Feb 19, 2019 at 05:02:46PM +0100, Marc Gonzalez wrote:

> > No, it's perfectly normal for machine constraints to stop drivers from
> > doing things so we shouldn't warn on this - it would get incredibly
> > noisy if we started printing every time constraints didn't let us do
> > something at info level.  Debug level might be viable, or definitely
> > vdbg or trace points.

> Several functions return an error (and log a KERN_ERR message) if their
> corresponding flag is not set:
>=20
> regulator_check_voltage()	REGULATOR_CHANGE_VOLTAGE

That's a bug due to an incomplete implementation, what it's supposed to
be doing there is checking if the voltage request is satisfied by the
current voltage and returning an error only if the requested voltage is
out of range.

> regulator_check_current_limit()	REGULATOR_CHANGE_CURRENT

This one is less clear than anything else - we might want to error out
here if the device is somehow relying on being able to lower the current
limit for safety.  We'd need an audit of users.

> regulator_mode_constrain()	REGULATOR_CHANGE_MODE

This one is also a bug, modes barely mean anything anyway.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxueZUACgkQJNaLcl1U
h9Asowf/Yt9w6jVOGbrJmaTj9IqMEMPjlv6sB92y8ROHc+dFCWOB6Hb6nhS4C2et
9WlPXoYdjvrcmMFTAJRbhqalTEBZhLroK1uNZegl+4Lu2mVrs/GlJCaI7X26YF5w
GwQkauHX5r2xROPkNcqNoSP+dgGb6wrBLBZvw80lRge1Ko1zmiALvCykf8itJqbp
J5iaONTacAhHXmzww8VWoUG4Ss8pSIAZeniLvIDmc+R3F4PZW5GdIlPXYwG6rzWT
mS1AqHqHYEVYvzHFsvz7YMyZo6lj2yz4dBzVLlF7tAD9h8oSyChZubq4PCuUpCSc
8R16ca9ILYRY7ApvlDw99Oe0xhE9TQ==
=IlAs
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
