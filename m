Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB27EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B622208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B622208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH0V4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:56:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeH0V4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:56:33 -0400
Received: from localhost (unknown [62.119.166.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 802AEC96;
        Mon, 27 Aug 2018 18:08:54 +0000 (UTC)
Date:   Mon, 27 Aug 2018 19:51:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Todd <thomas.m.a.todd@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtlwifi: efuse: fixed a line length coding
 style issue
Message-ID: <20180827175108.GD27089@kroah.com>
References: <20180813211120.17015-1-thomas.m.a.todd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813211120.17015-1-thomas.m.a.todd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 10:11:21PM +0100, Tom Todd wrote:
> Fixed a code style issue. Line length over 80 characters.
> 
> Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
> ---
>  drivers/staging/rtlwifi/efuse.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtlwifi/efuse.c b/drivers/staging/rtlwifi/efuse.c
> index 1dc71455f270..49ec9728fb04 100644
> --- a/drivers/staging/rtlwifi/efuse.c
> +++ b/drivers/staging/rtlwifi/efuse.c
> @@ -245,7 +245,8 @@ void read_efuse(struct ieee80211_hw *hw, u16 _offset, u16 _size_byte, u8 *pbuf)
>  	if (!efuse_word)
>  		goto out;
>  	for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
> -		efuse_word[i] = kcalloc(efuse_max_section, sizeof(u16), GFP_ATOMIC);
> +		efuse_word[i] =
> +			kcalloc(efuse_max_section, sizeof(u16), GFP_ATOMIC);

No, keep the kcalloc on the same line and just wrap any needed
parameters.

thanks,

greg k-h
