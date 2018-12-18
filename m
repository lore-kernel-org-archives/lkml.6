Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC60C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDF421841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="TuTA1+Nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeLRQQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:16:03 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:46650 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeLRQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=sV/QL4B04BXdYgCnVdFh/+CGTMTB8YD57dJQeC/jR0o=;
        b=TuTA1+NjrXEMkk2SlapT7nS11xW0GjkjlymrbYknIFuTWzhMV2f7+wPBMLkWFAZHvkrEK3PluzoyPo4+D4SytsCLHsLk/bQvqRVSaCf+/uhPimDPNWy9qJjt0ACI0bLxGMHz51ZsjwCskACJnjPbg4AYlCJWSK3LnnpQo4VpfkL7wUFBsEhhuNSO1R9qGeRVvEnMizQ+vLNuyANQQlTg6kudYxaor+UsEbh/yoRg9mxD8VaQ23+YICpFab+ck1PVMqXwn+K3EJ67TzB+pAgU+1LL0pf1q3YoWv8hoGd8W3OkGPgFk1avHVnB7rjemMltmZPje4NTSgAfDplgkk212Q==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:61555 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gZI2J-0002bA-Im; Tue, 18 Dec 2018 17:15:59 +0100
Subject: Re: [Xen-devel][PATCH v2 2/3] drm/xen-front: Use Xen common shared
 buffer implementation
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-2-andr2000@gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <75f3a715-94a0-a21d-04c1-aa3cf4cdb331@tronnes.org>
Date:   Tue, 18 Dec 2018 17:15:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181130074205.20496-2-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 30.11.2018 08.42, skrev Oleksandr Andrushchenko:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Use page directory based shared buffer implementation
> now available as common code for Xen frontend drivers.
>
> Remove flushing of shared buffer on page flip as this
> workaround needs a proper fix.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

