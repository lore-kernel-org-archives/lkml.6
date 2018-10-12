Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7260C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AD72087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB0AtPSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AD72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJLSnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbeJLSnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:43:49 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DE02077C;
        Fri, 12 Oct 2018 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539342713;
        bh=o5Zm0S+QTk6ofDOd63vMMh/Bp5vMleK3gqrhkttGPYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QB0AtPSBtZbJt/DzUR/GkaJmm/VcgF5UwOiqL2ZDz0ob7p4eQTp3AKvMAQ8SxDTEA
         jcc/4k82DqdZfg8tVTf4C6tZ6ibF3X1YsgkMAs0J6Kaul3o2Fx482M+sWRVXRg8X2t
         XCUZ5kpmt0gaZnCUvrPxzDybUngTfzcgPUfnEUL8=
Date:   Fri, 12 Oct 2018 13:11:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull[ drm fixes for 4.19-rc8
Message-ID: <20181012111151.GB6536@kroah.com>
References: <CAPM=9tzc0vn_bC9eXGpHyf562RmXx7C_rO9=g_JjYz2+xz8TmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzc0vn_bC9eXGpHyf562RmXx7C_rO9=g_JjYz2+xz8TmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 03:59:26PM +1000, Dave Airlie wrote:
> Hi Greg,
> 
> just a single nouveau fix from last week. Seems to be winding now correctly.
> 
> Dave.
> 
> drm-fixes-2018-10-12-1:
> single nouveau runtime reference and mst change
> The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:
> 
>   Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)
> 
> are available in the Git repository at:
> 
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-12-1

Now merged, thanks.

greg k-h

