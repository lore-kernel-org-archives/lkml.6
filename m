Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CFCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091FF20863
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091FF20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbeGQHvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:51:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54500 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeGQHvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:51:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B31ED20799; Tue, 17 Jul 2018 09:20:28 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 82437206ED;
        Tue, 17 Jul 2018 09:20:28 +0200 (CEST)
Date:   Tue, 17 Jul 2018 09:20:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Koen Kooi <koen@dominion.thruhere.net>
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>, SZ Lin <sz.lin@moxa.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: Add vendor prefix for Sancloud
Message-ID: <20180717072028.GA3100@piout.net>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-2-git-send-email-koen@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531808688-9716-2-git-send-email-koen@dominion.thruhere.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Koen,

I'm not sure how you expect that to be merged but you should probably
send this patch to the TI maintainers along 2/2 because probably no one
in copy of this patch will apply it.

On 17/07/2018 08:24:45+0200, Koen Kooi wrote:
> Add vendor prefix for Sancloud Ltd.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> v5: No changes
> v4: Add Acked-by
> v3: No changes
> v2: No changes
> v1: Initial submission
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 7cad066..c7aaa1f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -314,6 +314,7 @@ rohm	ROHM Semiconductor Co., Ltd
>  roofull	Shenzhen Roofull Technology Co, Ltd
>  samsung	Samsung Semiconductor
>  samtec	Samtec/Softing company
> +sancloud	Sancloud Ltd
>  sandisk	Sandisk Corporation
>  sbs	Smart Battery System
>  schindler	Schindler
> -- 
> 2.0.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
