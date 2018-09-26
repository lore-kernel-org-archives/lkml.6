Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3794F2154D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3794F2154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeI0DNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:13:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35851 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeI0DNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:13:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id c18-v6so408996otm.3;
        Wed, 26 Sep 2018 13:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJT41FwVm+66yW3vuXy/faxFIbNZ03LdraZxqybR1sc=;
        b=VDS3bZRxdhaVlr5QvtUetEt7wwXho1TwEKkX5QjJl2TUFnj+m7/0ortqdhNSAN3zsV
         5jea90hpGA2RVmJvZq+xYywLB4vvs3Y+IEufwVWS76wFc1WPeEIJCbbRbBWAAVM7YNfp
         J6wePfvIpJPSEtnFmA+wKvY7/KOfPz9eqQq5v/yHwsgueiDZFNIkiYZlQeUz/NEZgDUv
         5+N+JbEOQJZG+QUrQ78bJp4o/QCidTHEW3W5liOVzCg+vKB+GZ7k9QcUu9+Ou2WLOwWe
         eibWIDZ7OwoB3dFsL7T09VMcnr7h7NxXDue5XVcgRIZhRIhLAjf0N+FIclSBD2RnjM7p
         pYgw==
X-Gm-Message-State: ABuFfoitIHirMiYAkT1xTwTH+NdlkA8ZrcehlBWoAWlqxKLS2BYesIio
        8Cns0Lz4Ij9j90e3X7raQQ==
X-Google-Smtp-Source: ACcGV61V0mjq5/PGI0s3bet68LKJZNAFnNwANvs7bM4NVkx/GcP+jOgcgK8Ql31g1ZFe7gMf+zCmJg==
X-Received: by 2002:a9d:82:: with SMTP id w2-v6mr5569877oti.302.1537995543815;
        Wed, 26 Sep 2018 13:59:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f3-v6sm30569oth.31.2018.09.26.13.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 13:59:03 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:59:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        vivek.gautam@codeaurora.org, kishon@ti.com,
        v.anuragkumar@gmail.com, APANDEY@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH v4 1/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Message-ID: <20180926205902.GA28877@bogus>
References: <1536769366-31398-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536769366-31398-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536769366-31398-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 21:52:45 +0530, Anurag Kumar Vulisha wrote:
> This patch adds the document describing dt bindings for ZynqMP
> phy. ZynqMP SOC has a High Speed Processing System Gigabit
> Transceiver which provides PHY capabilties to USB, SATA,
> PCIE, Display Port and Ehernet SGMII controllers.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>  Changes in v4:
> 	1. Fixed the changes in phy-zynqmp.txt as suggested by "Rob Herring"
> 	2. Moved changes from include/dt-bindings/phy/phy.h into Patch 2 to 1
> 
>  Changes in v3:
> 	1. Corrected the Documentation as suggested by "Vivek Gautam"
> 
>  Changes in v2:
> 	1. None
> ---
>  .../devicetree/bindings/phy/phy-zynqmp.txt         | 109 +++++++++++++++++++++
>  include/dt-bindings/phy/phy.h                      |   2 +
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
