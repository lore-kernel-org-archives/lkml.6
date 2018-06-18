Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC6BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EAE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="C+E2YikU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EAE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933962AbeFRLcG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:32:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54294 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933337AbeFRLcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3N6o5a8ejqiri6/89nzZtLMjTybu486LFW3RO26ogVo=; b=C+E2YikUhZLJES6kKUrkcI0f2
        DBCO3LrZ8hf9drCj15dkI+ylGbVnyri058cH+v4nEg+UkPIl2Ko3E+b3h/NIRgP44zF1L/KRdE1Y5
        S2WLcwGFM+jiAiaDRdWzjv8sXYo4YwLpdRJHJpLYwLcMkGHcSJBwrfCpWkdvixqVoJ1rU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsO2-0007vE-Uf; Mon, 18 Jun 2018 11:31:55 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsO2-00076C-DJ; Mon, 18 Jun 2018 12:31:54 +0100
Date:   Mon, 18 Jun 2018 12:31:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: TSCS42xx: Remove Playback/Capture
 in names
Message-ID: <20180618113154.GC6928@sirena.org.uk>
References: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
 <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 03:46:28PM -0500, Steven Eckhoff wrote:
> These aren't needed and some userspace apps don't work consistently with
> them.
>=20
> Remove Playback/Capture from control names

Really?  They're part of the spec so it indicates that the apps have a
problem...

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsnmCkACgkQJNaLcl1U
h9AtMgf/db+DeLAlSJqM/obcQty/4KCFpwgIxy9w7jWqIyF37Cw9IzMII3WHrON2
SmXGsFvc/2CdDLMnqnWxgLOJpyZZGtQngc0F3OfhecoffUzLhF2ZzB9EgzJaWzbq
Ooik8l5WpaXYt+qiECh8m3z6vZFvOKHkq6BClH+UXgGNICYnoI2w3+ncfpQuQ3tx
CWDqx6Fq8fhmxdgM5Ovvnq3veSIseHZfkZLd3cQhGHNSIjBtGQw8cbeMu11VZwFL
LknamhHW99ROpck4uVIpItNi/4pgfZXvyKhbnWCLa8VRbm+xX7/lyEjyhfeUGo7y
axmcx7YPh7G72cZG5r+Mf7V7d4MMvA==
=cdsd
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
