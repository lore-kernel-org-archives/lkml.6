Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeDPSua (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:50:30 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:44141 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDPSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:50:24 -0400
Date: Mon, 16 Apr 2018 20:50:05 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: David Miller <davem@davemloft.net>
Cc: jacopo+renesas@jmondi.org, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a77965 SoC
Message-ID: <20180416185005.GC3377@w540>
References: <1523886917-14491-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180416.101755.99677892602830691.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <20180416.101755.99677892602830691.davem@davemloft.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi David,

On Mon, Apr 16, 2018 at 10:17:55AM -0400, David Miller wrote:
> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Date: Mon, 16 Apr 2018 15:55:17 +0200
>
> > Add documentation for r8a77965 compatible string to renesas ravb device
> > tree bindings documentation.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > ---
> >
> > Renesas R-Car M3-N support has been merged for v4.17.
> > Document the missing device tree bindings.
>
> Since this is purely a devicetree update, I'm assuming that it doesn't
> go through my networking tree.

Rob has picked this patch up in his tree, so no need for you to do the
same.

Thanks
   j

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa1PBdAAoJEHI0Bo8WoVY81BYQAMXgTZJrm632/N1eWEREMG7+
pZx42hdprYwyBACD89Y5CI8P/cyioGqgo1u7+aOik+CMfOshKxEf6gZGclny8Wt6
UOFusA1FvqN/kGURH+ojFAAR5SjofkUqIPRbfZ1zEIdaTSquA9J4NN+hkY2o/FvM
lgAFjQgEUsnl53/ldLlpoQuG/mLqcptjL5VxNXuTMG5PQx3iRNXYQQ8CLR9mVz3U
5FqlCANoZTxvCRbHQZGW0Fq5IhPuOM7YlJkUkT2VsCQ2L0T/KtBZ2rxIASvT4GUE
uCI8VJimikaPZVFqnTXk1FuWGle8grH146aM0vLjlLDagZOVbZ3A+WjPC1THyhWc
2TzP+fyyJ1LyfdHYllf44YJ4FI/QxjWLORtZL7DGVusPB9RADnL7ZKj+llcFr2WR
SK4ptBtG7Ww90l2L78QpLXnM7MUJbIlVDTQ8Yx68LJvDvo3Tjoqyp66WLt97UR1S
leKJKhhEv52ScuTqYudMgBE5zgaXP16rBvx9zTlZ4pvZVT+HtVngnIsHLThfEO9X
dBqXLD/GTF4YsPvvZBSNKvN0ybpHQ/ndd3nHXANwkAj9acAVKr3M7vOvCRC/NDOn
CjOAtPuzsM3+QiNre7FUwRcTpU8fQW42auAgFoO/lJ9tvgzfgdHZ0HCPjnkHM5TU
AnKZWtXyrl+PWeS9/C/a
=YanS
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
