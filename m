Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59BC25023
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59BC25023
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeGBVpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:45:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37114 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeGBVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:45:16 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3333ECDB;
        Mon,  2 Jul 2018 21:45:15 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:45:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     avi.fishman@nuvoton.com
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        avifishman70@gmail.com, tmaimon77@gmail.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Avi Fishman <AviFishman70@gmail.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: add subfolders for nuvoton *npcm*
Message-Id: <20180702144514.18b45671a29cf5250aacb153@linux-foundation.org>
In-Reply-To: <20180701093028.10174-2-avi.fishman@nuvoton.com>
References: <20180701093028.10174-1-avi.fishman@nuvoton.com>
        <20180701093028.10174-2-avi.fishman@nuvoton.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Jul 2018 12:30:28 +0300 avi.fishman@nuvoton.com wrote:

> From: Avi Fishman <AviFishman70@gmail.com>
> 
> Add several subfolders to look for *npcm* files under
> ARM/NUVOTON NPCM ARCHITECTURE
> 
> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ce3c5f32e5..23c450adad44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1727,7 +1727,10 @@ F:	arch/arm/mach-npcm/
>  F:	arch/arm/boot/dts/nuvoton-npcm*
>  F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
>  F:	drivers/*/*npcm*
> +F:	drivers/*/*/*npcm*
>  F:	Documentation/*/*npcm*
> +F:	Documentation/*/*/*npcm*
> +F:	Documentation/*/*/*/*npcm*

The Docuemntation/ pathnames have changed.  Please refresh to the
current Linus tree.

