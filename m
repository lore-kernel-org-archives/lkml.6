Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F5C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6390A218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Tf1UsUSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfAYQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:10:39 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:51815 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=aDtbZ42OP6CXyqWlOflx0b5+EvKf6YNHbXlER6cC/Ds=;
        b=Tf1UsUSoqEaOImgGxv+grgzPiCQv80nrV9fzuDCwwhfLEkHrwMBeuItbIbwvX5KKleGggUAse2AqYeVAmZ0BEA8fIV5WjO9XOBdpMn9IXxg+xLfgGuQSabhy9SyyvrKRthQ/fvib4tH/H5IGqsHUI8pCw8BdAI2LStqW3g7Mcf5bhOtYJs4VbIhb0resypx2nbdA1NknKToSfZeqVNhAxEiOs4MkdVQqHxKL+4hcED4nU5ErOKPLs/rjD6SPTGRt6NUM6pIbTxc6ZfGSwwz3qa5J2CTKRUKPH7Cx5wSoxapI7rv4o0zwoH6+9MVZ7NEWNRnxNFJhvonhsHidqm4ysg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49438 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn43w-0006Hz-Qh; Fri, 25 Jan 2019 17:10:36 +0100
Subject: Re: [PATCH v3 11/23] drm/qxl: drop unused offset parameter from
 qxl_io_create_primary()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-12-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <456a129b-1e79-a8a8-8d47-b90e626176fb@tronnes.org>
Date:   Fri, 25 Jan 2019 17:10:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-12-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
