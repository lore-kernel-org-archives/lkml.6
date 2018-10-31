Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D836DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3312081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3312081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeKACdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:33:04 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:10648 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbeKACdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:33:04 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C3397A110B;
        Wed, 31 Oct 2018 18:34:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id xgZy_zwhPyhD; Wed, 31 Oct 2018 18:34:03 +0100 (CET)
Date:   Thu, 1 Nov 2018 04:33:53 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel@vger.kernel.org, timmurray@google.com,
        joelaf@google.com, surenb@google.com,
        christian.brauner@canonical.com, ebiederm@xmission.com,
        keescook@chromium.org, oleg@redhat.com
Subject: Re: [PATCH v2] Implement /proc/pid/kill
Message-ID: <20181031173353.uob5qikkhsb5digy@yavin>
References: <20181029221037.87724-1-dancol@google.com>
 <20181031143744.77677-1-dancol@google.com>
 <20181031150548.GA103404@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="urpvdo46d6qtxa4g"
Content-Disposition: inline
In-Reply-To: <20181031150548.GA103404@joelaf.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--urpvdo46d6qtxa4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-31, Joel Fernandes <joel@joelfernandes.org> wrote:
> I suggest to maintainers we take this in as an intermediate solution
> since we don't have anything close to it and this is a real issue, and
> the fix proposed is simple.

I would suggest we wait until after LPC to see what Christian's design
is (given that, from what I've heard, it will help us solve more
problems than just the kill(2) issue).

I am very skeptical of adding new procfs files as an "intermediate
solution" (procfs is the most obvious example of an interface which is
effectively written in stone). Especially if this would conflict with
the idea Christian will propose -- as he said, there were proposals to
do this in the past and they didn't get anywhere because of lack of
discussion and brainstorming before posting patches.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--urpvdo46d6qtxa4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlvZ54AACgkQSnvnv3De
m5+fahAA0B0b0bhD/KuB/xokVIjR7z2eesm4mTyHpVWpP2gXKWi1xe3/7rgulUM1
vUKAGDnDbwW9ysxFv2E5c8UnI4vwn9lV0COYCq82Di+4xZ2nbvpK6VBNC8AsdhTL
Cu3QDHrumfwMSxK5wb2Wyq/pa2pe2DyKokZZC7bgr5rBjIiSpcYjCyywg8rgtYTe
0rkLlC7S8UPD0B+LI3e5NDwz8ksWdmlRldKgO514WI8rEMs6E1c6/REN9q35b5K9
c7XGyDYNy/+719hc2K1LxC0yrJZ3KnmaLtWN7o+PWYV93XxNjZHxrRAWh9jpoYAK
vo6q6AHOJAXP3z66qR2pbh7rPrrnoEneOfwTkSJILrFWecpgIlkd2Ov2g+/y1Oi9
zFEmaBi7bx9dbjdEnuExmcPBvnKrl7ddtnSyGutE4s+fHnXl+Vz+HQ4ohWb9qpcD
VBIqHNTgdhx/SE0edMOrE/yBx+5nppl2TT69UtziBRY4mVlRGwum9EGWQrHb318R
cu4Sls15kTeqaqbSOglyYC84bKrOqfHz3MBNG/PgcJ2rNNN4OBizlHz/UYf9yBx3
YdJgPLSSDxVtVdE3F4z5bnLHq/z+KNhaMHWmz3SYMHJBsy6gBhr0sYkfo0se4VLh
8WpOAfRIGwi0UQDDd2XmZ2MTOvJ0CJC3sBTtLa83VVLYwtBmggw=
=TCYp
-----END PGP SIGNATURE-----

--urpvdo46d6qtxa4g--
