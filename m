Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeCQUkL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:40:11 -0400
Received: from sauhun.de ([88.99.104.3]:38659 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbeCQUkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:40:09 -0400
Date: Sat, 17 Mar 2018 21:40:07 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Major code reorganization to make all i2c
 transfers working
Message-ID: <20180317204006.pxo6otdon7vxn7b2@ninjato>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wtzbosy3att6q5ac"
Content-Disposition: inline
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wtzbosy3att6q5ac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I trust the reviews of Andy and Sricharan for this series. From what I
looked at, the patches look good to me. Only one question left about
copyrights (raised seperately), but we are good to go I think.

Thanks for all the review!


--wtzbosy3att6q5ac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqtfSYACgkQFA3kzBSg
Kbaohg/+O9so7WGA5hDXg7pxkbHG5lpQryRhVAhySkBbf2HY9Dz6LRp9iMZHpd83
HRRCQs3pGJuiTeluQJjTeE2IexSDSJQr3jN9BL85x7IyhH5CTaQkAKT+2Jdhf63F
LEPsTR6KtFRh4ZtxvxqtrL+BdhIKAYj1TtNY8xYf5rKFtdQ6X2qFrcGd6jDD39O8
J7D/5El9L+jh7xcK4DwLlYTq01Ib8udu9QyAhgjO9bfXgjRjIT/glA3tv3VVoUE7
j+qr60aKW9/eIJkXKJDroqJBZaq8HsQyABMkqEOpRMjVaQVfuRKZW6aA5CscCyfi
bZ8/j6sBfeZe51tGsuJAddYIURwjcUtWDLhke13p9KMMi5BLLP+tepwnGm1LfScd
TngTIBBX9Z/V0LJ/QfXUJ5AX/20fofcOzl16yPi1Yd7IZBhZtFlAmIK9JvQkW5Hl
2lknLdeqjkqWASF6RzAukyIy6PI/Cr4UFFsILulzGGflXHpBsWKeteST3ovS2y+D
4Akxdm/FUk0njKyzl950eijnzAzNK4Ij698uilhIwi9mrulMCHck793jBqMfxScc
rPY++I4XZEhHColP7M6WU5KVKfx4MFPvbNZdi1SeH7fYqWApRbRptDgd4Kp6Vmej
P5ae85g63vEu/R1eNBcOwY7D56e98k6qtn9fGo+SgUFrXCgKCGE=
=pjBW
-----END PGP SIGNATURE-----

--wtzbosy3att6q5ac--
