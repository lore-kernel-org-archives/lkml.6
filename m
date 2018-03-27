Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC0DoT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 23:44:19 -0400
Received: from ozlabs.org ([103.22.144.67]:33477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbeC0DoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 23:44:17 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 27 Mar 2018 14:43:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lihao Liang <lianglihao@huawei.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: linux-next: manual merge of the tip tree with the trivial tree
Message-ID: <20180327144325.545af4fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gEMDPZB2slrjFZBKx/kNh9L"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gEMDPZB2slrjFZBKx/kNh9L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  kernel/cpu.c

between commit:

  ccd8c1c5926a ("CPU: Fix comment in cpuhp_bp_states[]")

from the trivial tree and commit:

  17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")

from the tip tree.

I fixed it up (the latter removed the comment updated by the former, so
I just did that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

Jiri, you could drop (or revert) the commit in your tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/gEMDPZB2slrjFZBKx/kNh9L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq5vd0ACgkQAVBC80lX
0Gy1HQf/fkP9YYpXqNUpBPR4KyRGTH7wakPC+odyOs6Rg/5STR4DE2iOA9fCIMBK
pktOQdFRFAq2bHWof3PeAqoamFhqXKaCxN0jBgx8minEJG1Us5muM6I/IXeZydht
K2dL8BLSmWXoC8ybuUZBHgveIP1f4a6Dm+UrWjepSli+IPvMCYbHCGk3BWSyULOd
Ws5pHhxDsyQX3pqvWW3/zRAWVHtrY3LW/ruiZPfKY924xABRMKkjWMTQzmrnERIs
XBQv1tb3J9et84HlxWKutAVg43Ye8uuKtjvkMihZtvXbM+FdJdNNqbABop8h3lpq
MYf9CQJ1tqk9hKUWY+UJW7Z22isVXQ==
=ozXD
-----END PGP SIGNATURE-----

--Sig_/gEMDPZB2slrjFZBKx/kNh9L--
