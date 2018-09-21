Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6539ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770EC21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Dgnwdr8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770EC21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbeIUGII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:08:08 -0400
Received: from ozlabs.org ([203.11.71.1]:56001 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeIUGII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:08:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GZ6G2q5Jz9sDB;
        Fri, 21 Sep 2018 10:21:57 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537489319;
        bh=IgdYSmYeXaUTf10pDb9COLEFeYIf7rWijQERRgEDcfw=;
        h=Date:From:To:Cc:Subject:From;
        b=Dgnwdr8L/hfvuU/KOuFA6G+wSqLs4bBtqNbOHHA+o1ShjJLoRZcVkAYsAM9/V8h/Q
         P0EcX74b0vhR4I5dCktZZ2DA0IBTDG9TEjdlV/8QoqTSbZKv3eRMe7+3LnZtmWj21c
         LmreWQAMgnQd1e/ctotVIvLsOC/2+pLCQ3nopgBf/vmrXguZqnV+7YDnK9GAjcolOe
         dpNl3SeYzvU0+eOGauPd7n9czyf2jbow2ucPDCseSde3TwSyrBfKEPnpeTbY1oG3Di
         k1FmXjOtSPmop4DF8zv4xAwhHabYchJDynwGelB5nkI8rIuE+atO3FCT+4j/P8POUX
         Uy6B3bIaDR1rg==
Date:   Fri, 21 Sep 2018 10:21:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: Signed-off-by missing for commit in the drm tree
Message-ID: <20180921102140.4ffca60d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RTYmUSbv36WW6UUBw4taHpl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RTYmUSbv36WW6UUBw4taHpl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7876fa4f55fd ("drm/amdgpu: add ring soft recovery v4")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/RTYmUSbv36WW6UUBw4taHpl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlukOZQACgkQAVBC80lX
0GykMAf/R4YRsv8AppoXwG16xVW9wptVq7hgSguRiVB2gMcjr3V52y+8DBo2JRrR
B1ct/jIySF8NE01HRm4QzIp9KtwOuTzhDDgQejgvu5cS02Zvc/wMw/1vIO2Zh9Cc
AzZ+7iqvIcL9UhAHEIJ3XHXYRnV9oLW3iDEsiakbmGlPSixyYa7uc6dZQJVAvybl
/BIT9+B5mdWPz+hsCDtzxe9+GJd8qDZpjS9zEb6H+XxeuyeYz+MKqkkJR3X6CVJz
+OSD98IR/3ZfqL14NI1OokDMys8LVP7+7d2qKkAr8CR16ute5CEimmwny/VqEI+E
nc6FzDlccuPK7vvjZjVfCmf3au+P/A==
=xYT/
-----END PGP SIGNATURE-----

--Sig_/RTYmUSbv36WW6UUBw4taHpl--
