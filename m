Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC81C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E745E2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZhnMi1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E745E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeJLSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbeJLSoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:44:11 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A7621473;
        Fri, 12 Oct 2018 11:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539342735;
        bh=oeIUR8s52frSRw4fdL7f/hEMHZ0e7kCRZmQSYIXYeQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZhnMi1HHxNskdBD7daqFhBRU0pKkGJl6OADzz4YCChaXMSO/QB44wLBBBoTguA7M
         DX32YXejmv8rGAgrr0gHjQledJZQsjltd4ilgVQqAy2HRA80ugDoTu19IkB1YZdfy0
         8zbAcTnVATZe82aFqzoj3K3JTStEU/NdXlcAINPU=
Date:   Fri, 12 Oct 2018 13:12:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] MMC fixes for v4.19-rc8
Message-ID: <20181012111213.GF6536@kroah.com>
References: <20181012103529.4688-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012103529.4688-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 12:35:29PM +0200, Ulf Hansson wrote:
> Hi Greg,
> 
> Here's a PR with two MMC/WIFI/SDIO fixes intended for v4.19-rc8. Details about
> the highlights are found in the signed tag.
> 
> Please pull this in!
> 
> Kind regards
> Ulf Hansson
> 
> 
> The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:
> 
>   Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-rc7

Now merged, thanks.

greg k-h

