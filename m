Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36349C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D14208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="nqNmx6jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D14208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeHBGBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:01:02 -0400
Received: from imap.thunk.org ([74.207.234.97]:56462 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeHBGBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pbg1k69aKRdVAT+L+W1IOhkdQZNlLBP0mzOzP5xyacg=; b=nqNmx6jgwewPodokL/JQTDmtGv
        yJQsagUp1cWobgFrVR2uaWBx1XfbtmxozKoe9VsnWS9re39p0lH6coYmFgKt6/GX4xjiJXU0qc+Wq
        zns4i6kon5witdliWU3OCtVrEjltzson9KdlMa4YMDyvu+xkkV8vsUlWOBdGfNsCtEe0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fl4xr-0001wp-2S; Thu, 02 Aug 2018 04:11:51 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2BEB27A614F; Thu,  2 Aug 2018 00:11:50 -0400 (EDT)
Date:   Thu, 2 Aug 2018 00:11:50 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Liu Song <liu.song11@zte.com.cn>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] Improve code readability
Message-ID: <20180802041150.GE9187@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Liu Song <liu.song11@zte.com.cn>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
References: <1533017715-122171-1-git-send-email-liu.song11@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533017715-122171-1-git-send-email-liu.song11@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 02:15:15PM +0800, Liu Song wrote:
> Merge the duplicated complex conditions to improve code readability.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>

Thanks, applied.

					- Ted
