Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02454C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0318208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Hbpok/g0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0318208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756118AbeFPGtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 02:49:11 -0400
Received: from ozlabs.org ([203.11.71.1]:35447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753907AbeFPGtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 02:49:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4177Hl2d7Tz9s4Y;
        Sat, 16 Jun 2018 16:49:03 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529131747;
        bh=5lGQUST25gLwmlUR+2HxK1QYZldYIl0GVi0bNx1CWl8=;
        h=Date:From:To:Cc:Subject:From;
        b=Hbpok/g0YknpN+E0O45Ue7tp/RMp3c2ewqhxA98JW+ddybmvqmJGoviAjBIlgb9G+
         GvluN3B0y8vHAQ55GGCvGjpeuTMpDJSMSW2oHVDtNdMrIyUTXawEvqHw+HfLHlV6qJ
         nMxx3X450tztDq4jTIOBzH25gjKqU0oMyJBfmrY50AX077m9lcmn27wccwfYD4pB7o
         ln06j8OEMOhgs2145xzwLxosoLHAVXqfIQ6887T0AvtGNPGg1CuWGYhxeQFudOWATj
         TkTXtA55ZcakCqdloHOStfLEWc/1k2YsRGW6fiVXlvU0U26NmNyzcAXal4GQsoIkCK
         ZWeWZBOyv4/dg==
Date:   Sat, 16 Jun 2018 16:48:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the vfs tree
Message-ID: <20180616164856.5ac44e4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TfuC/PLRPSpBhliNuI6yHTG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TfuC/PLRPSpBhliNuI6yHTG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Commits

  b6cfbecafbd2 ("afs: Handle CONFIG_PROC_FS=3Dn")
  0aac4bce4b49 ("afs: Show all of a server's addresses in /proc/fs/afs/serv=
ers")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/TfuC/PLRPSpBhliNuI6yHTG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlskstgACgkQAVBC80lX
0GzUJQf/ebNMNV9I37MHBekbJVR/H+UGhJy00nR9X9ctbC1IXoPA1WHue8nWQPZb
VcB7NKhirvCOguH8dg5EpHeJBbn1CoEdgI2l9FLu3Feiqgpd/RzqxWL4Yg2Gyo7P
KJRtgiAsG4XRqzE7Vxl2KF6nWKi4VX0RGPlK5SV7EECaB/URdHl26S6aXsbAp65A
2QTR74h6o5sBQV4UTx8kYJ/yo5K2Rwnym/kC+OFk0L5uv7lEwindPbxqvmo5Nxbz
CshjeccuHQhNJMdGeNnD5UtiInFSvEjUd6HPvFR1xOfP/Ae9A7IbXImRi/7RW9R4
Tq/e+mLrqKYstTtp31kQVRLhnjJV5Q==
=HNel
-----END PGP SIGNATURE-----

--Sig_/TfuC/PLRPSpBhliNuI6yHTG--
