Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeCPO2m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:28:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751245AbeCPO2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:28:41 -0400
Date: Thu, 15 Mar 2018 13:51:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sonny Rao <sonnyrao@chromium.org>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost: add vsock compat ioctl
Message-ID: <20180315135123.GB7015@stefanha-x1.localdomain>
References: <20180314213625.119211-1-sonnyrao@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20180314213625.119211-1-sonnyrao@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 02:36:25PM -0700, Sonny Rao wrote:
> This will allow usage of vsock from 32-bit binaries on a 64-bit
> kernel.
>=20
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>  drivers/vhost/vsock.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaqnpbAAoJEJykq7OBq3PIRW8IAMcewt0u7IxTrOAqBcWsEpGy
LinA4rdQttT81XR7oiFrzf0b+b/oaCPfW4ZNACeq3gADu4nDhIhp/ZYUKHVQh2NI
7ykw6yPm0pqIQB82mbz2LGGf3PK+0ZRhu9qTLBXhg4uDMDcWKZhD9fAm/xx0YCRS
4a2fhlFaxdK1TI4PCLB2vXnoto5aJqwHNTr9K/GOX69LHB7lMFKeMl/oLFduv2i2
BZeBj4TI8rcvgBcLEK68clN8WkBxvSu4sWiUTLGtp1bowbqPnh6Dcspt5y7is4N7
17y0mahmKrdKTGpmBN+cFsp9O7Fq0CDTH6H4vE3e+chpbaw7ieh90tTyMtZ5mKY=
=bRd3
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
