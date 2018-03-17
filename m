Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeCQUQv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:16:51 -0400
Received: from sauhun.de ([88.99.104.3]:38515 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbeCQUQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:16:49 -0400
Date: Sat, 17 Mar 2018 21:16:47 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: xiic: Make suspend function names consistent
Message-ID: <20180317201647.cfnaeozisotswg7f@ninjato>
References: <20180310174056.16572-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vagwv4bxe36tr3sa"
Content-Disposition: inline
In-Reply-To: <20180310174056.16572-1-mdf@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vagwv4bxe36tr3sa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 10, 2018 at 09:40:56AM -0800, Moritz Fischer wrote:
> Suspend functions seem to have been copied from i2c-cadence driver.
> Rename the functions to match the rest of the driver.
>=20
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Applied to for-next, thanks!


--vagwv4bxe36tr3sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqtd68ACgkQFA3kzBSg
KbZd9g/+KSr7fHlGszVeM94zuTsuUplGJVbi/67HmDhAvdwOdX+vKVhJV6xel85N
/FNHzuW7vdqTqSNfCWeweUzxm+nI4TmrFNTRAxSrF32tU1dSNBJpqByxgqJ951iV
FtQ9mhKZmDgMEwDMjaoeL2gg/I6NMxbQi6JeQnZLYyGkOip+qh1xwS6NW+EHN+zE
jqXD2SbX/tI++34IP9tRG+w4MXLBt2pFX2YxqO1ImaBjuoY80jeV7vClv+Y8n8su
xQrkvsPpHnYAXd+QHUbHOJUmi+Oj7vSrkc6PvDiswut5EWoAXNeVOUucEOE8/WKt
Dw5XE/jwDUBLwV20IJLMsSHrk0A6sUZY5GWEw4Zlupl/bFgQCNy9svV3DFvnBx8A
THuw+UoZlUdwtVHk/IF/DSf22fZZ2mIgbER7u5nHIcMhSZP6V4bf+iqHIc81xs62
GcRcFnawP7cvLw3bfiZyZwNlDJQip+/KBbqJmAeZ2kjblrdzsueLq7DG0tsL/Nnx
RUdjzy74K7WMbm2TlKW0c9GxEqrxOlt/N2jxqyxno9zcED1GwDLYdSSKzmbWVuLv
pxEz6vNSmU71D6gCccO5PhSv7bLQzYW1y/kG16fMssWrtDJhY9nZrWl5f7vG+38C
4Vla30KitgIyZBt3pSyg1msLcueIXQPrr7Nnbke6+iEPzZ7RIIA=
=CTIy
-----END PGP SIGNATURE-----

--vagwv4bxe36tr3sa--
