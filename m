Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E6C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBDD218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbeLUBbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:31:53 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:39122 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeLUBbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:31:53 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E323372CC53;
        Fri, 21 Dec 2018 04:31:49 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D2436964EA1; Fri, 21 Dec 2018 04:31:49 +0300 (MSK)
Date:   Fri, 21 Dec 2018 04:31:49 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/27] mips: define syscall_get_error()
Message-ID: <20181221013149.GA5299@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172302.GP6024@altlinux.org>
 <20181213190015.olf6vhuimjl4jixs@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20181213190015.olf6vhuimjl4jixs@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Thu, Dec 13, 2018 at 07:00:16PM +0000, Paul Burton wrote:
> Hi Dmitry,
>=20
> On Thu, Dec 13, 2018 at 08:23:02PM +0300, Dmitry V. Levin wrote:
> > syscall_get_error() is required to be implemented on all
> > architectures in addition to already implemented syscall_get_nr(),
> > syscall_get_arguments(), syscall_get_return_value(), and
> > syscall_get_arch() functions in order to extend the generic
> > ptrace API with PTRACE_GET_SYSCALL_INFO request.
> >=20
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Elvira Khabirova <lineprinter@altlinux.org>
> > Cc: Eugene Syromyatnikov <esyr@redhat.com>
> > Cc: linux-mips@vger.kernel.org
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>=20
> Acked-by: Paul Burton <paul.burton@mips.com>

As it looks like the whole series is going to be pinged for quite some time=
 yet,
would you mind taking this patch into the mips tree?

Thanks,


--=20
ldv

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcHEKFAAoJEAVFT+BVnCUIUCgP/jPJV99WP5UHPcyNZvi3cjaU
o1Z3oDaBawbrvmdh1x3GfEo0fnSc71aNrzsRZgHqwOA/3vJjkza1sv8Lx7G0xUEd
ZIidhkH58/J5l01NF4oLjChvyfhlXRL8Aav/plHW3SvzWuSbKgpjOFenEGDUzZge
DB+JSdpktrvUmTftTNuiPwL9v15HydzCi8Olwtd5E51OTyvjUmnYiLCSkcnErf2+
8DoBmeO2XGUwlXKjy78rkdc+9L4iR61lyGr7Ud9vNahwdOuZSaxo506k1vI4tDPP
CSWmm4dSL+DXaUneOO5tmy2wA5xSOcagRGTi3hrmDKmOB2d4DrlOLkhAvnUvM5z8
LYs/+GRt/ub4qQuHkHFpOUMwJ2N459GOnxgO+Rtd6uEYNtAR0N9pKxjppm1mOX+p
aSYMG5cLbcc4pkx9TWXbsceab32oyrLxGYGSGFBq7WcXDd9c0Kf/6meopy7Hc0Jz
i983Z/tljDsYGydKhx48w3xvfW8ZB/h99FoiNHvg5Wfd0Q4qWoViuopCUxKBYDJa
dm5mgWR0CNbOe0zXpTBrgymEfM7KCmdQAbAwbIMQMVcOHeN/1dyax18G1MBvEA+O
6m/6oF9riyattnmhJN5LTmftkrxOcaOb9N0lB4/5dsnLRU2mT8F76tl17OYi8fVY
4XzUuRSTC7PKMDaqis9n
=ADwb
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
