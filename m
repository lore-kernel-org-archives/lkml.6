Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8293BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B840217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeLROHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:07:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:40683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeLROHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:07:20 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M39zL-1hRlYZ06Zr-00ssDq; Tue, 18
 Dec 2018 15:07:16 +0100
Date:   Tue, 18 Dec 2018 15:07:14 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
Message-ID: <20181218140714.GC24278@latitude>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
 <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
 <20181217012837.GT15324@latitude>
 <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
 <20181218030538.GA24278@latitude>
 <9a39d910-2a05-3ce7-c949-296db2d458b9@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <9a39d910-2a05-3ce7-c949-296db2d458b9@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:fFtgRwRJe8YMoyTCxXSwkUhQ+9RdIEnj2Yslc6ZDzegKwsX5JLH
 AZCYZor2OVamo/i9Al1egSih8qgS+ax+hAE5adEvJVeMXh9icOCc2Xkw+HsRr7U3Z4k2XGF
 +UKbQCKGR4scLv5hK1SLgG/bwHtMHCDS4K0WaTjC5Ge8pv6vuhN4UGnAXhgqirFam2B7NJt
 TdNpTLVIKj0Du68xOg+eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I5n8iRj++T0=:xfMZm1pCxRyjBkdzavhZp7
 hAWVMuWS7YSdBShjaUMwBiueMrNfTTCnMqG0tMuucO4EmWTv8mn4zRxI4IO12oq8UAmnf61z8
 GZrog9WtFy0QaYKpWFYRrREFi6kiLtWv/scfSguFWncfcMZna7jKRIPw81aPoH7hYTuB6xs5n
 /9SJyV5pBWjMCzb3HPTZwD31W6FFECbpUrNHxVJ0a3QX3kkgNNCgJCtKt6yjkAYTjSj0Jvalq
 m7N46k5EjbdN1+rK/8vojORILwn0Mti/1RLV72ZxxFoEBF/pHxejSJSgDKMwzS3I3ZKmC8tFs
 /9L5XarXqtt08roZ9rJddgy1AD+KUr+27hotjfs3pNhz4Tz5srOIKJjW8tRi5haHyH0KeG4WG
 a7QkOG+hsR+Ho+PQMrRu4JWphqJlG5LFxIQLGGcsre8k2JFnjsIgYOEPLaE2BQJojpboXDJdc
 2Z571zdiJGq2b/Gb49wccEpbbj9eS4S+JykeDbOL/OEE6l/6XsfJXq2uE1+b1I5L9vkqszG44
 1SFHCCZRhH0dtF5kQDaIrmKGtL4gg70p8ekKDfFI35o7MAJKEXDulUZAxg7uKbTTMAZMPcF5P
 SOqDxu+ezbVZDu3KQYu8YUzfU9ubLaW2xfhRlOGXMmudfj8jnvprqtLz5Bn9QUgrXdXCEv7+t
 +CilVVRe1/cJYpR0svpHnUug/Pz94A3CkALA+OZt0CcFsKEJ8AA28kxS3i0SNzFXpIKxxU21d
 Kb0Xbj0uABYS6oYml2IEfD5RQXdOxywvY3eQYkbj23N1nwyQf5YmmB3itvPwc3TC0YJdw2DEO
 orBiuOKx9h3subBkvCSroMEb/nnjPG+MWdp0gVH/yeEmAnA8tj4P9TQwuWVZfXEYY7bL2/8WX
 bWbroB/tRdURc9VD8kYXWFBAhlkMhFirnBmRjpEk/jmhyXJe6gJ/z7MdqOFVjJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 09:18:42AM +0000, Christophe Leroy wrote:
> The only difference I see then are the flags. Everything else is seems
> identical.
>=20
> I know you tried already, but would you mind trying once more with the
> following change ?
>=20
[...]
> -		setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
> +		setbat(idx, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);

Good call, with this workaround on top of patches 1-3, it boots again:

	# mount -t debugfs d /sys/kernel/debug
	# cat /sys/kernel/debug/powerpc/block_address_translation
	---[ Instruction Block Address Translation ]---
	0: 0xc0000000-0xc0ffffff 0x00000000 Kernel EXEC
	1:         -
	2: 0xc1000000-0xc17fffff 0x01000000 Kernel EXEC
	3:         -
	4: 0xd0000000-0xd1ffffff 0x10000000 Kernel EXEC
	5:         -
	6:         -
	7:         -

	---[ Data Block Address Translation ]---
	0: 0xc0000000-0xc0ffffff 0x00000000 Kernel RW
	1: 0xfffe0000-0xffffffff 0x0d000000 Kernel RW no cache guarded
	2: 0xc1000000-0xc17fffff 0x01000000 Kernel RW
	3:         -
	4: 0xd0000000-0xd1ffffff 0x10000000 Kernel RW
	5:         -
	6:         -
	7:         -

> I think we may have some code trying to modify the kernel text without us=
ing
> code patching functions.

Is there any faster way than to sprinkle some printks in setup_kernel
and try to find the guilty piece of code this way?


Jonathan

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlwY/wkACgkQCDBEmo7z
X9tphw//eo4AefucR1Ifx7yXkmmJgCQhqeLD63BU/DIL9I5rw4tNFdmGvEh1AJ3y
vdGdGaTkya/mBGvyoDJ37eh3ldt+7N9qk7W16BZc2tjYQQRJOPht1Y/ecFypqcKc
8obxsorOVT6iAE8VoDU3ZJYZe6BZuVJCwEoPFySRl1bUYaADGIoeop5TF9ypgkrJ
LhQDUDO2SA1nQKMJ5HFfqeO8oqyo4MYt0rJqUZRP4FCIt/3caB4hcPDFv7eRdT2F
KSmmcLMPyYPDnC48vWkA5w8OKRbndPe3HRdtrWdwIbmVxBS+6mq+HDFu2qk7OhAV
KZKMieNtfgg/zOuKCX+/D+NtuLOj569vxuZShdDblcnnP8etLboF7oqtFyrmBK4+
WdoHIFLxBGiYS8QTYvPHSAkIx3e7rajrLhB+ggNXhIT7WQ71jX6KNCOYmwEJoke2
0O3s6iuMMIFDG3Jm89kovuf5B/6n10yvrr/1d+f5tLJueamBdkMG8LOPsdcXQacE
W60tfnzPqqD9jMUvWEmlSQgruc9sVlUz3pt9qNzbp8Q2PVUmfimpkrFh+ZkfWI5Y
QxW5QyQW2sUwOBCtfTLBm8wi94Ho/YR8MclmLA8hx1/2onxu70hxD9fHKzi3vD1e
ooehzWa+V46ZBr3l4pwhEJUDU2WCkxlZZTGKgspmv82r/2nQiXw=
=2uIf
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
