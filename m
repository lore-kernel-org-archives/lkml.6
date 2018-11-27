Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5ACC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFE3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFE3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeK1DkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:40:14 -0500
Received: from smtp113.iad3b.emailsrvr.com ([146.20.161.113]:37176 "EHLO
        smtp113.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730999AbeK1DkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:40:14 -0500
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 22:40:13 EST
Received: from smtp15.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
        by smtp15.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id 3D076C210C;
        Tue, 27 Nov 2018 11:33:41 -0500 (EST)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp15.relay.iad3b.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 5960FC0F15;
        Tue, 27 Nov 2018 11:33:40 -0500 (EST)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 27 Nov 2018 11:33:41 -0500
Subject: Re: [PATCH] staging: comedi: fix spelling mistake "desination" ->
 "destination"
To:     Colin King <colin.king@canonical.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Spencer E . Olson" <olsonse@umich.edu>, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181127142328.27287-1-colin.king@canonical.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <78410bc5-ec59-6ff6-f9e5-eef69abab74f@mev.co.uk>
Date:   Tue, 27 Nov 2018 16:33:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127142328.27287-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2018 14:23, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in message text in the call to unittest,
> fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/staging/comedi/drivers/tests/ni_routes_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/tests/ni_routes_test.c b/drivers/staging/comedi/drivers/tests/ni_routes_test.c
> index a1eda035f270..c6dc18f346e8 100644
> --- a/drivers/staging/comedi/drivers/tests/ni_routes_test.c
> +++ b/drivers/staging/comedi/drivers/tests/ni_routes_test.c
> @@ -372,7 +372,7 @@ void test_ni_lookup_route_register(void)
>   	unittest(ni_lookup_route_register(O(8), O(9), T) == 8,
>   		 "validate last destination\n");
>   	unittest(ni_lookup_route_register(O(10), O(9), T) == -EINVAL,
> -		 "lookup invalid desination\n");
> +		 "lookup invalid destination\n");
>   
>   	unittest(ni_lookup_route_register(rgout0_src0, TRIGGER_LINE(0), T) ==
>   		 -EINVAL,
> 

Thanks for spotting that!  Looks good.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
