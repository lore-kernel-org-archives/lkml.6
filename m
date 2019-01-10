Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A20214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547138924;
	bh=q4Z1/qPAcgxWo65ZNUG7tkoGELW41wK6ipyiw6GPM+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gkPKxB29i4DFm/eqsl/V/rOCLSBLhaoWD2gEVWJHHcgrqeYEi0snWPUfPqyaaifI6
	 mhSGX3cDcCb+G7KuXewf29fqC6xWVQnrNRI5Ak4/UcdTCBvpydMpTupKIpcZ7xD6Mj
	 dt+KztRWu5nfNBq0iuTIT4Cy5Uvjbhe8w0fIDTzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfAJQsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:48:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46348 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfAJQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uRdLaqjjbXHA/yvav4mqIO5NqcHMTevImX7e6HKVwAM=; b=SEBKbNv5jmHCdl421iL/E2NJx
        Vsc2fwubTloZWinZDEQ6NDJsDN5NJLtCCQkJ2pd5fSRQEgPCBsp67BTn0neA0JBE8BdVUPSmqNprj
        FiZUeZ27EAKccUVgEQ+8Yd0fvunmFkehoLeAgAIDBpjc18cFOKd0w3M9oplVhIP0OkdGA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghdVT-0003sh-HU; Thu, 10 Jan 2019 16:48:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2383611271D2; Thu, 10 Jan 2019 16:48:35 +0000 (GMT)
Date:   Thu, 10 Jan 2019 16:48:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Marcel Ziswiler <marcel@ziswiler.com>,
        Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH] ASoC: core: Fix deferral of machine drivers
Message-ID: <20190110164835.GF9541@sirena.org.uk>
References: <1546968494-22993-1-git-send-email-jonathanh@nvidia.com>
 <20190109183605.GH10405@sirena.org.uk>
 <44a64e6e-c9ec-8eba-60fe-eda092250d82@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <44a64e6e-c9ec-8eba-60fe-eda092250d82@nvidia.com>
X-Cookie: One planet is all you get.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 12:13:36PM +0000, Jon Hunter wrote:
> On 09/01/2019 18:36, Mark Brown wrote:
> > On Tue, Jan 08, 2019 at 05:28:14PM +0000, Jon Hunter wrote:

> >> -	struct snd_soc_dai_link_component *platform;
> >> +	struct snd_soc_dai_link_component platform;

> > This breaks the build for the SCU cards (and we needs a little rebase
> > against another fix I just merged, though I did do that when applying).

> Sorry I still don't see the build break, can you point me to it?

I'd need to find your patch again and fix the rebase issue.  It was
assigning a pointer to a platform IIRC.

> > I do think that this is going to be the safest thing to do for v5.0, it
> > can always be reverted later on when it's not needed but it seems clear
> > that a better fix is going to be way too invasive for the -rcs.  Can you
> > respin and retest please?

> Yes will do. I do wonder if we should be concerned about
> snd_soc_init_multicodec() as well? Looks like it could have a different
> problem if a machine driver already allocated the memory for the codec
> link component.

Since you appear to be volunteering to check...  :)

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw3d2IACgkQJNaLcl1U
h9DRIQf+JTa0QWwNeGiaDov8b+Xc2LfAdLSzSdsprCtEif+8ZOdmk6Dym2bn702m
d57+QjxRH0ikzJAaEe6UEG+P0yt6SfL8Iu6mDeRskf8KXAbYWIhDUSWPumWoveq0
aYsYTFlh7Uz7+7KHLT/5lm9JQgEohzdRi1+29QG2vnDSzG3rhRRQZqOYABUyS9lE
mhTPyS+fmMU2JPonl+zSdBd6U+kE5BjaymUIiWaOiSYM5Pwa/mAQdSQOqpQoj9K6
sX7agMcf9Z7KyzffLIlCaaPtlInBLu6zCToqcOv+ZJozVgqpxkMhgHdyAlE/cP4N
FPZvOxU2RBOCDT6pWvIvcjN4klOQQQ==
=8T4V
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
