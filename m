Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeCHU7p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:59:45 -0500
Received: from ozlabs.org ([103.22.144.67]:53851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeCHU7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:59:44 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 9 Mar 2018 07:59:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Felipe Balbi <balbi@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Youn <johnyoun@synopsys.com>,
        Sevak Arakelyan <sevaka@synopsys.com>,
        Grigor Tovmasyan <tovmasya@synopsys.com>
Subject: linux-next: Signed-off-by missing for commit in the usb-gadget tree
Message-ID: <20180309075921.46b573e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EVedlK6aHjERXWwU=FhMWsw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EVedlK6aHjERXWwU=FhMWsw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

Commit

  bcef07fa2454 ("usb: dwc2: Enable LPM")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/EVedlK6aHjERXWwU=FhMWsw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqhpCkACgkQAVBC80lX
0GyUQQf+ImldOfOtHgvWVCI0sZNkHp21h7XQaLggF6r/h8bE/ipYd5yH4k0bUc2P
1xCGhn/vRMZUAjEMcJioR5eaJiuwgu2bm428feRnoZfm3QYaoum5MIPM5gTPu6Te
WW/NdoDtIvd/QY4hArQ+RnlhQVoZaT4VYGqVonoEKmABvGaw/sTc1mvlT09zmjVt
ktLLVpSads/Npc5VPN0a1HJ/CoADXsyljPIhiEkYQuiO9IR3SGD2oCBmiynvHtfb
gH35pocMgVjzro/hfgVukQ6tEo1yhoUNz+1YT9lXriWj4Q6qArwPoKFOuiNvX+Gr
+bYAaEIB+OlZr99r8uHOS8fUvznE4w==
=S+YO
-----END PGP SIGNATURE-----

--Sig_/EVedlK6aHjERXWwU=FhMWsw--
