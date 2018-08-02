Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7221522
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyMB/rzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B7221522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbeHBQ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732468AbeHBQ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:27:57 -0400
Received: from [192.168.0.101] (unknown [121.229.118.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3713F21501;
        Thu,  2 Aug 2018 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533220589;
        bh=fAVuUNxSd0ngdky7InAWxrzpS+xgaDYAPahShK1Ko5g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uyMB/rzbi6uC3Pcx5d1d43ffVUL8P3+E2cIp8xbknbIkFLCWQSMd+uw0M0Qk8jCmo
         QuQ4S/1S8YxN1JMnJx4CA7iy02A/tnq5A9Z4HaL0F0+VuBp6dtNToaaFvYcAg4+aR6
         pMSMKDpuFvCNqu6U9Q/TqIxSi2BxT34+sATzALPk=
Subject: Re: [f2fs-dev] [PATCH] f2fs: use true and false for boolean values
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180802005138.GA25569@embeddedor.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <d2dc7df0-9d77-92fd-3907-88d288233009@kernel.org>
Date:   Thu, 2 Aug 2018 22:36:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802005138.GA25569@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/2 8:51, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
