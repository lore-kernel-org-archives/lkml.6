Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119EBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF993208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE/Shmxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF993208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeK0U45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:56:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbeK0U45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:56:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9BD20873;
        Tue, 27 Nov 2018 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543312775;
        bh=5dGNajAL+Run/A67QTRF/NrLjk7PkhPyEVXdpAIGP8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OE/ShmxhXqqKZPTL+QnwuQ3qHFasMeNXzhDKDJ1sR5SBYOfkMP6gpJCNTe4d+M+3i
         BPsf6kir6twf2Orw08uGHqzxE+jdg5tKVsyZPdRKcrIcSEDsSj3GJbjz4sGFykd8CO
         MTQB+bh91r7f7mmPc9zgGYFMuxZFUCl5aMg7ZP8s=
Date:   Tue, 27 Nov 2018 10:59:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/118] 4.19.5-stable review
Message-ID: <20181127095932.GB21989@kroah.com>
References: <20181126105059.832485122@linuxfoundation.org>
 <20181126190534.GC14137@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126190534.GC14137@roeck-us.net>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:05:34AM -0800, Guenter Roeck wrote:
> On Mon, Nov 26, 2018 at 11:49:54AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.5 release.
> > There are 118 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Nov 28 10:50:22 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 135 pass: 135 fail: 0
> Qemu test results:
> 	total: 311 pass: 311 fail: 0
> 
> Details are available at https://kerneltests.org/builders/.

Thanks for testing all of these and letting me know.

greg k-h
