Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeBZUc7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:32:59 -0500
Received: from sauhun.de ([88.99.104.3]:38479 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753760AbeBZUc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:32:57 -0500
Date: Mon, 26 Feb 2018 21:32:55 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Steven Honeyman <stevenhoneyman@gmail.com>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Jochen Eisinger <jochen@penguin-breeder.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mario Limonciello <Mario_Limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Message-ID: <20180226203255.lnnzipipjz5l2itz@ninjato>
References: <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali>
 <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
 <20180131120348.azy25aqvn5wrdkeh@pali>
 <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
 <20180212153012.vffvjmz26ifyxbj5@pali>
 <CAHp75VfF+qwCXcr3yuayE-Z+UG9wuMOKfGzLhdyPk79daEi9gQ@mail.gmail.com>
 <20180213150004.5d2v7y7wwuure4io@pali>
 <CAHp75VfxgbFiDxyrqyMRE8s85L1_EzkVvrA1NGYA5_su=5oGVQ@mail.gmail.com>
 <20180213165023.xmzovx7fd3gdljxw@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zswupbexvwztthqj"
Content-Disposition: inline
In-Reply-To: <20180213165023.xmzovx7fd3gdljxw@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zswupbexvwztthqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I'm not maintainer of i2c-i801.ko, Jean Delvare & Wolfram Sang are.
> Therefore instructing future contributors would be up to them.

This is really Jean's realm.


--zswupbexvwztthqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUbvcACgkQFA3kzBSg
KbbdcA//TTyCuZh33VimGE+9TaemKkLPnBtK0Igsd48ULTWn076k7Ap/nzVcCaRf
coMlZXkLbWkAkDmpoJ9t6YvIxXzxrils7QIcizjO4jcXNqgJbSyy1ejSqqRZcuJb
p/9KcKZtDHY+EsgdO4meJohoRKUHxCp5tQ0p7Drlq+cFyVMYR4vvvh9gTDeTpH2p
c6qOKQqvww6iY+9lqr0B4nyiJkQHyeDKsKBlUl/ZeGfFUkSTWo/jxNIik/oZecx8
KLIiNN9FCcpp3j4UJVBBv70Kcrwq/2RkcfNzeqbqxLehI3jKVueIIt/tG9ZkvBvQ
pbie3C6QTuQrZgEkEGUcz/ipmmeGQ5jhLXksdoT/S74zTdBpeBpDP0GLa16pq9QQ
yg0oNYB6SIzrtWQmtmz8xOuJ1n/VkVgOjLynEDk07+i8C3CNWEn9XK6ORPwopfb8
MWkz/mhwzEoqKA4hPCY5Pyu0ha+vhc8xs845tNB2S/1ID6JOFbkHboKJFumrGzZu
lpbJd0keU3caV9IN4AEx+OT9IP9wJCJlfy+HD0dwziTpGgGBLbncBOFW/LqcfGLp
mgBrkxg6Dmr8qUS522CA2Mc4JaC75Qk5uzbwFEvz0nM8ASBX7U+J1Utn2BWEMraP
09VnTc37amGcZ3hX3Q/htQBid+fcV2UKQOo9b01XuCR0G7zIrgU=
=1eH4
-----END PGP SIGNATURE-----

--zswupbexvwztthqj--
