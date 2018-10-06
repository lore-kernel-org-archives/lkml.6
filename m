Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9C1C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7536820834
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 02:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WbPZvymB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7536820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeJFJEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:04:46 -0400
Received: from ozlabs.org ([203.11.71.1]:40461 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeJFJEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:04:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42RqfH1F8wz9s47;
        Sat,  6 Oct 2018 12:03:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538791399;
        bh=RgdbzH+1NOs42bYvmsT0lkZW/Up5RtKk8fN9TBkiDNM=;
        h=Date:From:To:Cc:Subject:From;
        b=WbPZvymBF0R6XfwjrFzTeGv6jekKxSw377MAU1px/ZTTeIcncafnCryKedbMTGAa2
         SaowPThziho/WnVUROPQ2qVhsx6AI4uxLs+LthFVJk6YtfjkeeiSk8sIOGR7ylxVHs
         qDtQK5h9fsNf/X5nnxsibXm7hiKWqEjH/3onaYEufCzpZh/WY9+30R22xhYsqXiRr8
         q6tAudkI74vHQd+LWJkqvhCwP+YgkV3T+Cepk9VXXggenMudYIZxvE9CtfjxuU4zjI
         6CsX7wNRM0BxwdpRCChAYJZFDO6VmiQMDKcBvw+2y75B5dg16TKMlg8v4W+8wMCAGh
         ILTWOsLK0pJ/Q==
Date:   Sat, 6 Oct 2018 12:03:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: linux-next: Signed-off-by missing for commit in the usb-gadget tree
Message-ID: <20181006120318.20758e89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/..8lR9/Yd17k9=1oeXFOfPp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/..8lR9/Yd17k9=1oeXFOfPp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

Commit

  89969a842e72 ("usb: gadget: uvc: configfs: Sort frame intervals upon writ=
ing")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/..8lR9/Yd17k9=1oeXFOfPp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu4F+YACgkQAVBC80lX
0GzhcAf/Yy3HzDJwuZS6zifLkiaXdEye1AAD3Ff03iup9iNnIxfkv6N+EWcgYzBh
dYwCRRrjVnbTT/Dsigx7G7263dMAtnm0QFr8/H3qfChX1nfHqUhg0jYplV+KwxZV
URi1yvsdVW8oIWZf7RHnHdfwCv31QJQOFWrAotqfLetkSwRQV73yncQLbPqPMOgy
GEv9uIMAFqfbAjAxfwdW5s0X0P0oaIlmtRzKVKh4sGXyPnA+44QJcHIhcPl6wVBi
harx/Psn8uOZAOfn7IPE36XsBlWE6hfZKt76rmC+N1+rEK3WFFh3Shlf7lgICvwG
7Toe27hdEpuYGNkXBRBiGMhlu5mqjA==
=kkA8
-----END PGP SIGNATURE-----

--Sig_/..8lR9/Yd17k9=1oeXFOfPp--
