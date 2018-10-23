Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DF22080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="GEBH4INc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DF22080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeJWSKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:10:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35500 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EhzxdcAZFJ7nWQ+uXqE1x5otOvMloKZJQtAYKMo792M=; b=GEBH4INcBQSt237S4l/ujhCQy
        6IHJxaVYAZHae/ugvGr2KoAuDyS6vA4R4jswXCiDkw1PT0aiVlz0sLgK+j3jo82bsGdZxf6jhy2su
        crpJxnjW2u+qRk+M0ENg1xyXBfiPR9FI2Ir5/+WPs8oE97VxcwO7s2/CccWv1dneIkKWA=;
Received: from [185.7.230.215] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEtI6-0007P7-Kj; Tue, 23 Oct 2018 09:47:58 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0DD59440078; Tue, 23 Oct 2018 11:47:58 +0200 (CEST)
Date:   Tue, 23 Oct 2018 10:47:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181023094757.GI2103@sirena.org.uk>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <20181023111738.7f50e2bd@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TA4f0niHM6tHt3xR"
Content-Disposition: inline
In-Reply-To: <20181023111738.7f50e2bd@bbrezillon>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TA4f0niHM6tHt3xR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 23, 2018 at 11:17:38AM +0200, Boris Brezillon wrote:

> sent in-reply to the original email or in a separate email. I know Mark
> (Brown) has it automated in some way, not sure if it's through patchwork
> or if he's using a custom tool, and I'm also not sure it works for pull
> requests.

My tool works only for commits, Greg's appears to have a similar
limiation to mine as well.

--TA4f0niHM6tHt3xR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvO7k0ACgkQJNaLcl1U
h9DXAAf/cG7R/A0bWxFTOW/i5K1YrCjoJ8dOE0TG/wIqUMxeLfFRxWdK6g24mCZb
+pKgifwZjKbXmu9fSnZCSAUeR8ohvXqpH/6ZynDYKfuyAiILfVOB4dspzhCl5Ure
Zu+8jmQ2pbwqYW9INEmhq2u+d6O82tuThh9mrpiWIeKjvTX8IumGDuOZA5gOi+Oq
FyZPGg1TkVmfuWsgqaX8clMNFl7hiRJ8nxzfDL9YiGlmiJEdiQtdL+CMktj3/760
Ul7TsTfaIL1GVYMRp5Y38y8Nx2HWHoYcJOHx6zqZvrAWiQAxGK6JXbwC9OVJN0h1
sKbxvyfOY6LNXlbL9CyidzoUesJkOw==
=Soz7
-----END PGP SIGNATURE-----

--TA4f0niHM6tHt3xR--
