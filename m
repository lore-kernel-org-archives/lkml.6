Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20675ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EB1204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EB1204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbeGTO2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:28:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeGTO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:28:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B67ACE36;
        Fri, 20 Jul 2018 13:40:10 +0000 (UTC)
Date:   Fri, 20 Jul 2018 15:40:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/66] 4.9.114-stable review
Message-ID: <20180720134008.GB22550@kroah.com>
References: <20180720121407.228772286@linuxfoundation.org>
 <20180720133442.GC31668@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720133442.GC31668@flashbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 06:34:42AM -0700, Nathan Chancellor wrote:
> On Fri, Jul 20, 2018 at 02:13:17PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.114 release.
> > There are 66 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Jul 22 12:13:47 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.114-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled with -Werror, and installed onto my OnePlus 6.
> 
> No initial issues noticed in dmesg or general usage.

Wonderful, thanks for testing all 3 of these and letting me know.

greg k-h
