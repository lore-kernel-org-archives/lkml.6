Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFBFC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C141208A6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 08:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za3+SAjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C141208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeGHIG5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 04:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752901AbeGHIGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 04:06:55 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B62208A6;
        Sun,  8 Jul 2018 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531037215;
        bh=iXj53nMC4pkkHdyZ/rKtOe+NNQ62GBn8bP2koH0oU/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Za3+SAjSw2f2dcdj6cBsM2gVy2QzubZIq0Q8UQf61HMqi7qsiyHQ9jaSB9DuJX4kv
         B0hthWjLZwLQ5cCEzpYt/RDIy3LybjJhlwkPkMvLTEtFh4/44fo39NqOuImOlSD0yr
         7+k/Ute8QhAcUPpNUYFjo26AFJCcKbA7jIAo4Pck=
Date:   Sun, 8 Jul 2018 11:06:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     keescook@chromium.org, saeedm@mellanox.com, tariqt@mellanox.com,
        vadimp@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Use 2-factor allocator calls
Message-ID: <20180708080652.GN3014@mtr-leonro.mtl.com>
References: <20180704172847.GA33621@beast>
 <20180707.201553.20530216509400327.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RHnfto7yGd+QdmRl"
Content-Disposition: inline
In-Reply-To: <20180707.201553.20530216509400327.davem@davemloft.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RHnfto7yGd+QdmRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 07, 2018 at 08:15:53PM +0900, David Miller wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Wed, 4 Jul 2018 10:28:47 -0700
>
> > This restores the use of 2-factor allocation helpers that were already
> > fixed treewide. Please do not use open-coded multiplication; prefer,
> > instead, using 2-factor allocation helpers.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Saeed and co., please review.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

--RHnfto7yGd+QdmRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbQcYbAAoJEORje4g2clinHAIP/jpUDBtmsf39DP9gZNaMh58z
lbdtegfKAKl8pQc6G9uLb5MOoSjdjtMC/FJ3khYacziAmwj9fyp3N3nR+IptL5LY
hi/4HMB7XNz/rza6aSP6+RaCp8ntiFr38i1TFB1vHL3F6VD7OGGIG8zTfQkb8NwB
Ebn7BZ+cLR4EfMHq6BjYWA8fhR+lLtB5qD/jyS0oBqHEok8h7TqejbMqbw98nkg4
eousgOoP581XNGl8sxVsec3rQA7EVqg4lxSdBd3HSWxNKINRVtwHpXC73HKhHCUs
BTDwPfFdMNWM9KxgYFSSPCGxU2ag+kJFoaCjyCuaSISJgXpF+ZDsHHL7U5Q2EhYA
kU0AVllKF/xEm00CEWYcqQUKsRhg5vMFmC650td/pvQUesYVaLt5uuwPSkqDzY1r
vJn4JxwTez2irmuuXa10RPu+SvTOyJkgxkUsOb8Yx/UKZhi3LC3YRnMcFzVqzfRI
04rhYQwA+MDhImBk5eO25QnSVgh7TNz3kROTvjglwXn4xJREn5i0XQfN/RlyeALb
feJc8p7T1K+Jn0t9V6bxwut9F5kJ6qrkXX5HOG+rfyCSgLo3ME6xVgYLChN5kNU9
I0uQBETcIGzJVE3MgcQBhcp7zF4a4KUUBMFICsu0my8kYU3KRQevNBZZSOEGnqTa
DbsbXHkU09WbXsHhdnUx
=fj7O
-----END PGP SIGNATURE-----

--RHnfto7yGd+QdmRl--
