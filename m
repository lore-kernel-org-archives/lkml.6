Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1879EC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D468520843
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxjihBPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D468520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeJNOfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 10:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeJNOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 10:35:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C6E20645;
        Sun, 14 Oct 2018 06:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539500143;
        bh=5cJt2F9fqSVJCCHB9RPqtBNbfM2EbwvFqepfEdHrfLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxjihBPNsJyTZyUKW3efTw0WvTvhDAcobezsBbvNh9xN9fbyiABPK5AM/sIJjXMzk
         2aZjXKBBIbH3R+4HL+uOZ7PAmM6hKYTppLchCfBUgGwRD4SWE+Ik8xdrUr1vZS89Z/
         Oi+gYqYACTbAOOnvacXU5KX5G1wrS2RAnbIe2NS4=
Date:   Sun, 14 Oct 2018 08:55:41 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [GIT PULL] dax fixes for 4.19-rc8
Message-ID: <20181014065541.GB11198@kroah.com>
References: <8f47e3ce3cbe6e165701dbf665bb1770ca13d907.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f47e3ce3cbe6e165701dbf665bb1770ca13d907.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 05:25:21PM +0000, Williams, Dan J wrote:
> Hi Greg, please pull from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.19-rc8
> 
> ...to receive (2) urgent dax fixes for 4.19-rc8. They have appeared in
> a -next release.
> 
> However, note that commit d7782145e1ad ("filesystem-dax: Fix
> dax_layout_busy_page() livelock") is immediately replaced with the
> Xarray conversion targeting 4.20, so d7782145e1ad is the backport
> suitable fix for the livelock for v4.19 and earlier.
> 
> Please pull, thanks!
> 
> ---
> 
> The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:
> 
>   Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.19-rc8

Now merged, thanks.

greg k-h
