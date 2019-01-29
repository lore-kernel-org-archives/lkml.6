Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08007C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D743421848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfA2SGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:06:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46880 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727368AbfA2SGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:06:54 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1goXmc-0008Tj-BB; Tue, 29 Jan 2019 18:06:50 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1goXmc-0003wT-6b; Tue, 29 Jan 2019 18:06:50 +0000
Message-ID: <934aa59c4bd5d683d75651cbec78680cddd94cd9.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16] Backport of x86/vdso: Fix vDSO syscall fallback
 asm constraint regression
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Matthew Whitehead <tedheadster@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org
Date:   Tue, 29 Jan 2019 18:06:45 +0000
In-Reply-To: <1547901624-10766-1-git-send-email-tedheadster@gmail.com>
References: <1547901624-10766-1-git-send-email-tedheadster@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-whdOUujC0YmIti1Vf284"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-whdOUujC0YmIti1Vf284
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-01-22 at 14:51 +0000, Matthew Whitehead wrote:
> On Fri, Jan 18, 2019 at 9:07 PM tedheadster <tedheadster@gmail.com>
> wrote:
> > I do not see this problem with the upstream kernel, so 3.16
> > probably
> > needs a missing upstream patch.
>=20
> This was indeed fixed by Andy Lutomirski's follow-up patch "x86/vdso:
> Fix vDSO syscall fallback asm constraint regression". I tested part
> of Andy's patch and it resolved the failure.
>=20
> The 3.16 LTS kernel does not have the
> tools/testing/selftests/x86/test_vdso.c code, so a partial patch is
> indicated, unless Andy wants to provide that.
>=20
> Kindly backport to 3.16 LTS series.
[...]

I've queued this up now, thanks.

Ben.

--=20
Ben Hutchings
The obvious mathematical breakthrough [to break modern encryption]
would be development of an easy way to factor large prime numbers.
                                                           - Bill Gates



--=-whdOUujC0YmIti1Vf284
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlxQljUACgkQ57/I7JWG
EQnzmg//WisAFOeQbElQAnhnTDExOXgSZXoB1NuAKlbDV3VYtxlyx6+a72RzuiRk
vTCod5yNan+KtiUer3VBrukEmK7sY29B7yA6bxGub+UEaNoXt+N2SJ6wIXiocIuP
Owcd871Kx+WeNEdl+xdHL4Qfgj5Hr8ln7WIV/gdATobTI4xp9rssfIpiYdhbnUIn
tCifMscNLdmwGJxWelbqJedwsUn2G6SSV2r+TJvoW5TbFuMs6QJX2/PZMAPzlGzB
4QfDklx6c+tzIa6hYa/mDx7RxKODTPjZVgDjQjOStOi3pB/vO20JuhiV4GSjrxl4
RwDMr3UXousMesvakbojYnrR0/LZv5R0i/f4L61Wu+4Lk42shL3XI1xOQg9AdDo5
Rug8C9yQJp02kUs0UI++EdjAew15CnCQ+75Sk0qo9NYRloxTKf+yU1GGD07jX+e7
5bL/6aOLvt3/T888+fggp7oeJIrPiPmbd+Ijo7FeL0hTvESu5im6W3qRD0/5bpCa
didOmZuH/IrFJz2Mu7iDFYiBgr1eO2KlkG0Ebkqc8FZwgi/ArB4pCm51cCY13RYE
Xq6mNpctof6fhAaLYrlLhMQPEh8O+huH8mLjtlo0smI/f4g3WZc0YIA6u2j88TZk
magnGnzH2vLOwlH86V0telAkXcJgZz7j0LeSq92as+hTO9QqZ9w=
=UfHX
-----END PGP SIGNATURE-----

--=-whdOUujC0YmIti1Vf284--
