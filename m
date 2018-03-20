Return-Path: <konstantin@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521572090; cv=none;
        d=google.com; s=arc-20160816;
        b=Fayi2eUlFIRtEkVrbS4CYmOoc3c/K+4eDPu2ixh8TQdBtUzyuBKWVXANMAoxli01PK
         MZp4D6T5Fr9ittn6r6AFUPEJVzfaitHWxMH6fYpYXsqUe9jpp0FLinsRYw5n/iPPZ67A
         ETwPWAoD0D/TiSo06FsxnDPQf3VqzBj/r2MLaEc1pArfnHKu0Tcynbk1DUsmAhf1NH6P
         aCow88psp1ed3tDcavOnZO4IsCOSyekA0guuNT1KEmVVp+f6rZNNdr0Bh7cevk9voH2r
         GQ0IZSX2bGBROARCBW9ONTj25NirJXuCK0IXOAwOQ9BxU8dtOma/GLjcRKn+N4QZkD+Q
         5Q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:organization
         :from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=Wm2l7TNmYjHVXe5jC9OTAAxE+kkcPB3qur/+QaEML3E=;
        b=oaWABodLIWJfPnsEz9e0qN8G0obIZrOlLlafEOJSiJQkED595mhdG9IJhOTaMg0sDt
         bYngFuPTYigptC7A41NEN3m/kuxbDlBxf8LwwV/yx1O7pWUKlgZKtxXpjzE1AIt0SR8J
         vlsUSmJ/wFer68xPWa89UCwSpLwdAd0YE6bGm4KDVXtNfaK0rUgOqANQkkVl2V+RiLPL
         A4aJij9o4fU5v6+IjqhHsfzKri0mu8iErBocOFjuNw8lWMzZY8hYPqXZXPMVXOV2DBni
         ZMhXEAUjS6wIVQ/JgyKL208ki4QCIiqVCWz/S6kCw9KsmiBLmCZqZ1IoGePAvGIwAkSY
         L9CA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iG3SDk0L;
       spf=pass (google.com: domain of konstantin@linuxfoundation.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=konstantin@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iG3SDk0L;
       spf=pass (google.com: domain of konstantin@linuxfoundation.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=konstantin@linuxfoundation.org
X-Google-Smtp-Source: AG47ELv/mLnhWS36SEaNKWCAQqcbOrcLSc1LfnnM+qrPZ5ZEmgpwK/Z9Lp9TZTwY8rIlLKMLDEpBxA==
Subject: Re: [PATCH v3 19/20] firmware: add request_firmware_cache() to help
 with cache on reboot
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.de>,
 Thomas Gleixner <tglx@linutronix.de>, Jiri Kosina <jikos@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: akpm@linux-foundation.org, cantabile.desu@gmail.com, kubakici@wp.pl,
 linux-wireless@vger.kernel.org, keescook@chromium.org, shuah@kernel.org,
 mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com, dhowells@redhat.com,
 pali.rohar@gmail.com, arend.vanspriel@broadcom.com, zajec5@gmail.com,
 nbroeking@me.com, markivx@codeaurora.org, broonie@kernel.org,
 dmitry.torokhov@gmail.com, dwmw2@infradead.org, Abhay_Salunke@dell.com,
 bjorn.andersson@linaro.org, jewalt@lgsinnovations.com, oneukum@suse.com,
 ast@fb.com, andresx7@gmail.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20180310141501.2214-1-mcgrof@kernel.org>
 <20180310141501.2214-20-mcgrof@kernel.org> <20180320083055.GA21640@kroah.com>
 <20180320173409.GD4449@wotan.suse.de> <20180320173801.GA25040@kroah.com>
 <20180320182409.GF4449@wotan.suse.de>
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <5dc49c7f-56f6-28df-38da-bfa998afbdbb@linuxfoundation.org>
Date: Tue, 20 Mar 2018 14:54:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180320182409.GF4449@wotan.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dZnBsK6zJZIXdswTT4134XOJDdG4uDARv"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560438545867805?=
X-GMAIL-MSGID: =?utf-8?q?1595483976237952997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dZnBsK6zJZIXdswTT4134XOJDdG4uDARv
Content-Type: multipart/mixed; boundary="ky4SFbjlcXhHbJVEhY0MFmRXRqaODFEgR";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.de>,
 Thomas Gleixner <tglx@linutronix.de>, Jiri Kosina <jikos@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: akpm@linux-foundation.org, cantabile.desu@gmail.com, kubakici@wp.pl,
 linux-wireless@vger.kernel.org, keescook@chromium.org, shuah@kernel.org,
 mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com, dhowells@redhat.com,
 pali.rohar@gmail.com, arend.vanspriel@broadcom.com, zajec5@gmail.com,
 nbroeking@me.com, markivx@codeaurora.org, broonie@kernel.org,
 dmitry.torokhov@gmail.com, dwmw2@infradead.org, Abhay_Salunke@dell.com,
 bjorn.andersson@linaro.org, jewalt@lgsinnovations.com, oneukum@suse.com,
 ast@fb.com, andresx7@gmail.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Message-ID: <5dc49c7f-56f6-28df-38da-bfa998afbdbb@linuxfoundation.org>
Subject: Re: [PATCH v3 19/20] firmware: add request_firmware_cache() to help
 with cache on reboot
References: <20180310141501.2214-1-mcgrof@kernel.org>
 <20180310141501.2214-20-mcgrof@kernel.org> <20180320083055.GA21640@kroah.com>
 <20180320173409.GD4449@wotan.suse.de> <20180320173801.GA25040@kroah.com>
 <20180320182409.GF4449@wotan.suse.de>
In-Reply-To: <20180320182409.GF4449@wotan.suse.de>

--ky4SFbjlcXhHbJVEhY0MFmRXRqaODFEgR
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 03/20/18 14:24, Luis R. Rodriguez wrote:
> *Iff* this seems sensible, this would only mean kernel.org would have t=
o start
> accepting git notes long term, for those who optionally want to push th=
em or
> fetch them.

We don't disallow them. You just need to make sure you're fetching and
pushing them, because they aren't by default. You can set this in your
kernel.org origin section of .git/config:

[remote origin]
  ...
  fetch =3D +refs/notes/*:refs/notes/*

And then push them separately as "git push origin refs/notes/*".

Since frontends clone with --mirror, the notes will be available on all
git.kernel.org nodes (e.g. see
https://git.kernel.org/mricon/hook-test/c/a8d310d4c13)

If you do start using notes, I strongly suggest you pick a dedicated
refspace for it instead of putting things into the default
refs/notes/commits, e.g.:

git notes --ref crosstree [...]

This will create refs/notes/crosstree that has less of a chance to be
clobbered by someone else's use of notes.

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--ky4SFbjlcXhHbJVEhY0MFmRXRqaODFEgR--

--dZnBsK6zJZIXdswTT4134XOJDdG4uDARv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWrFY9AAKCRC2xBzjVmSZ
bNmiAP9UuzzjLaSnoK7TU9GXgJ0myKjzw2rSZm3czpzrMvVLMAD6AlX9DZNGUl0+
M0RQvBkxMoekEXswcP5TEcoi3UDAFQo=
=O/vz
-----END PGP SIGNATURE-----

--dZnBsK6zJZIXdswTT4134XOJDdG4uDARv--
