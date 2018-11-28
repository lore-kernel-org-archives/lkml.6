Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD9BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D3720645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D3720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeK2EeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:34:15 -0500
Received: from anholt.net ([50.246.234.109]:51674 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbeK2EeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:34:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DF09310A12C6;
        Wed, 28 Nov 2018 09:31:51 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zCISjtQeZJpD; Wed, 28 Nov 2018 09:31:51 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id F156B10A02AD;
        Wed, 28 Nov 2018 09:31:50 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 8DE322FE2D5E; Wed, 28 Nov 2018 09:31:50 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Yangtao Li <tiny.windzz@gmail.com>, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] drm/pl111: add of_node_put()
In-Reply-To: <20181121131723.22431-1-tiny.windzz@gmail.com>
References: <20181121131723.22431-1-tiny.windzz@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 28 Nov 2018 09:31:50 -0800
Message-ID: <87va4h5cs9.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Yangtao Li <tiny.windzz@gmail.com> writes:

> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.

The "bl_idle_init" appeared to be copy-and-paste from some other commit
message, so I droppped that bit and pushed.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlv+0QYACgkQtdYpNtH8
nuiDzQ//VcsSv6hBfJRFUp+C3eKbHJlmjDLlYtpIm7LXJtzUBRdQnmPWbLhHDVVg
8aPL5fQ+kr1Xuu7fkLtnBjHSNmqXZS+rE7x2O7UaN66P7oOmW+S2G7+x6wEBdW9q
A026vC0O8Ld4BYTBZJxdZMO5KXyT6K8UeJLSGCeAm3UQXqzEQdUm+48ZlNeHELN1
W6sI+w95R8JqWwA0v4u0+1jlZDTe4SS7Q1LlNWfy/nvTYF6TN1dGkKhHXMOQ0oc8
GEUXaB9MO+HynYy+unjDfabwMBZoGSBF88fSE09x0CQzlmyBqXWKmpCwRAjdCoo4
yxDn0LXwzZzVY09L2PPZcm5RB9eI1dHod+kf9qRSaLdn1NJW1mkQlNl2GDs31tzI
IiNmsjAKHAomcgGl/TEoEUWKfPhcHxDoQwSKQH/iuE1n8LmwBcZkX6Khha8J8tCf
k07alQSoROFHREDZyqbFaiW0OUBa0MNym/JRwF/W1frntlQj7Cwb0gG5o3iXFkiP
Ey8YIQY9gEkz9Y4nLgWPxHeh952jPBu5H6SBrV08GJWzG3uBQL+S3fA49AHdVCQr
R2brLwOGj/7Sr8NxGsEF9UQ4Z/Ue9pmCsAqNqKrS1vcx/CXCdbQKe+L0T/7yzqWO
Sczi7YZI+DpBx/ojBYwhLZ8lzvcdk3162oJG9ilrf5I9lrF4C2U=
=/ZFC
-----END PGP SIGNATURE-----
--=-=-=--
