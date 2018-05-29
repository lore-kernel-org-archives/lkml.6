Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967630AbeE2WMQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:12:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36730 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966322AbeE2WMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:12:12 -0400
X-Google-Smtp-Source: ADUXVKKC+zO4evRtAaozYi2Zqbi1W16FAFUwdw1MD/AT5hpYsd0AEXhmvq5zC5ibQCGN0BPSAWPLnA==
Date: Tue, 29 May 2018 15:12:08 -0700
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>,
        Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: chromeos_laptop: fix touchpad button
 mapping on Celes
Message-ID: <20180529221208.GA64318@decatoncale.mtv.corp.google.com>
References: <20180529190659.GA261828@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20180529190659.GA261828@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry, Hi Sultan,

On Tue, May 29, 2018 at 12:06:59PM -0700, Dmitry Torokhov wrote:
> Celes has newer touch controller (compared to the controllers used in
> older BayTrail-based devices) and so uses the same button mapping as
> Samus.
>=20
> This fixes the issue with mouse button being stuck in pressed state
> after the first click.
>=20
> Reported-by: Sultan Alsawaf <sultanxda@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied for v4.18. Thanks.

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsN0DgACgkQHwn1ewov
5liTKw/+NP2EGFxOadGEdKiXtaDBqPoKrVFY5JGQBOT9S+QdnzHJmavUF69owng1
U7Z/VWm8Ad4dnmhgn4NpkDGflZRu2JwHsthMLNcCUs9reOJqdmWrr2u0aj0RLnVz
et4Ud3JAk7ENO88jbAGl/eknsJrV0xMMmoARdypfYyp7/b2hMkWpXWI2YB8w8hJu
OS+ZoRuYoAOVxBDF9oczoyFh7RTIQJi3iPIhAuvMYgC+ZLXmAtA2Q1KF4iuHK1bO
Eu2Pvo0sSqCWUpWlpcg2I2PntjTsAeH0AbYBs52N+KVkiJzqsdrMbnBT20n+NPFb
+6ukPJshgU+/ysBU8g/APTRFwvbhB0jSh2obnBXFCI4g7PqYPLUDEQsq4vltcIJR
76YCqlkKne8/B71QJRpfR9FwBMVLjvQJh953v22F8bdH4VyC0lsx2CHEqHI/J3Oz
MNbO0JYaqd3V9M9fsmQbwybq0kLhI4t8TsxLQ/eE87XsaJz4R0sMWM159wAT2hxS
gaJHyKBgf6QNUQY1LMLWatm919JoC+YzecAda47QcgkYBkcIyV8iiyhgUxd2nJ5D
6OY3Q+ZijniTsGp6hYPNdcKzJ5Qq9tf16qjJigtoj+F6rOo4fTPkxp1hTToYMKrH
SVJUK7bEWLKVRmv22pdhgqZGHBuAeJkISIJgKsr9NLhboCO06yg=
=rOHP
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
