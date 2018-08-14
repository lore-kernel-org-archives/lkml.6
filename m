Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992CEC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D39F21531
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NHHqMqYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D39F21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbeHNLgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:36:21 -0400
Received: from ozlabs.org ([203.11.71.1]:59791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeHNLgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:36:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qRB63st5z9rxx;
        Tue, 14 Aug 2018 18:50:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534236607;
        bh=oc2pOM8Oj+6C9Mr0HLMhE2Nz0PjzbLVTffZZfeZ6PUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NHHqMqYWgtPJ5eHEdIory1y19su7UEtemdnwzNb8tW23/q/lMO3y58/WXA3cVss4b
         RvZWAykL2AUf0z+jV8hfuh0ODYvrqq1WisVEVvxUova54IKf+3UkZKAS3MzzC/AyCI
         wgo1ktEAI3HivWdUwX92viFaxiie3yl718HZexs3wf3WiucwnnifGHwFb+l7vrlFc/
         LaVw8ejRnbOIWaDa9Zgd0ljkbsFdub/YQ3bGG/RYdEmFHA5IJEMsYf/OaJU0nCDLie
         BHd6Z6ILVaG7MK7Pb01I7dc7RjlEPPp3dhLkLD0EplU1wpze7k/C5eTJ2ASPBen3qS
         jxFetb2rEI7vw==
Date:   Tue, 14 Aug 2018 18:50:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 4.19
Message-ID: <20180814185005.7a05e8ec@canb.auug.org.au>
In-Reply-To: <cover.1534161966.git.dsterba@suse.com>
References: <cover.1534161966.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/h7ABVJz/MdBTCU/Virl0lS5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h7ABVJz/MdBTCU/Virl0lS5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 13 Aug 2018 14:54:07 +0200 David Sterba <dsterba@suse.com> wrote:
>
> There are no known pending merge conflicts with other trees. Please
> pull, thanks.

Except, presumably with what is in linux-next (which is similar, but
not identical). :-(

Please clean up your linux-next included branch.

--=20
Cheers,
Stephen Rothwell

--Sig_/h7ABVJz/MdBTCU/Virl0lS5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltyl70ACgkQAVBC80lX
0Gx00ggAk35B95XMXqLSafF0xZumCj0bdyOGmFTNo47CValoM5JUAbJBBbiJv1Us
9H+FKPoZxN5FyCU18Fb6sKIAYBENA9lTyMm6AIRuCG7IpUzj00gGOlS+oELOCmJ2
RfmeiGjwmAQilRuTPGd+eIc36/GWtdwYKu5n8WpQimt7R9jRGZTMD2/ge2oZT0lO
maLy5BmMQWFEWx1IljG4F3Y/ENGbrD6u3ocA3KqueIIwGBxPE0qXFeu6LgXgxqHj
J/yzT/nUmqG7Gk0AOCgBnqNdNGDk/lUO8ArEArcGjrCPZv+l5O3coUaGYxafscxl
AgD1MxMHme+krFXpggXaAJKYJmTZWQ==
=Enyv
-----END PGP SIGNATURE-----

--Sig_/h7ABVJz/MdBTCU/Virl0lS5--
