Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6FBC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FBA214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsFU6ntX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FBA214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJIOdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeJIOdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:33:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3231D20835;
        Tue,  9 Oct 2018 07:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539069502;
        bh=Uf1AmCAVV5dXZjfy97JEbBUw6q416yVA/UmFWPWB2MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsFU6ntXk82cMO2G40cItlHFRKRT57La9vEUn3oDt/29C0tR7BsChxWyMw5wwOJ56
         7EjzdrbLwm5xIWMHhygfXsWcpvNAeyYyPh8Y1lZNjrrHCnEv1JWpEj0OvcyU0SgtZP
         uD4h1sby94gML2CpZl6BoiniB8ZGgtEomdnnpFm0=
Date:   Tue, 9 Oct 2018 09:18:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Colin King <colin.king@canonical.com>
Subject: Re: [GIT PULL] ARC updates for 4.19-rc8
Message-ID: <20181009071820.GA9097@kroah.com>
References: <C2D7FE5348E1B147BCA15975FBA23075012B0A4DEA@US01WEMBX2.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0A4DEA@US01WEMBX2.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 07:54:50PM +0000, Vineet Gupta wrote:
> Hi Greg,
> 
> Late in the cycle, but please pull ARC updates. We could have waited for next
> release had it not been for the the clone syscall fix which is stable material.
> 
> Thx,
> -Vineet
> 
> --------------->
> The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:
> 
>   Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-4.19-rc8

Now merged, thanks.

greg k-h
