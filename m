Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A95C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C0120844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="D72A8lFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C0120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeGXSWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:22:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41710 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388388AbeGXSWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XN11HUk8mzAsEWcv9oz8nTa26WLsJtGxds82DNtJD2E=; b=D72A8lFTg1q37kgN8T32I4VOw
        2uVydv2Rl2sf01QI9RjS6fKTIeZb1U1hVqWIiUNJ2OsLkZB99IOh+xpKY2AVWKFrjeqwfl2nSwBDn
        tc4ampJLBZVl6f1i6YzTfFKJorckNguSWuGYfamc6sBThLcBkO/l3+7AUXOnGFUV5UXUM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fi0tJ-0005gn-AC; Tue, 24 Jul 2018 17:14:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E8B131123A86; Tue, 24 Jul 2018 18:14:28 +0100 (BST)
Date:   Tue, 24 Jul 2018 18:14:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dylan Reid <dgreid@chromium.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Add a fix voltage regulator for DA7219 and
 ADAU7002
Message-ID: <20180724171428.GQ13268@sirena.org.uk>
References: <1532068715-2992-1-git-send-email-akshu.agrawal@amd.com>
 <20180720121816.GD10784@sirena.org.uk>
 <50343cff-bad4-7677-851f-f0b818ae7b29@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TSQPSNmi3T91JED+"
Content-Disposition: inline
In-Reply-To: <50343cff-bad4-7677-851f-f0b818ae7b29@amd.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TSQPSNmi3T91JED+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 10:56:44AM +0530, Agrawal, Akshu wrote:

> This approach shows inconsistencies and in some boot cycles da7219 fails
> to get regulator. Form the logs (below) it shows time gap between the
> time we call =E2=80=9Cplatform_device_register(&acp_da7219_regulator);=E2=
=80=9D and when
> the regulator actually gets registered.

This hack isn't going to help with that AFAICT, you're still registering
a platform device and relying on it appearing in time?  It just
registers less often.  I think what we need here is a way to register
the link between the devices independently of the regulator registering
or firmware, that way we won't get a dummy regulator.  Since AFAICT we
know the names of the devices that are being registered we can use their
dev_name()s which seems tractable - we need a function in
regulator/machine.h which lets you provide a set of struct
regulator_consumer_supply for a target dev_name.

--TSQPSNmi3T91JED+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXXnQACgkQJNaLcl1U
h9BhIQf9Fw7VLwNBmWVu4Ia61h8wt8CJ6Hg0m4ICosSAtNfWPiTTy+PnMRP/Q0pg
PJbjtkWAeE6TTbeXeQ4F8OHaGa/bvk4q820HM7WhXGfToXkL9iKsE3vjB0U6JqwT
UlUyNIA9d+eV8DmAxxsmG/4hRT13lkXtPF2BdkC6QsmrFWK50Oimh3DLJZOGAg5o
LnuQCCcctf33BQ2ZG2t28QF10NWUqIPGsT9D5GL4vsf9zc5pBD+DxjzgaVA8pgAJ
GOKim7OGpkzZZS/Y5G1QrWSW4hmgj+TBi+gWYcT+z50753trqTN3ZcCH2QuNfado
KOVNcXfo0aQZWNsUI6F1aP0YYcGLfQ==
=Nzh7
-----END PGP SIGNATURE-----

--TSQPSNmi3T91JED+--
