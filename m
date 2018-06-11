Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XU8iCI5XHlsafgAAmS7hNA
	; Mon, 11 Jun 2018 11:10:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6593D607BB; Mon, 11 Jun 2018 11:10:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="p4UdE05R"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EEE70601C3;
	Mon, 11 Jun 2018 11:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEE70601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932870AbeFKLK2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:10:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42228 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbeFKLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gZm3mqNc58taL0dgEBK5RNHFrDRxBA+HxgfbWiATwoY=; b=p4UdE05RQEisHND0k64UXxlCr
        nikokFd6L+wFKvcKg9Xbw3LJptwyrUhqmjseYXC8JBlYKnzLc2FfS03qhFB2GW4kgy+p+nQtD7Jas
        Lcig/J+GmDqpYPJ+qb+es29+KCxY1aMgBn/mtqnbW70Szfe59O04wHdKsKHHf+nxmB2Y4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fSKiC-0000s5-0i; Mon, 11 Jun 2018 11:10:12 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fSKiB-00043K-68; Mon, 11 Jun 2018 12:10:11 +0100
Date: Mon, 11 Jun 2018 12:10:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com
Subject: Re: handling voice calls in ALSA soc (on Droid 4)
Message-ID: <20180611111011.GA11580@sirena.org.uk>
References: <20180611102529.GA1272@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20180611102529.GA1272@amd>
X-Cookie: Sell by date stamped on bottom.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2018 at 12:25:30PM +0200, Pavel Machek wrote:

> ...and also. What is right interface for this? Mixer component that
> says if voice call is active or not?

Your modem should be represented as a component in the system and have
an input and an output representing the input and output on the cell
network.  See speyside for an example of how this can look in software
though there's a bunch of different ways modems can appear so you might
not have a fully digital link like that.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlseWI4ACgkQJNaLcl1U
h9DhpAf7BS15OOmveIfPROJ0s61oMffmjz/tM8L1Cn14P8bhfHE4ieEH1l2RDkny
sAviJ40O8vTn9XzuXyUSxj3JX8RD/0QsADPd1+X6w4Kgl8/l9Un6DlWBpLS2ro+t
Ny5QKkIX32NhyrqtRTxdfz4sif3IDOE9DYJ6AwbSyjhOUO6gUEq/uudv5A1KfOFt
DqumXqGRKVN5razt3lTFlel14NEzfdTVbDx4SJmXQz3zHgengRji6pYEdVvq5UqU
VXNE8SKSs2UlANWWtzRo8/8ShHZO0ySgkh7Dxne8TmD74zXwPy71DeVq20qcQrYU
k+/XWyFrbB9KnoHivTTFgjBdqnWgIw==
=dtGy
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
