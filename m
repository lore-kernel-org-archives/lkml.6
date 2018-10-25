Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A95C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F7C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yoi6SUh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F7C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJYWXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeJYWXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:23:33 -0400
Received: from localhost (unknown [185.7.230.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904E520665;
        Thu, 25 Oct 2018 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540475442;
        bh=x6XuKxpraVDqji8hbILdEqEZcyqrvPHqxuusUPbkEdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yoi6SUh/JhI7tcsSGRiqOZo6OstYzzz0wo7cqttEKlRzOAeiJ2ZYIeFOd5QGH4w2C
         Ag8aDJkrGX1bgZdISrgDt3MwxpXe76NeOPGGOJKAriGEOEvjxb5pLAidhK5E4T4Wo+
         kgUveubdi/gLSBKedD4YJphURZeMKYJRoPsO+nc0=
Date:   Thu, 25 Oct 2018 14:50:38 +0100
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] dmaengine updates for v4.20/5.0
Message-ID: <20181025135038.GA13472@vkoul-mobl>
References: <20181025093233.GB3089@vkoul-mobl>
 <CAHk-=wiSOnFYf=DvPdfmxiUL6+-3POEsV1cE3UNXjn93Bqym6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSOnFYf=DvPdfmxiUL6+-3POEsV1cE3UNXjn93Bqym6w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25-10-18, 06:46, Linus Torvalds wrote:
> On Thu, Oct 25, 2018 at 2:32 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> >  - Support for ColdFire mcf5441x edma controller
> >  - Support for link list mode in sprd dma
> >  - More users of managed dmaenginem_async_device_register API
> >  - Cyclic mode support in owl dma driver
> >  - DT updates for renesas drivers, dma-jz4780 updates and support for
> >    JZ4770, JZ4740 and JZ4725B controllers
> >  - Removal of deprecated dma_slave_config direction in dmaengine driver=
s,
> >    few more users will be removed in next cycle and eventually users.
>                                                                  ^^^^^
> removed?

Ah sorry it came out not so correct!. I meant usage of this will be
removed in users eventually

>=20
> >  - Minor updates to idma64, ioat, pxa, ppc drivers
>=20
> Pulled,

Thank You!

--=20
~Vinod

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb0couAAoJEHwUBw8lI4NHp5cP/AhO2EPNu9wb0A+HtplfOj55
Fx1z/7znpHXK1zV4FcMOgvBXgbNT59PmHBuNOfkXsy5WyLMPI3XWUbZ4iuKB+fIQ
L8uIJIrbTyEowQUhndVQ2AHbK+HQRfmw4cyereufg7OZKgMZa5Bs7HrgPGXbJAie
Kv7y8bOgZccetAIB6QWCykUpTpYPQvAOZx32Y/5gLGfjFmlBq14jTHpaYEOI4+SJ
MdKEnNRVCoaiOk0pRF5Y7ecooPRODFEJh6/agw3IfPQI91r30qFxFSPaBxiDqAif
DOqdBOVaKBTuGjoBr/vIKafOhWXhR5KYZd1OPqCHgQJWfAzPiI772GAXePefOA5D
WGGC7mFse5bLZvXI4hLCSnKHELA8dimf0tM2rohnjMNLX2RSA+NJGcvS3iMHh5gG
xjyPZOkS7SQXM5svoZ+R80EN5ouJdUF6lO5p/+q6pYa3uDUQzIzidvqP36hzPHDo
g83RTpqzWHtKwn4HCjma7lILdsdw+OEMSjSizDW90YJKvzOdIOXuKA1mrYhXccSw
2L0vXeGNnl6W2EHO1CkbEd9jH/Jxi6hMDvjkmW5n024gox5ag3n0azQL+phuRPR0
rogSewDxOAWaYafbog3dMk8xdplLYtUG5dBNMhB/ZzGn/ALtcPW5Q6ruw/a1Azsm
UspkBuBvfcnaM3Z5PLy3
=7os4
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
