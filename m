Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524637503; cv=none;
        d=google.com; s=arc-20160816;
        b=lFus2doSjKUDMUtuN6ftiEoqkob9InkqHNmXk/MFmWBsbLQmJIDDqDA5BPVkoScjGs
         3yqJKhj8GwRHXd+U+dn5Gck2Kt3pBIG5Ph1xDlzxJ0RooSg2oByBZCGmbFKnT4O0GBzV
         FiVI8UYDknq7OUzBediFEOAW/zGyOZw5C9+/U9NxW3k79yOp9P1ahc+UJSaweQ6EvS0o
         PIQdEA8l2FVkVeuRmyRPjWzVVRDXD74n5DyI+mPw7aeYGjOWDb5Ogn45dBf5FpSHa8fc
         WpeYhkvpUee15mqQ4ZAIkI45WH7H2tlZy70FQc73MCtAiSvroSqEDi4mNQ/PJJPMCE4n
         Dd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=eg946OA4SrywtTOCKdgxngr80e2cOkN9xUO9tp2gQsM=;
        b=F14zTKokScR6tteiG2MTC8V184UahY/spIF7S0GAstyfrfR9HnmNTfnKs7H2l82bOI
         kaGP29gWC6gTD8wOM6JIJtZyuF5AZ7AnMcZimoSw464JWPIC18BEx4aLlxlKPFaZ1M2w
         1dqHNk7jZAhTbXtMwJuGI9K+YY47pHNbkTLpWT0a36+KCgIDJIz/wOdl9GLtRRz5g2lA
         Fz5gD/salA24Op4WEvL1bjic6aLL6jVXt/2rQ5X9BP2MZ6TPsb0+daX3yjp999Lvr7k6
         qUZqe4B+TlaBFhCNf8kEOpixuWgx/R3l3S6HHzjbCbqhPGQsIgFLnBu4EDRs5LM8G94w
         Rh3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pnue/vY+;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pnue/vY+;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+sJ8qCVUdVX3d+bCdZSOo9bSIRdq68vGhEpt4M34QJeXEFEX2v+d7vLM0Rbv+i9ckTBiqNAg==
Date: Tue, 24 Apr 2018 20:24:59 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v4 0/2] tty/nozomi: general module cleanup
Message-ID: <20180425062459.nxwab3entvadgq43@gmail.com>
References: <cover.1524634929.git.joeypabalinas@gmail.com>
 <20180425060513.GA32729@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pwurv4m4qlkoqovb"
Content-Disposition: inline
In-Reply-To: <20180425060513.GA32729@kroah.com>
User-Agent: NeoMutt/20180323-62-378db9
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598668994395676905?=
X-GMAIL-MSGID: =?utf-8?q?1598698295321993316?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--pwurv4m4qlkoqovb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 08:05:13AM +0200, Greg Kroah-Hartman wrote:
> What changed between versions of this series?

Ah no changes, I thought this was normal convention when doing
a resend, but after looking through other LKML patches
they just use a giant RESEND instead of bumping the version.

Sorry about all the mess; I mostly have only sent single
patches before this.

--=20
Cheers,
Joey Pabalinas

--pwurv4m4qlkoqovb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrgHzsACgkQruvLfWhy
VBl7IxAAyJZ6gXpXmw8NOTAJv/y1nXn0X3p0ttpKpeleoAXTiPMurH1J6PHHkuAD
4x74oCJzUWmkQFzh68sbkvHta4nQzptVvn9fyoEFgS5mB4nQ7r2U3PxQNhLxwsrJ
1H5SOKBH9Tn7IFdMPkWysEjetQtMfRGmvsaKqoU1r3QuOeFkp9Snz+Q8zgUWicbu
PAsu2muyWyvCuONNeZstfzJvAATpOiS5+nkWRjsadYVV9dCWA5y0fT3EsVkdt/EH
xOdDt3JCUOkDtFMGNK524pAwYXSzKuLk7EK6GoEE5PnbBx0vfwyizsLDJefmrK9U
aM/V541qzh3arAr9WDbXUp3CGfiJA8/ZStgtKwPmi7ZxZOyR2S05gPHZ5I7JrAIk
GS5k4H0d44xRNg/X8fIUsX9N3hCjMs8PyyVXUN3ofGKrABu0t7Ng4qzCnwpL8kop
gm6fw/9QxtOgR42C53MA/7yEo2OhTIL6BMiuCHkpswdvO2sskbCk8YxmtIWpz5Pz
30TNRsveEfKgzoxlxb/PbcuQslruWpaLCHdceIwtX9g+FQ/j+fnxWwpEt8NE0HL7
8S8Jf2y3C61Te0+E1omz1Uezp0ctLL3bhHd5EavW/xwP+tSDJllmjur71jG9LqBW
16aGm9p1TLZOSmNsTd9cDqnh4mz6ZktaYpNsao3BDsPlWvQQBz8=
=/rAk
-----END PGP SIGNATURE-----

--pwurv4m4qlkoqovb--
