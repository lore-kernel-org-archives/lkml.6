Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0BEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E422173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfA1Lh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:37:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:53830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfA1Lh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:37:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F035FACAD;
        Mon, 28 Jan 2019 11:37:56 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: Move FCoE to Hannes Reinecke
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20190128110634.17243-1-jthumshirn@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <049182df-4bfa-a93f-3773-0a9789516c2b@suse.de>
Date:   Mon, 28 Jan 2019 12:37:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190128110634.17243-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/19 12:06 PM, Johannes Thumshirn wrote:
> I'll be moving on to different things in the storage stack and Hannes
> agreed to take over FCoE.
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f64f8d3740e..49b829794699 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5855,7 +5855,7 @@ S:	Maintained
>   F:	drivers/media/tuners/fc2580*
>   
>   FCOE SUBSYSTEM (libfc, libfcoe, fcoe)
> -M:	Johannes Thumshirn <jth@kernel.org>
> +M:	Hannes Reinecke <hare@suse.de>
>   L:	linux-scsi@vger.kernel.org
>   W:	www.Open-FCoE.org
>   S:	Supported
> 
Acked-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
