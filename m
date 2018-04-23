Return-Path: <dledford@redhat.com>
X-Google-Smtp-Source: AB8JxZrLk8hmIZ0qI789avG6FI48W/boQ0i9ukOXutx86ieEImY58AAgnCTUiZRJaGzq9TP0YN3z
ARC-Seal: i=1; a=rsa-sha256; t=1524496268; cv=none;
        d=google.com; s=arc-20160816;
        b=eOKYjfRJY+XDIdCAjJc2xmO/0CZI7AAJJRhJO8ROKad9up6K7cZv48FOUoCJkwECTi
         X+mFBSDeOjyW0w0m8IoAxg5C94A6aWRSG+Mn4z3zwegPzj8zsToPCvySyif4jor1wO95
         N3GV8H6uqHOY+BLHRsKildihj7I8IveADN4s69DYEa9Gl69MeotXUYMjTC/52kHufO57
         VBPK4kLIUV81b8PSYuA0HCrLb8e7s94XrO5BKQ+ZYvZXsWze/cgAjHsBx0imCR+3s7i5
         d3HKMlQ39oLshNXhAeYQX/2JMcwULejj06RvJnFQEtfJNDzUIZgtj6C51yK3R9WPIGny
         Mcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:organization:references:in-reply-to:date:cc:to:from
         :subject:message-id:arc-authentication-results;
        bh=7RCR+M8/O0r7I5t7QfZ8hkqe4e/MFMUnSaQpCAseEZk=;
        b=xyqCbSLPxyqOw3mjbs0s9/Ro+hEfGo8TalQDdtkF+QFkMEfYAK8ygB6AZkAT/sgMmg
         BajcghJd7l8hnMa09Jueob9fvWwy68YwrzBZbsaGHEvvdYszgURj6M68v+zdQRmVdom/
         2yXr+/c64+X8sIuDaZXFxz4W4TVaiTfFyFPRtxB+7EGrOqB4XVng2CMYfSfSXNfswaQw
         iV3gugtcXltCQGANV7eY9U9yR4sLGBb4NEzyIfi6m/Bfcf9tW6GYE67WrIV2DL6qS3lm
         UsC+QSaEXIIpo9cKUK69ieWOUnjKRomB6P+6cPHXCwHbfCiWv+t9mua96LwHLgf+4iE8
         7rHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dledford@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dledford@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dledford@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dledford@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Message-ID: <1524496266.11756.36.camel@redhat.com>
Subject: Re: [PATCH for-rc] uapi: Fix SPDX tags for files referring to the
 'OpenIB.org' license
From: Doug Ledford <dledford@redhat.com>
To: David Miller <davem@davemloft.net>, jgg@mellanox.com
Cc: linux-rdma@vger.kernel.org, kstewart@linuxfoundation.org,
	pombredanne@nexb.com, gregkh@linuxfoundation.org, tglx@linutronix.de,
	swinslow@linuxfoundation.org, santosh.shilimkar@oracle.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davejwatson@fb.com
Date: Mon, 23 Apr 2018 11:11:06 -0400
In-Reply-To: <20180422.210823.1454088204642743739.davem@davemloft.net>
References: <20180420154910.GA2519@ziepe.ca>
	 <20180422.210823.1454088204642743739.davem@davemloft.net>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-aTiSFOavqybSiOFpKn2H"
Mime-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598280819210868767?=
X-GMAIL-MSGID: =?utf-8?q?1598550199099626084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-aTiSFOavqybSiOFpKn2H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-04-22 at 21:08 -0400, David Miller wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Fri, 20 Apr 2018 09:49:10 -0600
>=20
> > Based on discussion with Kate Stewart this license is not a
> > BSD-2-Clause, but is now formally identified as Linux-OpenIB
> > by SPDX.
> >=20
> > The key difference between the licenses is in the 'warranty'
> > paragraph.
> >=20
> > if_infiniband.h refers to the 'OpenIB.org' license, but
> > does not include the text, instead it links to an obsolete
> > web site that contains a license that matches the BSD-2-Clause
> > SPX. There is no 'three clause' version of the OpenIB.org
> > license.
> >=20
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>=20
> Acked-by: David S. Miller <davem@davemloft.net>
>=20

Thanks, applied.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-aTiSFOavqybSiOFpKn2H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlrd94oACgkQuCajMw5X
L92qyQ/+N3Lbrhy4z7gxK7j1KPx6+DaH7yKqP1x3vjKkflvVDePAgfNKEgNWqKZv
aq0KDjOH/j3JioIaGQRuVtGx7VX+6bhVGfzd0EG3rN4wSzOpklU7X4sgL5zW8ZQ+
LLYMqTQ+adRZDHaks61gU6nHH8a2Tk2YtE6DaRO3XHzUlzxjVd4tXObDqV6lL2I3
9bG/VRDteswILhyp5fXXFPrMvneXTUc/HuXCCgTyq+FyR89AXX3SwrRMm5lo6Ubp
1StnQmkwSlmo6B9Y770zr3uAm8/EpdanTl6h0Oy3WyER+SPznElbiHK726UJ6BXS
5hOU8K7flfDL9Os/JPIezMcnn/zCgBLCF8R/euzTI6mIjVMpX5bMjFlF3xSTam2H
TkxFRxOiL/hrNrxRPvjOLgFkDdG8E/cZqhsi6Ap6WYeYiibWeT5PdsXD8o716uvE
J17g15RK87Dh9I9ZdgKxfJJ7lNO6vsRtili/IC2mmPZHnPjIOx/dSacDZgaH6taV
6Maquesc/ZACUf/gLoxYfJieagFcwMZTj3g3DgA9EHWwWxa19MFx2iQjBDMIUh7Q
CYnpV4DkCmb+UNhGF82gG75Z9dQKlKUeGX+CkzOud4zQOGei4A2zXFVo2704hHHp
d9jLr7oP6IDPvMvw0Y9E70DcwHRiINWJMjH0dA8DQfeTWBaBaI8=
=slaJ
-----END PGP SIGNATURE-----

--=-aTiSFOavqybSiOFpKn2H--
