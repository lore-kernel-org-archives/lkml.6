Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF9FC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EF62083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EF62083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeINV1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:27:10 -0400
Received: from sauhun.de ([88.99.104.3]:46280 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeINV1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:27:08 -0400
Received: from localhost (p54B33424.dip0.t-ipconnect.de [84.179.52.36])
        by pokefinder.org (Postfix) with ESMTPSA id 1601F2C015D;
        Fri, 14 Sep 2018 18:11:57 +0200 (CEST)
Date:   Fri, 14 Sep 2018 18:11:56 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] ARM: dma-mapping: update comment about handling
 dma_ops when detaching from IOMMU
Message-ID: <20180914161156.GB906@kunai>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdV_xpj62BkqwoTAaaugM3BkDRQTC=E0cEDqKBg3sUYNBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV_xpj62BkqwoTAaaugM3BkDRQTC=E0cEDqKBg3sUYNBg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 02:15:01PM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 13, 2018 at 5:18 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > Update the comment because we don't set the pointer to NULL anymore.
> > Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.
> >
> > Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu=
_detach_device()")
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Nice catch!
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, so I sent this seperately via ALKML now.


--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlub3cwACgkQFA3kzBSg
KbZBbRAAr9FUPBM/xafVRAtQivVuRwm9hR8mLRKPGHRuj6GBiEIcwH50OokDvsrS
vH4PiT6mXjS7HEkQ+N9INFIKJNibcj62IUZyVXe2GIEUft6A1xVeronjv/278Yg9
ExDON7xo3xR2FPapTDKrsEPKhc9r20DGlaHnOoHl8cRDvTeHaUdVIck74kV+irby
Fz0x2OGNeMo+5iW9NuodQdmGWJZKNDjisSd3jl/0BVp6skLt38NId3HHY0H1IbI8
2sVBVOgFZ17gQxAV4I3iu3XMjJWpWhXt3gNIBhp/duK1/N61SURd0x8dfYGUdLVi
s7LpGsv4x16mp4Vl1oSkwqSLfgHTOKoBS1hRei90nAkFLS1CuHNdJoKoo7yQpxX2
E+WqccOQiKkhMaepGxmycUDzTfslNEsVG2FV/pyZ9SoDJQE/iTXKrllcttpitfyf
6X9NOqeunyRJDyBseqS3zsCMivD20197ZOG0yu/wv+ixzlVSKCGUljUPlqx00S3H
Sa1+JiKPr7yRneb4T7IdEAE5pUr+flxDXHWu85676AUAmbxN2JVnwGzRJ2BgSnGf
6bE4dhAkLSPOd18UzsZeu/Tj61Ys8xLzagA1Akq4uHWkpegTa/23qIfccDzN1G6d
Vl96IMyXBXNE7zbBwvXzq+SNtrJe46XWPLoJcKu4/Z+iGVaouJI=
=+tnW
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
