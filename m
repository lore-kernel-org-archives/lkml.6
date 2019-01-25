Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B35AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A86218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="KC4YhZfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfAYRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:34:42 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:49046 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=OYgLc90JHBdxgYaR4VZMa31svhootUyb002bIRyG078=;
        b=KC4YhZfx1P36Y0AwALcMfnlHbDbifIElEY/v+Jrmq6fGGj/1srZVJoeV2GjMwCuBe7wFWJ/icZRgj4XFPzbAveox5YOX9cLXsg5qm/4+7JwRW89g+S+/qIrUpOmviQj3MS2g/k3YBoAj+jO/rChhBm+jEFPwFQWqC/U9pY7iWxa/jZ3ZykenVHxd5Jl+ln5b9tDLTnBs5H3RLeym1nSpqmPGhismu7Y+lQIbyQjsZ9e3M0OiVuyoX1xz7hqE2ejnbjAWGpfNRovQOJdGlmOccEgTFakniSNDtm0kXARjCm7vsEv7n6ZcIrFlV9+ztXIO8VUXsfJ5Ls+mZvm8TBJLhw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50565 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn5NH-000568-1m; Fri, 25 Jan 2019 18:34:39 +0100
Subject: Re: [PATCH v3 21/23] drm/qxl: add qxl_add_mode helper function
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-22-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <37996666-8a1a-9907-eb7e-475c966e857b@tronnes.org>
Date:   Fri, 25 Jan 2019 18:34:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-22-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> Add a helper function to add custom video modes to a connector.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
