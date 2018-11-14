Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755B7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8262175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQfDcT8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8262175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeKOJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeKOJFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:05:33 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A41122419;
        Wed, 14 Nov 2018 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542236418;
        bh=t4y3BskVYio2vbG0UzP4S8m3QDAp9hrwyRgJWQ8kh5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQfDcT8b6n9dyP/9SA5DaipBPeb87LAVkAbGWYBOCqh+mEtOeB8vuGeYudRyq+CMC
         H45OBCbRyRm1HD/P3UGmvZln/nXiVuWltG926whvFXXQbH6Q0EIIZVBABe0FoN2Bjl
         tOQF/tF6bR4pt3tblPKVvDAJpqomzTXDI51pq+XE=
Date:   Wed, 14 Nov 2018 15:00:17 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] GNSS fixes for v4.20-rc3 (take 2)
Message-ID: <20181114230017.GA12827@kroah.com>
References: <20181114195144.GA7982@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114195144.GA7982@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 08:51:44PM +0100, Johan Hovold wrote:
> Hi Greg,
> 
> Please ignore my previous pull request for GNSS fixes and consider this one
> instead.
> 
> I've now asked Stephen to include the GNSS tree in linux-next, and he
> immediately spotted the missing Sign-offs. I was too focused on how best to
> split the gnss and serdev patches and handle their dependency that I even
> forgot to post the GNSS patches to the list after setting up the new tree
> (hence the diff below).
> 
> Hopefully back in my usual routine after this.
> 
> Johan
> 
> 
> The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
> 
>   Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-4.20-rc3

Now pulled.  You will not get an automated email for this as I didn't
want to email out all of the messages from -rc1 to -rc2 at the same time
(problem on my side, not yours.)

thanks,

greg k-h
