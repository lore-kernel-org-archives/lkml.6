Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3599C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771A924600
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771A924600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934460AbeFVQos (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:44:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:52314 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934416AbeFVQoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:44:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 09:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="asc'?scan'208";a="239447466"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2018 09:44:43 -0700
Message-ID: <c84fddcce0c977fd945873fec5d64e96f25993db.camel@intel.com>
Subject: Re: [PATCH 1/4] Documentation: e100: Use correct heading adornment
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 09:44:43 -0700
In-Reply-To: <20180622003708.31848-2-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
         <20180622003708.31848-2-me@tobin.cc>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-83GaFcxJkhtHDYYe4+kR"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-83GaFcxJkhtHDYYe4+kR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 10:37 +1000, Tobin C. Harding wrote:
> Recently documentation file was converted to rst.  The document title
> has the incorrect heading adornment.  From kernel docs:
>=20
>         * Please stick to this order of heading adornments:
>=20
>           1. ``=3D`` with overline for document title::
>=20
>                =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                Document title
>                =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Add  overline heading adornment to document title.
>=20
> Fixes commit (85d63445f411 Documentation: e100: Update the Intel
> 10/100 driver doc)
>=20
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
--=-83GaFcxJkhtHDYYe4+kR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlstJ3sACgkQ5W/vlVpL
7c6JYg/+Pkp0Iqx9cWzEGwznsGy3++zm7us0e7ZixRBS1wLxcOILCpevomVuEFti
it2Oeg5yEWpJujZFg1v2T/UEsJMpSXsodc6rZdFbEUIFwQTz9tSDn8YJqAoFzEwd
EiyUVWv0DadDtPTMBpfhL5xEDt90AwhKMOzBkr74NECaTXVa7i1bMXDCLqG0UJIe
yVX+Eh2Dc9vvtWMkX5A/E/nKD6pyCR6QYE8ncNSuCXWhJGKEnAKrMYQmrBVTSDat
VgrX1npoH7+21Ky8yCB4ye9TuNRxABZcJS1SRUfAGEUI7kfLKvD5Lhb1ORIGt75u
U/mi/3CsAvJsmLcjEimmYOz2rUbeGEKC8rFJKYREpRtsjt3tFpxW6Bg3AHG+YF7+
NJnqB+LrxsjwLqIFXIvCYpHfPWfC6wkRRcIM0jk0mxL4eLvmZhSOa+aP6/O61zhk
+46CMO0RHqiiKC61cbebzUPqsFcyK9KVxpeBGFjOGQ73X8vGhRlFOJU/vxkBC+CK
rK2O6+y6z4nCZuGU61ef1D9s/zCDzhH/WNzJG1JYer+SdQWevTmZ7sup+VlbrYhn
MAEH3YmZN14NDo48mNWx8s0wBkak33l6Ylq7cKQrqpRY3+ARYkD56mNNgiKwOPZR
R9ssH4RaIElHhmgC7BMZTu/0/D0NsqTpJsLUcmrwrwCbyodChLE=
=ofn7
-----END PGP SIGNATURE-----

--=-83GaFcxJkhtHDYYe4+kR--

