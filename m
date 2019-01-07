Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D29C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C276420859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864083;
	bh=JARJ/dpS4oFbfasf007kpjP2niDDwi5m2EWEcr7dXDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=md4X1wMfaK71MMon6L+LyrxgUo3/dOWrYTlFMxfjIsRet1OMrj/8a/j3SL6FKO88i
	 yLk9SwNjHPyJP8FGtmvHsS+jlu13sc+NN7a3Y6jJsjkPlkAnq6JVINaOhts6Jbroo2
	 2CH9ovk+k/blHqqOWuRL04tYpXVh8gv9PWhjQDkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfAGM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfAGM2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:28:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4BE206BB;
        Mon,  7 Jan 2019 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864081;
        bh=JARJ/dpS4oFbfasf007kpjP2niDDwi5m2EWEcr7dXDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fryjng1WPV6dBN8/lbx0mRs2wwf72mSoxb2ysyPnwG74dPpARwKOaMIkVgjypWNwB
         33q9kBHRITeMQSEbsm7ARiRx8bO5E9WGernCN9gd16cfqYx1EdCAsRiKhMtSeFrHXS
         ML2IWXNW2Axw2Dhn4UDywLPdzgIcbhnu1PZofwSY=
Date:   Mon, 7 Jan 2019 13:27:58 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:
 linux-5.0-rc1/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c:412]:
 (style) Expression is always false
Message-ID: <20190107122758.GA24028@kroah.com>
References: <DB7PR08MB3801DE2E52BE7BF2E0D7D0129C890@DB7PR08MB3801.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR08MB3801DE2E52BE7BF2E0D7D0129C890@DB7PR08MB3801.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:40:08AM +0000, David Binderman wrote:
> 
> Hello there,
> 
> linux-5.0-rc1/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c:412]: (style) Expression is always false because 'else if' condition matches previous condition at line 410.
> 
> Source code is
> 
>         else if (pRaInfo->HighestRate > 0x0b)
>                 pRaInfo->PTModeSS = 2;
>         else if (pRaInfo->HighestRate > 0x0b)
>                 pRaInfo->PTModeSS = 1;
> 
> Suggest code rework.

Patches are always gladly accepted!

thanks,

greg k-h
