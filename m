Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708DEC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 06:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A3F214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 06:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKyjuKeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A3F214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJTOvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 10:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeJTOvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 10:51:19 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58ED72087A;
        Sat, 20 Oct 2018 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540017717;
        bh=QlBolkrRvn7FwCo5GkXnU4C64bsNTFKb1SHffyfOCYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKyjuKeEY+WYZigRED5GDWdndUKc9VLfK/GEy0Sm7rktc4U+WUlbchFNzdGOm0gtM
         G6x/8EFilARxPcNiBaizTRYBVngRpRx6ZOZ1/yZOVYVWH7uJQ+P6Ql0yRQQEnbT5mb
         yZjxy47nQDJbLzMuZWUaxgofyMYq57JxUe2Wxl8I=
Date:   Sat, 20 Oct 2018 08:41:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/53] 4.18.16-stable review
Message-ID: <20181020064155.GB15318@kroah.com>
References: <20181018175416.561567978@linuxfoundation.org>
 <d35531e7-ac1d-a2a2-47ea-cae9d1fff753@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d35531e7-ac1d-a2a2-47ea-cae9d1fff753@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:43:12PM -0600, Shuah Khan wrote:
> On 10/18/2018 11:53 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.16 release.
> > There are 53 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Oct 20 17:53:52 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.16-rc1.gz
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

Great, thanks for testing all of these and letting me know.

greg k-h
