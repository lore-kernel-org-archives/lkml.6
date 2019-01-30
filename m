Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F5C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC8B21848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548832383;
	bh=WeY9aW6CanI3Djkj7YNyj1HXPwX54l3e0H00jVyiAic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dEQvajWmZIP+LUb+EgGtKbL/zFUqbMaf1V3buwsyabk4C7o1FD3VbM9/IAH2YvhDw
	 +mqnJIFnKNCRAhuFmPGf5ViM2Oj9g4I33g9EOyCPBolpiix+OdoL7jq423d3qiQjKj
	 kUqya0IyesmzNswOdrZMZAEgh9tOJ9ar7N/TGdnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfA3HNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfA3HNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:13:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9AAC21473;
        Wed, 30 Jan 2019 07:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548832381;
        bh=WeY9aW6CanI3Djkj7YNyj1HXPwX54l3e0H00jVyiAic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04SYhoHUHcPuetG5ZWQ3SzUgyXKmstw7/cwRSVRqyeY5A4FvdSGmbzewde42tC50j
         668pgODplcRVGBwZTZfG+kfn8Pg6J9wyLqA24X76PpumuJVzUQicGUVHjXQxwQMzdB
         SnUKGOHtSvef8Nc5lLw2xUUWip2GEsxD7FN0OJR4=
Date:   Wed, 30 Jan 2019 08:12:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: xhci: remove unused member 'parent' in xhci_regset
 struct
Message-ID: <20190130071259.GC1204@kroah.com>
References: <1548814341-15116-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548814341-15116-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:12:21AM +0800, Chunfeng Yun wrote:
> The member @parent of xhci_regset struct is not used in fact,
> so remove it
> 
> Change-Id: Ic6727c28f7200782fe4516bcb41c789b427318a2

No need for this line :(
