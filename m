Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C1E20842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 23:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfAMXKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 18:10:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46997 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfAMXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 18:10:15 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 714D9809C5; Mon, 14 Jan 2019 00:10:07 +0100 (CET)
Date:   Mon, 14 Jan 2019 00:10:12 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 08/13] Documentation/ABI: Add node performance
 attributes
Message-ID: <20190113231012.GD18710@amd>
References: <20190109174341.19818-1-keith.busch@intel.com>
 <20190109174341.19818-9-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20190109174341.19818-9-keith.busch@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-09 10:43:36, Keith Busch wrote:
> Add descriptions for memory class initiator performance access attributes.
>=20

> +What:		/sys/devices/system/node/nodeX/classY/read_latency
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		This node's read latency in nanosecondss available to memory
> +		initiators in nodes found in this class's initiators_nodelist.
> +
> +What:		/sys/devices/system/node/nodeX/classY/write_bandwidth
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		This node's write bandwidth in MB/s available to memory
> +		initiators in nodes found in this class's initiators_nodelist.
> +
> +What:		/sys/devices/system/node/nodeX/classY/write_latency
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		This node's write latency in nanosecondss available to memory
> +		initiators in nodes found in this class's
> initiators_nodelist.

"nanosecondss", twice.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw7xVQACgkQMOfwapXb+vKXGgCfcEUziEucdCLurHcSo0hJzfJy
bPEAmwaIAoUO698IlY0VU3WeRzDeafDq
=fjA3
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
