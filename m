Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12554ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F080921547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F080921547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbeIUHea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:34:30 -0400
Received: from shelob.surriel.com ([96.67.55.147]:46352 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeIUHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:34:30 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g3AY5-0003wM-DX; Thu, 20 Sep 2018 21:48:01 -0400
Message-ID: <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
Subject: Re: Code of Conduct: Let's revamp it.
From:   Rik van Riel <riel@surriel.com>
To:     Edward Cree <ec429@cantab.net>, Olof Johansson <olof@lixom.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Sep 2018 21:48:01 -0400
In-Reply-To: <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
         <20180919081812.020f19e3@lwn.net>
         <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
         <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
         <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kVnuM3KLbC/0CBvj4wiF"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kVnuM3KLbC/0CBvj4wiF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-09-20 at 03:14 +0100, Edward Cree wrote:

> I think there are important differences between code to be run by
> CPUs
>  and a Code to be run by humans.  And when the author goes on a
> victory
>  lap on Twitter and declares the Code to be "a political document",
> is
>  it any surprise I'm worried?

Speaking for myself, I expect there will be occasional
impedance mismatches in communication between people
from different cultures, and people with different
neurotypes.

That is not only expected, it is also perfectly fine.

If people end up feeling like they are in conflict
with each other, and they would like help resolving
it, the first task of the TAB will be to mediate,
and help people figure out how communication could
be improved.

The goal of the code of conduct is to make the community
welcoming, and to help people with being a part of the
Linux community.

Mediation is not about telling people what to do,
but about asking the people involved what they would
like to see, and helping to breach the gap between
their styles of communication.

As an aside, the TAB has no power to remove anyone
from the community. Patches are applied by maintainers,
mailing lists are run by their administrators.

The only things the TAB can do is mediate and advise.

--=20
All Rights Reversed.

--=-kVnuM3KLbC/0CBvj4wiF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlukTdEACgkQznnekoTE
3oPyOgf/W93rHqk2gUzBnH82SAP3pmvjsxiPCSRchxzPe4U2Ju8dovvqJFiH9cf4
K8pbOwjDu/N65G3YNhOPZbx9UxC1F0YWVwDFCPbJqVD0ToNXQu8K/zYzEdUvRGOw
CewieGGe/MzJnOZAemKISidoK7gg+Nv+fyr397mk/Gy18zn7G+25vl6f8g0v9Zdq
QbWTVJ5fEwfaIvGHR/MHntJuOvEpYbUrQgkwZ/pHQuAKeDMenOngxxGFq8qNERSU
BHN6wPwLjMtx1hGEqe+ONgfgdxfPgGQDSGqCTdbdJKKb9S7Jfj1KE4CdqkfaJ8q2
6PcKpQEBLBWgPzbZ6ZVmpcrhIQykHg==
=Crdu
-----END PGP SIGNATURE-----

--=-kVnuM3KLbC/0CBvj4wiF--

