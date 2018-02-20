Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeBTN1U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:27:20 -0500
Received: from anholt.net ([50.246.234.109]:52242 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751854AbeBTN1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:27:18 -0500
From: Eric Anholt <eric@anholt.net>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
In-Reply-To: <20180220093119.23720-1-marcus.folkesson@gmail.com>
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Tue, 20 Feb 2018 11:59:21 +0000
Message-ID: <87inarq3c6.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Marcus Folkesson <marcus.folkesson@gmail.com> writes:

> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

For bcm2835,

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqMDZkACgkQtdYpNtH8
nuizYBAAtyk553+DzZaVVx26hYtCbUifq7bWkO3a/WZLoGchWLKT+SA4ehqoCj/e
nwBBKcegfxfHVRSFvcCWHOp8ZCHUVanUcZDWRMrfcoBNt1UDnuy86212/ImbeZ4b
FqE74PZvqYsItezl+GUqR6b9XZ69b7e9Cs8QZAhGW+zyo721TW4QgcCeLfZdlm+W
xM6McBIhHM1/R8YW68WvxA6zB+I7BTlkVZpAieQvfGV7tQG0EsOl7izDvuqlqSDW
2igj2nuQgfNqZN9w9fnsVDDrpWn7QiciqLSRVjw22Ved9bNAKTq1+VV34ZwDKHhk
CL5RynWGD68Z6qjqvTsCiB8Z4AsMzMJZV06ODX5HoKwFVgrU99iMYNXi/t9uUEGv
pHtChA5YfnN+kOoeI5/YbTYKfzYt5STbQC1wT5fgve+zg8paITbZX85+q7wISzWu
s02eea0znzLgQnv+H996omy4i+J1BVwenjj4OpcafKc9cYS0Jpe2gMkTEdHlZ7jX
t6ww0wG7ZqA8NCJIwi3o1Z6I7oftK5TRCIwxDpFEnFA1TzQQ6C4EY84/pt+fmIvR
mhZmdgUjU1d/3O8wFQQZTdc9dYMyDMeP/f4auLa7ZiFJEmxMAscYwgDV/P8LqpAe
TckVz6yMJ/lUaXppMw0K6Fkos+HbbDSftz/pfLtBYMcyqpVNqPI=
=dSh1
-----END PGP SIGNATURE-----
--=-=-=--
