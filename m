Return-Path: <keithp@keithp.com>
X-Google-Smtp-Source: AH8x225WiXL4SPQ7ddZnNAre6EHQywl0whtBVKm0iU4eaRC3wrpz9PRmATbvdCDau0AdxaJp6BAM
ARC-Seal: i=1; a=rsa-sha256; t=1518848902; cv=none;
        d=google.com; s=arc-20160816;
        b=i0E/S5Wv8E9xxV7ZQd1w1hMJtcCXFyUkUZDmnMUod8+J3JLSR7vvU0nLIpJaNN4pun
         +7KwbeNfVEEkIA7lehT69M3t7YBc/BEN7n8NDUDQpPsXz39dfVI7Ybtvi/hhJBUTUjKd
         anlnQ6wEntvsHUjeQ9jbH4lByvyEH7hylX04E+52F2L4pWVrxt+OfFYO44rBU/om/nhr
         aQD6AT8iucbj+OSTQEiOLs1zFyQcCYyPA6Aka7QKG8WLBdfq0I17e7Ij8aBqzaY/kSau
         vQG/7oDqbF2MIgJbN2MEB6oSKabdjjxPnRGqo6FVXJHI16RLdV6t37esJgyFwwIVTGqu
         SU8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=xtHwJ52sMmV7BQs5BJsBhg9gjWWzffiyapE7OpIB5wM=;
        b=ib0e8CZHSAcaN5jielA+MvcNAfFeCUuft7zKSTfaneDNNQgUh3xEeeGhXHXvWU6qZq
         qzYFolW3mSQYg8SVUoLfqw1HOSEX7iXiO4Gjy7w0evUhixtQQVs2e/FP4OZ6Ljyf5lLK
         2nEDprOZjHaVHC+o8agT5XYuGpKnM7vUEvcFxwNIhjaVwmM50cGoTzWO4Ju59GZTYsK0
         SUCgBX0vF7y+eZ+cOAiv8Sxf8WdRwpoWZx2OpcRIbs1208lYouNDn8OiTMfb/pMvFmWz
         WjU7a3yUY5/R5pVgy2a43aIAl4toBjC34RYz0V3vzrAb8RV8DbCzYntC7dI0iZNh1d2z
         Y20Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of keithp@keithp.com designates 63.227.221.253 as permitted sender) smtp.mailfrom=keithp@keithp.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of keithp@keithp.com designates 63.227.221.253 as permitted sender) smtp.mailfrom=keithp@keithp.com
From: "Keith Packard" <keithp@keithp.com>
To: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: chaoskey: Use kasprintf() over strcpy()/strcat()
In-Reply-To: <20180217045530.GA24226@beast>
References: <20180217045530.GA24226@beast>
Date: Fri, 16 Feb 2018 22:28:20 -0800
Message-ID: <87k1vci0zf.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592622666371182567?=
X-GMAIL-MSGID: =?utf-8?q?1592628506308363050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Kees Cook <keescook@chromium.org> writes:

> Instead of kmalloc() with manually calculated values followed by
> multiple strcpy()/strcat() calls, just fold it all into a single
> kasprintf() call.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Keith Packard <keithp@keithp.com>

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAlqHy4QACgkQ2yIaaQAA
ABEcHQ/8DMwcxK/VzNBH0Tvpc7fWqVEqlwDUHhTjIktMzN7AHrMG6DyOEnqs2mmT
cLSeYLVdUZQOopJ6Cc0aHtp2/V05T5d3BABhuQG8+/gPCXYi/ex0XmIKQoRGBkT1
vDg+Byn2PSzMall9EjP0V40lycEL9qYVZzV7OOi0Yi9xYnvEuzVp4o6fnqbpaCxl
k7Tq5DKSvUJTmXMJbxoGaCWYMxuiL9KGTAmTbgZUOjw6+h4bLgblvGUm9Gz4wof+
W9Mnd7QeZH1m0ISrZbfCRBVkaphD9so1NJNNsMsYW2J0wP/wOBQGkFJ5O/quMsh/
gDFOkH5iAl1cftEz+S8JtauEm8243eQFxfmiP2sTRt58C4ArIfp0cz0Wop78AXeJ
wvPT0sknolaOsQRYWVROKwbWomyvkzdKHNJlnaOnAMglHch8ck24tyeB7K+rWEF7
dLGTojV6+YETvw8q/cYzxYKExmnDu2/okrtKesGPc6T2UI4FCZMAtNEXqv45DDYr
f6zNLPAxfrxoCweqjulI/5bIoyQmda5K1+cGhfwbTkX0Df81l8/nLAdINx0uNNj9
CSQNngk3ET1pE6HeRKD3Kydl0nw3oSDgFK6YCMmJ9ltrDXuC4hNewJqS0yyPdifb
iYvyNw6dXV7xcVGHSc778ctM1G4eQtHGtT0/JyJLbbg/auaMtPM=
=h6uX
-----END PGP SIGNATURE-----
--=-=-=--
