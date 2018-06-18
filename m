Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E793C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3C2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC3C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936912AbeFRUjP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:39:15 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:57992 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935299AbeFRUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:39:14 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fV0vf-0003Cr-2i; Mon, 18 Jun 2018 22:39:11 +0200
Message-ID: <1529354350.3092.34.camel@sipsolutions.net>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 mac80211-next tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Mon, 18 Jun 2018 22:39:10 +0200
In-Reply-To: <20180616223036.46abefcb@canb.auug.org.au>
References: <20180616223036.46abefcb@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-16 at 22:30 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   f9444b499f68 ("ieee80211: bump IEEE80211_MAX_AMPDU_BUF to support HE")
> 
> is missing a Signed-off-by from its author.

I messed up that commit, I'm really the author. Probably some git-am
left-over configuration. I guess I'll fix it.

Thanks for the heads-up!

johannes
