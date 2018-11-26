Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB1CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BED20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="szmZn+2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BED20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeKZSBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeKZSBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:01:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1288820663;
        Mon, 26 Nov 2018 07:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543216124;
        bh=DThilgqzWdv/NxSVS9E2+w3D6N/3sUF1gKlCCfRJVGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=szmZn+2om0c8flBrFOopo+VbGWLgWhMl7CkESleJM/AI4zekoP7Id/gXM7Nslwdco
         9wAsHLvHus4mIgdxoc5SHAAJFjom+T1KrQvA/52UFZ3dDzdFhuDNsW1dY2hp7LepLl
         iovZDl3HVksc2bYynbvK3vBce4m6X+zIxltcSf4E=
Date:   Mon, 26 Nov 2018 08:08:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: for 4.20 -rc
Message-ID: <20181126070834.GD9680@kroah.com>
References: <20181123103008.11672-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123103008.11672-1-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 04:00:08PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 4.20 -rc below.
> 
> It includes tuning parameter fix in qcom-qusb2 PHY driver, dt-bindings fix
> for phy-qcom-qmp and a fix for randconfig error in uniphier-pcie.
> 
> Consider merging this in the -rc cycle.
> 
> Thanks
> Kishon
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.20-rc

Pulled and pushed out, thanks.

greg k-h
