Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6083C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38F321871
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546278459;
	bh=9PAS8a50+WTBWvP+ZqfK+74XfCT7gf2g8G1i6SAxUEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jo3lVKyT7mHYEbpj3AREoXfO13nVRYku4tB5301/hMjtO6a5xoTf6NBI6sMX/hFuR
	 Sn2Beq66qXQKGkv8TNmjvv0AWxrMPX5cpb40vPf+kU6zLrDR46UrU96m5iR2uSmyBd
	 X+TIN+g/aYFpT/Pi8C5wX+F1JclVf0BVr+VDRKDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeLaRrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:47:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52160 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeLaRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 12:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9PAS8a50+WTBWvP+ZqfK+74XfCT7gf2g8G1i6SAxUEY=; b=ro4qfKsIdATKtB3B1vFFrDgDw
        LBkbv/LLdSD6XMqi109SO+fpvNBdwAnz6rdpWvAFRYVldGH/DCJB8xUm9/FIkYRKzKRcK10a7Cm9g
        wsresYyy/s4VOmDdNxBtIkk6DvOephICB6BFE7RvCt8rI2HcUjRZzpriXT63LAw7fZ+gI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ge1eR-0002NG-Mo; Mon, 31 Dec 2018 17:46:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4F8D7440080; Mon, 31 Dec 2018 17:46:54 +0000 (GMT)
Date:   Mon, 31 Dec 2018 17:46:54 +0000
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
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Message-ID: <20181231174654.GH1846@sirena.org.uk>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-9-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline
In-Reply-To: <20181230195612.6657-9-okaya@kernel.org>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 30, 2018 at 07:56:09PM +0000, Sinan Kaya wrote:
> Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> CONFIG_PCI set but this is not specified anywhere.

I don't have the cover letter or anything for this series, what's going
on with dependencies?

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqVgsACgkQJNaLcl1U
h9DK0Qf5AdiTvdsqlkSq4ADpfxzrhXV9yrPpE9JaSk42vEizr7qzwrid+GFrVbLv
7xnKpMDE8DAdWxtRf9UAqj+G3iuj5jU8fGbCeVbYrCxpgZdsJA7YWixJq3XlZ6Iw
3Hvtscbn2u6N656P4L2fYcIpgFVHvMU3MdVVqs9LO3YknHVV+8j9/i8XKc5/KYx4
y2yCc5BHiniwsLMeupbyii3HHrAHw4FMGlgeqLqVT9558m3Vj3hwoWhvI/emG8uV
XhFI4OoiPPDtQlF5SU+fUKOnSjUF3vLNubC6peKLu8euzsC0kn5nNa9wtbDzoQ1c
N4Tkr2/CS/k/IOD8QLNbkHGjXzuj0w==
=9M9Q
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
