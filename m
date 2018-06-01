Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeFASUc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:20:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35994 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeFASU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:20:29 -0400
X-Google-Smtp-Source: ADUXVKJzJPe04wHbBY7VrMOXNl6WbfvkBmjoSzjWfeY7CxBk+s3UB/aAATSO+xzllW9IbJX9ITPSZg==
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <E5BF8501-35EB-4DDF-ADBE-6016CF31A502@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E9FA591B-599E-43C3-BEEE-EAB3888D87CB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] staging: lustre: delete the filesystem from the tree.
Date: Fri, 1 Jun 2018 14:20:27 -0400
In-Reply-To: <20180601114151.GA25225@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        lustre-devel <lustre-devel@lists.lustre.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, selinux@tycho.nsa.gov
To: Christoph Hellwig <hch@infradead.org>
References: <20180601091133.GA27521@kroah.com>
 <20180601114151.GA25225@infradead.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_E9FA591B-599E-43C3-BEEE-EAB3888D87CB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 1, 2018, at 7:41 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> Thanks,
> 
> all that churn without much visible progress to a mergeable codebase
> was really ennoying.
> 
> I'd recommend if people want to merge lustre they start with a managable
> subset first, e.g. the fs client code with simple IP-only networking.

Adding or removing the IB networking makes basically no difference to the
code size.  This would also make the client much less useful, since a large
number of sites use Lustre with IB networks.

Cheers, Andreas






--Apple-Mail=_E9FA591B-599E-43C3-BEEE-EAB3888D87CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlsRjmwACgkQcqXauRfM
H+BSaQ//YlKfRYCoaSC/AHdrPBNjFFX9kUo03fvLusPL3K534Y8SZcvAibkHj7Fz
cJ3TxQdB1f80T03e79BK1PiW5YUlC7UPYvBTPo4NsUqcFqsDt4LE7fInA4bZ7Oi8
hHWO444AZeIGkwDK+xzcHWn28t2qr0GGOncR55u1rO1GCcgf3shvpiFeX7tnEuGN
92P29IwO5UGrxAulJgE2HULNqstBD1qVeUe3T8hw3OLqQdDkqmtTOKsZfma8Aoj0
ESEjjXQ56g9RED0R0RDUSWcNTFZ+m9CPpaG54F7a5pb2eQotStvs6pw0mCMdzD65
smWk8TfdUzNPLm0LHnQYIQe8OhIoRARSjSXSNTpLJNkw2B3aQcbGQ97VjAHg9pJQ
Aw2vaTWxMw94W9atK1kP+8ZwJR3hUqVMoiWOAN1tXyo4MQh3VwdLaH8u9t2YTYrX
LEPg+fHHRbIhjRg36hgLYHSPVsuZo6O8ux0nuMiXLq2txYMCe7TjUQz65n4KxUIb
VbgSjy8G0vYgFIBTT0qLMdJ5NYT/AmtsanKTJ0dKmg7fRLYqA0YJ3pT9jRxoI1ac
g52VkYmj5U51dv+6nu25kj55M6VfOQEnHATYN6SSMXlkfEzI+2jQIXJyYhqtjEgP
P8/TxNdyaPXNMfjdvHD/Lxk/58VQUbWRRZxwCvjNFPeYiwbwylI=
=o3XY
-----END PGP SIGNATURE-----

--Apple-Mail=_E9FA591B-599E-43C3-BEEE-EAB3888D87CB--
