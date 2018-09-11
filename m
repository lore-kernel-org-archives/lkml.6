Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774E3C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D38B20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="phx95nQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D38B20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeIKVgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:36:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53254 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKVgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1GoQvR7otClXHIyby5tXfrhvIoKinVDkweTOnEGv9m8=; b=phx95nQaCwWEx29PoGtVdwTM7
        jWBCVA2I7+5xNtZWHZoqQmrOTv2Poiqgyfa1N5h9q5GyiIHB7rc2mKhFO3/pUcfzFQv2QVGsZ2kSG
        LX+/dkw8Df/9LZ/54i/h4FX6WA3uiKtoB0pUD2mXwNoooPaEy9vNDjHw9nDs+B3qMlX2Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzleX-00050j-F8; Tue, 11 Sep 2018 16:36:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EAC5D1121B1F; Tue, 11 Sep 2018 17:36:36 +0100 (BST)
Date:   Tue, 11 Sep 2018 17:36:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Yu Zhao <yuzhao@google.com>, alsa-devel@alsa-project.org,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "ASoC: Intel: Skylake: Acquire irq after RIRB
 allocation"
Message-ID: <20180911163636.GC10123@sirena.org.uk>
References: <20180910211718.200802-1-yuzhao@google.com>
 <s5hd0tk3712.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <s5hd0tk3712.wl-tiwai@suse.de>
X-Cookie: Bridge ahead.  Pay troll.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 11, 2018 at 08:03:21AM +0200, Takashi Iwai wrote:
> Yu Zhao wrote:

> > Will fix the problems in the following patches. Also attaching the
> > crash for future reference.

> > [   16.950887] RIP: 0010:snd_hdac_bus_update_rirb+0x19b/0x4cf [snd_hda_core]
> > [   16.950889] RSP: 0000:ffff88015c807c08 EFLAGS: 00010003
> > [   16.950891] RAX: 0000000000000101 RBX: 000000000000080c RCX: 1ffff10026822185

> Please try to rip off uninteresting hex values and other stuff there.

Right:

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluX7xQACgkQJNaLcl1U
h9ARRAf/Q5qEa3zePsa30sANzk+V1KkvPnxJE4fHJbtvPY8Reia43ia3WGb9ijyZ
Yn94Cie18uVetrVdmROu/TbAZvorguH6U89hG5kv83p3coTa2HS7lmEqyUP9vW8W
ZcI7XaFij3hJPsgwwHUyPLmfpnn5HZjEAcmuEEFF1u3447UQlgppO91huIHmGXJl
yp2sCvku/XVi88MBys8UEMNS50iVKggON7bnWWJRTiaYCODiXUBzenQoz2DoiCs1
83JVhaT6LlxYbD0F4lrlyTzu8Ih3yfKkEhydRsCJcOEHaa7QCmGhSksZcF+IR4jZ
qC2IFpnXIsuOKBMsReG/z/ckyVAqCg==
=sKQD
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
