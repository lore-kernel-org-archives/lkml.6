Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AF1C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC19C20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC19C20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755144AbeFRHHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:07:45 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:49514 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755175AbeFRHHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:07:43 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fUoGK-00079S-48; Mon, 18 Jun 2018 09:07:40 +0200
Message-ID: <1529305659.3490.0.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the mac80211-next tree with Linus'
 tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Date:   Mon, 18 Jun 2018 09:07:39 +0200
In-Reply-To: <20180618112943.4ceadf24@canb.auug.org.au>
References: <20180618112943.4ceadf24@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 11:29 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mac80211-next tree got a conflict in:
> 
>   net/mac80211/scan.c
> 
> between commit:
> 
>   6396bb221514 ("treewide: kzalloc() -> kcalloc()")
> 
> from Linus' tree and commit:
> 
>   b9771d41aee7 ("mac80211: support scan features for improved scan privacy")
> 
> from the mac80211-next tree.

Thanks Stephen!

I guess there isn't all that much I can do, unless davem pulls Linus's
tree in and then I can pull his and resolve it. We'll see.

johannes
