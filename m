Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx48Ulh0jyod2QiR6Aw33yi/Jsqu+k8Lc1QF7OVvqZgjp2UC0LGpFWkG4BT+rBBSp4ukv7ZIW
ARC-Seal: i=1; a=rsa-sha256; t=1524018827; cv=none;
        d=google.com; s=arc-20160816;
        b=zBbYHlKG7d1MANTPGEgjNP69RiDpvP9a0IX8W4O5hsQsIQ9KqTBEt1uV53I6hYHPtD
         hvjYim/51HsWnbdpdjmXD5bagpOXaP4XnDQDmyhQF2A5PErDzetOhpXahOYUkmLZxhEv
         +kOi5P3UxJEem04TBdUJBiXiE0hdQjodM46/IcZJlE/EUD6WEJD8MwUChRmOI6/6l/D3
         OS0ws3nve+MUfbtgfKs2R7alhCmjFmAyq+VsDl/LlVpG1kOpaMARIIxSSrUYPJb70m2+
         20dGqxLMKsvcuFAuQIVDX2st+ZTh4eCOxMyozEN+31nnvxSf/iSIsH2mtSJNert6aCJD
         oz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=Rv0xGUX6cA8qGeLBqUDVYxUdh3qbObR/H0VTIan2l4A=;
        b=uW93H1O/0ZLw9RvzOW8VL7MluOI3rqsx6GA0QYpz8rXbe/s4OZb6d5EJo2gD2D3EKN
         39jM8H8Jh15K6Q2tY2rion3v+zkrk2bUg7al/cCyeWSGwpYsvX4l90CMA6E2myrqCnxg
         rYXgqbcQbmKBJI4btPWY0eNUYxT4+RiKUUq4KOSzQo1kSV+KTvcynqVeUTv8AvujxI3p
         t4e3+59eJxOw134pISFCeMY19wD80bRmA741gOBcDPL/I34Bs4k07g/XOsRVGubabGBJ
         P3GqDx+Iodjv2kOF5s12zB68ShSEUPn06NP99OPWagrOOSgTMkPrhuZgE8rC8SvEDoGg
         tSYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Wed, 18 Apr 2018 12:33:39 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Dilger <andreas.dilger@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 3/6] staging: lustre: remove include/linux/libcfs/linux/linux-cpu.h
In-Reply-To: <alpine.LFD.2.21.1804160448410.16188@casper.infradead.org>
References: <152383910760.23409.2327082725637657049.stgit@noble> <152383935737.23409.2271901486597092772.stgit@noble> <alpine.LFD.2.21.1804160448410.16188@casper.infradead.org>
Message-ID: <871sfds0os.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861424153712105?=
X-GMAIL-MSGID: =?utf-8?q?1598049565759396429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16 2018, James Simmons wrote:

>> This include file contains definitions used when CONFIG_SMP
>> is in effect.  Other includes contain corresponding definitions
>> for when it isn't.
>> This can be hard to follow, so move the definitions to the one place.
>>=20
>> As HAVE_LIBCFS_CPT is defined precisely when CONFIG_SMP, we discard
>> that macro and just use CONFIG_SMP when needed.
>
> Nak. The lustre SMP is broken and needed to badly be reworked. I have it=
=20
> ready and can push it. I was waiting to see if I had to rebase it once
> the rc1 stuff but since their is a push to get everything out their I will
> push it.
>

Great - thanks for posting those.  I might wait until they land in
Greg's tree, then see if I there is anything else I want to add.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrWroQACgkQOeye3VZi
gbmjAQ//Z8nTtYK+zKwrhn6ytnL+JzOBwVVR2/mNn8brjxduxVqtYonNy+XJGRZJ
W4cGGqCGbgk57bHH1AAFs6EjkhqYjkrHyOXwODciHxRnTXtt+qie7rLliuX8ukiD
LbOroIWcZGEs9JrNdJwWkOGEMmdiJboFH2Ku19gvew9zHJJTEEg4fhxZQXQ4Mk6K
atQbtpB8aJWivD7sWQ1c2tIeOmfZB5NIcr8X/YtQPYcgEJkuX9Bu46ImLYeyphcL
l6u1/bMGN9aeraoCP5YfHGrEag0mS5nwHWP0nb6XER8PfZfK3WsNEtQBQ8Mi1UmQ
5NIBlSm7tBklyffU3skXilOneV/BW8kOHjvGnC79U3IyviQOKBwKYkGLO0XAeSxk
pdu+Wl+fOZgY6cq7LhNDgRk4Hb1gY/p8EiTuJDTMLaf2UT6R3X3NGFBcbXKiOfif
M1aGZOPpxBJMW6AnD8nrYlzRrqJ7hJwAmULvSqw+h6ZOZYqCX+i4NUT1qf0yd5yj
hBLF8f5JLxQVSj5M5dX/N0XfftGmH0+hEXQtJgCAkGRZOAH2L7pxYAzESnvxcGeo
HLsunnGY4+vbZ/BdYIRMhcXNmUZp4BHwgTyexudIbsv6GgoDEi2IYU5hhyqSPo3S
0fheL1MqCv0m5TVoEASVR1uZbUw97uMIw+4cWp3d/7L5vXCqreo=
=aBaO
-----END PGP SIGNATURE-----
--=-=-=--
