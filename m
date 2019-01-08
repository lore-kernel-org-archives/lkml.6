Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2238C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9655420850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949949;
	bh=IurZwXc7RO5H07wzSyhT2it1Kxrgbi9PJ8Fl3fBsK08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IXNi7qcuHZqZbP0LdHVN93H3Z+rnxxSsvN402S0QeF3AXrtsdAOSR87pRkGTs01KW
	 EhjzQg3+WSsHFUg+0WGVN99KP01kd/2wge6oeAZudt8R6X0QxsXIxwlld1MrYUBHxr
	 ag//itbQfDs1cVHonOHv7/orRYpfyY03tQDGlIJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfAHMTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfAHMTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:19:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD4E206B7;
        Tue,  8 Jan 2019 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949947;
        bh=IurZwXc7RO5H07wzSyhT2it1Kxrgbi9PJ8Fl3fBsK08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QURuGcty8Fsgv9Ci6b9G9igWc+Pz4DJJ0DB0mxy+K/eqrEhaJ6lqTlenOjs1GEbIf
         tb4mg55g3xDb0N/165sJhK0g1hYa/WnL/OEsHs0MwJlI9QbUxzxXGXtIggYFDLoqQN
         vqK3SLBgbIFZBjU329eaYmdIZ4MfUqEftcO7lDdw=
Date:   Tue, 8 Jan 2019 13:19:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
Message-ID: <20190108121905.GC3884@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:31:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.92 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc1.gz

-rc3 is out to hopefully fix the last reported build issue:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc3.gz

