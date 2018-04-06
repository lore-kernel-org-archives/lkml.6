Return-Path: <sfr@canb.auug.org.au>
X-Cyrus-Session-Id: sloti22d1t05-4185902-1522975200-3-3600345788292837828
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='103.22.144.67', Host='ozlabs.org', Country='AU', FromHeader='au',
  MailFrom='au'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: sfr@canb.auug.org.au
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522975199; b=IW+w7dzV2UmytV9DgCFDjfjUTEo3EWjYW+hkeQFWgGM5Didg2u
    dtz1vR7SinZ5x78J8A8CFdzdxdMrPTSeft1xfuFL6eAryR7xKC4n5m2ebcJ2vGh5
    bTWNfsgDNVSbtZkiLohT3MyPozyKkF4ikLWj3qU/uD2Z7kLL3heehQ35CruTSrX8
    KEvQmBmfKF5OHWSG/B1TCSgcglFn15QaDrj0bC4hjaHlDuQ2a83zC3PDPE5KUjc4
    zKz8cC969tsrK5DrIjvN5pWHjIoAYOHPp65pwvhsJzcsFaWxvp6Weezohd1vRXMo
    hY5BRBMuHnBEzboo6ELwVnOZZ8/xT3pTwkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type; s=fm2; t=
    1522975199; bh=mEvekzmBMOPkm4YAnV/Sr4sRmLbPV0dBBxZJ1FJe/iQ=; b=t
    9o23NB4G8F7joG9HP5UTkkE/jZCxrJcKb7NK1DUNmLhKPxlqNI4uw6Qzc5tbL+Zp
    KT6shduV4BjhbPYvOfByI46klAfs6svQ+ayiCV/jjHJIUpF1QuaUqezFyqTqOe8g
    UoyxOT+3ZeU6HI4fh3jBTZyZL0iv9wfR87Bh22zCjcfClrA90RkirVCBaRJWDpOf
    QsSUxorIE/8A9f6vAiFiTJAQ5+X+1lPUbIi8Jh8UhUXR69reFoeHTD5EQGBvAOqg
    b0J8KEd9ICvL7Vm9EfTpKtaFnTDqC9VH+PU4DnzpurVNFrCRLVPOlkYjYHKETCy8
    r5nQXQFlHshKQKH029SQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nZKWMUjj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nZKWMUjj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=103.22.144.67 (ozlabs.org);
    smime=temperror;
    spf=pass smtp.mailfrom=sfr@canb.auug.org.au smtp.helo=ozlabs.org;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=ozlabs.org x-ptr-lookup=ozlabs.org;
    x-return-mx=pass smtp.domain=canb.auug.org.au smtp.result=pass smtp_org.domain=auug.org.au smtp_org.result=pass smtp_is_org_domain=no header.domain=canb.auug.org.au header.result=pass header_org.domain=auug.org.au header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOlg1H/tVhn/4OzTICa6CqwjrFwRrdoVQGiE6zbeA759ahRkSu25ieZe/aPm3dZq8+M2tkDIV1KuvZQfoBoGpvk4fXygt2tq0TFc/ZPv6fFnrUhjIfxe
    BhdI8jbXndnz1P6J/cNwuSzTvU7eHY1d0asUKVxSomnB6lEoQeFakWqnN8Moub9erxbR455nWVk5SQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=SzIniHtys8oCJBrooC9eyg==:117
    a=SzIniHtys8oCJBrooC9eyg==:17 a=Kd1tUaAdevIA:10 a=rOUgymgbAAAA:8
    a=k_AxzzdXsRqLiShqE8gA:9 a=CjuIK1q_8ugA:10 a=p7VIKVgQydvKNSMOTZoA:9
    a=MP9ZtiD8KjrkvI0BhSjB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 6 Apr 2018 10:38:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, ARM
 <linux-arm-kernel@lists.infradead.org>
Cc: Greg KH <greg@kroah.com>, Linux-Next Mailing List
 <linux-next@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Patrice Chotard <patrice.chotard@st.com>,
 Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the arm-soc tree
Message-ID: <20180406103857.02c15ff4@canb.auug.org.au>
In-Reply-To: <20180315172858.7928ed93@canb.auug.org.au>
References: <20180315172858.7928ed93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pEQT=.bz1dZ_Ko8F6ch/4Vs"; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/pEQT=.bz1dZ_Ko8F6ch/4Vs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

On Thu, 15 Mar 2018 17:28:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tty tree got conflicts in:
>=20
>   arch/arm/boot/dts/stih407-b2120.dts
>   arch/arm/boot/dts/stih410-b2120.dts
>   arch/arm/boot/dts/stih410-b2260.dts
>   arch/arm/boot/dts/stih418-b2199.dts
>=20
> between commit:
>=20
>   db5430663017 ("arm: dts: replace 'linux,stdout-path' with 'stdout-path'=
")
>=20
> from the arm-soc tree and commit:
>=20
>   dbb3fb45edff ("ARM: dts: STi: Remove "console=3DttyASN" from bootargs f=
or STi boards")
>=20
> from the tty tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/arm/boot/dts/stih407-b2120.dts
> index de3c8bf129b5,a7a0f76e9cbc..000000000000
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@@ -14,11 -14,11 +14,11 @@@
>   	compatible =3D "st,stih407-b2120", "st,stih407";
>  =20
>   	chosen {
> - 		bootargs =3D "console=3DttyAS0,115200 clk_ignore_unused";
> + 		bootargs =3D "clk_ignore_unused";
>  -		linux,stdout-path =3D &sbc_serial0;
>  +		stdout-path =3D &sbc_serial0;
>   	};
>  =20
>  -	memory {
>  +	memory@40000000 {
>   		device_type =3D "memory";
>   		reg =3D <0x40000000 0x80000000>;
>   	};
> diff --cc arch/arm/boot/dts/stih410-b2120.dts
> index 0a59b7b0f4b2,6c6b4cc37e97..000000000000
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@@ -14,11 -14,11 +14,11 @@@
>   	compatible =3D "st,stih410-b2120", "st,stih410";
>  =20
>   	chosen {
> - 		bootargs =3D "console=3DttyAS0,115200 clk_ignore_unused";
> + 		bootargs =3D "clk_ignore_unused";
>  -		linux,stdout-path =3D &sbc_serial0;
>  +		stdout-path =3D &sbc_serial0;
>   	};
>  =20
>  -	memory {
>  +	memory@40000000 {
>   		device_type =3D "memory";
>   		reg =3D <0x40000000 0x80000000>;
>   	};
> diff --cc arch/arm/boot/dts/stih410-b2260.dts
> index feb8834478fa,50d36758391c..000000000000
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@@ -15,11 -15,11 +15,11 @@@
>   	compatible =3D "st,stih410-b2260", "st,stih410";
>  =20
>   	chosen {
> - 		bootargs =3D "console=3DttyAS1,115200 clk_ignore_unused";
> + 		bootargs =3D "clk_ignore_unused";
>  -		linux,stdout-path =3D &uart1;
>  +		stdout-path =3D &uart1;
>   	};
>  =20
>  -	memory {
>  +	memory@40000000 {
>   		device_type =3D "memory";
>   		reg =3D <0x40000000 0x40000000>;
>   	};
> diff --cc arch/arm/boot/dts/stih418-b2199.dts
> index 39b4db2e3507,7f5f3252bfc7..000000000000
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@@ -14,11 -14,11 +14,11 @@@
>   	compatible =3D "st,stih418-b2199", "st,stih418";
>  =20
>   	chosen {
> - 		bootargs =3D "console=3DttyAS0,115200 clk_ignore_unused";
> + 		bootargs =3D "clk_ignore_unused";
>  -		linux,stdout-path =3D &sbc_serial0;
>  +		stdout-path =3D &sbc_serial0;
>   	};
>  =20
>  -	memory {
>  +	memory@40000000 {
>   		device_type =3D "memory";
>   		reg =3D <0x40000000 0xc0000000>;
>   	};

These are now conflicts between the arm-soc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/pEQT=.bz1dZ_Ko8F6ch/4Vs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrGwaEACgkQAVBC80lX
0GwoiAf+ISjuR9YMTwQ/CAwXl93St7eITUDdpyGhdiguuZgW5YU4pz5wQ7b4YvJ7
puRUpTm/2D/3CNJY6k56TN5z+AJYJH6pfLiJ9TIBJGprJibK3iA03gTFiJTEuCi4
L10r16USA3S8y5LgWtZ3ysnn0J0dPLrE+43LJm4pF6C1YmzLyWx3iNCFLJdxpmKa
gk640DqL3AaNg+0lAPK5kqx9fV4oucVvpD3tZEXz0QkMQnd/FxzStt61q/x9EUNH
pfXMk0DYMT3egWjxQwuW1PG6zIJ5nkUjBSqz+ls/7ZniryE7UzbD330er7W6gepk
zmtPTZqni0jDhIaewEfguBjYjX2XzA==
=6MAp
-----END PGP SIGNATURE-----

--Sig_/pEQT=.bz1dZ_Ko8F6ch/4Vs--
