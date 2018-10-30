Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B139C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6344E20848
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2AbgZ3B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6344E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeJ3SRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeJ3SRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:17:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A618520827;
        Tue, 30 Oct 2018 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540891514;
        bh=4Li3Bvw49W5x7fFW89JG9jIvbWBQxUvHt3E8gENJMM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2AbgZ3B//YqykpvQ96bCnPAYnGD2lWRJ9pS+Cc2C89pZE8coRy4aPks258NbBzMqk
         hyd6Urza1Trz4DOo4iD+TVYv6z4+5XBAgEpvOjJmM+O+GdoO3df6G9d0hyYZCsjuNU
         DtITuLBcqEjN+1TAxdKcHdFomw3535qSbMA+xydg=
Date:   Tue, 30 Oct 2018 10:25:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vboxvideo: Remove unnecessary parentheses
Message-ID: <20181030092539.GA10009@kroah.com>
References: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 02:43:04PM -0300, Shayenne da Luz Moura wrote:
> Remove unneeded parentheses around the arguments of ||. This reduces
> clutter and code behave in the same way.
> Change suggested by checkpatch.pl.
> 
> vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
> crtc->x'
> 
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
>   - Make the commit message more clearer.

This patch does not apply to the latest kernel tree at all :(

Please fix up and resend.

thanks,

greg k-h
