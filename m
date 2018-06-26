Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC94126DC5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC94126DC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbeFZRBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:01:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36296 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeFZRA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:00:58 -0400
Received: by mail-pl0-f67.google.com with SMTP id a7-v6so8831873plp.3;
        Tue, 26 Jun 2018 10:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y97+4mrw+GpHpUnQUD6Hhd4F4ZqvWPapugc1vHELcK4=;
        b=oqI4VGRUXjTlDXSq1lcFhmXp+AnclPcmgGIQTelnJ057P28bbGeUP1Z2BrAh4VQLHZ
         oqnTwp5mV6dcaRsCEvd70TFJc+dqonpOgpcQGVka1sFlo+v8abl5Qzdrwe/fUgj0VVF1
         jz5rafGpGNiDZNNdLdd/5laAWDiT9w6a9QqqFXWXTMntoFTnil7JsjsjeIVMNHSOnmNH
         R7xPQ90T4tX1U04N/cDyo1euLlzPv6qDXgKE6JJvIW79B7bdLWPepxTnLySWopAcG/tp
         Fvk3zaEHAO2vQX+nXHKddnybg4EtHfu+0DnU74GBXstrj2XIwwEwxBJN91TrAmRS0qv8
         m8+A==
X-Gm-Message-State: APt69E1ak4oG/Q96F7F8YE+AP/P/fY1CpG9h4IIxVyFR06hmo0/lyVPu
        k9EeM3FiDXBSG3LwXey/xA==
X-Google-Smtp-Source: ADUXVKKyienV7WdPnBcQVZLdpO5dqhPmXkDI8c6y1yIKjD8DMILk2kmRAHd9WrCR9Vn8Au4LOG62Qw==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20-v6mr2445663plo.258.1530032457830;
        Tue, 26 Jun 2018 10:00:57 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id z72-v6sm5031338pfa.126.2018.06.26.10.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:00:57 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:00:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     vkoul@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        dan.j.williams@intel.com, appana.durga.rao@xilinx.com,
        lars@metafoo.de, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add VDMA
 vertical flip property
Message-ID: <20180626170054.GA1467@rob-hp-laptop>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528875288-9140-2-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528875288-9140-2-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 01:04:47PM +0530, Radhey Shyam Pandey wrote:
> The AXI VDMA core supports Vertical flip in S2MM path when Enable
> Vertical Flip (Advanced tab) is selected. To allow vertical flip
> programming define an optional 'xlnx,enable-vert-flip' channel
> child node property.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
