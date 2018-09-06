Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C698FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B2C20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B2C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbeIFWpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:45:20 -0400
Received: from sauhun.de ([88.99.104.3]:47900 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeIFWpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:45:20 -0400
Received: from localhost (i577A6E95.versanet.de [87.122.110.149])
        by pokefinder.org (Postfix) with ESMTPSA id E697A2C058F;
        Thu,  6 Sep 2018 20:08:39 +0200 (CEST)
Date:   Thu, 6 Sep 2018 20:08:37 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
Message-ID: <20180906180837.GA8607@kunai>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g46fRrYW8E8FsPB=5fWSGxemgc4ENc4D2fT7yBfH6p4ERg@mail.gmail.com>
 <eab56d58-0703-d201-dc9a-f9fd257e96cf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <eab56d58-0703-d201-dc9a-f9fd257e96cf@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Looks awesome! Thanks!
> >=20
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >=20
>=20
> Thanks a lot for your review Brendan!

Please don't quote the whole message. Everyone else has to scroll down
a lot to find the relevant information. Thanks!


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluRbSEACgkQFA3kzBSg
Kbbkfg/9HrorkqAdlIbkynR938MGcOFlN13CAr2gRHmQHJMx/9fJDYj6ycLklFzb
U+n1QiKIMiyVIBvuIkqQn9wGFu0tITOoN1dGDruHn5gc9QxHNmb7VLsPN2/EeJXf
01bQ/j7btHubwXVM58tcdRVlmXyBRVgRgA87IWH/Uc+s/TarRcj3kDmgyRQ5o9Vf
D+JuguURS5SrfH3pJzFRO/Dr3gilORnK/SapmNRqrvvhDdSgLNHdpwfC+ZFJmOsC
B1JEgxXKUke9G+Fi9fIdGH2ZKmtgKRWvkrKVwwPko3TVjMNf/s8ep4Oh6q7oTy6/
x1qD8No+MDHcIPJ/y8ca+1T9Wcmsc3kNpk6PE64DorCL68iNtoru7xkM/dhFvnLe
Fmr6lYTmOBlCX/xCd8h8tvXvVzDJIbcdZdKXRAaJFPIbVa00ySIUhHup87QyJLQw
aE9h+Urin6qbMtxkiwYLs6RbP6p5bXRX6t4ENudZb8UQz4QgWioSqZqZjBfmci4/
vjEkGxzzE3W8DIUxsET+Tdt/qPNwGOtyj/fQzz4leD6o0tw+gy1uE3eN+IDIkbuo
bufG9nmpQF6zZBPC9+lC9Sf0ewRILPMZ+BDjZhtts3rQa6MKStRLgE9/W2PR4zNa
jUFY5ioJnDp78Dm8jafFT+5aVh4/rUa5Bqp1DaLsdOQd0M0v4kw=
=iVNz
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
