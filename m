Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0F8C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79BA2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949907;
	bh=lKre37L1Dq1ASQzZ6ipDTPRWb9W3Jv32OgrzppDnY6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UmUuYPxtgqeHyHY4Bzuh/TsSjyuH55TxsGFB4s67AfDu/VcB9Wj0mHysLB4PmdaNi
	 2KoClBQ5Q5+pEWBrPMRETi7h+6/c/LRIGFAjvj+lLXma2PWm8ZOd18Etg8xcvrHMWk
	 EXhtw9A5RVrrTQqnpSMAYkIpkBuKwWnuY2GAoB84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfAHMS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:18:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfAHMSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:18:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1814206B7;
        Tue,  8 Jan 2019 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949905;
        bh=lKre37L1Dq1ASQzZ6ipDTPRWb9W3Jv32OgrzppDnY6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/i+G8GNJ6C03MAxbE0cVlHwcon/fL60e0rhe9v4qZfz+Pnl3tvkwPg6zWWF1//5f
         6hWDez9Z0GmljlsQa+6IbF5E57EmLCM98kLGmc4BIblaU84YkLuWh0e55mIgv9ST/R
         baaQ4p4FXezpO+r2sWIjHosfdfJVyZoNMkvz2opU=
Date:   Tue, 8 Jan 2019 13:18:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
Message-ID: <20190108121822.GB3884@kroah.com>
References: <20190107105330.280153213@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:32:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.149 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:53:04 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.149-rc1.gz

-rc4 is now out, hopefully this is the last one...
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.149-rc1.gz

