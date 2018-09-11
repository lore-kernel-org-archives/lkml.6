Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403F8C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF052086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF052086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeIKVAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:00:53 -0400
Received: from mleia.com ([178.79.152.223]:44880 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKVAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:00:53 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 04FC24160E2;
        Tue, 11 Sep 2018 17:00:55 +0100 (BST)
Subject: Re: [PATCH] mmc: mxcmmc: replace spin_lock_irqsave with spin_lock in
 ISR
To:     jun qian <hangdianqj@163.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kees Cook <keescook@chromium.org>, Allen <allen.lkml@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180911144701.53383-1-hangdianqj@163.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <1c5cd9ec-3c33-0ad8-d1bf-a5d3883c9e5c@mleia.com>
Date:   Tue, 11 Sep 2018 19:00:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180911144701.53383-1-hangdianqj@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180911_170055_039862_A4ADCAEE 
X-CRM114-Status: UNSURE (   5.03  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 05:47 PM, jun qian wrote:
> As you are already in ISR, it is unnecessary to call spin_lock_irqsave.
> 
> Signed-off-by: jun qian <hangdianqj@163.com>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

---
Best wishes,
Vladimir
