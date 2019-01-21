Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19271C2F426
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92202085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548082022;
	bh=ZIGABvdda1pgy32JprqiuX67dPY/TD+nH0y80MK8stY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kBsL6jgjsbzsCuK54bjzdObusrS24MKHYc9k9yuDBcuEvWrHYBezN96MkFHtf4EKi
	 RCRWZ9nIm7bu2uuBgVcmDSYkXlK81MiLrDRKMBR6P9gguQhWovUGbX2MiLMMGsIzxY
	 Nrm8P6c4DH83Ppa/zUZTvj/WCViCnSAfsAwKFO4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfAUOrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfAUOrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:47:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDFBF2085A;
        Mon, 21 Jan 2019 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548082020;
        bh=ZIGABvdda1pgy32JprqiuX67dPY/TD+nH0y80MK8stY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acarjYDGAbxWuFM/9FmumzKgzWkRq+ohg9GGvYCwbFuUIpQRnZnrtlNFaBsPVCvcX
         VBE5+rtCQfgcgpHsNGq7YI3MOSFIZ4XpZ3LsWaO1gGxmeXwNsVy1sr0C3EsHVGIO3e
         kfrkt+cIk7FJhJ8dBkEbKmdYMHmsBJu3N3fpKxy8=
Date:   Mon, 21 Jan 2019 15:46:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.20 000/111] 4.20.4-stable review
Message-ID: <20190121144657.GA27366@kroah.com>
References: <CAA85sZs98K62OE6er2ysBSJ2MQC=1xWapCw_tw458Z_K4BjMDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZs98K62OE6er2ysBSJ2MQC=1xWapCw_tw458Z_K4BjMDA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:44:24PM +0100, Ian Kumlien wrote:
> Hi,
> 
> IMHO you are missing: 41d1c8839e5f8cb781cc635f12791decee8271b7
> 
> Which should be marked for stable, it fixes:
> https://bugzilla.kernel.org/show_bug.cgi?id=202235

The networking maintainer handles sending those patches to me.  It
wasn't part of the last set of patches, so perhaps it will be in the
next one?

Please see:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h
