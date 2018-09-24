Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38835ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72DE21471
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72DE21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeIXHHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 03:07:15 -0400
Received: from dliviu.plus.com ([80.229.23.120]:49668 "EHLO smtp.dudau.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIXHHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 03:07:15 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Sep 2018 03:07:14 EDT
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 9F08541D130D;
        Mon, 24 Sep 2018 02:01:50 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Mon, 24 Sep 2018 02:01:50 +0100
Date:   Mon, 24 Sep 2018 02:01:50 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mali-dp tree
Message-ID: <20180924010149.GF9849@bart.dudau.co.uk>
References: <20180922085834.5442f585@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180922085834.5442f585@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 08:58:34AM +1000, Stephen Rothwell wrote:
> Hi Liviu,

Hi Stephen,

> 
> Commit
> 
>   fd75f5726f65 ("drm/mali-dp: Implement plane alpha and pixel blend on malidp")
> 
> is missing a Signed-off-by from its committer.

My bad, I cherry picked-it from a staging tree and did not add the sign-off.

This is now fixed, thanks for the heads up!

Best regards,
Liviu

> 
> -- 
> Cheers,
> Stephen Rothwell
