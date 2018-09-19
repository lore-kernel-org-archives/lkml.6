Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D7ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFA62150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXzzccIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFA62150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbeISSne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeISSnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:43:33 -0400
Received: from [192.168.0.101] (unknown [117.62.222.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710F620645;
        Wed, 19 Sep 2018 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537362342;
        bh=3Eo3fxy3Ew4fJ9NFcnFrjwinsYd4vDE7+xfFCkpWrLc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pXzzccIbOP1XwZ3B9dbkk9DEGn5sDjK3p6R0QLN5ewmCoYwOwqtUbHUdDZhxdF+IJ
         o5V7JJe3dSw3N0GWOEUSGN2XHq35vYpRS7EBJ9C47/ZATW7GMan7pi1YiVvZTl7Ytt
         w7eTL3fO7XwE5mF8rTd9VipHxqIcjE6VwLLO+AHI=
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: add new idle interval timing for
 discard and gc paths
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
References: <1537346927-9649-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ffa10ee8-c629-aac5-ffbb-6bb6bb24b7f3@kernel.org>
Date:   Wed, 19 Sep 2018 21:05:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537346927-9649-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 16:48, Sahitya Tummala wrote:
> This helps to control the frequency of submission of discard and
> GC requests independently, based on the need.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
