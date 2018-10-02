Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5673DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222B5213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222B5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJBHxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:53:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBHxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:53:25 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 189066C;
        Tue,  2 Oct 2018 01:12:52 +0000 (UTC)
Date:   Mon, 1 Oct 2018 17:53:22 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: SoC fixes
Message-ID: <20181002005322.GB29284@kroah.com>
References: <20180930192343.erige7yfbrnvil2m@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930192343.erige7yfbrnvil2m@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 12:23:43PM -0700, Olof Johansson wrote:
> Hi Linus, Greg,
> 
> The following changes since commit a132bb90414bfad4f8ee23cb45fe6946a89b167d:
> 
>   Merge tag 'sunxi-fixes-for-4.19' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into fixes (2018-09-08 10:04:37 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

Now pulled, thanks.

greg k-h
