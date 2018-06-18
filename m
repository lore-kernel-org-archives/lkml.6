Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC26C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0550220852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V8cNSqDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0550220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935920AbeFRLG5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:06:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40360 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933895AbeFRLGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ij+s0KXV8LUpB/YEIXez1WGvqoDnpchCX5g49dQgF0g=; b=V8cNSqDjEDxvd/S+7Hl4femlQ
        4oah/lE7+PisWdCgkKMt3GEh7guwQzoilFz9GIQGfgSu02Z+Ao5UlCldvp9OpoNHwvzrR1CBgNzUM
        qp/p+vDUE7qqpzJ+tP2919SjLVKBQC36Mei9wt7mZD2g+p2RIKcyaxOKTxHN8mLxbm7G0=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUrze-0007uY-N6; Mon, 18 Jun 2018 11:06:42 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUrze-0005jW-3N; Mon, 18 Jun 2018 12:06:42 +0100
Date:   Mon, 18 Jun 2018 12:06:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     andy.gross@linaro.org, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Message-ID: <20180618110642.GA6928@sirena.org.uk>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20180614111138.8923-6-niklas.cassel@linaro.org>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 14, 2018 at 01:11:36PM +0200, Niklas Cassel wrote:
> of_platform_device_destroy is only defined when building
> with CONFIG_OF=y. Add a depends on OF.

Is it sensible that of_platform_device_destroy() is only defined when
building with CONFIG_OF=y?

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsnkj4ACgkQJNaLcl1U
h9AVVwf/VkuPxov3tJzTawHKXw0n000NRSxme0b13/p1sM5sEOLHLsj+tCaYPfy/
TsY0kHTJ6NDmr9YRm/vFbDRxUc19/6LAH021VsFrg3kz0mH/fNgifFfbYxoIjCCf
2YyW5Ei1SLVFARQIN9BiphjwsZL6i/aEKlg7Q7b95OjVnA2/E/fh3ZGMhrUQ17t/
HhCaw1EQ9yqhefxtCD8meRFZbrYrIT2tWIxZuXA/cBQplR8HIOu9NcUD7Pz+rJcO
b1bwNTAEDfG8KSOZTTcTuASrumJLze1gOi6RVoQlSidG30ya3regKB4sJ0VndECL
+JUXsvVr/HCOHFsS+rYWIzV0rWtpFA==
=ATMi
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
