Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93229C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635152064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635152064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeJaJ1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:27:49 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:33445 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeJaJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:27:49 -0400
Received: by mail-pf1-f178.google.com with SMTP id a15-v6so6718142pfn.0;
        Tue, 30 Oct 2018 17:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SjcowQdrbSQS9+zHi+XjsqwXwzrxj6npdWYTEomiVG3KLCi281I10C77J16P8L+NUU
         k10XC4Wf21+93Oy0R7Mi+HEZwU9gjii5S8BPxtgF2egPSZSxThhPU66JhYCPEgeQzmnW
         /r9+LRsFMUoLIm2Tj/fB5vmfqeyCSmqSrz/LO+0L8Ub+lLguNStsbV13y2/+imISm8Xw
         N7XUWrGB3FUuXBSzTS3618rPudSRgrJWlOAE1Cmsfwv0gtzDFBeqOKowYWS3TvvMmbFv
         AVWIeFBCFqsnIZJyUZmPiQL51og8DwHiFx/QO6Kd651RbY6M/7TTYfLj3R90nHNmKkW8
         O7Aw==
X-Gm-Message-State: AGRZ1gLiZBheqON+6jVF3I21IuMl6WkQgGE/RWNoGsv8t6w2e0KD/j+n
        GG2la5bFBonDY4PTWA+hDpHgezYa
X-Google-Smtp-Source: AJdET5dSwx2uCMimr0u4YrXbY2SseCuWqSli/zxNsEApIlOuTO7jvnO0G/RjA6XQ59RaKomSz6odTQ==
X-Received: by 2002:a62:401:: with SMTP id 1-v6mr938193pfe.156.1540945925568;
        Tue, 30 Oct 2018 17:32:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id p129-v6sm13978576pgp.92.2018.10.30.17.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 17:32:04 -0700 (PDT)
Subject: Re: [PATCH 03/16] blk-mq: provide dummy blk_mq_map_queue_type()
 helper
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-4-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <98e6e36b-250e-cf8c-979b-953b1b501a38@grimberg.me>
Date:   Tue, 30 Oct 2018 17:32:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-4-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
