Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6450AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314A82145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545054755;
	bh=FlCrmHGvm6seMToFGGbjnlWhjJhctA6B0AtHxFo/JDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qjOo2C294uVJ6nkulXJM29YcBGxBYALm7x3anGT9cnn1LzhTwau4XHHHrAa37vMGq
	 5C+4UF//Ml7BHmGwqIpTLPSSOJ4iSexS3vGmbX2c3zF1jcNPXgS2Vwgq/aRG1g/+bi
	 aVvQsTyoX+YJKsj4H8/rJfW559tv+QaU3uQuWSME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeLQNwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbeLQNwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:52:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD1F206A2;
        Mon, 17 Dec 2018 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545054753;
        bh=FlCrmHGvm6seMToFGGbjnlWhjJhctA6B0AtHxFo/JDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAVj7bxzt1AORqRytupV5ZI9UWvjbf+vQlplrKywUorOmAeyD/a+tJUJuwBvK1iks
         otbSEMSo3b6g5/J06/GOg96S3My/EQvl/XGUv1IsTo8eKb3ImZMVWwkLd9dfwf1QLL
         8u6NbgFPib1VRGhMlfuMVOJugPD3ppkTHxzYLngM=
Date:   Mon, 17 Dec 2018 14:52:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     natechancellor@gmail.com, kernelpatch@126.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] staging: rtlwifi: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181217135230.GA1836@kroah.com>
References: <20181215085635.27602-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215085635.27602-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 03:56:35AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/staging/rtlwifi/debug.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)

Always test build your patches so you do not get grumpy maintainers
telling you to not break the build :(

Please fix up.

greg k-h
