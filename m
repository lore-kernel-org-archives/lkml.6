Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE020C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951B0245EA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951B0245EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934384AbeFVQoN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:44:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:48514 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934164AbeFVQoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:44:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 09:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="asc'?scan'208";a="239769296"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2018 09:44:01 -0700
Message-ID: <5718d34758dd55090dbc73441c3b12c6c5c02ff8.camel@intel.com>
Subject: Re: [PATCH 0/4] docs: e100[0] fix build errors
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 09:44:00 -0700
In-Reply-To: <20180622003708.31848-1-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-saeb+Ae6JKlcEeHrnlq9"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-saeb+Ae6JKlcEeHrnlq9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 10:37 +1000, Tobin C. Harding wrote:
> I may be a little confused here, I'm getting docs build failure on
> Linus' mainline, linux-next, and your docs-next but different errors.
> There seems to be patches to the first two trees that are not in your
> docs-next tree?
>=20
> Do networking docs typically go through your tree?  Looks like
> networking has done some conversion to rst that hasn't gone through
> your
> tree.  Or else my git skills are failing.

Networking documentation changes went through David Miller's networking
tree because he maintains changes under Documentation/networking/
--=-saeb+Ae6JKlcEeHrnlq9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlstJ1AACgkQ5W/vlVpL
7c4g3Q//UT7WA9IeTyE07BIZ3JwQk/0uSosowJHOGMXYEyil0K76/q17U7XwHigK
SO7DPtDtSj0nU9v15OW+pNkZarFCndJ6pUCG/vyHYQnLFV8AMYSho/iGJGpH5WTq
GHn25uj1oLz7nMu3W+bVDZ17j0p6luMTXb90bRUNufVrmdpVRdGhvW9OKMoT2lIs
48Un1akbX3OA6w9PZj9fzrlXRzp0XoJiRBiVrck/HkdNGsMdsiXSv7zndYMpkRBb
Roe4Y9TGdHRIpvqK3Lb+WFjPU2sU9s+kJIb1y5AQd0JPpt7DPffoFPNOuAeSXR77
GpeEkf8bzERQz7HqDSCOE180owpEbXAaxuu0YN5d6+5mlU1YVYCgQ82zQJmynftB
OG23bP87dJZL/xh3ZPKsEIGaQgOxzkYNUQT8hXAajd+Ap0yQLvOuhYvvteMSYLhO
7p1FpDi7tMmq+1yWcMq0joOGLBw9t8kyXi2dXN5oJCKA/l6gyOqLTgrW4Y0OD2bk
Pcq1CcekRDa2n7xmhR40kCFcPrDxBO69PdVkGiDEonwXi29Qzcjw7ur2sQSKTmzM
qHTEiowvfomh81LIhzlKZUq5kd8AYWyyn6R2TJA7DYPm1IRgwl7H7qJEb+Ushsxr
zl/B/f8gd6/pQTnK6VnwTEcZBiD+ZvTwtLNv10NGz9Xedb4Hc6c=
=cIYU
-----END PGP SIGNATURE-----

--=-saeb+Ae6JKlcEeHrnlq9--

