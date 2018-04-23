Return-Path: <monstr@monstr.eu>
ARC-Seal: i=1; a=rsa-sha256; t=1524473600; cv=none;
        d=google.com; s=arc-20160816;
        b=kuApO95ZE3Rl+SPtqxSKpcxwboMvhFIVIbG0ahB/+p7ejStGKoax4AOO6iXg2C5kTc
         84y/eXCey03ZYZJO0JgH83JBcf7XOUwh85E+mKpbPez35xeMYHpkggX0488BSgW+KoWp
         dHxwPq2nH7BgSWtamX7ssDG+Rn0CL1P55TfHYRDPR/GACxRkhIwiap321DhmzXNpJ855
         nBYZOLHdFqKoGyCPddATbRoTdD/auqlvWdWgzsquHEkCMTHSp5Z/n26MvZAst6K70usD
         t+Ng9UOmLCroj9Ml+j/YJejA5AVBkBp1Wcx4AID8Y3LcmLxCdrW5SowXi/z5q+X7pmg8
         w/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:openpgp:from
         :references:cc:to:subject:reply-to:dkim-signature
         :arc-authentication-results;
        bh=DtTKBDqbBeXnQXS12orvN+0Ht/dt8WDaO/5bjpVDpMc=;
        b=bpazNkQHSKjVSm6Ts/a4dKNh5/azkjnaAdbo1Q7AzxSZBAvmln5yi+vgvguRK3Z8c5
         DMpc8WbCjngPFeWKvK3iY7Zc4ut33G6qS0w+oh/ntg8fg3GP9sina9Hy+KnaeOHlxbOz
         Ev9UaH05FBJXtb9QzsFWHs3UnjI78KM2xI96IHbwJUaViSdzgY+YsYpD5CeJ+ARLAwb3
         crxQIvhDcxzJNeAe2YICBAST762IAjSUSTjZMpU2qmtr6UVsAkjPJZYl+oTVSG9PLhXV
         ZhTyuPWnxz3B7Vge/pcnMPO4GlXOMaU50gBgHD5ODYFygSuEopzkY+Yj4Pte3lNC/dpb
         aKeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=erPAt9oO;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=erPAt9oO;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
X-Google-Smtp-Source: AIpwx4+Pk4f6zSbuDiVWa5rzuvcNYAIiY3WytfIyK6SfgVgu9OgN6zxv3Pf8fk4H0NsdJ/R5Y6x+4A==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] microblaze: Fix simpleImage format generation
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <b1738933cc6be175d4f97f11c00a05c0f3f81cad.1523368843.git.michal.simek@xilinx.com>
From: Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Message-ID: <ba7563d1-bf96-1660-15f4-faad07f52148@monstr.eu>
Date: Mon, 23 Apr 2018 10:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b1738933cc6be175d4f97f11c00a05c0f3f81cad.1523368843.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="D4Mjy8Mc8hTztoQPs2hYY9oGjKCWwGnmh"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597368022192081099?=
X-GMAIL-MSGID: =?utf-8?q?1598526430406501122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D4Mjy8Mc8hTztoQPs2hYY9oGjKCWwGnmh
Content-Type: multipart/mixed; boundary="PVtWc8UBMK0HO7r8dBbPwIUO37KzCdhKk";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <ba7563d1-bf96-1660-15f4-faad07f52148@monstr.eu>
Subject: Re: [PATCH] microblaze: Fix simpleImage format generation
References: <b1738933cc6be175d4f97f11c00a05c0f3f81cad.1523368843.git.michal.simek@xilinx.com>
In-Reply-To: <b1738933cc6be175d4f97f11c00a05c0f3f81cad.1523368843.git.michal.simek@xilinx.com>

--PVtWc8UBMK0HO7r8dBbPwIUO37KzCdhKk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.4.2018 16:00, Michal Simek wrote:
> simpleImage generation was broken for some time. This patch is fixing
> steps how simpleImage.*.ub file is generated. Steps are objdump of
> vmlinux and create .ub.
> Also make sure that there is striped elf version with .strip suffix.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  arch/microblaze/boot/Makefile | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makef=
ile
> index fd46385a4c97..600e5a198bd2 100644
> --- a/arch/microblaze/boot/Makefile
> +++ b/arch/microblaze/boot/Makefile
> @@ -22,17 +22,19 @@ $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
>  quiet_cmd_cp =3D CP      $< $@$2
>  	cmd_cp =3D cat $< >$@$2 || (rm -f $@ && echo false)
> =20
> -quiet_cmd_strip =3D STRIP   $@
> +quiet_cmd_strip =3D STRIP   $< $@$2
>  	cmd_strip =3D $(STRIP) -K microblaze_start -K _end -K __log_buf \
> -				-K _fdt_start vmlinux -o $@
> +				-K _fdt_start $< -o $@$2
> =20
>  UIMAGE_LOADADDR =3D $(CONFIG_KERNEL_BASE_ADDR)
> +UIMAGE_IN =3D $@
> +UIMAGE_OUT =3D $@.ub
> =20
>  $(obj)/simpleImage.%: vmlinux FORCE
>  	$(call if_changed,cp,.unstrip)
>  	$(call if_changed,objcopy)
>  	$(call if_changed,uimage)
> -	$(call if_changed,strip)
> -	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
> +	$(call if_changed,strip,.strip)
> +	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
> =20
>  clean-files +=3D simpleImage.*.unstrip linux.bin.ub
>=20

Applied.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--PVtWc8UBMK0HO7r8dBbPwIUO37KzCdhKk--

--D4Mjy8Mc8hTztoQPs2hYY9oGjKCWwGnmh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlrdnvoACgkQykllyylKDCHb/gCdGAImJrnMj63R4RvueVaYkmF+
xacAoISbOZRZWR4zSYn8tXEPuRum7FWQ
=Xcie
-----END PGP SIGNATURE-----

--D4Mjy8Mc8hTztoQPs2hYY9oGjKCWwGnmh--
