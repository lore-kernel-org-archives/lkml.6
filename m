Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C27C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF9721479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546518877;
	bh=lE30DEBsMyqVtarIPnTyAKXgsFlVsolmUcj4aZ5R7j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SOcYtMj0bXVHaE3QMUQa/mAUX4ebl8KpkqsbnbtB+FofRjDwzVQALZEFqHxe4lDVr
	 xrTscDyx2tUw7dMcBLcuxqv6llVPYO47nKPECdRwF8H9pEbRf3HJ1kG/JSx2sFPN4m
	 PyWZUCffTgv4wqACnCcciPgwA1pj/haeu7d+OIOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfACMeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:34:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59382 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfACMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yqzuYoTiGAUHUr3Dw9FR7Ct/Ol1rX/VorE7ZjjtN4tc=; b=HIvUNCcNnAVe90vxvA+WpuNn8
        tV4yH4Bza1FL4zlcfhI19a3geKutd7KUgghe5tKWnBfxVvwAX/ZKJ1D1ef7v3DxxqRBHBuHyyF89S
        UygtJ1jbc4+ABTfHCkloVdk4yYWg0usgk+1/WhhmkUZoIWkNHn2Qbe43CoU6jU6QTuwCk=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gf2C9-0005T3-VJ; Thu, 03 Jan 2019 12:33:54 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 31559440080; Thu,  3 Jan 2019 12:33:52 +0000 (GMT)
Date:   Thu, 3 Jan 2019 12:33:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Message-ID: <20190103123352.GQ1846@sirena.org.uk>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-9-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GJ7e10BhKqIkML+d"
Content-Disposition: inline
In-Reply-To: <20190102181038.4418-9-okaya@kernel.org>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GJ7e10BhKqIkML+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 02, 2019 at 06:10:35PM +0000, Sinan Kaya wrote:

> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
> on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
> IOSF_MBI driver.

I still don't understand what's going on with dependencies here and
still don't have the cover letter or anything :( .  As far as I can tell
the above commit is in Linus' tree so I'd expect I can just apply it
directly but you were saying that this needs to go via some other tree
so I'm a bit confused as to what's going on here.

--GJ7e10BhKqIkML+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuAS8ACgkQJNaLcl1U
h9AfsAf/Y8iYvN5bwrUXaCdE6npcj44ip+VII6wzCtj/kkF12jE3fs038wm47Wy6
PMwMLgsThOPQ+xnpqR3kKGLVj3NPMXNPEQc88AKH628xL4CnQIlMDkZuTz3kQGBx
PWC3hm3SpPhqnJ4CMcAFMlkUr8pstJgYfYMrYU2lMKP6lcQnehULZH3CqNrVLCAP
RnDtVVM+7aG9Q9uSDCDHwyDHW6MGJSbu1Y1qneYBlAzDtRZLv70OPcKBUhOFp2Td
fV0+F8eu01xcu0OWEPsd6woapz5gWRrWjED4sZ//ORXC4z0S7C8AtquuVstD1pdq
XmOUm5jv+LM/UqCLQR9jFNkXD8XeyQ==
=2d4x
-----END PGP SIGNATURE-----

--GJ7e10BhKqIkML+d--
