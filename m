Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7C5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADCB20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADCB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLCAYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:24:43 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:37770 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeLCAYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:24:43 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9A88D72CA65;
        Mon,  3 Dec 2018 03:24:36 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8DA3E7CCE9D; Mon,  3 Dec 2018 03:24:36 +0300 (MSK)
Date:   Mon, 3 Dec 2018 03:24:36 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/15] m68k: define syscall_get_arch()
Message-ID: <20181203002436.GA9487@altlinux.org>
References: <20181120001128.GA11300@altlinux.org>
 <20181120001524.GF11387@altlinux.org>
 <CAMuHMdV+-Lw-mx8OAifrFP--XhbiHr8hAZ56rsG=9Ayu9BeXtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV+-Lw-mx8OAifrFP--XhbiHr8hAZ56rsG=9Ayu9BeXtw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Sun, Dec 02, 2018 at 11:29:10AM +0100, Geert Uytterhoeven wrote:
> Hi Dmitry,
>=20
> On Tue, Nov 20, 2018 at 1:15 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> > syscall_get_arch() is required to be implemented on all architectures
> > in order to extend the generic ptrace API with PTRACE_GET_SYSCALL_INFO
> > request.
> >
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>=20
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> What's your plan w.r.t. the upstreaming strategy?
> Do you plan to get this series in as a whole, or through individual archi=
tecture
> maintainers?

Given that the last patch in this series adds an argument
to syscall_get_arch(), my plan is to get this series in
as a whole along with PTRACE_GET_SYSCALL_INFO series.


--=20
ldv

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcBHfEAAoJEAVFT+BVnCUIv3IQANEYpjiuqjrx7/vCgL6hw4aU
s6HDODsgDAjjBjtPQk6/f/cDxKt8PJixYYdIB/XQFIOopARMwdwMmJ9Qv11WW1Wo
FcN2NIC74unafyWdaiss6/M5UAAstuKps7LCWPV6Lnhe7jR7Z8Imkz8ESL0070EH
fZcl4lnqrpukaISh4XPu3E5egiSzM0emWc/CwyotRirujLJ3AvCJrGBOyOzLaJBu
BuJo1Q3kZkPRsZvXjMn56fcWI2GfN2bjmtxxBLvmkcxFkkeQCQguhbAJ9SxYBHL7
c7W9Ov43TX85IEy6rpsr0ohBQUMyDMPxFp1chSayODDxOh6gnSiy7yLcFjk9ufvi
Poh0O5HUQRVlgvUcYD6spQ1xzroganvbmFdP9ypXUGw2myfQIKJ5fzeW0HcN5zgV
VtkT2EEV4jEufpz+lSbaeBmhbC4Gk6/AALfyaJQwyey2/8tGJRzRUvonPt+smf6L
9giJpoUP3Uj/VtoNrVbPZ6AFunOYu3/xk7WKc50ZtUjpfxs+G16B3XMw89PYNamu
LVcVVDxcqxM+OPkOka0xe8RhgFOwG0DQbBJ7sGU4ePm/aQJ4zXwYUU/qusk6wEOQ
9NsX9KidkeGHiKFkdPxw0Jklh618M5zcww2cTFQnrZWEAgbWuWQDt56LhTc5z5Yq
LGGFLKlDR1Eop8GVyRbl
=xI3X
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
