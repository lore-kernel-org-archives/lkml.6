Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5404EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C814206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392226AbfAPKvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:51:54 -0500
Received: from smtp64.iad3a.emailsrvr.com ([173.203.187.64]:58793 "EHLO
        smtp64.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389044AbfAPKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:51:53 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2019 05:51:52 EST
Received: from smtp33.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp33.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 5E696543C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:44:14 -0500 (EST)
Received: from smtp65.iad3a.emailsrvr.com (relay.iad3a.rsapps.net [172.27.255.110])
        by smtp33.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTPS id 56FDB540A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:44:14 -0500 (EST)
Received: from smtp1.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp1.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id BA5D55B10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:44:13 -0500 (EST)
Received: from smtp97.iad3a.emailsrvr.com (relay.iad3a.rsapps.net [172.27.255.110])
        by smtp1.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTPS id B297C5A79
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:44:13 -0500 (EST)
Received: from smtp5.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp5.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 2701925732;
        Wed, 16 Jan 2019 05:44:13 -0500 (EST)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp5.relay.iad3a.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 87BB5257CA;
        Wed, 16 Jan 2019 05:44:12 -0500 (EST)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 16 Jan 2019 05:44:13 -0500
Subject: Re: [PATCH] staging: comedi: Removed not necessary braces for single
 block
To:     Jitendra Khasdev <jkhasdev@gmail.com>,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190115153656.10913-1-jkhasdev@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <8c44b247-e44d-aaff-e0af-544b2c4eb4c0@mev.co.uk>
Date:   Wed, 16 Jan 2019 10:44:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115153656.10913-1-jkhasdev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2019 15:36, Jitendra Khasdev wrote:
> This patch is used to remove not necessary braces for single if block.
> 
> Signed-off-by: Jitendra Khasdev <jkhasdev@gmail.com>
> ---
>   drivers/staging/comedi/comedi_fops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index 5d2fcbfe02af..38980fad8be4 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -1605,9 +1605,9 @@ static int do_insn_ioctl(struct comedi_device *dev,
>   	unsigned int n_data = MIN_SAMPLES;
>   	int ret = 0;
>   
> -	if (copy_from_user(&insn, arg, sizeof(insn))) {
> +	if (copy_from_user(&insn, arg, sizeof(insn)))
>   		return -EFAULT;
> -	}
> +
>   
>   	n_data = max(n_data, insn.n);
>   
> 

The patch looks fine. Thanks for the fix!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
