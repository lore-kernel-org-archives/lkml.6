Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3472C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A348F20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 13:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A348F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeI3ULc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:11:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbeI3ULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:11:31 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9823FE81;
        Sun, 30 Sep 2018 13:38:27 +0000 (UTC)
Date:   Sun, 30 Sep 2018 06:38:26 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] auxdisplay for v4.19-rc6
Message-ID: <20180930133826.GB5085@kroah.com>
References: <20180930121555.GA15969@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930121555.GA15969@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 02:15:55PM +0200, Miguel Ojeda wrote:
> Hi Greg,
> 
> Please pull this trivial fix in MAINTAINERS for auxdisplay.
> 
> Cheers,
> Miguel
> 
> The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:
> 
>   Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/ojeda/linux.git tags/auxdisplay-for-greg-v4.19-rc6

Now pulled, thanks.

greg k-h
