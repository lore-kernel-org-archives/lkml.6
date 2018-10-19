Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68E8ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8996821477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeMPvdpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8996821477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJSQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbeJSQUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:20:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92B22064A;
        Fri, 19 Oct 2018 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539936955;
        bh=+dCfjwA/NOWbHdb6Dbwt/nnPIZ9Sk6IZa5Uqiox7QRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeMPvdpvRcdIWI+QkqqeiCEqqFtfsFEvb0O7X+nilZvOpzwZ+rkwwfFDgXRxBY4EX
         e1H/Of9WbHGCBew5LJG/o5nKkCU4olf1BW9QD+9K9GDF3UVwcrn3I+5jlwlh3MCV6f
         gPH4dZyVKEvHJmfQ8Z9kqCyKVXzO8eube8uLFe6A=
Date:   Fri, 19 Oct 2018 10:15:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/41] 4.14.78-stable review
Message-ID: <20181019081553.GA21716@kroah.com>
References: <20181018175416.718399607@linuxfoundation.org>
 <20181019014132.GC19093@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019014132.GC19093@flashbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 06:41:32PM -0700, Nathan Chancellor wrote:
> On Thu, Oct 18, 2018 at 07:54:15PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.78 release.
> > There are 41 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Oct 20 17:53:55 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.78-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and installed onto my Raspberry Pi.
> 
> No initial issues noticed in dmesg or general usage.

Thanks for testing 3 of these and letting me know.

greg k-h
