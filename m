Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A2CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFA223F16
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DudmP0QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFA223F16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeGDVtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:49:15 -0400
Received: from ozlabs.org ([203.11.71.1]:34701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752667AbeGDVtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:49:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41LZPz3ggdz9s2R;
        Thu,  5 Jul 2018 07:49:10 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530740951;
        bh=4c7ulahMS9yjpMYifR9lOes6D1EFc8ChwrZilMJwN8U=;
        h=Date:From:To:Cc:Subject:From;
        b=DudmP0QCBhGxOzf0pqfOOHt9xSnBW6OzpPZcMoPvTAEBCvLPPpCI3UimzsSoUSmKv
         G2mDsyyLmMJsJGzHd7a/NBF4Ph9KsXvnuwmlDymVIgwmgi/OOkZYU6AyxfDXSJS7AJ
         ehJcIo6KuQ4nHaCaY+J+B2xbXR/t9v6L4XgNFTeY0LTSM864st5TRthm4p4NM7jxcc
         lFjUEhTloCRJ+q8pmFHV4jOq/rJVZNDe2r4lMDJoHpGwYu86SjhldVeYiVc3VZ8+dR
         k26P2C9zuA9xPef286XSWp0ZFldA6/BRp0Tmr/Md9Oxt9+J4XkTjvTjIkGFSZSlQ3n
         XKyspWuWE1Qnw==
Date:   Thu, 5 Jul 2018 07:49:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20180705074905.23b11080@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.WgibyCgcRJSPwC35p13fmi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.WgibyCgcRJSPwC35p13fmi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  33bd5ac54dc4 ("net/ipv6: Revert attempt to simplify route replace and app=
end")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/.WgibyCgcRJSPwC35p13fmi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls9QNEACgkQAVBC80lX
0GykAAf/Sroz4WOUeA2FxXTjaA86lHsw4c8iFcBlWY7gza/qHCf73cfCi8DluJSK
QVL7CqxzUD97KNhlpjkEYx8wKP49ummfPiBjsh28n0/askBZ4CUK1CcbzkaX9Rnm
nxav6N8SeSbKbeMlrwGC6XoelFDinpfdZ6Ldy+rGvwViru5kpKlIVQ2bhdMk5hBZ
BtZoGgPg1vLNxiXxha36jjXYw1J3bdXNeKAPsv9hKhcfla/uNfroDZBhYmflCMH/
5JZzVvWEN4QE6bCxSQDXJ107D1x0keS2me93LT5KGebhgTPrMYrgARCzPQd2TNLI
yfSvMhOT6q0Q2A6UXEcZ5b7HsRDMrQ==
=ylyy
-----END PGP SIGNATURE-----

--Sig_/.WgibyCgcRJSPwC35p13fmi--
