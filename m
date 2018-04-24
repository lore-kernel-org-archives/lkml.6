Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeDXNFX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757822AbeDXNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:05:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A51B21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 24 Apr 2018 14:05:12 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180424130511.GB28813@saruman>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Apr 24, 2018 at 01:55:54PM +0100, Matt Redfearn wrote:
> Since it appears that MIPS oprofile support is currently broken, core
> oprofile is not getting many updates and not as many architectures
> implement support for it compared to perf, remove the MIPS support.

That sounds reasonable to me. Any idea how long its been broken?

I'll let it sit on the list for a bit in case anybody does object and
wants to fix it instead.

Thanks
James

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWt8rhwAKCRA1zuSGKxAj
8lZfAP9eSR44etV2E3TeKaFlQdlxvJdyf/JV8kY8kvLjADfstQEA8TIZDjOp0bcZ
CDH4FQuVp/SeqEFuxNED3nw+3UudqQ8=
=hVzL
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
