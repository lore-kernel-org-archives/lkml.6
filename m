Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7C9ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E0221476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="N3VTfpn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E0221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeJRDOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:14:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50324 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJRDOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ByXzP+CsOejUfDQ/kspUYGh8FHSBZ+58ktHFX5K55NI=; b=N3VTfpn5afLCKoaso56dGX+Ch
        kBz/w5oIQ7SyXdZgaSxf+o9gBJgaA+tlaHND8vrdMBHuwje0lCS0m5X941T7OrYSCuzCNxyRZn2EG
        kvmeg0SeZDf3DgnzN/APqns28zOCF3XfCWenwq+hUC/xIl8OHX4NakoBblkadPwehTfEQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCrJ3-0001qf-GD; Wed, 17 Oct 2018 19:16:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3B20F11224C4; Wed, 17 Oct 2018 20:16:33 +0100 (BST)
Date:   Wed, 17 Oct 2018 20:16:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 9/9] ASoC: tegra_sgtl5000: fix platform name vs.
 of_node assignement
Message-ID: <20181017191633.GL24097@sirena.org.uk>
References: <20181016104730.4598-1-marcel@ziswiler.com>
 <20181016104730.4598-10-marcel@ziswiler.com>
 <35848cb7-36ee-6698-ff17-7f0e73567914@nvidia.com>
 <1539786500.6233.58.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5C3/nrmPumNj5sH"
Content-Disposition: inline
In-Reply-To: <1539786500.6233.58.camel@toradex.com>
X-Cookie: No passing zone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t5C3/nrmPumNj5sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 17, 2018 at 02:28:22PM +0000, Marcel Ziswiler wrote:

> Some questions:

> - How exactly are devm allocations supposed to work concerning probe
> deferrals?

Probe deferrals are just normal probe errors, any devm_ allocated stuff
gets unwound.

> - Does or should the platform get cleared during a probe deferral
> cycle?

> - If so, why does that not work?

Is something writing to static data when it should be writing to
dynamically allocated data?  That's what this sounds like, we shouldn't
be modifying any static data and any data dynamically allocated during
probe ought to be being discarded.

> - Or is some special implicit probe deferral handling missing in soc-
> core?

Like I say a probe deferral is just a normal error.

--t5C3/nrmPumNj5sH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHipAACgkQJNaLcl1U
h9BkSAf/SouRZpX4VQqudTnmOiqKqZkMRbwM6NBQpPpPsCCRtMqnI+WEN+LE8snt
yn/nMdP7g3m6uAV15M486uYS+qkFI3eQ1hYt7bWfi01kclqsZS7JUqaMgKvziM05
Uphkd15nbTHBTyHuhznZPy3+tkRbdfb7cGzBJR9xagor/WfDCnjQdkwV9TIn3l/K
7LhBs+XluSRL0A0Jq5MYuEIuKV1X4iPrNCdpTYO01Y4APrSend4SYL3vqY4MxzCX
MQiaUvEO/XYxFQHhKmvwwku4cgq0cFZLm+qARMuxY9CA+XzlE/IXnQDe8pF1XtsN
qx4q0cnhCClRQ/uXiDX0GHgpLtWGaA==
=V209
-----END PGP SIGNATURE-----

--t5C3/nrmPumNj5sH--
