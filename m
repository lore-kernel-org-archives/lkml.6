Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD4DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD582075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="TeihzEBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfBHOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:55:14 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:34455 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfBHOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549637712;
        s=strato-dkim-0002; d=aepfle.de;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=nFB5TzZhp4rOfoKsEQpCfZ2TLxqIXIx7hKQSO2UutCk=;
        b=TeihzEBTxIws1gRDV1Bgd6k7s9dNxUR5/XwkFDQyd60o1BRmbDpEE49YztkVXtMky7
        1HN7gG4Jy+XhkVmMdVZO/LXPrZ4GF0+xkHI24RZ0+quf5ZIOTyyW32ILiGLdafp4RNHJ
        W9BiwBVFPI8jTHQphB7KBDJX0AkCJ3c60wkgT1xwmy9VqnPbc7JFOWyTvuYvhO22Yv5r
        e4eYdV5G5ecFqWWauJbSLYNSXZSMuirpsI2o7HhLQ7NpIFtNJ79N7KVYcM3bbqQ/JKwc
        bMNQ0mCi03zSdWulj8vyAGwIJpmUIDjVpqz7IQNu4WvPqvbSkZzqAkJwymQTYYaDF6O3
        WVRQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAgc09FajRctxFpb+ZDKqA9+B38Tio5yEQ1NasN4="
X-RZG-CLASS-ID: mo00
Received: from aepfle.de
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 20a457v18Eq3WIF
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Feb 2019 15:52:03 +0100 (CET)
Date:   Fri, 8 Feb 2019 15:51:59 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     lantianyu1986@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        vkuznets@redhat.com, alex.williamson@redhat.com, sashal@kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH V3 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Message-ID: <20190208145159.GA17854@aepfle.de>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.11.2 (20190107T174927.9920de1b)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Feb 07, lantianyu1986@gmail.com wrote:

> +++ b/drivers/iommu/Kconfig
> +config HYPERV_IOMMU
> +	bool "Hyper-V x2APIC IRQ Handling"
> +	depends on HYPERV
> +	select IOMMU_API
> +	help


Consider adding 'default HYPERV' like some other drivers already do it.

Olaf

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXF2XjAAKCRBdQqD6ppg2
fmGcAJ9YHvrop3zssh0S9nzhUQtTdp2DvQCfeSlpubU2Zx7jnb8G+URfPb4FQDg=
=ilV3
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
