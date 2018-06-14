Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 13C65C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B972B208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B972B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754988AbeFNLVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:21:54 -0400
Received: from smtp73.ord1d.emailsrvr.com ([184.106.54.73]:52784 "EHLO
        smtp73.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754857AbeFNLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:21:53 -0400
Received: from smtp18.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 13F0BA00A3;
        Thu, 14 Jun 2018 07:21:53 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp18.relay.ord1d.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 5F8A1A00C7;
        Thu, 14 Jun 2018 07:21:52 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 14 Jun 2018 07:21:53 -0400
Subject: Re: [PATCH] Staging: comedi: ssv_dnp: fixed style line length warning
To:     Javier Martinez <javiermlinux@gmail.com>
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180613190108.GA14435@javier-Z97X>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <18b92187-502d-ec14-1a4f-35b9c4a0053e@mev.co.uk>
Date:   Thu, 14 Jun 2018 12:21:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613190108.GA14435@javier-Z97X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 20:01, Javier Martinez wrote:
> Fixed style line length warning detected by checkpatch.pl in the file
> ssv_dnp.c.
> 
> Signed-off-by: Javier Martinez <javiermlinux@gmail.com>
> ---
>   drivers/staging/comedi/drivers/ssv_dnp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ssv_dnp.c b/drivers/staging/comedi/drivers/ssv_dnp.c
> index 0628060e42ca..87f46e0eb9ee 100644
> --- a/drivers/staging/comedi/drivers/ssv_dnp.c
> +++ b/drivers/staging/comedi/drivers/ssv_dnp.c
> @@ -16,7 +16,7 @@
>    * Status: unknown
>    */
>   
> -/* include files ----------------------------------------------------------- */
> +/* include files ------------------------------------------------------ */
>   
>   #include <linux/module.h>
>   #include "../comedidev.h"
> 

I cannot reproduce the checkpatch.pl warning.  The line is only 79 
columns wide.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
