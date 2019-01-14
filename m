Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EEF205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547503703;
	bh=JdANIHcHPD3HVLALkXO2NpqLDhBxGDye2VixhEeQp3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=etHprRJKJWA+R6Juwi9fG+e7pm6zEKFrzVoLmEqOBVAkOBZeGkmASv8wYcnJOel5G
	 NnWYQmqN3uYSwAOUXDWQQ3mtpaRfV0FB9Ahwb3BiPAc5tZVoQJgwqUhBwqrheSHa3x
	 lv8xeYQPBkHg0/xYE4lf8iIF13mIN8N03du+CWK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfANWIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:08:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59170 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfANWIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JdANIHcHPD3HVLALkXO2NpqLDhBxGDye2VixhEeQp3w=; b=SWf3Zn43guAzjKi6iargRPy2V
        97tIVoiDEwV6abHHC20NSYJdZhTeC3O2nbekwtCSC0r7ALlwbBPCpw1Judc10weaF+O3a88GdVuBM
        YdxCPVdr4SURxE0n8gSl5yIWrJhHISFcbcF6ID3IPke5KN+XUmf6FU92c8QpJxdk5Rx+I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjAP4-0008FI-DK; Mon, 14 Jan 2019 22:08:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EA2E51127AD0; Mon, 14 Jan 2019 22:08:17 +0000 (GMT)
Date:   Mon, 14 Jan 2019 22:08:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: dt-bindings: Convert fixed-regulator to
 json-schema
Message-ID: <20190114220817.GH11073@sirena.org.uk>
References: <20190110221903.3990-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
Content-Disposition: inline
In-Reply-To: <20190110221903.3990-6-robh@kernel.org>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 04:19:03PM -0600, Rob Herring wrote:
> Convert the fixed-regulator binding to DT schema format using
> json-schema.

Actually I've had to drop the series this conflicted with since it broke
a bunch of platforms so I'll go ahead and apply this instead, no need to
respin!

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9CFEACgkQJNaLcl1U
h9D3Uwf/YdWRexgPnkLabs94GZD6T9erBqzrFnXhZf0b4SxxknkChZ9ahq+VDi1r
pUsf/T5HKA75PiPQCcbn+TVM0fRQBlNDeb/2q1l1YWnU8fXSgY8VgYmWqgJGKpVg
ytWAKmIo440zfYvyPOXwxedGaJ29xGUmAHiL96WXIZJZdqqBkrWLyrbRMpSCnwI/
tO9Q5TntZM1TcaALSx2ooGCO+eqCXTKHfazMxco7qFYwqzVsEeYjNzIjBQ/Vx3q4
ynf/SetNemGsPfIa+0gHkdn6eoC5e2nIGz1OhBEuW6CVhvpcFxDkoGAiYcin2Rc4
zQwyCkCtS5kMSUCi+IoUijCgKqLOdw==
=8G0B
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--
