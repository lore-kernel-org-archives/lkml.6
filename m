Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4776C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A65D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546872727;
	bh=uvegBL+JEnTVMcTSDJoy2oV9weLA4qursE//lP+xors=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dmP1mj0QG4/nQzwZK1btw8OjA1hvPQ9EAQVWTNRFFSzlHfragmA3J4FZMHQex5qLg
	 7LGWJLFDhRorab3zjKJ1nnykRvyrZGc/lrJ1T7VlaUnNkJh3PIMAhnrOk/i0rPecHZ
	 +7TGY6FIV1ehyA9KOVwf3Tq2Jt/MqP87UrLBPmaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfAGOwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbfAGOwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:52:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 878F52183E;
        Mon,  7 Jan 2019 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546872726;
        bh=uvegBL+JEnTVMcTSDJoy2oV9weLA4qursE//lP+xors=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJgBgTFTO7BtUXU2Vpr4PWOW81l3wZJ0VSuSAWAOEj+DvCcmx89nt0fmPLMjX19YW
         /qrzN1A93JrcB+ISLi2jgYqcHmD4wTYIQQEClQWK0YmBZsKgNYV09cHPIZXIj1P1uT
         WknN79klQtjLUgttwsJmsxyJnDK0oPQwbaRoroy4=
Date:   Mon, 7 Jan 2019 15:52:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
Message-ID: <20190107145203.GB27768@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:31:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.92 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc1.gz

-rc2 is out to fix a build issue that I somehow missed:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc2.gz
