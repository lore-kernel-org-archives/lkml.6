Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524638049; cv=none;
        d=google.com; s=arc-20160816;
        b=ZOfZNHq0noea6PS8MnbcISKKWMg4AduaubAECLWUFF2PM3iuCO+dSiFa6PbEM76xFz
         aQEt2qZoyV57++sma4EmMYhRH1OHS1jvqgLndWBqOMPXVite5YlprM+ayY84i5pemRq4
         opMvZkc5bkeo3HydzugY1XMtcH9/yRLHPDVpHIZk+1JqB1fsPT0B/Y6rKiNjGALWmcaB
         6Zt54S7u7IZ95jjWqO43t8kjR+kJHtzMtA8VM3dIXqWIXrc0Eei2oZ6/ebihmaRFW10S
         5EWeUBXEY5d2hpUOH7o1mnnUX0bTiMFFZkKFxWv9bw2/5UGWp/cXJpCqq8Pz71/0EU0d
         ezNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mGQwzPTlTMoSob+lFtJx9is7xXNPbwZGY1MC3bfmG4U=;
        b=0deJP/gIcmtFTbknZOLR/SxMxTib/zdwe+MNQRvUdBIbnULlGOIc8XmUHv0JXFuzsW
         lOI0BxI196OsTO36Xm4/aRyjAUtWZCBjpDJN1VUf2pmzeQCglzd+RglZ5hVQ39Aoerwp
         lx/mLB6ln8dBcvLYSANGwFFzt5oJBCtWgex8IELSPtsIBQ/56EIFSSQsoNRC1s6Df+LO
         7KOaJrcv0DJqhJlKSAihGkYabZ5lIn2GTTXYJ62Gr5XfLag3ibcHSFSzzQmTnqLDoQQl
         Kc0V4uG/8yGvcDZ6T6aJ9YAbZZDzubRAOHAkYmsEhthONVZjdrPOh2vkQV/U0DqiLAl8
         5thA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r/5o1iFV;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r/5o1iFV;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49A6qULPDGymbrOXg0QauxlqgeIQ+m6RwWvW+nxGYj6H2btGreHKnd/tDHDtfjTiatPuvLFLQ==
Date: Tue, 24 Apr 2018 20:34:05 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v3 1/2] tty/nozomi: cleanup DUMP() macro
Message-ID: <20180425063405.x5mgdcwm7lvbixmr@gmail.com>
References: <cover.1524606061.git.joeypabalinas@gmail.com>
 <58b559776732f0fc14b1c30ec7da6fc27c3f1cc8.1524606061.git.joeypabalinas@gmail.com>
 <20180425053848.GB30843@kroah.com>
 <20180425054530.gifahvwftdbjuo7x@gmail.com>
 <20180425060931.GA595@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kivuzmvplziwlqtq"
Content-Disposition: inline
In-Reply-To: <20180425060931.GA595@kroah.com>
User-Agent: NeoMutt/20180323-62-378db9
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668996565319671?=
X-GMAIL-MSGID: =?utf-8?q?1598698867189791382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--kivuzmvplziwlqtq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 08:09:31AM +0200, Greg Kroah-Hartman wrote:
> Ah, never seen that before.  Just use the defaults and you should be
> fine.  Having the normal diffstat is good.

Yes, will definitely do from now on.

--=20
Cheers,
Joey Pabalinas

--kivuzmvplziwlqtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrgIV0ACgkQruvLfWhy
VBlD3w/6AsJG9Gr7iaKDWLW7L3ae2t7ieIj6YmPVkH9kVR5IKqLxggMznTBgylDq
896eP96JBdGcuyteETe1sRYZAPnG3uU4xas3V2OIp3zq4OuEMlLHQ4XcEAqCj9Ai
ENT2egyxVf3lCCcSU38nCVTbp+ibBxF4r7TQ2B06nWzWT5HjDpGJnv4dl2tm5Z8L
Mm7lC3/N1f0TB8BvLQeIExt+/z8f8rJ0QHEEQ4Szz8hAZlJhitD7uZb1rW6hNseX
6Lh4jZ9/qZqRj7sHFYK+sJPU+cAdPifpMxrZ8I+KIjgFzHtwdaTGDdNolKouZAiP
dpjFnV7e8I59dO0AW9c+v1yKuZI6DHVB7QHOz7sXBfSx2epVl4GqR/NjF6hd6MEZ
A5PteiXQvTBkADCq17Kk5KDARwLujH99+DNhzMY7Bmd5e7s4Y8CG36271kvLAK4k
CTkc86/Rn6sWB14uieEf78Gw5fqzOtpZLDdRJwNrI/wYQ8wMW5fRdBV/JLAGkk7e
ZniksL2VyX7PPEjXfSCf3lMe3x3dSiX83Obi2KcVD3hIioDAJxQYgDwx9yRnNWRV
SGEYG6Xbw4e30U4dpI48Up72IamR6UAtqU+fq/dyQIoHLCIo00S3ODy+3N4IP3fO
CI0bM+vaUkYG/tSXLRSvOODF9xyuJXz9LuLNRrTqHJ0iBczlUyw=
=yivu
-----END PGP SIGNATURE-----

--kivuzmvplziwlqtq--
