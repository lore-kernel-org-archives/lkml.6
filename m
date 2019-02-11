Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051E320863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549874191;
	bh=MQFyVlBgUXCRmqoHhipCl58c3LMr7jMSZ/VbxTJXsl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wDPzf/DGlemcbhKwwA2lWxt2d3JiISUZUTDSypeP5fEE3vJi/yctBQwQl0mi7G+Zo
	 dc3XVp4YbVu8hdGBgEQr32KzIeqnxDx3hSclwWjN6wzsBXZ/kLdaoF1L6F0SCKuIMf
	 VhZHqgoCfiSVMfaBu911cmI43msLWsenGC7xfeYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBKIg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfBKIg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:36:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5F720863;
        Mon, 11 Feb 2019 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549874188;
        bh=MQFyVlBgUXCRmqoHhipCl58c3LMr7jMSZ/VbxTJXsl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFi2E/pntk3DL73VSWgdA9ELnKhsO/wK1fmW020wx13ZjmMwrAHGadOH5hBU21nRV
         WPVtDIHEoPbO06RFZVFEBBSyPzaoNOXR/ke738tfD7TmSmzIPbAA5mEtfp+488en49
         gFhjO84YilwwveuRvycujaOriCsg4mReTsYzeh4s=
Date:   Mon, 11 Feb 2019 09:36:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?7LWc7LCs7JqwIChzYW1zdW5nLmNvbSk=?= <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.1
Message-ID: <20190211083626.GA5207@kroah.com>
References: <CGME20190211082653epcas1p13b821c85b62b6611ca0a6b0a6c3d68b9@epcas1p1.samsung.com>
 <28f4fb8e-26aa-fa5b-03ea-cfcc6161d0c6@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f4fb8e-26aa-fa5b-03ea-cfcc6161d0c6@samsung.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:26:52PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.1. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:
> 
>   Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.1

Pulled and pushed out, thanks.

greg k-h
