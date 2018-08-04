Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA40C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41ED217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 11:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41ED217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.carbon-project.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeHDNEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 09:04:30 -0400
Received: from blackmesa.kw-serverwartung.de ([78.46.90.79]:53490 "EHLO
        blackmesa.kw-serverwartung.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726855AbeHDNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 09:04:30 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Aug 2018 09:04:29 EDT
Received: from localhost (localhost [127.0.0.1])
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTP id C87F37B806E;
        Sat,  4 Aug 2018 10:59:47 +0000 (UTC)
Received: from blackmesa.kw-serverwartung.de ([127.0.0.1])
        by localhost (blackmesa.kw-serverwartung.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zqlm8zZH6lwF; Sat,  4 Aug 2018 10:59:45 +0000 (UTC)
Received: from [192.168.178.22] (p54AF7608.dip0.t-ipconnect.de [84.175.118.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by blackmesa.kw-serverwartung.de (Postfix) with ESMTPSA id A06CA7B8033;
        Sat,  4 Aug 2018 10:59:45 +0000 (UTC)
To:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
In-Reply-To: <20180803062828.GA9708@kroah.com>
References: <20180803062828.GA9708@kroah.com>
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
Subject: Re: Linux 4.17.12
Message-ID: <afe8b55a-6cd3-b193-4cd6-8f78baa5298d@dev.carbon-project.org>
Date:   Sat, 4 Aug 2018 12:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="U9rmKbMz2CeDBdQnU881yyTqRgj5jWmxU"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U9rmKbMz2CeDBdQnU881yyTqRgj5jWmxU
Content-Type: multipart/mixed; boundary="We6rzefoqGWAZ4NuPVm7f1ZoI0APqNm3m";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>
To: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org,
 stable@vger.kernel.org
Message-ID: <afe8b55a-6cd3-b193-4cd6-8f78baa5298d@dev.carbon-project.org>
Subject: Re: Linux 4.17.12
References: <20180803062828.GA9708@kroah.com>
In-Reply-To: <20180803062828.GA9708@kroah.com>

--We6rzefoqGWAZ4NuPVm7f1ZoI0APqNm3m
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hey Greg,
as with the 4.17.11 release, there is no signature file for the patch
(<https://cdn.kernel.org/pub/linux/kernel/v4.x/patch-4.17.12.xz>. Could y=
ou
please add a signature for that patch?

Thanks,
Kai


--We6rzefoqGWAZ4NuPVm7f1ZoI0APqNm3m--

--U9rmKbMz2CeDBdQnU881yyTqRgj5jWmxU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQHGGOoanjvCkOaaid97R0LvoA5AgUCW2WGbgAKCRB97R0LvoA5
AmwJAQCiCGE/tQU9056MpkFsTYNqLuZJz6CTdJ3xrNpSLXzywgD9EDfVjv8uDM5A
zsW2XKyEFEY+tOChRcpSNFNn3+iBPA4=
=Q2s6
-----END PGP SIGNATURE-----

--U9rmKbMz2CeDBdQnU881yyTqRgj5jWmxU--
