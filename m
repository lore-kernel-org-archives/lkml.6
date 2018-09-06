Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D91EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBDD2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBDD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeIFXIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:08:31 -0400
Received: from sauhun.de ([88.99.104.3]:48108 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeIFXIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:08:31 -0400
Received: from localhost (i577A6E95.versanet.de [87.122.110.149])
        by pokefinder.org (Postfix) with ESMTPSA id DD7F02C058F;
        Thu,  6 Sep 2018 20:31:46 +0200 (CEST)
Date:   Thu, 6 Sep 2018 20:31:44 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jun Gao <jun.gao@mediatek.com>
Cc:     srv_heupstream@mediatek.com, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/2] i2c: mediatek: Register i2c adapter driver earlier
Message-ID: <20180906183144.GD8607@kunai>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
 <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2018 at 09:15:28PM +0800, Jun Gao wrote:
> From: Jun Gao <jun.gao@mediatek.com>
>=20
> In order not to block the initializations of some i2c devices.
> Register i2c adapter driver at appropriate time.
>=20
> Signed-off-by: Jun Gao <jun.gao@mediatek.com>

The reasons this patch was rejected in v2 still hold.


--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluRcpAACgkQFA3kzBSg
KbZN3BAAsqTrWJ5QI5dYweb+tLwNyMhYSAnc4IFN6kWZUrd5EXil95DmgJk4X2MP
e593rEqeyLhpnX96PTFZOuwKtz1Pd/VUvUa2u1IHM1K6NiK4lTfLRa54Fi/8/5Hs
tZHsgiZaxAXiZ6wxfLIoE/FKFipvgmpX72qfxsGPjMU21668qrGfzrLpNzZMd4n/
TEMgo3ILkMEM8JBepw6FdVgAUyt+lBd51PSd5Sruo0i+Yungl0whikIa/9Lxl21K
Mgh3oJ9E+fhCrL4soX8NSjW+foFGs52Wz1dumnhLXkkcuwOPfzZzYbGOt0bDiuIo
yDvweosF9HovW35oVT1lDP+3N6FT8o06plxVpcvPtLBhywQ9GF0lP7BFqd/I0XPE
7+0LM0dfmNF5og0Hc5My6ZhwWP+Qvd5YpcUGTIf7qlFY2zE+00H9/cHuSERqQKAn
eYQaVm6TZrGQ9+eIn/BxWiSQZfqg08Qa6TVgR/HAW2nqJ0DIn8Hdl6C7WP59ucB9
vCke0c8CXLMDI5AHgUWcsrZ6gHzlx7yNn7kkxoqdBUbUfOMS5gUStIv7ca6+NS5i
+cj3ymQCwvMXBmI44w8Fz3y2f4RCziQ9gOWvX77t0aUIrG17x1Z5EsVgJmOdN98H
T4SOfeEAi29j1Ah/GmLMenRA09M83tsYiQDdkouteYbJMhh6rtQ=
=fhL5
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
