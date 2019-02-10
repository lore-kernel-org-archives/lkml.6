Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB5C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B620863
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfBJXIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:08:42 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:58718 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfBJXIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:08:41 -0500
Received: from [10.100.0.22] (host-37-191-231-105.lynet.no [37.191.231.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: k_f)
        by smtp.gentoo.org (Postfix) with ESMTPSA id A7276335D60;
        Sun, 10 Feb 2019 23:08:37 +0000 (UTC)
Reply-To: k_f@gentoo.org
Subject: Re: Licensing of include/linux/hash.h
To:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Ben Finney <bignose@debian.org>
Cc:     Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        919356@bugs.debian.org, debian-legal@lists.debian.org,
        linux-kernel@vger.kernel.org
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
 <20190123085000.fp7lhtjxcyzw3m4x@dumbo>
From:   Kristian Fiskerstrand <k_f@gentoo.org>
Openpgp: preference=signencrypt
Autocrypt: addr=k_f@gentoo.org; prefer-encrypt=mutual; keydata=
 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 kQ==
Message-ID: <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
Date:   Mon, 11 Feb 2019 00:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190123085000.fp7lhtjxcyzw3m4x@dumbo>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="UI1QkKzcn9akEglUPIq4rxlHik9gplcJC"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UI1QkKzcn9akEglUPIq4rxlHik9gplcJC
Content-Type: multipart/mixed; boundary="UyJehXtQNT6n86xSQqb2xjfex2i2LyM4G";
 protected-headers="v1"
From: Kristian Fiskerstrand <k_f@gentoo.org>
Reply-To: k_f@gentoo.org
To: Domenico Andreoli <domenico.andreoli@linux.com>,
 Ben Finney <bignose@debian.org>
Cc: Nadia Yvette Chambers <nyc@holomorphy.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, 919356@bugs.debian.org,
 debian-legal@lists.debian.org, linux-kernel@vger.kernel.org
Message-ID: <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org>
Subject: Re: Licensing of include/linux/hash.h
References: <20190115170017.5gxarqxzfezgr5ld@dumbo>
 <20190123085000.fp7lhtjxcyzw3m4x@dumbo>
In-Reply-To: <20190123085000.fp7lhtjxcyzw3m4x@dumbo>

--UyJehXtQNT6n86xSQqb2xjfex2i2LyM4G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/23/19 9:50 AM, Domenico Andreoli wrote:
> Ben Finney <bignose@debian.org> writes:
>> Domenico Andreoli <cavok@debian.org> writes:
>>
>>>   the situation of dwarves-dfsg improved a lot over the weekend
>>
>> That's good to hear. What is the event you're referring to? Can you gi=
ve
>> a URL to something that describes this change?
>=20
> Upstream (in CC) reacted to my request of clarification and patches
> have been applied upstream and on Salsa. See bug 919356 [0] (please
> keep in CC).
>=20
>>> the only knot left is now the license of hash.h
>>>
>>> This file is also present in the kernel [0] with an updated copyright=

>>> but still without license.
>>
>> The file you show (in the Linux code base) seems likely to have an
>> equivalent implementation under a different license, from some other
>> code base.
>=20
> This will require research and work unlikely to be done before Buster
> release. Are we going to drop this package for now?
>=20
>>> I received a private email from somebody in the kernel community who
>>> already tried to contact Nadia in the past but did not get any reply.=

>>
>> Thank you also for contacting the Linux developers forum to ask
>> <URL:https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1900=
588.html>.
>=20
> (also in CC now)
>=20
>>> I think that pushing it to non-free is formally the right thing but I=

>>> actually feel it's not the right thing.
>>
>> To know that work (that file) is free software, we need a clear grant =
of
>> some specific license, for that work.
>>
>> If the work is not free, it would be incorrect to have the work in Deb=
ian.
>=20
> Is it possible that for the kernel it is instead correct because it is,=

> as whole, covered by its COPYING?
>=20
>> Alternatives, for complying with the Debian Free Software Guidelines w=
ith
>> this package, include:
>>
>> * Find a credible grant of license under some GPL-compatible free
>>   license to that exact file. Document that explicit grant in the Debi=
an
>>   package. This demonstrates the work is DFSG-free.
>>
>> * Convince =E2=80=98dwarves-dfsg=E2=80=99 upstream to replace that fil=
e with a different
>>   implementation (I don't know whether such an implementation exists)
>>   under a license compatible with the same version of GNU GPL. Documen=
t
>>   that explicit grant in the Debian package. This demonstrates the
>>   modified work is DFSG-free.
>=20
> Arnaldo, what priority would you give to this task?
>=20
>>
>> * Replace that file in Debian only, with a different implementation as=

>>   above. Document that explicit grant in the Debian package. This
>>   demonstrates the modified Debian package is DFSG-free.
>>
>> * Move the work to the =E2=80=98non-free=E2=80=99 area.
>>
>> * Remove the work altogether.
>>
>> Those are in descending order of (my recommended) preference.
>=20
> Thanks,
> Domenico
>=20
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D919356
>=20

It was [pointed out] by one of our license group that [hash.h]  is the
same that has a GPL-2+ in [fio] which has a signed-off-by.

References:
[pointed out]
https://bugs.gentoo.org/677586#c1

[hash.h]
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/fio.git/commit/hash=
=2Eh?id=3Dbdc7211e190482f0c17c109a0d90834a6611be1c

[fio]
https://metadata.ftp-master.debian.org/changelogs/main/f/fio/fio_3.12-2_c=
opyright



--=20
Kristian Fiskerstrand
OpenPGP keyblock reachable at hkp://pool.sks-keyservers.net
fpr:94CB AFDD 3034 5109 5618 35AA 0B7F 8B60 E3ED FAE3


--UyJehXtQNT6n86xSQqb2xjfex2i2LyM4G--

--UI1QkKzcn9akEglUPIq4rxlHik9gplcJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEICl/zzfUVEdaBsDU24F+DhePmz8FAlxgrvAACgkQ24F+DheP
mz/Wawf/dPz7RKaij521cRnyLutWutYYy9bL7RfhsSAEHx9IVERaycN5TqeSKAzu
HHOR5ctXVA/NfSeIinTOPnan57lQdyMzG0tKD7PwmhrZuJzVd48Y5ojc8QOTJF8C
Q+HblRRZz2zg0nIuQF0/zeulsVyiE5/YLO3XTidDK3eQ1dn9x7hBFsADXOEyPdo6
FiTNxMLC+Mbvw56bzJP9oBCKII/FUqMQKYMhSxaxN+XnbccZbgW/FsabjAIbdmb1
zV7ctyE27xfLwsA3MOz+TjKLE8x++uc5sY1ficDAGTzJcQnB+S8xeWtc6Egot9FB
zo07DV54mF6XY1vsBE+Jko2gR9z1GQ==
=rX8F
-----END PGP SIGNATURE-----

--UI1QkKzcn9akEglUPIq4rxlHik9gplcJC--
