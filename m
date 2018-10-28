Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C7DECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EB920870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gyOGhV5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EB920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJ1Ngd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 09:36:33 -0400
Received: from ozlabs.org ([203.11.71.1]:53561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbeJ1Ngd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 09:36:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42jQN10y2wz9sDF;
        Sun, 28 Oct 2018 15:53:05 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540702385;
        bh=yBC7tS1Cu3z9xspMbg8n1WeM9GqEMD3Lg85Et0R8hIc=;
        h=Date:From:To:Cc:Subject:From;
        b=gyOGhV5skXN5CExqwZ+Sr9SvqRgCzFJ9XAhcn9a0cjln8y7QPLTOeYSeOYHbRRACN
         fovd6qwqTISDhLwQxQ8IgX3ptCTB/AhxliUtFD4Z0txpoU/IRCOUfkjEbL5EgExKaz
         9pEy5XSFvq1utUNo3BCG2v1MavzzVuANxx7NnDbDruKxVC5wcPfcCGOz1gz7jVLfAd
         89fim5tzPan6yt27g3v/US50wx7/XPFR6gBoZuQmtja7KMIJ1GSKumbFAKL9pd5WJk
         f7JNw3nKjQnoGja1XSOcdiZ//diFqiO4hYuedyPzrjwWqQpCtGUNH/0hCYHLbNM7jm
         jysP0P0KwpLdg==
Date:   Sun, 28 Oct 2018 15:53:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Salter <msalter@redhat.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the c6x tree
Message-ID: <20181028155304.0bbd1c70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OESwlCympYFTVk5WZx//9uu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OESwlCympYFTVk5WZx//9uu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Commit

  fe381767b94f ("c6x: switch to NO_BOOTMEM")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/OESwlCympYFTVk5WZx//9uu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvVQLAACgkQAVBC80lX
0Gxj3Qf+Krho7LIK2wtWX9Ex/koGMG5U5jSC/pSbrSUY5lrqYMaGCJOK9Z9I1x9t
Q090ZGGnBaLY5JozpdsZwowNzgzViGq4cGbB1VNpjoDoJCXq6KZ3Ok/h8VD/9Rgm
n4n0vJC2zy47T21WgnIXcEsyNqEP9KF84y4l0D77ZKsi3KZfCooeHBrT6tY0CT/m
8es0Qi/v6n2Mj5CtbX6fiPoArQglw8FEFrp/BLEAcHAZGamUTNXn5NTFR3vfhBD0
BVmUPjuX0eiFDKu0X3lrTj2o+D2l1ZtL9BfibBKqn2Vcgg1oamzFz4R5YgyHtapC
krenj6igzWBAzRiLBYy+CyoDYRRS7w==
=LItn
-----END PGP SIGNATURE-----

--Sig_/OESwlCympYFTVk5WZx//9uu--
