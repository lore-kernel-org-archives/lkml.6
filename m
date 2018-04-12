Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeDLTAe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:00:34 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:45428 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeDLTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:00:33 -0400
X-Google-Smtp-Source: AIpwx4+uW8GRNLt0PL1DQmAtxRRTo/trRRRcGg0S3hoYfZ04cX0MfiNa/8k1NqjzjhaT33J9BrYiqQ==
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
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <0d238bfc-3386-335b-e2c6-310b97db4421@linuxfoundation.org>
Date: Thu, 12 Apr 2018 15:00:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180412142845.6b97b223@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dlBO1wqCmtR14XvnMHWdOnjy6Ew5DmqpA"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dlBO1wqCmtR14XvnMHWdOnjy6Ew5DmqpA
Content-Type: multipart/mixed; boundary="cUjOPY8rol1xPkkPIwjQqbT9YyPAxyl9P";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Konstantin Ryabitsev <mricon@kernel.org>
Message-ID: <0d238bfc-3386-335b-e2c6-310b97db4421@linuxfoundation.org>
Subject: Re: [PATCH 0/5] [GIT PULL] tracing: A few last minute clean up and
 fixes
References: <20180412015359.244491749@goodmis.org>
 <CA+55aFxHPAzO-U+Q2RVjpAd4T6oM_Puor5qRC8pPYOdohO2L_w@mail.gmail.com>
 <CA+55aFzPhRdZSX2wMiiact8RpnYMHy48RK+Ng7n_Ek_vpYy3fg@mail.gmail.com>
 <20180412142845.6b97b223@gandalf.local.home>
In-Reply-To: <20180412142845.6b97b223@gandalf.local.home>

--cUjOPY8rol1xPkkPIwjQqbT9YyPAxyl9P
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 04/12/18 14:28, Steven Rostedt wrote:
> That is 4096. I pushed it to the key servers about a half hour ago,
> hopefully, it has made its way around, as I'm going to start using it.

I semi-heartily recommend using an ECDSA key instead (ED25519), because
it will be much faster and we know they work fine for Linus since jejb
uses them to sign his tags. My understanding is that 4096-bit RSA keys
are pretty slow on Nitrokey Start devices.

If you want to stick to RSA instead of the new-fangled ECC (if you can
call a standard from 1980s new-fangled, that is), there is really no
benefit to having a signing subkey stronger than 2048 bits, especially
for the purposes of signing git objects -- which are only as strong as SH=
A1.


Regards,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--cUjOPY8rol1xPkkPIwjQqbT9YyPAxyl9P--

--dlBO1wqCmtR14XvnMHWdOnjy6Ew5DmqpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWs+szQAKCRC2xBzjVmSZ
bA0sAQDlsetgiI63VJODbW82zf6SPphqIpeipvp2eGGQ8pZyVwEAsXHgekm7BDam
2ShKxs1808dFZh/eNRr+mIY5Nj2iFQo=
=4qSB
-----END PGP SIGNATURE-----

--dlBO1wqCmtR14XvnMHWdOnjy6Ew5DmqpA--
