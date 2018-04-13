Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeDMQuj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:50:39 -0400
Received: from sauhun.de ([88.99.104.3]:48920 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752235AbeDMQui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:50:38 -0400
Date: Fri, 13 Apr 2018 18:50:36 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Sam Hansen <hansens@google.com>
Cc: linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation/i2c: sync docs with current state
 of i2c-tools
Message-ID: <20180413165036.5h7f6h42opzr64qi@ninjato>
References: <CAP9bUy7rONNHYeRkYtaWHcfqoZcGKXJz-JocED26zBj9n+-ZbQ@mail.gmail.com>
 <20180413164405.127522-1-hansens@google.com>
 <20180413164405.127522-2-hansens@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mg355zbbnwkmajlw"
Content-Disposition: inline
In-Reply-To: <20180413164405.127522-2-hansens@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mg355zbbnwkmajlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 09:44:04AM -0700, Sam Hansen wrote:
> Currently, Documentation/i2c/dev-interface describes the use of
> i2c_smbus_* helper routines as static inlined functions provided by
> linux/i2c-dev.h.  Work has been done to refactor the linux/i2c-dev.h file
> in the i2c-tools project out into its own library.  As a result, these
> docs have become stale.
>=20
> This patch corrects the discrepancy and directs the reader to the
> i2c-tools project for more information.
>=20
> Signed-off-by: Sam Hansen <hansens@google.com>

Looks good to me as well.


--mg355zbbnwkmajlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrQ39wACgkQFA3kzBSg
KbbpQhAAnoYnClgq1EGw78esWIU4N/LWLZ7idsFEdYhdnetF/F4TjKNg8u9Tiw1m
Blcvwthu/uG7ykHRKR6yXxuMPkfmWUfOMcm/n37PznbLIII3G0Tq775VRadwWypb
Dt3gv8OGvbn8WB8cvbCGAqjVbqz6/JO/eWsZGvWlSqE2vAcwQr8kTKqek+1x2rGf
JgkoOJyrTg1vZvmrssE1UyiZRRF1UjTlhqxoelVaa1eApmGpBYoVgX1eL5CRlKVq
FAelziJ/3rCXm+dBucLDJptNkgFlsFInZE+/BerZhq/HL1nHonJ9gNaO+zbVdJaZ
UwVM8s3dsGV2JLD5ZrrxYj9YXKb5xYBHaRXWOxHcQFr5xchNWOf9h0w86cqZAk+9
ahNNIA/DZiqOkkBxswsLSglkykDCPppuU0TQaNAmLimNldMlxTvYopfICfzXeMQv
Ok3/nX6bbh6cxHP9ru4P/byYyx+6epJA+mfXKUwCbOxgpXSKKVCSFCwNQ29oiJgi
o5BTc+9KYFE45BL/MFrWP4Lxe9EoxxBiJ9Swfay6meOs0CXS+ouf9OyT4cC3/Sgg
Q/9KWTnbTmN4OI8u+fyrC6QpA/N/+TWNWjyzvGhomi5hRGuzfG7p5lgEE4cQKSs7
kEN+1ppYJlqsxWaB78xLCJpnAZKs46R0ISQn1r/mLjPGQSXwgHM=
=odDK
-----END PGP SIGNATURE-----

--mg355zbbnwkmajlw--
