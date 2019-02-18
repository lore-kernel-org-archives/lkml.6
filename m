Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9D721738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="te9hzEBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389614AbfBRQdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:33:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbfBRQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=12/BgepHdPMkSN+4ChlSX9dMnpQZdKeGatQFZq6z9P4=; b=te9hzEBaj9JP3pm+rYeWnwYhNM
        ev9ZPftCT5WpBgz2UA9facaTVmD26Uws9Bmgu9N0vStBtLstyEz9gnWw0qHkC1a25RTqav75KwNN2
        vILsdzYy1xmjh2lfLx4tWGHOV5+cEtl5ajgzIjILnrIpVgm6gTBEXi/jqxn+mEL/Avs169vDNh3de
        8EXWY4PbKkWH4yAY9+Us007Qg5pRZhLPOkilNyaTuOYSNBAjv9zlD+yVSQQbcsssgw66LIa3mcnv9
        L6Ovu+QJCN/eOrzEIce6j/2wXKCuhFuvxJ6rlHZDeW+yQzI7ZiNTKfPzJt1hOtoczXeZStx9YO/01
        3cYEDHGQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvlrJ-0008Na-LG; Mon, 18 Feb 2019 16:33:33 +0000
Subject: Re: [PATCH] drivers/component: kerneldoc polish
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>
References: <20190218085242.18845-1-daniel.vetter@ffwll.ch>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ceedac5a-9781-972b-54e4-c8c8fb8c18c6@infradead.org>
Date:   Mon, 18 Feb 2019 08:33:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190218085242.18845-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 12:52 AM, Daniel Vetter wrote:
> Polish the kerneldoc a bit with suggestions from Randy.
> 

Hi Daniel,
There are 2 more typos below.  With those fixed, you or Greg can add:
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Ramalingam C <ramalingam.c@intel.com>
> --
> Greg, I don't need this in any of the topic branches, best if you
> pick this one up into your -next tree directly.
> 
> Cheers, Daniel
> ---
>  drivers/base/component.c  | 14 +++++++-------
>  include/linux/component.h |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index 7dbc41cccd58..6954e448f46b 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -27,7 +27,7 @@
>   * helper fills the niche of aggregate drivers for specific hardware, where
>   * further standardization into a subsystem would not be practical. The common
>   * example is when a logical device (e.g. a DRM display driver) is spread around
> - * the SoC on various component (scanout engines, blending blocks, transcoders
> + * the SoC on various components (scanout engines, blending blocks, transcoders
>   * for various outputs and so on).
>   *
>   * The component helper also doesn't solve runtime dependencies, e.g. for system
> @@ -378,7 +378,7 @@ static void __component_match_add(struct device *master,
>  }
>  
>  /**
> - * component_match_add_release - add a component match with release callback
> + * component_match_add_release - add a component match entry with release callback
>   * @master: device with the aggregate driver
>   * @matchptr: pointer to the list of component matches
>   * @release: release function for @compare_data
> @@ -408,7 +408,7 @@ void component_match_add_release(struct device *master,
>  EXPORT_SYMBOL(component_match_add_release);
>  
>  /**
> - * component_match_add_typed - add a compent match for a typed component
> + * component_match_add_typed - add a compent match entry for a typed component

                                        component

>   * @master: device with the aggregate driver
>   * @matchptr: pointer to the list of component matches
>   * @compare_typed: compare function to match against all typed components
> @@ -537,11 +537,11 @@ static void component_unbind(struct component *component,
>  }
>  
>  /**
> - * component_unbind_all - unbind all component to an aggregate driver
> + * component_unbind_all - unbind all components of an aggregate driver
>   * @master_dev: device with the aggregate driver
>   * @data: opaque pointer, passed to all components
>   *
> - * Unbinds all components to the aggregate @dev by passing @data to their
> + * Unbinds all components of the aggregate @dev by passing @data to their
>   * &component_ops.unbind functions. Should be called from
>   * &component_master_ops.unbind.
>   */
> @@ -619,11 +619,11 @@ static int component_bind(struct component *component, struct master *master,
>  }
>  
>  /**
> - * component_bind_all - bind all component to an aggregate driver
> + * component_bind_all - bind all components of an aggregate driver
>   * @master_dev: device with the aggregate driver
>   * @data: opaque pointer, passed to all components
>   *
> - * Binds all components to the aggregate @dev by passing @data to their
> + * Binds all components of the aggregate @dev by passing @data to their
>   * &component_ops.bind functions. Should be called from
>   * &component_master_ops.bind.
>   */
> diff --git a/include/linux/component.h b/include/linux/component.h
> index 30bcc7e590eb..8628d4d0aff1 100644
> --- a/include/linux/component.h
> +++ b/include/linux/component.h
> @@ -98,7 +98,7 @@ void component_match_add_typed(struct device *master,
>  	int (*compare_typed)(struct device *, int, void *), void *compare_data);
>  
>  /**
> - * component_match_add - add a compent match
> + * component_match_add - add a compent match entry

                                  component

>   * @master: device with the aggregate driver
>   * @matchptr: pointer to the list of component matches
>   * @compare: compare function to match against all components
> 


-- 
~Randy
