Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78513C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F02217B9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F02217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeHDJI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 05:08:27 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56241
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbeHDJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 05:08:27 -0400
X-IronPort-AV: E=Sophos;i="5.51,442,1526335200"; 
   d="scan'208";a="274957413"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2018 09:08:46 +0200
Date:   Sat, 4 Aug 2018 09:08:46 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Sohil Ladhani <supertakumi86@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kees Cook <keescook@chromium.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arushi Singhal <arushisinghal19971997@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtlwifi: base: fixed a brace coding style
 issue
In-Reply-To: <20180804070540.GA8867@zenus>
Message-ID: <alpine.DEB.2.20.1808040907480.2435@hadrien>
References: <20180804070540.GA8867@zenus>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2018, Sohil Ladhani wrote:

> Fixed a coding style issue

This seems to fix the header problem.  But it is a patch on the same code
at the same place doing the same thing as the previous message.  So you
should say [PATCH v2] in the subject line, and then below the --- explain
what has changed as compared to the previous submission.

julia

>
> Signed-off-by: Sohil Ladhani <supertakumi86@gmail.com>
> ---
>  drivers/staging/rtlwifi/base.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtlwifi/base.c b/drivers/staging/rtlwifi/base.c
> index 094827c1879a..654aa4e068ba 100644
> --- a/drivers/staging/rtlwifi/base.c
> +++ b/drivers/staging/rtlwifi/base.c
> @@ -685,9 +685,8 @@ static void _rtl_query_protection_mode(struct ieee80211_hw *hw,
>  	}
>  }
>
> -u8 rtl_mrate_idx_to_arfr_id(
> -	struct ieee80211_hw *hw, u8 rate_index,
> -	enum wireless_mode wirelessmode)
> +u8 rtl_mrate_idx_to_arfr_id(struct ieee80211_hw *hw, u8 rate_index,
> +			    enum wireless_mode wirelessmode)
>  {
>  	struct rtl_priv *rtlpriv = rtl_priv(hw);
>  	struct rtl_phy *rtlphy = &rtlpriv->phy;
> --
> 2.18.0
>
>
