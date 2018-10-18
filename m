Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3BCC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3993D21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8NeC9Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3993D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeJRPLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbeJRPLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:11:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F5B2145D;
        Thu, 18 Oct 2018 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539846706;
        bh=IWX7SqU3i1jHlzHOxMCkcOzqNE7ZRxJv2oljmCWrWmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8NeC9Nwzh23PqAuzlXKwRT2zffGJGGIAUQAQ3LhRx+PNvRly4aSBl1ADl6Hz7FOQ
         PA1PA0jqwyKgqjN2JsTToECfXARXjoLx9OlIf8LuessEx0om4dlRexPCVi/yrJ9D6Y
         3kbnr83aEZizeI+Tz+89yDCr/V10IRPFaKOIn5mw=
Date:   Thu, 18 Oct 2018 09:11:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/135] 4.18.15-stable review
Message-ID: <20181018071143.GB3660@kroah.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <ae771800-7a93-8004-5036-7e5c959acdf5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae771800-7a93-8004-5036-7e5c959acdf5@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:30:28PM -0600, Shuah Khan wrote:
> On 10/16/2018 11:03 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.15 release.
> > There are 135 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Oct 18 17:04:43 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.15-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all three of these and letting me know.

greg k-h
