Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F018AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58652087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y69VjocU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58652087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJKD6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeJKD6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:58:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33FC02082B;
        Wed, 10 Oct 2018 20:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539203686;
        bh=GNxkYmIA8xZQiZsj4G3LxuifQOYxTJhW2cRyU0duBtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y69VjocURqqebndYfrUvzURckX7ZPqFLH7QtgEa2KnzHyOTBSrBFm98lCcOkk/s39
         x+IeOhnAvp0vlT5yMU14j5XiQkqr8U7K++zpAvrtFO5oyQgrCr2qzI/v1e0N7wOy0N
         TF1WQuC2nTrawSG8L2pXcoy9VkSQXqvoGS3l9er4=
Date:   Wed, 10 Oct 2018 22:34:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Devicetree fix for 4.19-rc8
Message-ID: <20181010203444.GA6979@kroah.com>
References: <CAL_JsqL4xQXoQubUEb9p2r5AEV+n1OAW=ss-DVQm4dmWU=n2hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL4xQXoQubUEb9p2r5AEV+n1OAW=ss-DVQm4dmWU=n2hw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 06:59:13AM -0500, Rob Herring wrote:
> Hi Greg,
> 
> Please pull this one DT fix for 4.19.
> 
> Note I didn't tag this for stable as I cherry-picked it from my 4.20
> branch and wanted to not touch the commit msg at all. Maybe that
> doesn't matter.

I'll pick it up manually, no worries.

> 
> Rob
> 
> The following changes since commit e54192b48da75f025ae4b277925eaf6aca1d13bd:
> 
>   of: fix phandle cache creation for DTs with no phandles (2018-09-11
> 11:28:40 -0500)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> tags/devicetree-fixes-for-4.19-3

Now merged, thanks.

greg k-h


