Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8121720867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VaFSBj35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8121720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeICR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:26:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44638 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbeICR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E95ozkAkOehKkA79q1VOkuzvYjmojSNmEaSWjBS5Ois=; b=VaFSBj35bwA4SluzI9l7/DKxZ
        7NucMEGgtV6gy4ppvlExahcd/8dV5uERaXGc1DIkMW/+KQY7WRh76Gb2onmPkbRUWVVWHENeB2Lx7
        pt+QeMc92CnipxC+xxBBNIj2P2CgefW9JmreObwvr5Sm7K5+btxkM4oy0KTE0vDIqEeFE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fwoYE-0000F0-3E; Mon, 03 Sep 2018 13:05:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C801F11227AE; Mon,  3 Sep 2018 14:05:53 +0100 (BST)
Date:   Mon, 3 Sep 2018 14:05:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: tlv320aic31xx: Add headphone/headset detection
Message-ID: <20180903130553.GI10302@sirena.org.uk>
References: <20180831182434.14499-1-afd@ti.com>
 <20180831182434.14499-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline
In-Reply-To: <20180831182434.14499-3-afd@ti.com>
X-Cookie: Inside, I'm already SOBBING!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 01:24:33PM -0500, Andrew F. Davis wrote:
> This device can detect the insertion/removal of headphones and headsets.
> Enable reporting this status by enabling this interrupt and forwarding
> this to upper-layers if a jack has been defined.

This and patch 4 look good but depend on patch 2.

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNMbEACgkQJNaLcl1U
h9Bn4Af9GCP34IPojd6vGbAnJwmLh+ZQPaV2FLWfktnKpgRjnaOt9htE4EPORNTT
C4DZgExwbnPkK7lF5J432p9mEgzRavyCVxMYjH/9adblUT52rJ53Nze7MzX3Qbyy
aCOriYQQ00Jf9LBHHtlo88GHR0BfIoZleadWAeD266UbSkE1nqvauk8Qc3uthM0G
h0tba70v0E/5Bpbo69GrGO+F90b0mWniYdjPUGn5otseO44GIHRwSDqVsHnPcuM3
jlcScmT8jFHVLwyi4UjmygZtnl3Jwow0TzkSaW/UWfTISSf5+Lur8pH3PlaoQ0Cg
O4/YwYAV3oXqscczA6cd8BTDbPHsog==
=+x1n
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--
