Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5F6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44FA20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44FA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbeIGBIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:08:47 -0400
Received: from namei.org ([65.99.196.166]:46276 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeIGBIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:08:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w86KVXNF013643;
        Thu, 6 Sep 2018 20:31:33 GMT
Date:   Fri, 7 Sep 2018 06:31:33 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
cc:     Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: remove unnecessary unlikely()
In-Reply-To: <20180905203443.32289-1-igor.stoppa@huawei.com>
Message-ID: <alpine.LRH.2.21.1809070631170.31431@namei.org>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, Igor Stoppa wrote:

> WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
> into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

and next-testing.


Thanks!

-- 
James Morris
<jmorris@namei.org>

