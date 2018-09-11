Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7031C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9BF2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu6cwiZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9BF2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeIKSro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeIKSrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:47:43 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B060220866;
        Tue, 11 Sep 2018 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536673698;
        bh=YCOmQuyxzPfiD/yVsxHvh1GA0RaEDS8Mo0FGsYTcfgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gu6cwiZnKSmlXz1CwUNvdU+vDE6LnBdLWH1dkZfZkUIz9KwN7nOil9Y7/EjnundIm
         iL90cQjYAq3f8MujwGkLZK2UL2f58LMeWfmeQiLl8gBOMuVeoFIICA2TsU7/fv5Q65
         bxwkpBSHeZjVrdud84DHeLwK0roN6w9AdcgV8l3Q=
Date:   Tue, 11 Sep 2018 08:48:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joao Pinto <Joao.Pinto@synopsys.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: designware: Change maintainer to Gustavo Pimentel
Message-ID: <20180911134817.GE250890@bhelgaas-glaptop.roam.corp.google.com>
References: <aa29f3f8dbae3a2c8523ddfd74d11505600bc47f.1536659938.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa29f3f8dbae3a2c8523ddfd74d11505600bc47f.1536659938.git.jpinto@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 01:06:30PM +0100, Joao Pinto wrote:
> Currently I am managing the Synopsys drivers & tools team (full-time) and so I
> am passing the pcie-designware maintenance to Gustavo.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> CC: Jingoo Han <jingoohan1@gmail.com>

Applied to for-linus for v4.19, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b..e5e8984 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11153,7 +11153,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>  
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
> -M:	Joao Pinto <Joao.Pinto@synopsys.com>
> +M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
> -- 
> 2.9.3
> 
> 
