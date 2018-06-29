Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB3CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D9A27B2A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilUMAdl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D9A27B2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966069AbeF2IvX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935243AbeF2IvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:51:20 -0400
Received: from localhost (unknown [122.167.66.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFFC627B28;
        Fri, 29 Jun 2018 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530262279;
        bh=ETaB1uAETzjhpRJM8lQAF4aJEHxLXBIbopYk/m7lwE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilUMAdl4xhddlAU2XgqvvVHw17mkbV9/8XdeOyWA+VzirL3zXxACwZZhcmphUSG+K
         /l30zQCYusm4EQHVkUxSWXK3u7PFnZ/Lbdk4HQlq9LOYB1ZYUvbRh9YupjtVVICcc4
         w4/Y6vqQ174PG6qGIKt7S6HWegYXsQG4TT/5h3LE=
Date:   Fri, 29 Jun 2018 14:21:05 +0530
From:   Vinod <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        dan.j.williams@intel.com, appana.durga.rao@xilinx.com,
        lars@metafoo.de, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable VDMA S2MM vertical flip support
Message-ID: <20180629085105.GC22377@vkoul-mobl>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-18, 13:04, Radhey Shyam Pandey wrote:
> The AXI VDMA core supports Vertical Flip with S2MM as the path when
> Enable Vertical Flip (Advanced tab) is selected. This patch series add
> DT property for vertical flip and program its state in VDMA start_transfer.

Applied both, thanks

-- 
~Vinod
