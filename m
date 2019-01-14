Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639EDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30EA620657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547474915;
	bh=MMGHwi3pms9lGCf6j3rLVj66rkGvxsnrLfx2+TpEJYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZD5SxnToUz4jnkv/d6V/HH0slJu9T4FuIQe9Vdwj2A0hCPljpTidAEx/mL70oQKp
	 3jvcWo5EtyYsikb34k9Os9hQ5zH+BrF+fEJHDkJpkF404EiZtF1LtRIyGgZxKKREwH
	 gamm3r+OY7K2DvnqESjqeejYTZ1qExOh+hqtNtZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfANOId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:08:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44360 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANOId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MMGHwi3pms9lGCf6j3rLVj66rkGvxsnrLfx2+TpEJYk=; b=vkJ5ftjiy/04i4WtuvTZ91u5f
        UCMVUYgOcRrxr+IdZYcEeX0KqM4TteJWqLAZwyvPehu2qxNNZP5vi5BSbh42+mMKXpep5Lqk7LqeE
        Tp8dte9aVz7ll/3/N9VC4O/zpz3Mmn8LhnkbECeKIeIeE6lVAs/3qB23jb4bvJ3scV/sg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj2uU-0005NM-VP; Mon, 14 Jan 2019 14:08:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3B4531127AD2; Mon, 14 Jan 2019 14:08:14 +0000 (GMT)
Date:   Mon, 14 Jan 2019 14:08:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, brian.austin@cirrus.com,
        Paul.Handrigan@cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: cs4341: fix waring unused-function
Message-ID: <20190114140814.GC11073@sirena.org.uk>
References: <20190114095540.22956-1-anders.roxell@linaro.org>
 <20190114112443.GA11073@sirena.org.uk>
 <CADYN=9LU2fngmUZrM_E7qS7rGB7y4b45H12yZOW=X7JfaS1qqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <CADYN=9LU2fngmUZrM_E7qS7rGB7y4b45H12yZOW=X7JfaS1qqQ@mail.gmail.com>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2019 at 01:49:17PM +0100, Anders Roxell wrote:

> Do you want me to resend it without " 1/3]... " in the subject?

No, that's fine.

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw8l80ACgkQJNaLcl1U
h9B31gf/T9PzP/h1uPds/fefFp+3eV9W+igONVCH1EbOpe9a/zNQ7jETxpD/3ZB9
mlN3SRsfkzLOx1LQqpF6MGVPE9kaKLne2RR1qmu4CZQ7vWKP5rl/g03UYHlaOYIG
JNSzyJQNAjxA7GrIfo1lPKgB39qp92z3kWTIcRIOk/nTGIKGuvA4jJ5dn8HldEqu
BhJdJ84sqp5rD7JdqDt5eaWk+aJvT5rzOmdlqxjpuJ6vyZ+InFDHdIozQXcEvdFH
wy8uCSyqrXIx6rRJTfJ7eZak5Q1dY7G6zT3W1FbUvp0m+U6kY7iY6+baL+pWssps
Cx/XYQ7qf8RDgqOlWCQIonKlCsXZTA==
=Pica
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
