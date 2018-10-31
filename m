Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A3C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25092054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25092054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeJaJ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:57:48 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:34316 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbeJaJ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:57:47 -0400
Received: by mail-pg1-f171.google.com with SMTP id k1-v6so5097423pgq.1;
        Tue, 30 Oct 2018 18:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=MMw2GivY7NGS+REb2d9bjPC3ALtAZPDC25juW6LXcG9hY/DiWuFnoTGrk/ttZKuqSN
         YSoegr6oSbRUeZSfRc2NzP6nVMjCSA9u9gkjBE53hccNEwzmcJ5cXgMipEaw7vb37O89
         OxNMb+TSHOWNCBdNHXvvIyceF80/Vs6/ihOmHvL4l6X4Owc/31HyLNHDMadRnRbvB5i3
         YkZ1HDS8noMLpSFaEmdt8U3v5zWENpubInVauekSDN25P9xGhJNABkWfLv7fSySDjXi5
         rE6YQiCfrnYo4fH923mm4IRj9NCV7M4CNHMwkmHwz5jDQ3hY9q3w3s+IDxt2jv31Hr16
         YS1A==
X-Gm-Message-State: AGRZ1gJGs9dEZ/ZwEfeyUdmzRtbHiLHcwCtFPaxQexmuQySaib56Lart
        qWjogW3foWR0VMhrbOym2petGryC
X-Google-Smtp-Source: AJdET5dr7W8Sbl+1MuC5W9qiewhHV3BIha8O5vgmjBApGTE+FeJ8dtooZmLVtxzNkbt2IsojmyEf4g==
X-Received: by 2002:a63:aa48:: with SMTP id x8-v6mr961282pgo.87.1540947720152;
        Tue, 30 Oct 2018 18:02:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id h2-v6sm1331578pfc.6.2018.10.30.18.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:01:59 -0700 (PDT)
Subject: Re: [PATCH 09/16] blk-mq: cache request hardware queue mapping
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-10-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <89f05950-c462-6643-78db-1510879fe2d7@grimberg.me>
Date:   Tue, 30 Oct 2018 18:01:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-10-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
