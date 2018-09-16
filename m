Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C71ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBD52087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBD52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeIQBcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:32:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45624 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeIQBcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:32:35 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3FCD284B;
        Sun, 16 Sep 2018 20:08:29 +0000 (UTC)
Date:   Sun, 16 Sep 2018 22:08:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pablo Pellecchia <pablo9891@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Staging: wlan-ng: Solved Coding Style issues
Message-ID: <20180916200826.GA22689@kroah.com>
References: <20180916193911.8191-1-pablo9891@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916193911.8191-1-pablo9891@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 04:39:11PM -0300, Pablo Pellecchia wrote:
> Solved parenthesis alignment issues throw by checkpatch.pl
> 
> Signed-off-by: Pablo Pellecchia <pablo9891@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 40 ++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index d4cf09b11e33..38bf555a8d3e 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -234,8 +234,8 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
>  	int result = 0;
>  
>  	result = prism2_domibset_uint32(wlandev,
> -		DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
> -		key_index);
> +					DIDmib_dot11smt_dot11PrivacyTable_dot11WEPDefaultKeyID,
> +					key_index);

And now you violate the line length rule :(

Which is why the code looks like it does, what you should really do is
fix up that horridly long variable name.  That will fix this properly.
Can you do that instead?

thanks,

greg k-h
