Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DD0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5E32084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5E32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH2ApA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:45:00 -0400
Received: from sauhun.de ([88.99.104.3]:42040 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeH2ApA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:45:00 -0400
Received: from localhost (p54B335A5.dip0.t-ipconnect.de [84.179.53.165])
        by pokefinder.org (Postfix) with ESMTPSA id 37B1C3310A4;
        Tue, 28 Aug 2018 22:51:35 +0200 (CEST)
Date:   Tue, 28 Aug 2018 22:51:34 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] clk: renesas: use SPDX identifier for Renesas
 drivers
Message-ID: <20180828205134.3bmxpeex5d3la2f6@katana>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdWcrpzit40X_z_hJrCSgupnnucPF0nciPiAiJP8EOX+TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rkq5zhg47yznmgpf"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWcrpzit40X_z_hJrCSgupnnucPF0nciPiAiJP8EOX+TA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rkq5zhg47yznmgpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Any specific reason you skipped all other files in that directory?

In the first batch, I only worked on files where 'git grep' returned
success on somthing like '(c).*Renesas'. In a later batch, I wanted to
work on Renesas specific directories.


--rkq5zhg47yznmgpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluFtdEACgkQFA3kzBSg
KbYFyQ/8Dp/bfqlHVUcnwpC982Up9FAPDJKHj1br6UCzV9sheqU4eq3KkdVw8scs
Oz6olEAIYP+egqh3PVpy1XVDb8146btFla9PLt0v7/8zrJNUKUU0Wjm6QZaWMMaT
iHse7ub7oK2UfpTuTB9+fvzeu1B70SMUTAwWVxrzwG5RybM/HeUUUv5paSwT6fSi
IB8VKDGphK3IQ0K/qndbAC5V7huK+4Av5wlrT7P1A7EOyLnxCMa9YUUcVjE2zktd
k8kVlbs0uM/zpTuB7yShXugJQVvDUk6uenKmfgmxC9vRMAMoIGJmzFadnmnZyIac
uegytGCsM08EWZ4RIyJU6HKI5gxbA4I8Reaji203vO4HmH9YJsf50DdUaMSRMy/+
q+1uZ3YgkMwKNMqlVxbCwBUapoWOLgky0lLOBTaC24T3HHGDtPBX+6yz6UI/Rwtx
ARAf663APOsGlkrz5QJWvIsILDVznFECLied+L6JcZwX9G5b3bQIDyS5qcFRb5EZ
QH20AXWugMC+g4oIQsKrJA8MmJ3CozirZDhHJyDuTAkmRYzLQp7PoWFdsUotxeDF
DJOeNMBCNDVPR9uIjl1/XfEXNDF1h9aom3MZQHyUsoJ8fL0Y/MKBXw5noZueOa1T
oXsY9HkTy2MSw+mAK1xrPj6QFVOTFZI2gbXRu5puhCBFHeilVAM=
=1x73
-----END PGP SIGNATURE-----

--rkq5zhg47yznmgpf--
