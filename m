Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4245214EE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4245214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeHUQ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:29:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727153AbeHUQ3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:29:05 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E53756D848B0;
        Tue, 21 Aug 2018 21:08:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Tue, 21 Aug 2018
 21:08:53 +0800
Subject: Re: [PATCH] scsi: core: Update SCSI_MQ_DEFAULT help text to match
 default
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20180821114407.18393-1-geert+renesas@glider.be>
CC:     Hannes Reinecke <hare@suse.com>, Ming Lei <ming.lei@redhat.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <690904cb-f9a0-ffe3-9ee7-1b76a6682031@huawei.com>
Date:   Tue, 21 Aug 2018 14:08:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180821114407.18393-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2018 12:44, Geert Uytterhoeven wrote:
> The default was changed, but the help text was not updated.
>
> Fix grammar (s/the option/this option/) while at it.
>
> Fixes: d5038a13eca72fb2 ("scsi: core: switch to scsi-mq by default")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/scsi/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 8fc851a9e1162a56..a0491e11bd359499 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -53,11 +53,11 @@ config SCSI_MQ_DEFAULT
>  	depends on SCSI
>  	---help---
>  	  This option enables the new blk-mq based I/O path for SCSI

It's arguably not 'new' either :)

> -	  devices by default.  With the option the scsi_mod.use_blk_mq
> +	  devices by default.  With this option the scsi_mod.use_blk_mq
>  	  module/boot option defaults to Y, without it to N, but it can
>  	  still be overridden either way.
>
> -	  If unsure say N.
> +	  If unsure say Y.
>
>  config SCSI_PROC_FS
>  	bool "legacy /proc/scsi/ support"
>


