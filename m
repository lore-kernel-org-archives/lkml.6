Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCF1208C1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeLODV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:21:29 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44892 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeLODV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:21:28 -0500
Received: by mail-yb1-f196.google.com with SMTP id d2so3074115ybs.11;
        Fri, 14 Dec 2018 19:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qPsOgK/HIYhRAQ36LYVL6GTM5NKZM5V39PwS3hyj5ZoxAyx3Yw4UqcroH6+iOzlZ3t
         zmOA4bUiUmVia3KLkPbKKyELCXzlD7bgUCxJ+7Uy0nXvphcuTDQ29AYgPxoQ5J4eByCg
         /90AK7z7ydizL8seBWXY8HaIUjmLDUpFEC4Qrz8L96cEuAR22z4szJEQwaetxIhazHMz
         ICc+XZsaSMrPtl6smMEY1bIHeSvBeRF0KjOBrLyJv+VOGCD/XCBfAHo5S6RFG9dHlYv6
         A+6Eaid8LE0zIZGDJLOp+EpCQGNnHdMkIkMVklTcmc7ieWHmtmBJa4vQ3uHnIeDA+2Y4
         3gwg==
X-Gm-Message-State: AA+aEWb15OpTt2viLr4trylRj32XGMFiDHgwQMnidhP8yxXlHaGtUHur
        zTzUji1nxLcvpWQzFKewger/AK2T
X-Google-Smtp-Source: AFSGD/X86xfjPuwj7SZqRotpNk3WEOOWYB3qZQnpN38LA47ZJS0BcUwHZccWeJfElktZCMCE3m8k6w==
X-Received: by 2002:a25:7e41:: with SMTP id z62mr5668810ybc.119.1544844087551;
        Fri, 14 Dec 2018 19:21:27 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id n133sm2142449ywb.55.2018.12.14.19.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 19:21:26 -0800 (PST)
Subject: Re: [PATCH][next] nvme-tcp: fix spelling mistake "attepmpt" ->
 "attempt"
To:     Colin King <colin.king@canonical.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181214114243.10675-1-colin.king@canonical.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c4ebec98-fb2a-a0c3-c45c-d519f755c161@grimberg.me>
Date:   Fri, 14 Dec 2018 19:21:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214114243.10675-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
