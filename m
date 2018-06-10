Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bYMYEfG5HFvzTwAAmS7hNA
	; Sun, 10 Jun 2018 05:41:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B2D9660795; Sun, 10 Jun 2018 05:41:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm/iPG8m"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4109E601C3;
	Sun, 10 Jun 2018 05:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4109E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbeFJFlE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbeFJFlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:41:02 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E752087E;
        Sun, 10 Jun 2018 05:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528609261;
        bh=3A4YrEvYXHErtJzeYN+QgVqeTqUtnebgHad6TOyjK/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pm/iPG8mFZvbT273ELo/nxZA8SkG58pdzR5bC3hDEBaCam4p7VhgFXRFtR0nv9Odk
         B/PA9+/YMbJW+7v9pFH2JfuIb7VD3nYKrLMy72d7B0glXPQ5csrIBvXzjxrskmtsEc
         42BdnlWq5PAqc5Qz/DMgxeOWfEha3K3bKDw3aJII=
Date: Sun, 10 Jun 2018 08:40:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Please add mlx5-next tree
Message-ID: <20180610054058.GF12407@mtr-leonro.mtl.com>
References: <20180606192500.GZ2958@mtr-leonro.mtl.com>
 <20180608161945.66f4628f@xeon-e3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20180608161945.66f4628f@xeon-e3>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 08, 2018 at 04:19:45PM -0700, Stephen Hemminger wrote:
> On Wed, 6 Jun 2018 22:25:00 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
>
> > Hi Stephen,
> >
> > Can you please add the branch "mlx5-next" from the following tree to the
> > linux-next integration tree?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/
> >
> > The mlx5-next branch is used to send shared pull requests to both netdev
> > and RDMA subsystems and it is worth to have linux-next coverage on it
> > before.
> >
> > Thanks
>
> I would hope all network drivers keep getting review in netdev.
> Don't want a path to upstream that bypasses review.

Me too, this branch/tree is intended for patches AFTER they passed review
in netdev and/or RDMA.

Thanks

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbHLnqAAoJEORje4g2clin8/8QAKUJvH4vO+AGkBQtJOMKp3qL
aLMROb24crqJIUGLmxBtI/K/4xD8V0aDByDEnxhrLrSvO9VYi8yVrO8/c4cDyU+h
CCeQBXRJdIBnwm5RLa4B0rbfMdzfoDJ+2EIIID24DPTHh5U15zhplffCbSm7e0YW
igtpCficxuHwIziVA4LVKvf7QNzGrZhohY9dSu8O6k9AhYCRavAZfei5FMZZHaj5
VjMeMsUN5DWfsSaaILg7lx0nKGl93EMsT4UJDoflD5mrmUxYL7SISUam6uuIzU/m
u5I71S9BGueEwjBE0PmbgK8ezimz6147aCHwH+Ggl6VCi8VdvKCr8sCwbG7JpPnj
SPXolW/QoxxdnHwE31A+X2pUHIaYA7iRUIWubYZSxdY5yn3Kb1YBAs7a7yQsMJIc
A5RoZiyVPj8eDmSijjku+onk3g1znnyWRmCHjCoz7WZhGYsEUKeVFwjtVXqcuD/E
rTksMlmi8Pp8RSvTRxPyHyjRtOVX//6Gf0G3/8vuJilSIl/+uvuaUwoEclWArSmI
qO9YsNJnC9drMNTMped7waCGy+sjM70xDPP3TTq4whOzNHb70edUqGYmSFITg3bj
lgRphZ1ucw423v1BleFWwINBcVUi6Mggl8gTH5Aij5PDIkHBvHheTp5AeuSlym8y
zUwwipFuOM/CFEHOExcD
=BKie
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
