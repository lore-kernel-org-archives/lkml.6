Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A42C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A83B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xF5M4TWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A83B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeFTOEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:04:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33730 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ltdsnm0aY0y2kG/nKXK0DwPbFHn3W41jJhr6HKXn7i0=; b=xF5M4TWLqB2RoFqNbvEbimFaW
        gyyd2kAmrAOLLfbIZiM9CjD3vWfQBCjL3uS4QxsqIQHgKaidWhg9LpQGkkmd/zutEgCVbAzVeGa5y
        XUdmPGg4lvRDqAc4AX9z8U43St18k2R/rZAnHgZfgLgh2WFlFjKjEMTmaMYniULEygARs=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVdhK-0002JA-2e; Wed, 20 Jun 2018 14:02:58 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVdhJ-0001Wq-GW; Wed, 20 Jun 2018 15:02:57 +0100
Date:   Wed, 20 Jun 2018 15:02:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [v2, 2/2] ASoC: AMD: Configure channel 1 or channel 0 for capture
Message-ID: <20180620140257.GG6242@sirena.org.uk>
References: <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
 <1528354129-5023-2-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <1528354129-5023-2-git-send-email-akshu.agrawal@amd.com>
X-Cookie: No directory.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 07, 2018 at 02:48:44PM +0800, Akshu Agrawal wrote:

> This patch is dependent on ASoC: AMD: Change codec to channel link as per hardware redesign
> https://patchwork.kernel.org/patch/10388099/

Can you please send a patch series with all the pending changes for this
driver?  It's getting really difficult to track which of the patches
you've sent fit together and what's currently pending as there's often
quite a few different AMD patch serieses in flight with interdependencies.

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqXpAACgkQJNaLcl1U
h9DdFQf+IolwLAVOV0PbeU17Tz5AkSGTqgLhSP9bwS0etfjcVcQ/J7yls1wLOvIy
w9OcpEAlGa61C43O2TXRAgpkD/j9/c2pW1BtZTca3nMu4yPKF5sDavVSy+iiDVh0
Y6IMGVsjgZOgJxlYVdr+5tMvTbKTiJic7VAkNyzFFSZ1Sz0gB2sICijJQtpc73ZN
wbGoVyRszvpayvO3HKm++zOe9pI3MWzdlCb/2wDMc2/+QuHoWLNfoAE2pIBmrhCH
QuG7rRFDS0iISTaljq1QFx2Av0NnkmUEaI/S1I49apckTIZzJGUdN5vrQYhOH7H5
F9v91jU9/MUTj6J5WM864sz+rugSOg==
=BTiA
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
