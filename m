Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeFAJYp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:24:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750740AbeFAJYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:24:43 -0400
Date: Fri, 1 Jun 2018 10:24:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Subject: Re: [PATCH] fuse: fix NULL dereference when new_inode() fails
Message-ID: <20180601092441.GA8687@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20180524202004.7813-1-stefanha@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ping?

Archive link in case I broke email threading:
https://marc.info/?l=linux-fsdevel&m=152719324102009&w=2

Stefan

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbERDZAAoJEJykq7OBq3PIkEYH/0OByjUIii5cCcTwTAZXv70R
l5hoUAILS8ao0BWMwE1DrNrc94+s0zAvEzctFMBR9c1eU/rcGqpYLsA/tT6PBUz3
HUgXf/V/k31dGb/JnN6BZE/3Ff+MBuxZBPgcdiItIfYRZWEQg8tZ+et0YXxmO0Rv
KgnPH6ljdYJgR8P3B8ScFhVx54X0wjHPZWH+OZveUdjD9TKyH4REMx0bfoxJAexV
7/GUUvJGxzZFB2UA9Y9dtu+8y55mFxNeuKK3g7K7Yy2U8z/mYc8fZ+muFE69zYMx
bh25ppm5tjJGEGhmFIhkj5ALfaJ9wl0VomFXQib1tk6klhKz+HcPnIpaORmzzVE=
=fikI
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
