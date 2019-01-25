Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DB9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A7F218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="VvVwQcQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfAYPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:45:01 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:41871 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=VczL5wwm4VPxnDlosZ3tOf2eQ5jVeMGmH/LPku7O4HI=;
        b=VvVwQcQ9/5S+mXHuRm/Hxv44gNoFhXOuX8/m7Iv5xj2+mZlYgPrPlcO1WiKY/u1lZSggQaajCvCcirC06FZVYfjSynkZmFzFaSMiHu45VSMD22euqb9/4vp/JWsJSKe4lxotLcHo1WzvQBfDvLtTp+Ny/Zgwo2jERrd7HJ0CkiGr8iXtX89j5uv62KaVZ+Vkg3Aoa8bJmjyIzZhCoE0t9Wb327GITqxKbcEpJn5GOWCt/V9mY+XLNmRzxR6txDYs5N19bqp7WR8BEcBQontfaC4szwKdWGmn+ONmG+L1B5wuf8LWHkY+LmIeTFu1PhPEtfGOyHynWSFnsbWWSOB/ig==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49175 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn3f8-0000xh-TH; Fri, 25 Jan 2019 16:44:58 +0100
Subject: Re: [PATCH v3 02/23] drm/qxl: drop unused qxl_fb_virtual_address
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-3-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <ab644a0a-f87f-d237-e18c-3de79da56597@tronnes.org>
Date:   Fri, 25 Jan 2019 16:44:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.19, skrev Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
