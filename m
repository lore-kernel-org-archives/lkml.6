Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeDLTzl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:55:41 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:38453 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbeDLTzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:55:39 -0400
X-Google-Smtp-Source: AIpwx4/X/Zrm4S1X7ZZkqirNYebLwX/2qc6eOhbF2w+uPMwbHQ+D9PP0oZYMbx4Cri0F/lJUsgDuEA==
Subject: Re: [PATCH 0/5] [GIT PULL] tracing: A few last minute clean up and
 fixes
To: Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Ryabitsev <mricon@kernel.org>
References: <20180412015359.244491749@goodmis.org>
 <CA+55aFxHPAzO-U+Q2RVjpAd4T6oM_Puor5qRC8pPYOdohO2L_w@mail.gmail.com>
 <CA+55aFzPhRdZSX2wMiiact8RpnYMHy48RK+Ng7n_Ek_vpYy3fg@mail.gmail.com>
 <20180412142845.6b97b223@gandalf.local.home>
 <20180412154659.29f5c905@gandalf.local.home>
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <a59bbc6d-6cd3-9525-33d1-42b186c5b061@linuxfoundation.org>
Date: Thu, 12 Apr 2018 15:55:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180412154659.29f5c905@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ekexysLOZnnpANopdTPSQbJDe6uLMZDqV"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ekexysLOZnnpANopdTPSQbJDe6uLMZDqV
Content-Type: multipart/mixed; boundary="zGhjpiHUP4DQyfAOlPvO2vJWBZ09m0wzJ";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Konstantin Ryabitsev <mricon@kernel.org>
Message-ID: <a59bbc6d-6cd3-9525-33d1-42b186c5b061@linuxfoundation.org>
Subject: Re: [PATCH 0/5] [GIT PULL] tracing: A few last minute clean up and
 fixes
References: <20180412015359.244491749@goodmis.org>
 <CA+55aFxHPAzO-U+Q2RVjpAd4T6oM_Puor5qRC8pPYOdohO2L_w@mail.gmail.com>
 <CA+55aFzPhRdZSX2wMiiact8RpnYMHy48RK+Ng7n_Ek_vpYy3fg@mail.gmail.com>
 <20180412142845.6b97b223@gandalf.local.home>
 <20180412154659.29f5c905@gandalf.local.home>
In-Reply-To: <20180412154659.29f5c905@gandalf.local.home>

--zGhjpiHUP4DQyfAOlPvO2vJWBZ09m0wzJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 04/12/18 15:46, Steven Rostedt wrote:
> On Thu, 12 Apr 2018 14:28:45 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>> Primary key fingerprint: 5ED9 A48F C54C 0A22 D1D0  804C EBC2 6CDB 5A56=
 DE73
>>      Subkey fingerprint: B5D7 BDD5 67E0 67A3 EE0C  9FBE 3F0B D661 FC59=
 E3D3
>=20
> Don't use this key.
>=20
> Konstantin wanted me to make a ECC key, which I did. Here's the new key=
:
>=20
>    Subkey fingerprint: 514B 0EDE 3C38 7F94 4FB3  7993 29E5 7410 9AEB FA=
AA

Nice!

You don't actually have to tell people the fingerprint, as the subkey
will inherit the trust/validity of your master key. For the recipients,
it's sufficient to just refresh your key:

gpg2 --refresh-key rostedt@goodmis.org

To validate ECC tags, you will need to tell git to always use gpg2,
since gpg1 doesn't know what ECC is:

git config --global gpg.program gpg2
git config --global gpgv.program gpgv2

Regards,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--zGhjpiHUP4DQyfAOlPvO2vJWBZ09m0wzJ--

--ekexysLOZnnpANopdTPSQbJDe6uLMZDqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWs+5twAKCRC2xBzjVmSZ
bApqAP4hxcnBp12QRdkkKHspr6fGBq0Uty34ePvlme+tbSf2iQEApWonMIgKRgxB
mMVxSuMYxqOykpncj95hvQmyd9fcdQw=
=pcKz
-----END PGP SIGNATURE-----

--ekexysLOZnnpANopdTPSQbJDe6uLMZDqV--
