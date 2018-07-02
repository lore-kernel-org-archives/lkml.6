Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D19B25D4F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NNCRkCiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D19B25D4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeGBVmU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:42:20 -0400
Received: from ozlabs.org ([203.11.71.1]:42887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932079AbeGBVlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:41:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41KLLP5S06z9s2R;
        Tue,  3 Jul 2018 07:41:49 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530567709;
        bh=QdvFWwrMLXU8RE1/8wZMCvpyxzrS6B0siQl6ItIjxps=;
        h=Date:From:To:Cc:Subject:From;
        b=NNCRkCiz3GysyuyavMpdk/g0BGfPSq8uct6aGuHzgB6JPoDzEwO1vI86FSi9St5EI
         EzvCt1tPBoh5bDnnJNfL+gP+MyYfQff7BCeAWr4wX0859/Z+klYTjyebK8TbENR44J
         cAAFvU+ygU2waE9RYNwZbzHqH7bn+1RKfj8+yWMeAkqXfSWVNk100DCmWAOi+a3fZG
         +y5AftirQkTNcp4C1u/g4JzZNJvOsx6AJQXA1gdbuMKO9vcbWH2+jQkCRHkS3Qt1dt
         4CHqjuyM8LYQikoekpzOgQlRpi9OXaKWD22eVw45hON0UICweJssRht5IPzJ1RTGks
         PPdqOvHOM1hoA==
Date:   Tue, 3 Jul 2018 07:41:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the omap tree
Message-ID: <20180703074143.3947b094@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eHb6nov.o6xrU6gFJ/zthJY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eHb6nov.o6xrU6gFJ/zthJY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Commit

  5322c19b117a ("ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/eHb6nov.o6xrU6gFJ/zthJY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls6nBcACgkQAVBC80lX
0GwI/Qf/cPVzdF/coLtj0WhLsnGtH6rDzglFOPvi0dkUF6Ssdr8l00GkHJyWYzWb
t/4bSDzMOAmDoh49RJfJ0z/L25PjC+KITHTCx0xOGv+EdvP0xNL27KHYr62V/q1f
BfzP4gx5hzeptzRrZeNJPYuTuj5UbZbm5TTdBrd9jNlGP/8yeYar7QzpQ1dTUd0O
rKvd92pVi0mp5XzyY+Rdg/1tRzt26bJQp0jmoWfpLi9EMcGu6FK3gH1sin4po7VU
G4kjUrZVOsLLBPL7VbneGL2i4zLFaqTaPwAfmOMy7te6Y+kaXAywqJhRA+WQBjML
SSJLIE3zWmpn/ouqUTZAsxPsZ4tlvA==
=wI3D
-----END PGP SIGNATURE-----

--Sig_/eHb6nov.o6xrU6gFJ/zthJY--
