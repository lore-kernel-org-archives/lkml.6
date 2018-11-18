Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E49C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FCF2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="krUOo27y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FCF2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKSDEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:04:00 -0500
Received: from ozlabs.org ([203.11.71.1]:35619 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeKSDD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:03:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42yd7c2tQyz9s6w;
        Mon, 19 Nov 2018 03:43:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542559392;
        bh=dddc4pJIztvHS19sIKTl1mEG7UGbO28akZ7F93LKWjQ=;
        h=Date:From:To:Cc:Subject:From;
        b=krUOo27yI89y1+vHb1ByXU39+ZwkMbPS5OGPjjHJcldPYKDzCxa/dDJiVkxUk43yT
         ff6vZEFKLedamQRtFvH/mjndDd1wTFSeuYOkWv9tOQbFkwLmKQzGYcNkXCZyTcd2YH
         H3VcJphilTrPWM6+5+yGsTaz9JekHQSp0GVpD7szp6HNdS6RSfpZ8kzWh3eLU8e81H
         xUXz0BBGhP8k6ftkK4oP0/YcWulYMPBdacuNjR5v1HtvXagDYDVRIzZRX6SjT2AWn+
         oproc6xet4OUH9NAYWUz0ZaRR9y2RxOoiFcb3mW73qAsiKJz3RjWX4hBnyO3awsRAr
         AXBZ3TGYgqxZg==
Date:   Mon, 19 Nov 2018 03:42:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: removal of old trees
Message-ID: <20181119034231.3ee05626@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ksCgbxZwbbya07w.KC9/rSl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ksCgbxZwbbya07w.KC9/rSl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[This message is Bcc'd to the contacts of affected trees]

The following trees have not been updated for more than a year, so I am
removing them from linux-next.  If you want any of them reinstated,
please just send me an email.

Tree		URL
----		---
aio		git://git.kvack.org/~bcrl/aio-next.git#master
drm-panel	git://anongit.freedesktop.org/tegra/linux.git#drm/panel/for-next
edac		git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac.git#=
linux_next
idle		git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git#next
keys		git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git#k=
eys-next
kvm-mips	git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git#=
next
lightnvm	git://github.com/OpenChannelSSD/linux.git#for-next
nand-fixes	git://git.infradead.org/linux-mtd.git#nand/fixes
realtek		git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realt=
ek.git#for-next
sunxi-drm	git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git#s=
unxi-drm/for-next
uuid		git://git.infradead.org/users/hch/uuid.git#for-next
vfs-miklos	git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#n=
ext

--=20
Cheers,
Stephen Rothwell

--Sig_/ksCgbxZwbbya07w.KC9/rSl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvxlncACgkQAVBC80lX
0GzPbwf/XTgjZpYZpXE+bVHouZ+ijQxZO7XgYpvc09Y8RfG88kksX8pcfTTkYB6l
7aNRXEhKoWTPgWeN/I88Sk0JzA+dDXETVEcR4rDNS173kl5Eiol4KSBfqP/OfU7L
YECHetKLIQS806plc7hUWVVJnyTNfEFlgE5m73YZTx/75SaRtX4YjBJPqzg5Hf7s
c8EEK3QBvMBWaQt3NWxI504v4onBq35VQs0uvyKiQ4zBZvf+KW6cyhPm6ihYMVT2
nz9SoAdwPfAp3FaXu9ThCzroNsfn6wWRj/DRdZQBCV/MXWzx3uP5nxkUdkf/DX3/
bDDlv7Qy43GM44FNBLlIAJlb/5lUsw==
=/T7X
-----END PGP SIGNATURE-----

--Sig_/ksCgbxZwbbya07w.KC9/rSl--
