Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9009C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C7920881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XxUcPyyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfAaUme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:42:34 -0500
Received: from ozlabs.org ([203.11.71.1]:50171 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfAaUme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:42:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rBxg5dbsz9s4Z;
        Fri,  1 Feb 2019 07:42:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548967352;
        bh=UpfAXXzYICu1ypeKLeHmdjphgFNHshUdlOnMH8JAtxE=;
        h=Date:From:To:Cc:Subject:From;
        b=XxUcPyyog2BPQo+zA0TFIJMUdD/cauSj6rexvB/Y/pC8G3kQ+Je1kanv1WTjSJvNr
         GxHWX9ARi94K3YgRoFZcPIJFlOzrHn9KH/pSDQYt9ZhZAgf0Z6QW+grCF0VAILeezo
         ZwbE+PKDH/RY7TkDMPB6XsSE7hm4WILpKU01TuT6fgIK9I4G4dW2H/QcvPenWLC0WU
         yo3ouUNz04fkkfF2U2xvEKEZ+H8MIQ2OYU1X1Jgs9UVXbeHzGQh2ljH1KVTmhlYOyR
         0CFKJoedsBCzbqrcYoDeXdnIG94PondhY7OqugAyCygJZBvIZHBWYyFlziwwEHrV9l
         fezHp824WAoSQ==
Date:   Fri, 1 Feb 2019 07:42:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kvm-arm tree
Message-ID: <20190201074229.072c93fb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TFHTk7i4P=s6TGRQ6DUjrQ1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TFHTk7i4P=s6TGRQ6DUjrQ1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  24d742a3417e ("KVM: arm/arm64: Move kvm_is_write_fault to header file")
  b39baf6f4327 ("KVM: arm/arm64: timer: Rework data structures for multiple=
 timers")
  3e6cb42d0c31 ("KVM: arm/arm64: Factor out VMID into struct kvm_vmid")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/TFHTk7i4P=s6TGRQ6DUjrQ1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxTXbUACgkQAVBC80lX
0GxMNQf8Dy9gP6WLFFchH/yyG3NQXfxxQJ0HEgWjZT7Wwqg8P8J0lHHhn6YQqxAU
wp54k/h+SrxftyWK1y5tS/i0BsuslBvyeiUjiT6pr1YozKA2Ek5JsfqT/ESBDBjT
IoFxz0NhzZd3KTKKL9pjoYd8bO3BnIGaAzOwkL2TOJGM426eMB3YeHG5X3lhwPob
NfJheRij8K7D7qOP03eHQts5X/jDhUnEg9xyA3tyBiLnCbi6Gv6NA9OpcWpCjr1l
7OlMOAtxEvIYVqIVl+V8ZdZ46oYrKzU3C7Fu9aWJe/3GTOeXp0dF/Jd0KFxhM3Pl
JsEO8KgRDO3EvmJJFBNxu8gP2IufWg==
=pFV7
-----END PGP SIGNATURE-----

--Sig_/TFHTk7i4P=s6TGRQ6DUjrQ1--
