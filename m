Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F2C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF21B20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF21B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeLCMQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:16:55 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:42157 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeLCMQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:16:55 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gTn8u-0001yg-Se from Vladimir_Zapolskiy@mentor.com ; Mon, 03 Dec 2018 04:16:04 -0800
Received: from [137.202.108.125] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 3 Dec 2018 12:16:01 +0000
Subject: Re: [PATCH linux-next v2 5/6] dt-bindings: clock: add clock id for
 renesas adg clocks
To:     <jiada_wang@mentor.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
References: <20181203112409.18276-1-jiada_wang@mentor.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <25148671-24cd-980b-ce6d-adabb3cfd09e@mentor.com>
Date:   Mon, 3 Dec 2018 14:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181203112409.18276-1-jiada_wang@mentor.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada,

On 12/03/2018 01:24 PM, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> This patch adds clock ID for renesas adg clocks
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  include/dt-bindings/clock/renesas-adg.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 include/dt-bindings/clock/renesas-adg.h
> 
> diff --git a/include/dt-bindings/clock/renesas-adg.h b/include/dt-bindings/clock/renesas-adg.h
> new file mode 100644
> index 000000000000..fe30c186cef7
> --- /dev/null
> +++ b/include/dt-bindings/clock/renesas-adg.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Mentor Graphics inc.
> + */
> +#ifndef __DT_BINDINGS_RENESAS_ADG_H__
> +#define __DT_BINDINGS_RENESAS_ADG_H__
> +
> +#define ADG_FIX				0
> +#define ADG_AVB				1
> +
> +#endif /* __DT_BINDINGS_RENESAS_ADG_H__ */
> 

instead of adding these trivial definitions in a new header file with no
potential for further extension, I would like to ask you to write a proper
device tree bindings documentation section and describe the clock ids as
a list of acceptable values for a cell.

--
Best wishes,
Vladimir
