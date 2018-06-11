Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 91E86C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382E1208CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU5X/UbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382E1208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934034AbeFKRBY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933502AbeFKRBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:01:23 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE49208B9;
        Mon, 11 Jun 2018 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528736483;
        bh=B+vxVTy9zjbE+u3XGJixyOcNzxiYeQW23xL1oqAXxCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BU5X/UbVGs57BJ7s7eICBJ58JosqGW92AcARFnsrP3KfBUkxSs874lKub2QyyPfHm
         8r3ywnEmTvSUHqshZO79G4P0QUBhb8J8ZD45pLm6CJf0PxuttbFnzhLnF/hrqea/7X
         4SLx3p07m1t7TKOcWTNYX+2ExhePqXLGJKFhDVPA=
Date:   Mon, 11 Jun 2018 10:01:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: What commit v4.17 is?
Message-ID: <20180611170122.GB6783@jaegeuk-macbookpro.roam.corp.google.com>
References: <VI1PR07MB16455C3E87BEE7172DF2BB61A1790@VI1PR07MB1645.eurprd07.prod.outlook.com>
 <VI1PR07MB164579C7BD26A5420FBB5191A1780@VI1PR07MB1645.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR07MB164579C7BD26A5420FBB5191A1780@VI1PR07MB1645.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 06/11, Jorge Fernandez Monteagudo wrote:
> Hi all,
> 
> 
> This is my first message in the mailing list and is about what f2fs commit is present in the 4.17 kernel. I guess is a
> 
> very basic question but I'm not very skilled with git.
> 
> 
> Currently I'm using a 4.14 kernel I downloaded from https://kernel.googlesource.com/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable/+/linux-4.14.y
> 
> commit 00f0eaaadfe041ee518c5a9122a121864e56cd23 (Thu Jan 25 14:54:42 2018 +0800). This kernel is working ok for me because I need
> 
> my SSD disk with F2FS to recover from powerfail tests.
> 
> 
> Now I have to update to an 4.17 kernel in order to get my AMD graphic card to work but I don't want to lose the F2FS recovering capabilities.
> 
> Is the previous commit 00f0eaaadfe041ee518c5a9122a121864e56cd23 present in the vanilla 4.17 kernel I can download from kernel.org or

That commit was lastly merged in vanilla v4.16, which means v4.17 should include
all the commits that you've used.

Thanks,

> 
> I need a special kernel from f2fs or f2fs-stable?
> 
> 
> Thanks!
> 
