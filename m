Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC01CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEFE20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZcE3wsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEFE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeK0GNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeK0GNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:13:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064E02086B;
        Mon, 26 Nov 2018 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543259895;
        bh=nJBtae/sPV1x/mtSxanE6H4TS0FxMbQR/RHrZtIhfzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZcE3wskRfWTwXM99ZBUIWQDXas3LnLlzFPVp5KnsDv0j6//Zv7Nhopf3W5OWK1lN
         1XkhNIyZzABbHQagTKhN5l/l9/yZtc7d7cKLk9iPfzMnTCpxhuW79B7R6Q17DYOuy2
         N27AOb+gL3n6+x31A6L8ct6erDbfSCZK1WCtQKso=
Date:   Mon, 26 Nov 2018 20:18:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kys@microsoft.com
Cc:     will.deacon@arm.com, catalin.marinas@armm.com,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
Message-ID: <20181126191812.GA32208@kroah.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122031059.16338-1-kys@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 03:10:56AM +0000, kys@linuxonhyperv.com wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> @@ -0,0 +1,338 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This file contains definitions from the Hyper-V Hypervisor Top-Level
> + * Functional Specification (TLFS):
> + * https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fvirtualization%2Fhyper-v-on-windows%2Freference%2Ftlfs&amp;data=02%7C01%7Ckys%40microsoft.com%7Cc831a45fd63e4a4b083908d641216aa8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636768009113747528&amp;sdata=jRSrs9ZWXdmeS7LQUEpoSyUfBS7a5KLYy%2FolFdE2tI0%3D&amp;reserved=0

"interesting" url :(

Care to use a real one?

thanks,

greg k-h
