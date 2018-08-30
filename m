Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1040C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4624120658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DeVikV9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4624120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeHaBls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:41:48 -0400
Received: from ozlabs.org ([203.11.71.1]:43161 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbeHaBlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:41:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 421bSG6jksz9s1x;
        Fri, 31 Aug 2018 07:37:34 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535665055;
        bh=/seg1j1D7PgyFmAJ9/BsaEzMj13Qh1XJddcGdloLeI8=;
        h=Date:From:To:Cc:Subject:From;
        b=DeVikV9vttVk8a3WlaumYj9MxtDyb7ICOerh+j6loLLfVFe3uTse2nIaRpWEyUN5W
         pd9S3Y1U5W6I97HYMBk6B1ajO3vn5Fa3tSszunmkYG+KlmYZpQW+QFOP5eoPGpv+Bg
         GSqkmNavKyUDCitf/nitz/fqBHMxpfhvucMmW3jfVA9vDwKvNzpAJQ6WbZiIffS//G
         Ux+krCFmtZKJzMH/11r5HAMkQo36IO9L2nulcgG8Wa6o8s4ttwet+aBrDICAogE+yK
         r8/nKvjknH1SwGRjLYDnGquPMRv6iIc42o7IhyLRqAqrZbP6j05rTfnDT4dvsyfWxG
         DBlumr0n6MRng==
Date:   Fri, 31 Aug 2018 07:37:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ipmi tree
Message-ID: <20180831073725.2cf9081d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NGhh8HcI6tL4LWDfp+3to7d"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NGhh8HcI6tL4LWDfp+3to7d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Corey,

Commit

  6320fd2c65b5 ("ipmi: fix return value of ipmi_set_my_LUN")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/NGhh8HcI6tL4LWDfp+3to7d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluIY5UACgkQAVBC80lX
0Gzdzwf/WAv8tEJUADTfXqJO1qsMGICI+TnFowF69caXT0qqefXeMTKHrvzI30DP
PG5lmK+D0EKUZ0I3rIWqI0NmwYnV90TB1+A5/nYc1+wAfhmIu5OBc07RivddmdBk
MQjCxub1NQXrUj31nnXHHe7PutLFA8BCpOpfG91lybL7fS1i/JRdNH8cmelBJe0q
T+2lshRsexgumGL6AasD9aPQhMy2RStRb6EKv9kKBau20swBhgzFRE8MKCyosAHc
sotVZ1CgqfWCfv7a/OA49ckRLZemuUOilMeUlpoelcuVxPre8F+WE0hUTQ6Bgr2s
Cn7cT6u0Uu4JV0nOwo96jgvDLa12zA==
=r+0o
-----END PGP SIGNATURE-----

--Sig_/NGhh8HcI6tL4LWDfp+3to7d--
