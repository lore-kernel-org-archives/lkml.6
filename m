Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeBVHsp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:48:45 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:60344
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbeBVHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:48:43 -0500
Message-ID: <1519285717.2388.11.camel@debian.org>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
From: Yves-Alexis Perez <corsac@debian.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Date: Thu, 22 Feb 2018 08:48:37 +0100
In-Reply-To: <20180220142512.039309aa@jacob-builder>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
         <20180213140303.42mbzfxpypljy37l@8bytes.org>
         <20180213214002.GA27066@otc-nc-03> <1518992132.2542.5.camel@debian.org>
         <20180220142512.039309aa@jacob-builder>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iIS2QBEqX5miAuDNO4vV"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iIS2QBEqX5miAuDNO4vV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-20 at 14:25 -0800, Jacob Pan wrote:
> I didn't know about chipsec but reading the code seems to rely on an
> out-of-tree kernel module. I don't think it matches what we need here.

Yes good indeed, I had forgot about that. Maybe the userland part is still
useful, but there's definitely a need for (protected) access to privileged
memory (and access to /dev/mem is less practical than debugfs, I guess).

Regards,
--=20
Yves-Alexis
--=-iIS2QBEqX5miAuDNO4vV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqOddUACgkQ3rYcyPpX
RFsBGwgA2j4wld43w9fzKFS9Tr/cBIhJ6u1Ap9yovmGTUEz4nWJeY6QL108CjrmF
aW4JfkMKoLNgq/7sGTQqD2K28H/XUJ0PVmXFpqR8iLdVLmpvEJpbWL4zBQSurrOQ
Buwi90VRCRqzLgO/30ohfSlQoIbk5cl5NqMWzSG8x4zYxffG0T2cpJFub6a9L2PI
NnF8bqjyqdwS1gZQkj47Y9KVSEq+85KsYDXXJE8mUAA2fd6eg77wZF5QBxQkeEcL
jXP2pBldjPFpkG1pCexL3nFG3AjVMfvSM6Kj9GmcUKfDFZiX6af3N0e0xePoa/pE
34OoObjheDonqbP+GyAeDsFnAgIxxw==
=SpJn
-----END PGP SIGNATURE-----

--=-iIS2QBEqX5miAuDNO4vV--
