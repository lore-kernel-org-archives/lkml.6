Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03549C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C818B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h+xGUFqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbeLQUIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:08:15 -0500
Received: from ozlabs.org ([203.11.71.1]:53969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbeLQUIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:08:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JXJs00bVz9s1c;
        Tue, 18 Dec 2018 07:08:12 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545077293;
        bh=XQtDhtUVf0Q476UHcQQso2ZbVjdaC0R5E0Sc00wEygQ=;
        h=Date:From:To:Cc:Subject:From;
        b=h+xGUFqs7vuCibyq5r/SRMw96WFnDLo5yaeIK6qdfR99/g1Oli4Rew/es5cKvuh7k
         iPcxls2lUBhxfO4Ln7XAI4snL0t7JNLJcBwzvGX2PGduatIXhfWFwUl/yxEelSzVqD
         qPR+s1Hk337RE7rGDYqwVPqLDglKMzSCOGWG/taBkkKF32wiLnj0XRXVvFWkDdAEwM
         DUB1I/sWlqCIJHhnqp/oTwKhdWHfeAya5/J5ObwxHZFLhMUu+JHUFWJMj2vuhOE8Dk
         /91ptFjp0xIB51yvMIpFVLEnXxsXWdNjRlpMOLz87ons3w27npzWQVW5H8kQeYLSgW
         iP7q5vgwEHivQ==
Date:   Tue, 18 Dec 2018 07:08:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the printk tree
Message-ID: <20181218070807.07cb795d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qnrle3UzuAP1tkKsAbJw/G+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qnrle3UzuAP1tkKsAbJw/G+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Petr,

Commit

  503283fa006d ("printk: Add caller information to printk() output.")

is missing a Signed-off-by from its committer.

Moreover, that patch appears twice in the tree (the other time properly
signed-off),

--=20
Cheers,
Stephen Rothwell

--Sig_/qnrle3UzuAP1tkKsAbJw/G+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwYAicACgkQAVBC80lX
0GzvKwf/YNNcd4mgWnInFjdyuaD0pFiNYvkGwly6Pb3EXX/iHVBqqH703xJIU6lG
m3eUp69BEl9sMOPY8Gf+I+dwSTSQcSLuRyOiygIdvD5K+yZTMtB6OhXjegsU0x4i
aqigOeXkiyPLKCywHrgCuNjQZMiHtnBPKMmlcK4BjrNjIiZC+e9bU93IQ3Hud2ki
qG0lsMKAJtcDAoAmk6CRdHp98mk2khQtoR01XvQEz3KUraaMYG1cwdsrdqOpy7vF
Ac6UKTADOOd34QSxuaHAiEZIhviKy+cJXMsfZ0thA/MDAWasB6RL8WuX1ItUXyoW
gv97BmG7jY95Sn1aetXi618pYT2EXA==
=5e5x
-----END PGP SIGNATURE-----

--Sig_/qnrle3UzuAP1tkKsAbJw/G+--
