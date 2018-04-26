Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbeDZKgW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:36:22 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36144 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755751AbeDZKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:35:36 -0400
X-Google-Smtp-Source: AIpwx496T2btm/KZGi/uqzEBCf9ptTegqMEda6fFsucWCLWo5jjLZ3qH5ynxv8ZMD1ToXlTeZfW/Og==
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH v1 0/2] microblaze/PCI: Remove unused code
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180420185653.GV28657@bhelgaas-glaptop.roam.corp.google.com>
From: Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Message-ID: <19860462-223f-dcff-1f1b-536b1f0a3beb@monstr.eu>
Date: Thu, 26 Apr 2018 12:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420185653.GV28657@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="b8gPjuoeEu6kaT7VlkxgXxqdsbsv2jBFQ"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b8gPjuoeEu6kaT7VlkxgXxqdsbsv2jBFQ
Content-Type: multipart/mixed; boundary="k4vdRQLwq7H80UmZYEABOtlXksOcZx6ej";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <19860462-223f-dcff-1f1b-536b1f0a3beb@monstr.eu>
Subject: Re: [PATCH v1 0/2] microblaze/PCI: Remove unused code
References: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180420185653.GV28657@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180420185653.GV28657@bhelgaas-glaptop.roam.corp.google.com>

--k4vdRQLwq7H80UmZYEABOtlXksOcZx6ej
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On 20.4.2018 20:56, Bjorn Helgaas wrote:
> On Tue, Apr 10, 2018 at 08:24:59AM -0500, Bjorn Helgaas wrote:
>> Remove some unused microblaze PCI code.
>>
>> I can merge these via PCI if you like, Michal.  I have some related
>> changes coming for some sparc resource claim issues.  Or it's fine if
>> you pick them up.
>=20
> I applied these to pci/microblaze for v4.17.  If you pick them up,
> Michal, I'll drop them; just let me know.

Not a problem with it.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--k4vdRQLwq7H80UmZYEABOtlXksOcZx6ej--

--b8gPjuoeEu6kaT7VlkxgXxqdsbsv2jBFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlrhq3EACgkQykllyylKDCG+OQCfRn+lKGnyXGLltVSB6z7y4Zxu
95kAnRZHo7wbFem0ubtYIKSF9Rp+8nVu
=IIMb
-----END PGP SIGNATURE-----

--b8gPjuoeEu6kaT7VlkxgXxqdsbsv2jBFQ--
