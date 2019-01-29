Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4C0C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1466E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548790989;
	bh=PijT9WWa8zR6byDhHGAjVD/HIFesAKG8ry7Qt8+6Upg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A0c/OWDtosalKOyyX/YCrABT/bQ+HZ/ckMUW4+KQgxw5eeeNQVe681QJekz/c2+Ho
	 yX1E/Ufx9Kvt9gen82wt+/h5w0IDK+YpZ4ATLfL63BbZ7nZgzBHWDI3QJqNnLHZ8Xm
	 xQIpaNolxYZw3ymzzCoEKdlaEFtVnVwhUy0MR+GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfA2TnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfA2TnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:43:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B649B20869;
        Tue, 29 Jan 2019 19:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548790987;
        bh=PijT9WWa8zR6byDhHGAjVD/HIFesAKG8ry7Qt8+6Upg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bBxFWInUB928d1Vxc0QtoPysfvuYFWf/f8/FHV+vjNJ0Z2T31mdpKbZ1cHMsv0fnD
         S1OXhPRntYApgsbCpHBYIQsSU7rNtSRScwL7pPKc7bm6dOQohu3b5B42bdqBp3KCjt
         h6rMWyCEu0qoS/L4GX5BoP3niRqbYjoUVQz7IMZw=
Date:   Tue, 29 Jan 2019 20:43:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/44] 4.9.154-stable review
Message-ID: <20190129194304.GA32029@kroah.com>
References: <20190129113139.826927690@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:35:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.154 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y

Released a -rc2 to fix a CIFS build bug.
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.154-rc2.gz


