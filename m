Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F5EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD81920645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqj2VOz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD81920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJJQfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeJJQfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:35:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE1320645;
        Wed, 10 Oct 2018 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539162840;
        bh=AWgBzfiyDaFTCAYgSLp/PYAD6TxgX/lriHNR3Pyz/Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqj2VOz74lWnQQzyyj4Uiny23CMcj2rqOxt/A2BI9K9nitku7VRE2hQql5Btr3Ght
         VZtARnQAtio/sHzNQXNTOh1eIx256lsruHoeGAVTxbBTki0p342TRDjgo0chRuYnHF
         MgotCjftcrOPsN/e8/XrrlPjPRR5yBZjLbgQdGEA=
Date:   Wed, 10 Oct 2018 11:13:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] percpu fixes for-4.19-rc8
Message-ID: <20181010091358.GB2932@kroah.com>
References: <20181009222815.GA56709@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009222815.GA56709@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:28:15PM -0700, Dennis Zhou wrote:
> Hi Greg,
> 
> The new percpu allocator introduced in 4.14 had a missing free for the
> percpu metadata. This caused a memory leak when percpu memory is being
> churned resulting in the allocation and deallocation of percpu memory
> chunks.
> 
> Thanks,
> Dennis
> 
> The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:
> 
>   Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-4.19-fixes

Now merged, thanks.

greg k-h


