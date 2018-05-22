Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeEVVGe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:06:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:50309 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbeEVVGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:06:32 -0400
From: NeilBrown <neilb@suse.com>
To: Patrick Farrell <paf@cray.com>, Oleg Drokin <oleg.drokin@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>
Date: Wed, 23 May 2018 07:06:23 +1000
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lustre Development List" <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 13/30] staging: lustre: replace libcfs_register_ioctl with a blocking notifier_chain
In-Reply-To: <BE6A1DEE-0CAE-4703-89C5-4722C0319BF9@cray.com>
References: <152687724799.24196.7718555295926047576.stgit@noble> <152687731283.24196.5413466102459843186.stgit@noble> <BE6A1DEE-0CAE-4703-89C5-4722C0319BF9@cray.com>
Message-ID: <87a7srz9gw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, May 21 2018, Patrick Farrell wrote:

> This, and the rest of the series, look good.  Feel free to add a Reviewed-by.

Thanks a lot!

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsEhk8ACgkQOeye3VZi
gbkv0Q/+KEA4qjEnJ8M71rYVqK7Lz867rzVi8CI2ExV8PJ6GvXZ612RgcWN9UwEu
6aS1p9woHsYjbx1dTajLlvxxP+vzHCZFJMgBFkKEnOSY0A2cc3R5QCKJiWKq8PyV
aF6gixtvbvgChrkH7PXWTKlpIsq4DH5pfFBPYD9bX6lNDMlHFhGvQxYCsgvRfm6u
JrL3IX12RsYlaO1HJsOC1yxg/3UmY29PnRRFYQ0xddPXHMzJejYY+M0N0KRTvr1g
0HG/dbKMIPcwypEVY4uNzSUpffoInxb4g57shHawvbz9/fZdQ2/uYr/BEHzbURRS
P458Q+XeKYl99s02344r7XTxwuze62359PWuvzJgcL79N4aQrEGWLnLu354FpssG
Mf3Ok24yLB2rWqpNdFx9bpNX/C5Kng6gkN1db5B6WpPZiESOJfitltyFyUZjirff
u9OmzXkT7zqIUkBRpytbkK5NO394DrV94iIM0gzQ4ekPQsQlT+galLMa8yrGAP0x
97W4AKQJbQpRy7yuzoveGErur5zwvWgW7Y6UeyF96qOzD50dqO/ZejGsBczxuZpT
8v8mOmbzWEuq1ZzMuGbeBS6ec8G0ymsvBtrd2WjS3oCm3AozVshqA+tL9KCwyfwQ
AoqXdFG+pdXve0ONFMzKpOmVdARth+79y5qZp+Tfnpm09TuOHiA=
=CFID
-----END PGP SIGNATURE-----
--=-=-=--
