Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeCIJwu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:52:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750909AbeCIJws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:52:48 -0500
Date: Fri, 9 Mar 2018 09:52:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: vhost: vsock: fixed a brace coding style issue
Message-ID: <20180309095242.GA9668@stefanha-x1.localdomain>
References: <20180309025603.4890-1-vaibhavmurkute88@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20180309025603.4890-1-vaibhavmurkute88@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 08:26:03AM +0530, Vaibhav Murkute wrote:
> Fixed a coding style issue.
>=20
> Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
> ---
>  drivers/vhost/vsock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaollqAAoJEJykq7OBq3PIAy4H/0UVPxwyMBl7mtMlWj2JAstn
oxPazPiWs5e0X3seQR45te0T5Q0v8NDRgbiGICx9Gh6mnYH58a8Lg6IYuYwIO+U8
8bJjvjfRNiXcSe+9pwDCvDZXeu4eug79qw/pZF+Fst//mxQ2bXIRMPMp2kQXj2Ye
+9IHzC8iCNMbTcTO6cc4Z0BCtpwXXAqA9neSmzr9ox2/HJoMU7zGr9dTii4lVxJq
x/S44HFRQfLFfVOE+0qqwYAHNvpOduJp8jazVx1joYGtXLPXeNGT63LMkGsSVhul
TLoKPoYCIGb7BygT5jsHD7nDRYAWSHPraDyKrm7NQxclnkfvklRIYdDE8o2GuWQ=
=L3or
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
