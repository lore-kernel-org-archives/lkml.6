Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE067C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8117F21502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2XQPpFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8117F21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJJQfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeJJQfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:35:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB40214DA;
        Wed, 10 Oct 2018 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539162846;
        bh=Ofv39qdEcff9tRN4jr/FgY61yqSyGaLIE9t6z2uhZQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2XQPpFyDi/sv10ZJPQocQA80oIOWHv1sPKMg/jFhLn767EKuYANXcBDmDv8O/9zJ
         8owazyEKbonSwmbVcbz2lJooD5OMqhiTnAlcR2WVAKV6mzgZr3ZvR58HEb/passDh0
         emlEApy4xCsWynV0bWSzHBBP/1BnYlkP+AGksHg4=
Date:   Wed, 10 Oct 2018 11:14:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@google.com>
Cc:     bleung@chromium.org, linux-kernel@vger.kernel.org,
        jekarlson@gmail.com, narmstrong@baylibre.com,
        enric.balletbo@collabora.com, olof@lixom.net
Subject: Re: [GIT PULL] chrome-platform fixes for v4.19-rc8
Message-ID: <20181010091404.GC2932@kroah.com>
References: <20181010042318.GA142005@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010042318.GA142005@decatoncale.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 09:23:18PM -0700, Benson Leung wrote:
> Hi Greg,
> 
> Sorry for the late in the cycle request, but this one is fairly urgent.
> 
> Please pull thi fix to chrome platform. A patch that landed
> for 4.19 broke cros_ec based chromebooks' keyboards, and this fixes them.
> 
> Thanks,
> Benson
> 
> The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:
> 
>   Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git tags/tag-chrome-platform-fixes-for-v4.19-rc8

Now merged, thanks.

greg k-h
