Return-Path: <jhogan@kernel.org>
X-Google-Smtp-Source: AIpwx4/DKp9iJdEipDJEwGQxX6ql1S30luWyPwkx4howb/MEWrhEi2qxhiIsFaTt00+1VnpkQgb6
ARC-Seal: i=1; a=rsa-sha256; t=1522879387; cv=none;
        d=google.com; s=arc-20160816;
        b=JFGLebtU/PI+yGV0Ppe0+5sSywL4kYTqQlnrkqjvPlbkT9+0KcRcD2IAfEKLSMecxh
         M7yPzC8KnXgtPM4qDlzQRjohEyPDHCno8kQB+9Qu23TMh9pbuy9x43taKaOXWD+aogB/
         f4zv0/E0RB/1x10ZOe5E8F2t3pBAgpLsSm2GbiniJuhaXud+H3g6TVMlIdfZG2c0yPef
         5jIeV8TlPCGS8DU7SplUgepuE97xP4G30mplHdjOVXs/DXTUxS74fo3SRc/bc2QmZxBf
         85KxzYsKXfO7ojMrzkrMBK+gScVV2y+KgVFLupd3IdwegZr3zjz+QYeWNP+bJDyYinvT
         kwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=hdav8NuneBreLH5ff9AsV8XYmvuSTeE1o6QipVesZFc=;
        b=H0m9gbfS2v3dJZULuvySbIsHi13tAWegeqlhmR7jQUrDXHi19ZLac/jRWL12hcEpzI
         LLyGy+/wUnenC0tpqNwBjKw/ZdNjKTMZ4bLirUrEmDGjBp7qt77w4vgl3FmlIpmHUmeA
         Aj5mkvWUPxzQFqakHzmUzUYS32pTB5WknJvXgCS84B2vudt0FwpioTm/SeVDAitbisKc
         CEgy/uzcmkQAK092eFBLT1/joQW3uPE//tu7XlE+HHFKczfcuSfIgy7GEARuUgUzJUOj
         3bbhgZEmw2MBHc/ippGZJ0TxZNUVzBMndvw7iX2lgZwNpaBKXsFggDlVdTv33JfZpEHQ
         phAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jhogan@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jhogan@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B393A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 4 Apr 2018 23:02:58 +0100
From: James Hogan <jhogan@kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: matt.redfearn@mips.com, antonynpavlov@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org, mcgrof@kernel.org, robin.murphy@arm.com,
	geert@linux-m68k.org, linux-riscv@lists.infradead.org, clm@fb.com,
	ynorov@caviumnetworks.com, jk@ozlabs.org, f.fainelli@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org,
	bart.vanassche@wdc.com, robh@kernel.org, terrelln@fb.com,
	dan.j.williams@intel.com, albert@sifive.com,
	viro@zeniv.linux.org.uk, tom@quantonium.net,
	linux-kernel@vger.kernel.org, richard@nod.at,
	paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v5 2/3] lib: Rename compiler intrinsic selects to
 GENERIC_LIB_*
Message-ID: <20180404220258.GA9347@saruman>
References: <1522747466-22081-2-git-send-email-matt.redfearn@mips.com>
 <mhng-58affcc9-9eff-4403-861e-e40aea063afc@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <mhng-58affcc9-9eff-4403-861e-e40aea063afc@palmer-si-x1c4>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596716596411217880?=
X-GMAIL-MSGID: =?utf-8?q?1596854777178815030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 03:39:34PM -0700, Palmer Dabbelt wrote:
> Sorry, I'm not sure if this is the right patch -- someone suggested ackin=
g=20
> this, but it's already Review-By me and if I understand correctly it's go=
ing=20
> through your tree.  I'm a bit new to this, but if it helps then here's a
>=20
> Acked-By: Palmer Dabbelt <palmer@sifive.com>

Thanks Palmer.

No worries. FYI Documentation/process/submitting-patches.rst appears to
now contain lots of gory detail about what Acked-by and Reviewed-by are
supposed to mean.

In this case an acked-by is needed to show your approval of the parts of
the patch which touch the subsystem you are responsible for (and/or code
which you have authored) so that the patch can go via another tree. It
usually indicates that you've reviewed those parts of the patch too, but
not necessarily the whole thing.

Cheers
James

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrFS4sACgkQbAtpk944
dnpr9g//V8bKit7US+KbeZJcnQjS9mk4j6Jy5u79FCg4cQEUhojq+VmZufEd4tLL
OxlaWa1DhT9QOhnFsqflnqZ707KOeEtuvrTZnAvfWhyg+pyjfpH0OZ8I945p7Vrv
KWDQRJZWVWLSJsfCyx/kmFlGqtFvAkYN0tJmPm6VgNP5PxXrl3pSle+EqBaRXTEH
rVyotC9jHPiGZ7j8v8f+uUi0LgmD5kWCgTOmHHGHtrB7t2yEPOV9bMmcBW+Cxczs
ylQ4MenNoFKBbbaDSnSBLwHRCUeiuVk87Xw9TTaRVl0uwZjk0HxIZqRqX6DhTZ4q
zbE0hYWWNH5ZYNOjhJXoyU3eerqkMLpSfhrFvF14Ju5ZiwipXg3bsA24B4ZY6R0l
MFRQ5EMJPWbzBbnpdxYRq0vmwwZGugH58h81JsRhl1WPKKy5pMUT1OCtd8UoEF10
Rhv1/YgKsPeaM3WRYlBG6/PDVZzkKJC+ldq6jFvd3QaLnlKJ88r8L4Db8vLguLng
Pg7QTyLQeQxK4wkTy5/FIJ8All79Cg6ZIjqoiZlNriiiS5SJLPQKCJZrk0nXsSOX
R7YsbYZ3xcC1eoVAbXQptvLUoJxOz1pfQzX4gCsR2FyWVBiDpPH1jrEdsktvBe6S
tLOFU206tw47obnBN51tNelX68f83D7zvIrXs/zMI6WVQYQDf6o=
=+XC4
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
