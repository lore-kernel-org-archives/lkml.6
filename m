Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29D5C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B0B218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="efoN+Wqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfAYPw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:52:57 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:35112 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbfAYPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=0EWt73547Gh5GE44VIlgYQJK4/fqDpo28jJDaXSh13M=;
        b=efoN+WqxlB+MoEbXyYdiS7+iGjmUHm7KCOMJ/K8ZnitohuFyngkfVr6GoOJJ/iAs2uWQkOTJnwGiR7qjcZZ3dpCCS5N08TZgYL4M3oaJG+vraUfoi5TJfW3IxO9ce9RB16rgJr9b+vaQY17Vc+s/DpDb4QCQGBgimMb6ZSh5VGvughsOLxA9VpsQpvXsYeBuQMA6rvbaHPHAwEi3uWU5SehTyjuJ6DEIlrf6AnQmCnP9CASl334/E8NCubbtvOCChMyW59Jlyvmmjd7LORXULB+YwVS1um6k9yAZ+qVtb0v9teyq+eBZmBC+mJzumoR1661ggGuKYKMpLN5w9/79/A==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49219 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn3mo-0002Zg-0z; Fri, 25 Jan 2019 16:52:54 +0100
Subject: Re: [PATCH v3 04/23] drm/qxl: change the way slot is detected
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        Frediano Ziglio <fziglio@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-5-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <a0bd0249-baad-76d3-4270-a1c4610fd8f1@tronnes.org>
Date:   Fri, 25 Jan 2019 16:52:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> From: Frediano Ziglio <fziglio@redhat.com>
> 
> Instead of relaying on surface type use the actual placement.
> This allow to have different placement for a single type of
> surface.
> 
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> 
> [ kraxel: rebased, adapted to upstream changes ]
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
