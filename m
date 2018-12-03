Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85728C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499FE20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499FE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLCVAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:00:39 -0500
Received: from sauhun.de ([88.99.104.3]:58484 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCVAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:00:39 -0500
Received: from localhost (p54B3353C.dip0.t-ipconnect.de [84.179.53.60])
        by pokefinder.org (Postfix) with ESMTPSA id 519753E17CF;
        Mon,  3 Dec 2018 22:00:36 +0100 (CET)
Date:   Mon, 3 Dec 2018 22:00:35 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Message-ID: <20181203210035.GA4611@kunai>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
 <20181127125050.GO1107@kunai>
 <CAL_JsqJZJVMvd0aQJ8eDXBqiZ=quLrNGr3hhqePm8fCushHxxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJZJVMvd0aQJ8eDXBqiZ=quLrNGr3hhqePm8fCushHxxQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Didn't we agree that I take trivial devices changes? Normally, it
> doesn't really matter, but I'll have to delay landing the json-schema
> conversion because this will conflict.

Oh, sorry, I missed that! I haven't send my pull request to Linus, so I
can easily drop this patch again and apply a version not touching
trivial-devices instead.


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwFmW8ACgkQFA3kzBSg
KbbjEA/+OKQ7MdMHGblhl5HTt3byGdsdKyB36y6xbG2jtRbs79sZI7YbEk6hDyaZ
e1MiKL32PtkaxTGCQZRyMwFolO463ESYuN+KsrzDKkb6vv3KZieTJh17WOFmD9gP
1o4q9PINNf4HkjgFRbJEKRZCnYI6jYhDgPHduTib7c1K3J9FH/DNOVfj4Vdpw6UO
BPmtdyyauDkUBlkdTM1fFk8Y8zhg8bd/8gqa0oIFsKVKM2DocCoRCojtIBB9QQZA
LR7ponmAL4bChhccnE4op9BYCiD+Nv6fAq2mZSmYAF/nl93y+YwchbAY9oBmONSf
xhG7BwhJag5UnIbPgrVFd8XL9+UO1dLijUezAJd9WVDLICOmb6wL65G4iZzIN4Tq
3eRhfgaUumP1vIgGZwSQ9c7MmZ3rpKgQvaes5dl33cwIKJD9JqFdbo102aO0ntHD
n66b2KbEknyYYQvC08o2EZMOqt5RI1IoPY+vI7x1UH860Z6SRWpO+wMuH2PPiH81
TZjdJFGM409DADjbrIdaAN/XqJ9F8Qkne4iCWJ+YX+e4k3O0oBEsrTuYDlyBT6kq
D4VdyR6UkeGAAbOZoPNdoWXrZib6OufsIglU9opQPMWuMRNryYak4ooKsxM5nY6R
SHFPNLstdHTsXNd4YYqXFWDG4nQAFqLM95KtnFA9w5ZbMNWea6Q=
=g2RM
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
