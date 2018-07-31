Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04009C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C47208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ozC7+99G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C47208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeGaLnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:43:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731578AbeGaLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3n3lqb3S5tpcoiMDJ4v6GeigGVR5MzvU19BNV0jK1aw=; b=ozC7+99GIDS6TrAWAmwvFLp+Z
        7SUdJXLL0e0mlkO81oB7vb5YAAe/Nw9F+2QEpYt0pLhXa/4KrgXQ+YYdI8JwMkc+hur5hYf0A7rh0
        He1NBLn9bDlZ2yNhbsyAxjYeFOvAKEuO38q9ND5uyieuBy5ejrLS6pQGDhczjbMwyttRk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkRUp-0006tQ-TX; Tue, 31 Jul 2018 10:03:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7A6A91124227; Tue, 31 Jul 2018 11:03:15 +0100 (BST)
Date:   Tue, 31 Jul 2018 11:03:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Alexander.Deucher@amd.com,
        djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Message-ID: <20180731100315.GA5719@sirena.org.uk>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de>
 <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <s5hwotc0y6v.wl-tiwai@suse.de>
X-Cookie: Save the bales!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 07:30:16AM +0200, Takashi Iwai wrote:

> OTOH, if the CPU dai can really provide a dynamic value that is
> strictly tied with pointer, CPU dai itself should provide the pointer
> callback that covers both the pointer and the base delay, and it
> should be used instead of component pointer callback.

Probably anything in the SoC would be potentially able to get a dynamic
value out - the main issue for off SoC devices is the cost of getting to
the data but that's not an issue when you're memory mapped.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgM+AACgkQJNaLcl1U
h9DIFAf+Iq4OJr53hDh+Gkgyws3gyviprKD6tvTQmBGujYIymIGGdQ0MxxRG2rGN
eKs9uHn/8fUVsQbwBIKa6oOgvRpaNLcVZ7KCD9RbHAv6nmcsOOdNXFgnP/Wki2lP
xB0g+TCwZwOt2NC6kPyDInk7CP4Pt1pNJbD9efRnJl2XvlaCTSFCWgXdUnQ9VRT7
6SkIYTMbj4ZwKZn3WhV5AS65JIF+JRc3T+d+nX/WLOztXurwqIeMjLdiIkXei7cn
yNxFgB5TZ8kpXPgrLdAHZjz3NUruixK6iscFbJxuXiw/FSyl5iysbeK5zM7plHuP
7gIPXBgphQhcYA80WBDOZ0QArh6jlw==
=fPkA
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
