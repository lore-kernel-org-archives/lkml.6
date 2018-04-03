Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDCOuB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:50:01 -0400
Received: from sauhun.de ([88.99.104.3]:42952 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeDCOuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:50:00 -0400
Date: Tue, 3 Apr 2018 16:49:59 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/6] drivers/i2c: Update i2c_trace_msg static key to
 modern api
Message-ID: <20180403144958.53nxpu45seq22z7e@ninjato>
References: <20180326210929.5244-1-dave@stgolabs.net>
 <20180326210929.5244-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tx6ouxo62eifwm54"
Content-Disposition: inline
In-Reply-To: <20180326210929.5244-2-dave@stgolabs.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tx6ouxo62eifwm54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 02:09:24PM -0700, Davidlohr Bueso wrote:
> No changes in refcount semantics -- key init is false; replace
>=20
> static_key_slow_inc|dec   with   static_branch_inc|dec
> static_key_false          with   static_branch_unlikely
>=20
> Added a '_key' suffix to i2c_trace_msg, for better self
> documentation.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Applied to for-next, thanks!


--tx6ouxo62eifwm54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrDlJYACgkQFA3kzBSg
KbbqPg/+I9BgaAylKMmEtze2Qd6wWvMDirY2VYKQerX6f8r9zgBGWafkoHWEO2fo
wGX8dalEpdgBT+QR3SQnzeefS/XSbzMrAyAh26ptdLDXO9Hz1ig8lPpptVqesg4r
lHWwv7p9ESluueXc0Z+OzqCCt1O+urzMPs/idIt1tWJKDRX3CJM2i53c4ryC6nCj
1rdcokRbou6s9igBzuDy2tq96KRJ6m3hsJQs6bD8caheI9FWrLNBdjb+8nW/tu8V
xI/IFcZ77M4CDlp+P5BdkVLlzrF5HMd0MU8H4S1G3aOmZ48AGLCKOvJW20hODOH5
7z1+MFuwFZ1nm0yNhrFmfbOvDBFnReCAL3A2d4xHlycyVR6JJZBcG34zSRVREdeq
SjgsPAktqP7oF6VOg1u0xH0J2DJx7xM+sJ8Pk1t+2kexUqWu8PHjpUpSmJIVVQeZ
4kA5wxTQLiCHC2VeD1DN4Yd+r8yEa1JxLCFs4KBzvAsHr78BSWWbJAC0bgGKXQle
svF2o3/ywuzKshn+jdxmIaDvcY2N5OPi7PWitdaXzlvCgCOrJh7Noe7hKh7ULXoi
t+l4lsc3NzkceN6/KaZ4WR2P3u2Foch9akHvMw8R9B0lExFxiZ6G3lFu3Ck7leJ8
NiAUXcGrPTWndfdFQhR3wLB50um9cYziyHg1+5h9vurvN+5GK9o=
=lapX
-----END PGP SIGNATURE-----

--tx6ouxo62eifwm54--
