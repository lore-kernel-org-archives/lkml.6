Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65181C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F1A20841
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WMdTNnOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F1A20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeICGyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:54:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeICGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Cc:References:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vLUfh4VzkSLeR4QaPyjT9thKtwNeTIzq8n9/7Jje5OY=; b=WMdTNnOiyeNZIKE3toixpKKwli
        KN4KPZk4Zs6RAlMneTlDeB6FGay9kZDWD79Q8MhkHDzGEgDEq416OXKkPH8l+Xhnn890liFPCfJgG
        iwJ0LbLHeSCKQbWifO7nw5oWqxU192DDD4bzy2mAwTsgqg9Mxe65rx/m9xCKHOgmK0t71bgo0slHy
        Yw8by/+FqatFzWT50+W+N/YQn1zdiXdisvEI6jw9G223BPSVPyKVyYqfKz+0er3ppVCi84qyNXHrE
        GupGagqTFHGtGuswNgIGKG8CYM+9OD9FTxwQkQqoUCXD0xdXX3Wy9KJSZNo8e2c6so8lOjIrplkid
        aLRtnudg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwejJ-0005V3-Cy; Mon, 03 Sep 2018 02:36:41 +0000
Subject: Re: [PATCH] regulator: fix kernel-doc parameter warning
From:   Randy Dunlap <rdunlap@infradead.org>
To:     LKML <linux-kernel@vger.kernel.org>
References: <6307dcdd-7e4a-d708-eda8-b81edbc8e52c@infradead.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Message-ID: <31c46cf4-6acd-7e00-39e4-e8540f3fda9d@infradead.org>
Date:   Sun, 2 Sep 2018 19:36:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6307dcdd-7e4a-d708-eda8-b81edbc8e52c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about missing the Cc's.
Would you like me to resend it?


On 09/02/2018 07:33 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning:
> 
> ../drivers/regulator/core.c:4479: warning: Excess function parameter 'state' description in 'regulator_suspend'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  drivers/regulator/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-419-rc2.orig/drivers/regulator/core.c
> +++ lnx-419-rc2/drivers/regulator/core.c
> @@ -4470,7 +4470,7 @@ static int _regulator_suspend(struct dev
>  
>  /**
>   * regulator_suspend - prepare regulators for system wide suspend
> - * @state: system suspend state
> + * @dev: ``&struct device`` pointer that is passed to _regulator_suspend()
>   *
>   * Configure each regulator with it's suspend operating parameters for state.
>   */
> 


-- 
~Randy
