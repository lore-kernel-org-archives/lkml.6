Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935173AbeE2Oa5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:30:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43026 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934533AbeE2Oav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:30:51 -0400
X-Google-Smtp-Source: AB8JxZrqk/g5GVYaAwO/k9hVit7X5Gx0Epw7SvPCGd7VzyPRMMqxbvwuTn4na+/HipvQIdhjhB2jaA==
Date: Tue, 29 May 2018 16:30:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] display: panel: Add KOE tx14d24vm1bpa display
 support (320x240)
Message-ID: <20180529143047.GB22634@ulmo>
References: <20180412143715.6828-1-lukma@denx.de>
 <20180509154338.2841-1-lukma@denx.de>
 <20180519130533.2494bceb@jawa>
 <20180528095519.799adadc@jawa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20180528095519.799adadc@jawa>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2018 at 09:55:19AM +0200, Lukasz Majewski wrote:
> Hi,
>=20
> > Hi Thierry,
> >=20
> > > This commit adds support for KOE's 5.7" display.
> > >  =20
> >=20
> > Thierry, shall I perform some more work on this code, or is it
> > eligible for applying to your tree?
>=20
> Gentle ping. If Thierry is overworked - maybe there is a co-maintainer
> so he/she could apply this patch?

Please use the proper prefix for the commit subject to increase the
chances of this being noticed.

This is also still missing a Reviewed-by or Acked-by from Rob.

Thierry

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsNZBcACgkQ3SOs138+
s6GnfQ//VHE9F4PXqAaNTI/1z/+qhaIC6w5Mo6gMXd5k1OyUZQmi50PrgFFlhB6u
rJ0dIxke6ufh7MaFvJ7Yxat5au/Q7cVwJud5c4IRC43HXCHHv1mkOBkWVR+stJ9y
atXbCd0INbIU+mBvLJY+QK90G9wdEX5d/BZJgW8qvodUwXnZ6lPmvzQbMdnd1C4r
zbh1XfgUf6cyzoJqs4zUk7oXwGiwXLyJY/w3un5QdhKAb8GSjQle1AnO/ERWxQmG
1FtlYh0FanRNC/14jRb4gZTDvrKxtP/p1wNm9Th0Jn5IBbfSWU/HW9vZFh+oJ798
Cql19SXQ9CewGkCjGjEuVOyiBnqJIUwiCHtEZZtqHRAomX7hFcj9c6Ab6kXbRA0j
PYfx69YV6+kHX8feeRMfvn/N50Y8GfaqUT+wq1pDxobGd6jT1iz/icPLtqw4JaIh
HOWROqkIVUPbtkjNk4i0NNlnoEyw1LdjiFHlRtBMYgOdp+2FjopmzY3i/RQWpWmY
e2LILDSuEjnpkex9OGqEpLMTpfyCSGYZb/49yGGsY8lCS+VtwWrGSY1/YRVNvKUU
ZQHGPO1kWuueUb2/LlCvSXiJRrhCJOHDPuLQhMFLxysDrsCAXX3yBDHPM9lJOOsw
Sg5QzthVtMB6imjkY2Q4c/Z/SNnAc2H22zPuU3uqu9kC311nPOg=
=WCqz
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
