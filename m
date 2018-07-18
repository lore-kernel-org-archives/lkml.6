Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9353ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3FE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JNgBs3Jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3FE2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeGROma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:42:30 -0400
Received: from ozlabs.org ([203.11.71.1]:57955 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbeGROm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:42:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VzR93FGCz9s3R;
        Thu, 19 Jul 2018 00:04:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531922662;
        bh=MT9rxquOWO11cXCXLjsvRdA/uMC+h/zuLc3ZO2aEhK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JNgBs3JokrMeGxxYOeFIdgbekgkKkak460vdcyUXRTxqK6semPoSv4NrheciFQ4Ui
         jH2cnUhnkamQxOODvZDUVi2qLuwOfesTpgOAAU9nR/fu20SQyLUlT8obtfcZg6hPg8
         He+zDAClSaaJkoeJu+gsZlIK5mEh4X5WCuLLpIL9W71zwePa3/0JTk9E6PfMMaEpUV
         ggt12hp/xZL/hdk1p22u/dVXBNd8kGOWAuMIod8xAPghE0gjQxl5hmoNUxgQkN26WQ
         fhr8h9758dK8ZT/uhYMnlpN8UPMs5vxm5I9UEfCo5lO3idw/BNH9/y/MHJNndfm9da
         fn1V8q69smw0w==
Date:   Thu, 19 Jul 2018 00:04:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v9fs] Pull request for linux-next
Message-ID: <20180719000420.537d0290@canb.auug.org.au>
In-Reply-To: <20180718062920.GA7302@nautica>
References: <20180718062920.GA7302@nautica>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P6Jf1csb1wfrjc.A8nycrxN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P6Jf1csb1wfrjc.A8nycrxN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dominique,

On Wed, 18 Jul 2018 08:29:20 +0200 Dominique Martinet <asmadeus@codewreck.o=
rg> wrote:
>
> I'd like to request that you add the following tree to linux-next:
>=20
>   git://github.com/martinetd/linux 9p-next
>=20
> 9p has seen some renewal of interest recently and I'd like to help take
> a bit of the burden off Andrew, who suggested getting this included in
> linux-next here[1].
>=20
> This branch contains 9p filesystem & network patches that I have
> gathered recently after they have been reviewed, and will keep pushing
> patches there.
>=20
>=20
> I've tried to respect the rules I've found, but please tell me if I
> missed anything:
>  - all patches have the author's Signed-off-by tag,
>  - been posted to the v9fs and linux-kernel lists,
>  - have been reviewed,
>  - have been tested (*cough* a bit, I need to improve the process),
>  - and are destined to the 4.19 merge window
>=20
>=20
> [1] https://sourceforge.net/p/v9fs/mailman/message/36370423/

All looks good to me. Added from (later) today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/P6Jf1csb1wfrjc.A8nycrxN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltPSOQACgkQAVBC80lX
0GzqqQf8CkiIwMUAOopeK+yJvl0XW0HlvBrqk0rEIpDIlH2JrExqYKbHaD5kr1yo
mIigZ9BScNG0aRMw4zj6epFfnilCZaecShmtcBDvbTEja76yp48fVzUEnjlmzvQS
fKwOywCwts7/VKaH6XeH3Lzh2Gvuq6Xbb+8XJd+/4M3A2UGN/kIMIpna2+rl85nu
k1eTKfvrA1o0P2E87ee1htUoFKJE6FwJukfpXZU+7NDl0li1lmcw0VbrL+hIc4XG
KSYYb3CCWXvQgDtN4jHX8Mh8IJAr89nDAjeHi+T98sJVyRDCoRmB21ELQM9VM/nh
t1Q9uiQvw1ETJQ+SRXWAyWDt4l23Hw==
=KgqM
-----END PGP SIGNATURE-----

--Sig_/P6Jf1csb1wfrjc.A8nycrxN--
