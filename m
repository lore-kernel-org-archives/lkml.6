Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A33C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A164217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A164217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.carbon-project.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbeHDOkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:40:06 -0400
Received: from blackmesa.kw-serverwartung.de ([78.46.90.79]:54074 "EHLO
        blackmesa.kw-serverwartung.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbeHDOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:40:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id B93077B8075;
        Sat,  4 Aug 2018 12:42:26 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BkOA1GukyBhJ; Sat,  4 Aug 2018 12:42:24 +0000 (UTC)
Received: from [192.168.178.22] (p54AF7608.dip0.t-ipconnect.de [84.175.118.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id 7FF1B7B806A;
        Sat,  4 Aug 2018 12:42:24 +0000 (UTC)
Subject: Re: Linux 4.17.12
To:     Greg K-H <gregkh@linuxfoundation.org>
References: <20180803062828.GA9708@kroah.com>
 <afe8b55a-6cd3-b193-4cd6-8f78baa5298d@dev.carbon-project.org>
 <364B6D5B-B609-4AA4-B1E6-F93B965FD010@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
From:   =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>
Openpgp: id=071863A86A78EF0A439A6A277DED1D0BBE803902;
 url=http://db.debian.org/fetchkey.cgi?fingerprint=060096CEF3C8E733E5B61587A309D76CE1DE59D2
Autocrypt: addr=kai@dev.carbon-project.org; prefer-encrypt=mutual; keydata=
 mDMEWxlO6RYJKwYBBAHaRw8BAQdAb87LOUtKaNFQxavEeliQ510Ivqg7xM0poHcvqDA7zhq0
 LEthaSBXYXNzZXJiw6RjaCA8a2FpQGRldi5jYXJib24tcHJvamVjdC5vcmc+iI0EExYKADUW
 IQQHGGOoanjvCkOaaid97R0LvoA5AgUCWxlO6QIbAwULCQoNCAQVCgkIAxYDAgIeAQIXgAAK
 CRB97R0LvoA5AnKvAQDKdB27zpNfY60nV+RL8V01HJpYBKnUHS30+Z+6SB/FBQD+OenidFS5
 dgHngtcRKjD+GBjC7SUYG72naTr2p/FReA24OARbGU7pEgorBgEEAZdVAQUBAQdAoS3gvzlS
 o6GP34XWmY/ekcAbm3EknjYvh2dPtQYqQ0MDAQgHiHgEGBYKACAWIQQHGGOoanjvCkOaaid9
 7R0LvoA5AgUCWxlO6QIbDAAKCRB97R0LvoA5AsdDAQCg9t/O5JGyz+bytbg+owq+vrNQquRp
 Hvm24wPR+mzO+wD/WzSwUGqu6iM9NmV5IoYpJtHI/Ldh+I8jksYtm6Jb7Qc=
Message-ID: <9b338bb8-2156-33e9-d310-440381e9640d@dev.carbon-project.org>
Date:   Sat, 4 Aug 2018 14:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <364B6D5B-B609-4AA4-B1E6-F93B965FD010@linuxfoundation.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QBcgLBPz1fqGvm4ut0a5I2Okz0YKdvthx"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QBcgLBPz1fqGvm4ut0a5I2Okz0YKdvthx
Content-Type: multipart/mixed; boundary="4hP4dvzIGFaV5xouydI17WceOBtgXXnxk";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>
To: Greg K-H <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-ID: <9b338bb8-2156-33e9-d310-440381e9640d@dev.carbon-project.org>
Subject: Re: Linux 4.17.12
References: <20180803062828.GA9708@kroah.com>
 <afe8b55a-6cd3-b193-4cd6-8f78baa5298d@dev.carbon-project.org>
 <364B6D5B-B609-4AA4-B1E6-F93B965FD010@linuxfoundation.org>
In-Reply-To: <364B6D5B-B609-4AA4-B1E6-F93B965FD010@linuxfoundation.org>

--4hP4dvzIGFaV5xouydI17WceOBtgXXnxk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Greg K-H wrote on 04.08.2018 14:30:
> On August 4, 2018 12:56:23 PM GMT+02:00, "Kai Wasserb=C3=A4ch" <kai@dev=
=2Ecarbon-project.org> wrote:
>> Hey Greg,
>> as with the 4.17.11 release, there is no signature file for the patch
>> (<https://cdn.kernel.org/pub/linux/kernel/v4.x/patch-4.17.12.xz>. Coul=
d
>> you
>> please add a signature for that patch?
>>
>> Thanks,
>> Kai
>=20
> https://www.kernel.org/minor-changes-to-tarball-release-format.html

Oh, I must have missed that! Sorry for the noise then.


--4hP4dvzIGFaV5xouydI17WceOBtgXXnxk--

--QBcgLBPz1fqGvm4ut0a5I2Okz0YKdvthx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQHGGOoanjvCkOaaid97R0LvoA5AgUCW2WecgAKCRB97R0LvoA5
AoXGAP9Dmpw4CdhqXDiufNAzmw2MTvEte6vdwLCxFbC1Q1FuSwD+MiPS3yFHmt+c
lyvegtCJEJxUBWnxfIxeKZYzSWN7ewY=
=XYyR
-----END PGP SIGNATURE-----

--QBcgLBPz1fqGvm4ut0a5I2Okz0YKdvthx--
