Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDRIVe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:21:34 -0400
Received: from sauhun.de ([88.99.104.3]:34766 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753097AbeDRIVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:21:32 -0400
Date: Wed, 18 Apr 2018 10:21:30 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Sam Hansen <hansens@google.com>
Cc: linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Documentation/i2c: sync docs with current state
 of i2c-tools
Message-ID: <20180418082130.5oqgy7xsja5qucov@ninjato>
References: <20180413174257.139182-1-hansens@google.com>
 <20180413174257.139182-2-hansens@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2uix42vfbp2u3fyn"
Content-Disposition: inline
In-Reply-To: <20180413174257.139182-2-hansens@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2uix42vfbp2u3fyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +The above functions are made available by linking against the libi2c library,
> +which is provided by the i2c-tools project.  See:
> +https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/.

In the beginning, we say that '#include <i2c/smbus.h>' is needed.
Shouldn't we mention i2c-tools there already and in what case it is
needed (only for SMBus)? I'd think so.

Sam, would you be open to do this as an incremental patch?


--2uix42vfbp2u3fyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrXAAoACgkQFA3kzBSg
KbZ/yg/+KCc2z1il/rqkOGxwBeDcTjX3PxWle+xEi5fNCYWfGDHXsmCx5M3khhej
f/EEkvROKdZD6KScYTqNXZibY+D8GwBCmBuxdSmyp/wEdfo/+KXwtWHQb+pHIR0f
+y3/5oym9O3TiBd8bc4h+8AGtqPjm06Gur9Io8Ejy4CQMNe/WL1pZVN5PvIJn9as
RheNO6F7Bot7Pj1VPfmjvwQpWBem8iMST7+gsAsBi3+PRzIC911jcWK/xBHVlOM/
SpnWfVN2D/50SwgebhlIsvLnH7eaRx5O8Ei5h8j01bCkJR+NHlOygQSjmhV3OFaE
c2bajtRV6aEkN0GHicp2GO2/R+PL6I3BTvti9/3RHb9TTK+cui1EfbchnKHG+JgN
A+F/abCtYmWwmNEeHUasbHqLXLqS6QUgrkb2FXPxOOcs6voF8XhATGHqVwYm9EOd
aGuLL+cdAOUGAENSUU9mhKMZZLBGLE9KF2yQE6noKuiWVjBP6PUFw3N3g4VOeaum
wMWsvl1QG2wFJv6BCUJd6UK9tPSx2ET57KKctpOXuSuTWmxtI6x5h/HIrSJpvKfJ
4dKvHrFDr60FcQHfcKErL5etXIIJ9ntdgU8MqQbWpV0++KqGU8StD10SJbQgWuFh
tJkz1OaC+co+fC36D0aAkcfgzL+l+SE3Mm/L8d7WUS8nPWbnZ+U=
=hrrX
-----END PGP SIGNATURE-----

--2uix42vfbp2u3fyn--
