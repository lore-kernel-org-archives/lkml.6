Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81755ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237ED20652
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J4ETu3c8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237ED20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbeIUOx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:53:29 -0400
Received: from ozlabs.org ([203.11.71.1]:37859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389235AbeIUOx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:53:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GnkP3JRZz9sC7;
        Fri, 21 Sep 2018 19:05:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537520733;
        bh=c/UT0/iYEjgMyhEVoR1W0DkIOmkMVIwrXSBnYViLNhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J4ETu3c8c1SOpFONVeBDk+rpCKybKbNN000VdU91pJOfJCXy2vxzAGUZmU47VjXuZ
         vccwUjcG5osnBeae/16WEVOShxojkKLFQGivLFxz+HAYcr285uyb95GLs+wBSm+L+S
         h84RxNoKJvqb/K6hEtrWgUEvqptcSIsOsn5a1g/fH9mRmEuYEUwrpxB8vWkHVDrz8I
         NYcg6NKmG01B8gqi0XkbYe8YpkUzPaMfwO30yqAmJlZY0RrrY8ln+VMxYFXu+l5Qc5
         MQHaQqiez/XZBBsmvu60UC0BauctrYkK3rbI34xN4xvDWhLAOCxR+/naOh2T/GDxuw
         gBydeOc++/1Jw==
Date:   Fri, 21 Sep 2018 19:05:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [REVIEW][PATCH 9/9] signal/powerpc: Use force_sig_fault where
 appropriate
Message-ID: <20180921190532.1fc443f0@canb.auug.org.au>
In-Reply-To: <20180918175850.4437-9-ebiederm@xmission.com>
References: <878t3yitze.fsf@xmission.com>
        <20180918175850.4437-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LvvCWtQn0+MyTAxO+aensSW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LvvCWtQn0+MyTAxO+aensSW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 18 Sep 2018 19:58:50 +0200 "Eric W. Biederman" <ebiederm@xmission.c=
om> wrote:
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Again, looks all good to me.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>
--=20
Cheers,
Stephen Rothwell

--Sig_/LvvCWtQn0+MyTAxO+aensSW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluktFwACgkQAVBC80lX
0GxUZggAjfzzqiy0I2AO7lFNh2CfaFDcrUYOuRhMUQ8cCkh4xzo0LGIJUjrjSUVg
yiYBNCa1IkxfvhO9p0mCPOo6UFOxVDDmG+szKObU7uUpTLyfqF/YOJucdzvYZj56
8UukU/if+4cPgJCrsLyIYRrnJ3njeKN1UhCy6prUBIXK7hOfK3xGbHUo5MWm31A/
48iwE9rpB2JmBgubhCvEE7cpZWFH1QMjPMn74x8sxPZsU7581Hu+Es5d+eMdH902
nMqyukQvYjrmau3jSAbK/3bspU2LTcB/eBZRkkpX2/loSqgPpqCfuZibjzpWVz98
jx8mpkClmnRO6dkhVEjWcpz758lVzA==
=7xuH
-----END PGP SIGNATURE-----

--Sig_/LvvCWtQn0+MyTAxO+aensSW--
