Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BA5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB7525AE5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB7525AE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934058AbeFYOAB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:00:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbeFYOAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:00:00 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A6C1CFD;
        Mon, 25 Jun 2018 13:59:58 +0000 (UTC)
Date:   Mon, 25 Jun 2018 21:59:53 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     avifishman70@gmail.com
Cc:     stern@rowland.harvard.edu, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        tony@atomide.com, baolu.lu@linux.intel.com, elder@linaro.org,
        digetx@gmail.com, kstewart@linuxfoundation.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/3] MAINTAINERS: add subfolders for nuvoton *npcm*
Message-ID: <20180625135953.GA3999@kroah.com>
References: <20180620063306.134820-1-avifishman70@gmail.com>
 <20180620063306.134820-4-avifishman70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620063306.134820-4-avifishman70@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:33:06AM +0300, avifishman70@gmail.com wrote:
> From: Avi Fishman <AviFishman70@gmail.com>
> 
> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>

No changelog text?

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

Patch does not apply to 4.18-rc2 :(

thanks,

greg k-h
