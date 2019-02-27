Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E3BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE81020842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="PijNzlNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfB0RLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:11:24 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:44435 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfB0RLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=SypTJSBZ8TZfF9FJooPSd3PSicFFvmxtQlBDsf/VCRw=;
        b=PijNzlNWiMREUM4qRHNo4JQfABKW/R/XASsYBniuOB1tgI0Hdqh4d4eMTXLRWsQ/dSd2MUI3i91plxyrzn28XwT41ZgRLtrHDjBk+5ScsATm9AUahZ4pisLFGIQKM3ezrajy39kJUJppC45XTJGoXBmW3kfK4dOBUDxUAln/XnuZxK5zQ0YkZAVlBjRG6dGDa1u0kgqdHK8CxAIUDm1H+DKADZlEFnn1WRZls+mrOyLltObOWLwpLMEp2ESPl7bG5P2AY6BEDpVAGY2LgW25tzeVu0q4N2JPIAVsDWe0kq+75pfmh1mlMBPVWXT4phZM8rmI9k8Ylq7+0q/0e39e+A==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58477 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gz2jq-0002tx-0V; Wed, 27 Feb 2019 18:11:22 +0100
Subject: Re: [PATCH 1/3] drm/virtio: implement prime mmap
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190227144441.6755-1-kraxel@redhat.com>
 <20190227144441.6755-2-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <83886094-a5f4-bb79-f727-ed0c7b81eac3@tronnes.org>
Date:   Wed, 27 Feb 2019 18:11:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227144441.6755-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 27.02.2019 15.44, skrev Gerd Hoffmann:
> Sync gem vm_node.start with ttm vm_node.start,
> then we can just call drm_gem_prime_mmap().
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
