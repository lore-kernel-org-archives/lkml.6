Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD55C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F12D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548869051;
	bh=+qexuxyzZUXCvUAFV0o1R9tjZx4Et7tW4L3+Zv2mgis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Sg2TweBBgkXYQDsdFfrO1stJNTcFJMSlcwb0IxEM+UOqplthowLycX1hks81BP7lf
	 vHANAPzmzwJgMDAbH4hX9VTxqqGH3b6SZj6ZwEC1oIccpmpOxwd2kf/ZWcQxAF2cVg
	 dM7oZR+kFi6GsZQgO//2g8hkr4yciWsvniUxH76E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfA3RYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfA3RYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:24:09 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92DB2082F;
        Wed, 30 Jan 2019 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548869048;
        bh=+qexuxyzZUXCvUAFV0o1R9tjZx4Et7tW4L3+Zv2mgis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANd4YPqqC6IyP3tlK8Ra9P/rIpieQeuauCECrQA21M/0YqDThQKdIamrmhEzlEx97
         vNA7FNVXfuS3Ze1hoT67VHaPhjHM8PIdNtzmhgMS/yr362T8iZoXsumOey1uFuvz9s
         DkAf851PTC84gyG/0KsJTylhltxLgjbWd61h4RTs=
Date:   Wed, 30 Jan 2019 18:23:58 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 6/9] spi: atmel-quadspi: switch to SPDX license
 identifiers
Message-ID: <20190130182344.07e1d635@bbrezillon>
In-Reply-To: <20190130150818.24902-7-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-7-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:40 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Adopt the SPDX license identifiers to ease license compliance
> management.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
>  drivers/spi/atmel-quadspi.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index e6de6e3d1345..1d21db7851e9 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for Atmel QSPI Controller
>   *
> @@ -7,18 +8,6 @@
>   * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>   * Author: Piotr Bugalski <bugalski.piotr@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
>   * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescale.
>   */
>  

