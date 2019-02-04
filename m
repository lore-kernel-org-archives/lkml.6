Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52922C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F187E2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="e7+LSEzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfBDM0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:26:37 -0500
Received: from smtpcmd14161.aruba.it ([62.149.156.161]:42980 "EHLO
        smtpcmd14161.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfBDM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:26:37 -0500
Received: from [192.168.1.32] ([93.146.66.165])
        by smtpcmd14.ad.aruba.it with bizsmtp
        id YcSY1z00Q3Zw7e501cSYg2; Mon, 04 Feb 2019 13:26:35 +0100
Subject: Re: [PATCH v15 1/3] pps: descriptor-based gpio
To:     Tom Burkart <tom@aussec.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Martins <rasm@fe.up.pt>,
        James Nuss <jamesnuss@nanometrics.ca>
References: <20190202105724.4743-1-tom@aussec.com>
 <20190202105724.4743-2-tom@aussec.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <adfd3290-51bb-3f1a-f7f9-0b0b5ad3c2ae@enneenne.com>
Date:   Mon, 4 Feb 2019 13:26:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190202105724.4743-2-tom@aussec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1549283195; bh=L5EnDVSaEGFYxbOoGc5N+3yz4KVNzd6AQVjw5dS9YLw=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=e7+LSEzXQMBGuNH8+B87pFvOIBwnuTT8ZCEYftDFguZ+y0pLM9v64fPgrM+tn39rV
         Pf4v9hUkaIZ3nzMtj1gSK7wffoxGSc4P560R+RIq7GjUz7Hhi6YpYKieIPjVQ12cBq
         Wi6hVEjWiG9fxO25XkpppQrvXATekAU03iK4VfHrNW4XwNrhyTMJo+1JTUKTpdCfDU
         qNzK0Q6A42UTihAI4GIsyeMCYaUSbpKzWCHxgEagwOpacFW3z2LmuR+t0gRdTgyPWB
         VSNbULCv//24n7nejGU9VlqCnsMxLuWVou+eVIWlL1zet8At36iMVcMHelbZGnwiU/
         HTRTGWNg7OENQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2019 11:57, Tom Burkart wrote:
> This patch changes the GPIO access for the pps-gpio driver from the
> integer based API to the descriptor based API.
> 
> Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
> Signed-off-by: Tom Burkart <tom@aussec.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
