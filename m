Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbeDYOYN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:24:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754131AbeDYOYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:24:11 -0400
Subject: Re: [Qemu-devel] [RFC v2] qemu: Add virtio pmem device
To: Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org
References: <152465613714.2268.4576822049531163532@71c20359a636>
 <1558768042.22416958.1524657509446.JavaMail.zimbra@redhat.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
        linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>,
        lcapitulino@redhat.com, linux-mm@kvack.org,
        niteshnarayanlal@hotmail.com, mst@redhat.com, hch@infradead.org,
        marcel@redhat.com, nilal@redhat.com,
        haozhong zhang <haozhong.zhang@intel.com>, famz@redhat.com,
        riel@surriel.com, stefanha@redhat.com, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, kwolf@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        linux-kernel@vger.kernel.org, imammedo@redhat.com
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Organization: Red Hat, Inc.
Message-ID: <79f72139-0fcb-3d5e-a16c-24f3b5ee1a07@redhat.com>
Date: Wed, 25 Apr 2018 09:23:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1558768042.22416958.1524657509446.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mmDwZV4M0zXDDT20DagSjiWsqCXrchrth"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mmDwZV4M0zXDDT20DagSjiWsqCXrchrth
Content-Type: multipart/mixed; boundary="vBkAcENT23vZalYco71XxAjzoGHE2FcjS";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>, qemu-devel@nongnu.org
Cc: jack@suse.cz, kvm@vger.kernel.org, david@redhat.com,
 linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>,
 lcapitulino@redhat.com, linux-mm@kvack.org, niteshnarayanlal@hotmail.com,
 mst@redhat.com, hch@infradead.org, marcel@redhat.com, nilal@redhat.com,
 haozhong zhang <haozhong.zhang@intel.com>, famz@redhat.com,
 riel@surriel.com, stefanha@redhat.com, pbonzini@redhat.com,
 dan j williams <dan.j.williams@intel.com>, kwolf@redhat.com,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
 linux-kernel@vger.kernel.org, imammedo@redhat.com
Message-ID: <79f72139-0fcb-3d5e-a16c-24f3b5ee1a07@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2] qemu: Add virtio pmem device
References: <152465613714.2268.4576822049531163532@71c20359a636>
 <1558768042.22416958.1524657509446.JavaMail.zimbra@redhat.com>
In-Reply-To: <1558768042.22416958.1524657509446.JavaMail.zimbra@redhat.com>

--vBkAcENT23vZalYco71XxAjzoGHE2FcjS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 06:58 AM, Pankaj Gupta wrote:
>=20
> Hi,
>=20
> Compile failures are because Qemu 'Memory-Device changes' are not yet
> in qemu master. As mentioned in Qemu patch message patch is
> dependent on 'Memeory-device' patches by 'David Hildenbrand'.


On 04/25/2018 06:24 AM, Pankaj Gupta wrote:
> This PV device code is dependent and tested
> with 'David Hildenbrand's ' patchset[1] to
> map non-PCDIMM devices to guest address space.
> There is still upstream discussion on using
> among PCI bar vs memory device, will update
> as per concensus.
>
> [1] https://marc.info/?l=3Dqemu-devel&m=3D152450249319168&w=3D2

Then let's spell that in a way that patchew understands (since patchew
does not know how to turn marc.info references into Message-IDs):

Based-on: <20180423165126.15441-1-david@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vBkAcENT23vZalYco71XxAjzoGHE2FcjS--

--mmDwZV4M0zXDDT20DagSjiWsqCXrchrth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrgj3EACgkQp6FrSiUn
Q2rWJgf9Fi1g3YjOnasyD2+TxIYRagQbx7/Sg/F2VvSqM3NyJ+Wk9/7iNIzkyLPg
99LY6CY46HaSyftjTGrQqc9D5bwpvXWn4gg2O311rMOlrSO+dPBixFs7fMm3wxgx
WGZ9W5NdfYWLG+crVHyCBymKvwW/l+bVvAn4URLoiHXCJQu6DKhsdp/N8bpdSUfr
XPbCVzgqIoA3dpVOR3aEHqIyVPqwnKwbI9Lya11/upKF7Zczvjp+TJZe/1k+v7v1
pD1CNy0v32pYYgEqt7lwo4eWCM+ZS8zyWHV+MG6pXHg4jfFEmPbsOwGSYm1T5zjH
4hQowL4JcnXSBPhNr8ew9xwqW0kBbw==
=e3JN
-----END PGP SIGNATURE-----

--mmDwZV4M0zXDDT20DagSjiWsqCXrchrth--
