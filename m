Return-Path: <monstr@monstr.eu>
ARC-Seal: i=1; a=rsa-sha256; t=1519911160; cv=none;
        d=google.com; s=arc-20160816;
        b=nEgKNbFVM/0umxZduNSKNWaIm//qkGSR7gWO3IR4LO47hhkZK0FRHFjGsUjPoQlo9S
         220m/MCpb9qGx4ZXuYqvey4MKj8ISE5eUgikYMuaDy6PF57hY1pRvbRnzIW6yFUnFcqr
         dEBserK8zafEKuXLmkjNQ1izjMLbuB2zlehglDYwyfZN/dyP0+60oztlng6/p/1zGxtF
         1qHZTr8Cp2f5LkAffYiI41vR00IlTY8TEK9qeNQwxiw3sSEzl7OgO9u9caQKbFYr5F0/
         nDSSk4qByDZB+H065AWxPUMCrh/yj08Npd1fInI7cOL6hOmJMliUHpNNnMRVixiHC24e
         k/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:reply-to:dkim-signature:arc-authentication-results;
        bh=1Qcj5cXic98GE+/tfUuF5ZnIAon42OXvOKdmiwq2mLA=;
        b=v6qZH5gqS0daLX4utS1iZN48SIvDHvsfBLQ4JKogUnMJP4aCPy5Fwr2dpFhKXjPtLk
         +5YbUT1HabNnVBtzxz5Ag/S3p6h3xZrelZhNfEol0Ft/mY8EGnC4ilsJvmpKfWhOECkj
         GkYFpN5MJAiKVBwG6547xG1BIBIet80I1sSlPf90YeCiaFdgNVzoSe1aRQVLAlddwbbx
         KwpsoM9i+IqoLAZ2s9VMFdgx4A9rZGX+YlBNYwGfJQRlDbr+cDyBFve0P6BIryxi2zTd
         +n+Z/bj9sfy2zfew7miFNSJ5Lu0IC9cqHww+U+Sg3DB1uMbYD5hCKTDsFJi3EK2P3B9W
         ENEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=v2WZJomE;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@monstr-eu.20150623.gappssmtp.com header.s=20150623 header.b=v2WZJomE;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of monstr@monstr.eu) smtp.mailfrom=monstr@monstr.eu
X-Google-Smtp-Source: AG47ELvywmtgoB+5vVrQazceB5mW0utKQwszY9Uv3w/urcqgq4T6M1n+JBWX4v6YGkKAJk6j286yrw==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
To: Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
 mingo@kernel.org, gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
 sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
 dmitry.torokhov@gmail.com, michal.simek@xilinx.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rajanv@xilinx.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jolly Shah <jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-4-git-send-email-jollys@xilinx.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <3e14f7b3-52e7-660a-a2f7-cc23b3262f0a@monstr.eu>
Date: Thu, 1 Mar 2018 14:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519154467-2896-4-git-send-email-jollys@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="T5SveNFf9S9pbl8ytpIx2dCLdT0veqDBk"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948932748631222?=
X-GMAIL-MSGID: =?utf-8?q?1593742365006559203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T5SveNFf9S9pbl8ytpIx2dCLdT0veqDBk
Content-Type: multipart/mixed; boundary="XvUM08OxZLrZUW5ISXBJsNzdJnJoO3JTs";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
 mingo@kernel.org, gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
 sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
 dmitry.torokhov@gmail.com, michal.simek@xilinx.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rajanv@xilinx.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jolly Shah <jollys@xilinx.com>
Message-ID: <3e14f7b3-52e7-660a-a2f7-cc23b3262f0a@monstr.eu>
Subject: Re: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-4-git-send-email-jollys@xilinx.com>
In-Reply-To: <1519154467-2896-4-git-send-email-jollys@xilinx.com>

--XvUM08OxZLrZUW5ISXBJsNzdJnJoO3JTs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.2.2018 20:21, Jolly Shah wrote:
> Add Firmware-ggs sysfs interface which provides read/write
> interface to global storage registers.
>=20
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../ABI/stable/sysfs-driver-zynqmp-firmware        |  50 ++++

This file name has changed between v4 and v5. File from v4 was correct.
That's why I am waiting for v6 to be send before this is applied.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--XvUM08OxZLrZUW5ISXBJsNzdJnJoO3JTs--

--T5SveNFf9S9pbl8ytpIx2dCLdT0veqDBk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqYAOsACgkQykllyylKDCF6ggCeIpeJunxbLo3V8NGfUDFPBu/y
L/oAoJU6oRhlFAjv39Mfw4wPs2HhB9Wi
=OP/I
-----END PGP SIGNATURE-----

--T5SveNFf9S9pbl8ytpIx2dCLdT0veqDBk--
