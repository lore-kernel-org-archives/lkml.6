Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbeC3EHm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 00:07:42 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53972 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750744AbeC3EHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 00:07:40 -0400
X-Google-Smtp-Source: AIpwx4/VmmY0L0OU6mzbZfcUVWt73UKa5fGiGe5iSXHUrPiNCWgMR6q6cPwNzjtHhJoFE3m4yl/z4w==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: linux-next 20180327 - "SELinux: (dev dm-3, type ext4) getxattr errno 34"
In-Reply-To: <20180330013221.GD3790@thunk.org>
References: <24018.1522346273@turing-police.cc.vt.edu> <db97ea5d-0925-63bd-6840-1364a7977a50@tycho.nsa.gov> <026f2dc7-1c9c-93ff-569c-87a77aad0ece@tycho.nsa.gov>
 <20180330013221.GD3790@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1522382851_14829P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Mar 2018 00:07:31 -0400
Message-ID: <15451.1522382851@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1522382851_14829P
Content-Type: text/plain; charset=us-ascii

On Thu, 29 Mar 2018 21:32:21 -0400, "Theodore Y. Ts'o" said:

> Yes, the breakage is my fault; my apologies.  The new version of the
> patch is already posted in bugzilla (and on linux-ext4).  I'll be
> pushing out a refreshed ext4.git branch shortly.

Confirming that reverting de57a63ea4389e39b1cdd1cef15e1ec9b58a964c
and applying the new version from the bugzilla results in a clean boot.


--==_Exmh_1522382851_14829P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWr24A40DS38y7CIcAQKb2gf9HZK4jy0D2DydpBWjCAbBac6blhm4FfSa
WMSpDMrOgf3M+fG0yOcqkpmmB15Gs4wgfwqEqehqgAnJBpqFzUQ+wz8545LleauI
yif4ME1IB5dcOgn1bwaoSa58t3IAst4tXwHqvwbR3t3m1GV6Dt57CPQVP94hQqhe
Uv4BeJCRE/VVoIrPKAxcKRUhk7ISK9u47YEdKR7zKBEcfmZVajPTZTVMDgVuqdYy
9LjD9g5S3i+9laKfmzz0qZqopB7XGhH5VW5Gh3e2aRfIjy5jD80l6CZ4Ux8lq4DO
wSnCbLY2Lhn1JBH9IFmypxM4QtHdO4zahC8yIOD4wUBVhhXKkicuZg==
=Kmso
-----END PGP SIGNATURE-----

--==_Exmh_1522382851_14829P--
