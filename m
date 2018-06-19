Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD43C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDF420875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXUw6677"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDF420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937279AbeFSEOY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeFSEOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:14:21 -0400
Received: from localhost (unknown [106.200.222.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFCD92083A;
        Tue, 19 Jun 2018 04:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529381660;
        bh=OTefSrWlIqVgHHAr0ZCyPfpHPjQYUDCQRbu+J13FEjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXUw6677ztfElZacK7UlWIiEuZhyn837Xx6qPZEslWGIS0yh96fkoYNQQZQuIHdNd
         RvfqNLhx6GAPiy7FN+xuZFV7pg3zYip738S24R8CwqBdguPcdjNv5bxKwm+EhTyaKP
         ohTmf6RBvohJln1VFy1VZTVi02Gaevx/gYOoZXAw=
Date:   Tue, 19 Jun 2018 09:44:12 +0530
From:   Vinod <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@zh-kernel.org, dmaengine@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, sparclinux@vger.kernel.org,
        devel@lists.orangefs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 26/26] fix a series of Documentation/ broken file name
 references
Message-ID: <20180619041412.GL25852@vkoul-mobl>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <041e7a803fc0e5c5dfc1fb8b2f761074ca0baa2c.1529079120.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041e7a803fc0e5c5dfc1fb8b2f761074ca0baa2c.1529079120.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-18, 13:30, Mauro Carvalho Chehab wrote:

>  If you have any comment or update to the content, please contact the
>  original document maintainer directly.  However, if you have a problem
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index b451354735d3..08ba8473a284 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -38,7 +38,7 @@
>   * Each device has a channels list, which runs unlocked but is never modified
>   * once the device is registered, it's just setup by the driver.
>   *
> - * See Documentation/dmaengine.txt for more details
> + * See Documentation/driver-api/dmaengine for more details

DMAengine part:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
