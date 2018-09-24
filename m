Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2520C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCAB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCAB2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeIYDzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:55:37 -0400
Received: from sauhun.de ([88.99.104.3]:38716 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeIYDzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:55:36 -0400
Received: from localhost (i577B9B6D.versanet.de [87.123.155.109])
        by pokefinder.org (Postfix) with ESMTPSA id 87A522C0599;
        Mon, 24 Sep 2018 23:51:18 +0200 (CEST)
Date:   Mon, 24 Sep 2018 23:51:18 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jae.hyun.yoo@linux.intel.com, benh@kernel.crashing.org,
        joel@jms.id.au, andrew@aj.id.au, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] i2c: aspeed: fix invalid clock parameters for very
 large divisors
Message-ID: <20180924215118.GC18592@kunai>
References: <20180921233050.121570-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20180921233050.121570-1-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 04:30:50PM -0700, Brendan Higgins wrote:
> The function that computes clock parameters from divisors did not
> respect the maximum size of the bitfields that the parameters were
> written to. This fixes the bug.
>=20
> This bug can be reproduced with (and this fix verified with) the test
> at: https://kunit-review.googlesource.com/c/linux/+/1035/
>=20
> Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1035/
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!


--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlupXFYACgkQFA3kzBSg
KbahfhAAh0xJrb8oNN7zxZFdzS9tPQgQGhsLeTzyVuPQ/8ygfqC/nEu57R/tfjVs
yNV/q2mU0BiToaUUVjA84LydqRJyd67yLy9ltsh/DbQu9WK4904xTfTG607FRYHX
DUDO7rs2GAqdQbS7N6ivvvLIR0bwmoeY+fqZ1F7uchlxu9x8sukWJSGTKM1wX8z1
Lj3I5zb3KmHXa7B+v+CuutQCF0qRyTe4fT6JTBq2ILRxV/yvqNyOYc1BYqbOLHKO
dRSfoX8t75g9LuTqw7fBCerI3WOv29E/GTgc0Mqbc6Sob9puqao57xCpCW+Wy+tx
mlFU5U8S3SbieIOtoUcaDAs+QIVsqvpuOQdR+NTpujj+DljBYR+ogjqOexc8VKrq
Vo7n8qYdH8b8QHPW7piKd9cblF392FBfYir8zgq8eTx7clKP5mK3p5d3OFHSorAI
CJagkEB+IFhPslOtOjEz9mjiZ8H7kXX+FXPO3Nhdvv0zUXvDbqupAE6bMInrAO3A
NC4Q2PRx9X8MyjHZrCwyEErR25jugt+PJJTch/ygwGUQwNznQ8p+t9j0FxnpBUf4
KNjAgdg6Et3hEv8mxSf2dEF5j/1/WNUPO8COh8k2cBa+kJI2k9l81uAX0s9y/7Sz
lOCL+f9BMMXPvVmeXuxGZflK6JbZAh1XIEyaHriU/HanUAmz52w=
=dRZ3
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
