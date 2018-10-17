Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA13ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1FA21529
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYvGvgje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1FA21529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJQPqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJQPqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:46:01 -0400
Received: from localhost (unknown [188.88.119.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A14FD21527;
        Wed, 17 Oct 2018 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539762695;
        bh=90P2U1zLtjw0u9cm3oSaW1gN+lJ4Ri/TvZykDYQn7H0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=KYvGvgjek+jiB4C+Q5iYev2r5w/LJo/XUz++LfQVx2SkMa27Ye1qsQln7zoxO9tIE
         8dxNflNxKKzBRM9Y+e7pyOx/Igub9eFbUMOyUCJle5L9yD0UkK/tIBGEUN62pFhst6
         tNlBu+3VUt7hiEyt4wpIBaumhech3/Ho6vr+eSYM=
Date:   Wed, 17 Oct 2018 09:51:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.77-stable review
Message-ID: <20181017075132.GI25537@kroah.com>
References: <20181016170524.530541524@linuxfoundation.org>
 <20181017035642.33i6jcg2bsr7lhq2@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181017035642.33i6jcg2bsr7lhq2@xps.therub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:56:42PM -0500, Dan Rue wrote:
> On Tue, Oct 16, 2018 at 07:04:28PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.77 release.
> > There are 109 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Oct 18 17:04:58 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Wonderful, thanks for testing,

greg k-h
