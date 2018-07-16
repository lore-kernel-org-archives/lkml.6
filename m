Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55334ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF80208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF80208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeGPJqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:46:17 -0400
Received: from smtp65.ord1d.emailsrvr.com ([184.106.54.65]:48388 "EHLO
        smtp65.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727594AbeGPJqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:46:17 -0400
Received: from smtp1.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp1.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id EA58F401F8;
        Mon, 16 Jul 2018 05:19:47 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp1.relay.ord1d.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 4214740234;
        Mon, 16 Jul 2018 05:19:47 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 16 Jul 2018 05:19:47 -0400
Subject: Re: [PATCH] staging: comedi: comedi_fops: Shift assignment operator
 '=' to previous line
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180714154453.GA27869@nishad>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <3526b74c-9fe4-4aa5-bc3f-bf9725684438@mev.co.uk>
Date:   Mon, 16 Jul 2018 10:19:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180714154453.GA27869@nishad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/18 16:44, Nishad Kamdar wrote:
> Shift '=' assignment operator to the end of previous
> line to conform to preferred kernel style line wrapping.
> Issue reported by checkpatch CHECK.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>   drivers/staging/comedi/comedi_fops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index 1f3b1106f478..e18b61cdbdeb 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -79,8 +79,8 @@ MODULE_PARM_DESC(comedi_default_buf_size_kb,
>   		 "default asynchronous buffer size in KiB (default "
>   		 __MODULE_STRING(CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB) ")");
>   
> -unsigned int comedi_default_buf_maxsize_kb
> -	= CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB;
> +unsigned int comedi_default_buf_maxsize_kb =
> +	CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB;
>   module_param(comedi_default_buf_maxsize_kb, uint, 0644);
>   MODULE_PARM_DESC(comedi_default_buf_maxsize_kb,
>   		 "default maximum size of asynchronous buffer in KiB (default "
> 

That looks fine, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
