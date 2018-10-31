Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71181C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A442082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A442082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeJaJYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:24:25 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:42327 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbeJaJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:24:25 -0400
Received: by mail-pf1-f178.google.com with SMTP id f26-v6so6692140pfn.9;
        Tue, 30 Oct 2018 17:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ItdZ2mCl887/EaLqJvrSI3kmCdXOsZY6Mbu+al2nDABQhYOd6ojC8v6WbbRrlDhnaj
         ERsNt5nN29QQZ+1dS28pwmmZvWjVyFYWlegBIknq11vHtnMU5cnmAsGlweKIkAgvDtp2
         lgX4Z5arDI14kG/GiEuGlsc63Hq9WCQyZRaV9ZcdrtAEXHwDWqrmFs/R4A+5jO8LmFl4
         yku0omdPH7vbqt83O+G2I54TkLV/pRxM/qzJ8YAY4GW3uJnrpOysKJkm9dgUU4E3Gp7+
         kUk5sE6n9GJn56zxkKNYH0QMLuebA3I0DfRuFb9Wu35J0WkyhKzEkDuNZ8o+peERZQ6S
         JQBA==
X-Gm-Message-State: AGRZ1gIsb9XGLcRSJuSd/ntYSyoEklf90WKNfwHc+fKB5VaNNBgQU+4J
        kFTpFEnBgSnj8wWkZ51Q1Hokx87r
X-Google-Smtp-Source: AJdET5eszJ4XT5zW4lYRA6D7Z4/rdsQS1+6sy5b4ebD/I0MZwKHTK7eULCH9P2VAfvx8uZtvnr1vvg==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr903870pgg.398.1540945722342;
        Tue, 30 Oct 2018 17:28:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id u124-v6sm44983739pgc.0.2018.10.30.17.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 17:28:41 -0700 (PDT)
Subject: Re: [PATCH 01/16] blk-mq: kill q->mq_map
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-2-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d1432666-2ecc-6f56-29fd-9dd76037c5b6@grimberg.me>
Date:   Tue, 30 Oct 2018 17:28:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
