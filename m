Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47913C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44A720779
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4B+9Quu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44A720779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932714AbeGGMdh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 08:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752207AbeGGMde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 08:33:34 -0400
Received: from localhost (unknown [122.167.118.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD4C21C36;
        Sat,  7 Jul 2018 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530965782;
        bh=mncMrwfZpf1ueSnA+iWQN2rRse87XTHoo4JWaVd1Fgk=;
        h=Date:From:To:Cc:Subject:From;
        b=O4B+9Quu5+qFBXVEjy2vp/tfUhtJfMbMJU6gJkeTPq4o358TfumJbMe44tmwswodD
         FEmu43DTRIWcFxok+B9iQP0bGvsQBtIFindM6+vVTsRkcDejAUwIM4AQsCgpB9GsDF
         9XceTovnEXhP2rlehB7TqyIyXoY8t06Ws3s2b1Zo=
Date:   Sat, 7 Jul 2018 17:46:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v4.18-rc4
Message-ID: <20180707121613.GY22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heya Linus,

We have few odd fixes on driver and one email update change for you this
time. Please Pull to receive:

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-4.18=
-rc4

for you to fetch changes up to c4c2b7644cc9a41f17a8cc8904efe3f66ae4c7ed:

  dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate() (2018-06-28 11:5=
7:21 +0530)

----------------------------------------------------------------
dmaengine fixes for v4.18-rc4

 - Driver fixes for k3dma (off by one), pl330 (burst residue granularity)
   and omap-dma (incorrect residue_granularity)
 - Sinan's email update

----------------------------------------------------------------
Dan Carpenter (1):
      dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()

Janusz Krzysztofik (1):
      dmaengine: ti: omap-dma: Fix OMAP1510 incorrect residue_granularity

Marek Szyprowski (1):
      dmaengine: pl330: report BURST residue granularity

Sinan Kaya (1):
      MAINTAINERS: Update email-id of Sinan Kaya

 MAINTAINERS               | 2 +-
 drivers/dma/k3dma.c       | 2 +-
 drivers/dma/pl330.c       | 2 +-
 drivers/dma/ti/omap-dma.c | 6 +++++-
 4 files changed, 8 insertions(+), 4 deletions(-)

Thanks
--=20
~Vinod

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbQK8NAAoJEHwUBw8lI4NHDFQP/2cCDR8xnfBaiNxbdH06tjle
50Of16oZu37hgYwXBdYgL7daxsI5UtHJwn3MNdhwpejIMiFwUZAdMk7HXuISBFr+
GvUGWCJKRlr5XxTRT04wTR1nlJtouz+TUi9MoxYe/pJ7hYx1TEx6Th64WtYmuMZe
qVQNhGniaQnoaG2+KoiG2xW29L0MccMb2eVDKfEqSyu0GCvnj2Q1oO0nT6efWLu8
Xu86lhUGygdL+yybZuZAZGRapZE08lSsw/MW/ur4HYFXQKvn3ckN/leGr3V0CfqQ
YLGmqZGaCvDU3EczouAAWy8wwSu0QQ/lTgX+3sdBsBDIY76IeJxNMxpQ6HOvIsz4
JRSLMkOUqK+okUNK/siDvS23R1w/M6xaJ1NPYYnV9r30/IoQxU2T3Q8EQZOBTMOy
1EmNr/M0L5V1H7LQ5LaCyhS2NUTxtywRzetwMVypSScbmtS2GWITDSmi3K3OuBHU
KpIXUynt+oYukfcCIyDP6JlAzoW+/7uvR1sp+NJQO8EOmE9Da3p9XnS5ZTaHrtzI
g0BwVq4lf+N4BMWiEykg/VHkBG9LWcI68vhSRm9VNxwrEMsHvedacn8c8iebgf/y
O0U4W22dJcfR+ZCTzrirI9P+hVMPj5mtODUSCIEDguyB39z3Sc8RXCBdPbNB9jz8
VvK8WoSGqxXTlbmDaXqX
=n4gN
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
