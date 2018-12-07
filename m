Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90667C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FE22146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544187970;
	bh=BT4xbuMCaZvffQDfGEpWrcoXWYOIJljJPZAiOcn4BGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y9LFjoke3DmjXBwgfrGWS3Qq3h1Ntq5vOIQeRTJtaf+ybtf8rSYILOT5jpCQO5Rbu
	 y7VtJaIPvdGN+SE61PyypbtJXckVnlTgi0I5q1Ej6hfliwIkxmkkkZsSRxPpEp2OVf
	 THF7l96FQHzJS3LdfZxzu3dtEB3aTyXJhNB5z1ZQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FE22146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeLGNGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeLGNGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:06:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC9F20989;
        Fri,  7 Dec 2018 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544187968;
        bh=BT4xbuMCaZvffQDfGEpWrcoXWYOIJljJPZAiOcn4BGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixZSfaeIhqSG64oTza+V7BRaK136zDmmVNxdq7EYc596nHK0wwPwmy7ndUdBoLN9R
         rowAcj571a53pueaPbbh0JWBT6v6SIGhXCW1M/UDb0iz47jClzuMVp5bQr4G4cz9dz
         IRGw0T1cvfKi3872xk/2USbx0ZIXOgPVywnFFuFg=
Date:   Fri, 7 Dec 2018 14:05:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] GNSS fixes for 4.20-rc6
Message-ID: <20181207130559.GA26870@kroah.com>
References: <20181207125745.GA9989@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207125745.GA9989@localhost>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 01:57:45PM +0100, Johan Hovold wrote:
> The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:
> 
>   Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-4.20-rc6


Pulled and pushed out, thanks.

greg k-h
