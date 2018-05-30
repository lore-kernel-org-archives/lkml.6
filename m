Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeE3Maa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:30:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:12038 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752724AbeE3Ma3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:30:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="asc'?scan'208";a="43331528"
From: Felipe Balbi <balbi@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v3 1/3] usb: gadget: ccid: add support for USB CCID Gadget Device
In-Reply-To: <20180529185021.13738-1-marcus.folkesson@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
Date: Wed, 30 May 2018 15:28:18 +0300
Message-ID: <87r2ltcopp.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> Chip Card Interface Device (CCID) protocol is a USB protocol that
> allows a smartcard device to be connected to a computer via a card
> reader using a standard USB interface, without the need for each manufact=
urer
> of smartcards to provide its own reader or protocol.
>
> This gadget driver makes Linux show up as a CCID device to the host and l=
et a
> userspace daemon act as the smartcard.
>
> This is useful when the Linux gadget itself should act as a cryptographic
> device or forward APDUs to an embedded smartcard device.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

this could be done entirely in userspace with functionfs, why do we need
this part in the kernel? It does very little.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlsOmOIACgkQzL64meEa
mQbOzg//Zjt5SPpolplikLJu91nAO8HLYQCcjL+61fYqAp1DfPfZ1TuJ6XXazcks
9ND9QpHsuTvEhjoyI/1p7tefFdQYcUAh98N2Jflp5biK6MjpzjYCenxpBhvtj8kk
r/Kr1ecKGk6+22CzcMgHGEWNzz1pNiL5FFXFE2M014RDJ49lOxS8CVydDBUCY161
6VbM10KMKoJNCzx97QhVamxprysuCDK9HQKvduvcD+x6483SlYcGUvICGhhYBJ12
i7/Z/6u4jdkpRpYTCZFQ/rKnaYTJUbTTatWiXNiyNgFQeXr1OUlzc8q6iVdbv4vy
Qsk42U/5Er2sqG05lkk99+p6jr+kw6FnFkD8DU23m10u3h72/vNzyt+TEB9qkXb4
v3Y4TgezcQd4wezP+ggqt8tkA4sGz+R7QHUrwQ3PvjdsKJqY0IQtJAKMNE02En8F
yXYSjpu9Jm0j8+drqICEfDggB5iyzTks1BfK5f6WIUSd3rDit1my5LQmUj+bBXA1
//X4SEpezxgV5STJJHReceVtP5mvjS9mG5AUjhfTu++qRWze7HFReC9aGobXDt0P
gufwqbq2x5q1bkooWOFJJVjvYBo30sXNP1BJ9KxQgvMEOUhwJM8AQRpE+W3z+nnd
ABB+Uj1ARbAy/RIRhvTKoqSb61sInG1hOB/vqIHW4jYnrDsj8VA=
=0rMg
-----END PGP SIGNATURE-----
--=-=-=--
