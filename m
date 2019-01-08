Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1F5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAE521019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546961610;
	bh=xAoDdHr/2WsnlX+3YCEtl8ZnDkOpUboaCAyqQXgf+Uc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=lCFR8biooOWkMi6ppMnlMPf7CBZ1jKn/7e4YXytxqQo8ANLzqsEyx3MlQ9VrlFLb3
	 I1E6T6k8yQUO/o/j7MrsS81CUprN7wA8CgYXufkBOdCDMuXluEll0a1cc2IFZZcv7V
	 qio8fL+IpNYKXyb8wmS1JajMbOds5QVCXgI4DrOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfAHPda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:33:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53964 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfAHPd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ru5TQwtYVLIwXFT7sJTk9YSTYwYOzo6v/mLEKPfBYuw=; b=t0Le/RMLkVK3CUn7lygPmT+GB
        RmNmxAzHJvRqpyHxPiRlr4kptheR6Jf9B8uEb47YzQwQWxTgE5U3qLedg9E6AkS70D/5tmip0VUWs
        BMFZOQ2V2xzf1G0YHjX40xU9D/8wrV31wJ54u3BFr7X6giwBIdJpgTRqk3ySkHFGpnqRs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggtNR-0003Gh-4E; Tue, 08 Jan 2019 15:33:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8830A112778C; Tue,  8 Jan 2019 15:33:12 +0000 (GMT)
Date:   Tue, 8 Jan 2019 15:33:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Reichl <hias@horus.com>,
        Jon Hunter <jonathanh@nvidia.com>, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name
 vs. of_node assignement
Message-ID: <20190108153312.GE6590@sirena.org.uk>
References: <20181018111829.27056-1-marcel@ziswiler.com>
 <20181018111829.27056-4-marcel@ziswiler.com>
 <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
 <20181021112301.GC8554@sirena.org.uk>
 <20181218174040.k7u26vnnoplllnwb@camel2.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20181218174040.k7u26vnnoplllnwb@camel2.lan>
X-Cookie: You look tired.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 18, 2018 at 06:40:40PM +0100, Matthias Reichl wrote:
> On Sun, Oct 21, 2018 at 12:23:01PM +0100, Mark Brown wrote:
> > On Fri, Oct 19, 2018 at 11:22:46AM +0100, Jon Hunter wrote:

> > Indeed, this is a bit of a mess.  We probably shouldn't be modifying the
> > data that the drivers passed in, otherwise we get into trouble like
> > this.   That suggests that we should copy the data, probably all of it.
> > I will try to have a proper look at this next week.

> did you find the time to look into this?

No, the end of the year turned out to be really busy unfortunately.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw0wrcACgkQJNaLcl1U
h9B/2Qf+KYOyXhgkAUL6esq2OqmG/7tg94X4kIe8O7y9KJ0okLelfakouR0JGiuY
CKBUVkzfHLzKtX0qdTayVq9LfVqiISnO1jtkcjYmoxnOvKuINo/KtfNHmpJb0ZYb
sKP2rNx6++b7EsEBtaB1RmKk0IpjkJBsTYU0aSFpFPwbW7e9usRBmHxXGup0CKm2
XKoicn805BXwRzKtREilYua/5hHNiUGvrPo4jSRhiNUn13C40IrQELv5kj8txEO5
ZgnL4P0QNFc5MheXtbGhFB1x/5g9iCYxM4v6udIP5XRV/nFCX2qX3AjdAEaplOJf
M1mSFzv76wn5VwPKnULRpOPggVNH7A==
=SDSH
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
