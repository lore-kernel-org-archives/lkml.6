Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0548E21871
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548782934;
	bh=h2pSo0p3u6q84JpTPiOtL6rNc8mlAgud6FOw2m1Hg2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bivHKtFpBVv4SK8XALDLKn0nPdSeJMXD9fZNLOIzRL2WGeb6sxn3zttdhucKyoUyg
	 8A4ali84yjuFnUMVSdeHGFBpJe5lxsbjYc32jyhJt3IJTBlEx01XKrQUbc8iKb8tW5
	 mwzk9daYQA6I8e5VXMsslvdNNVo+AM19b3IItdo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfA2R2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfA2R2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:28:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D8A20989;
        Tue, 29 Jan 2019 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548782931;
        bh=h2pSo0p3u6q84JpTPiOtL6rNc8mlAgud6FOw2m1Hg2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2nwRlUqg+Al39r7aLC/mwcdFCc7NCppnMe0ohHzlR6F2RB/p9QgSVZ2vozppboSwU
         UFrbe4YgS1PY1w6xsxGo/4fseLhiiwkCXU9cETyFzukwLBhOB0WV7ueVrBrAOs+RXa
         FDWMneGf9VK3u3QXmtsYGMbwI6+e7weatD0pBl24=
Date:   Tue, 29 Jan 2019 18:28:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/103] 4.19.19-stable review
Message-ID: <20190129172848.GE27005@kroah.com>
References: <20190129113159.567154026@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:34:37PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.19 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 31 11:31:30 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.

-rc2 is out to fix a reported networking issue:

 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.19-rc2.gz

