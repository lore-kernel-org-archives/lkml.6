Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeENOgT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:36:19 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:51031 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932470AbeENOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:36:16 -0400
X-Google-Smtp-Source: AB8JxZoCCt/wSX+HBs9/wzWR4vm9hTSwJ+4lS3ubtfz26W3h+KRg7WQN70SFcbOvboUXQrl21F+D7g==
Subject: Re: [PATCH] memstick: ms_block: fix unused variable warning
To: Anders Roxell <anders.roxell@linaro.org>, maximlevitsky@gmail.com
Cc: linux-kernel@vger.kernel.org
References: <20180514101756.2120-1-anders.roxell@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4870b67f-63d8-7c8d-b351-99379c1d921f@kernel.dk>
Date: Mon, 14 May 2018 08:36:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180514101756.2120-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/18 4:17 AM, Anders Roxell wrote:
> When building a warning pops up unused variable 'host'
> drivers/memstick/core/ms_block.c: In function ‘msb_init_disk’:
> drivers/memstick/core/ms_block.c:2097:24: warning: unused variable ‘host’ [-Wunused-variable]
>   struct memstick_host *host = card->host;

Thanks, but I already applied the fixup from Christoph.

-- 
Jens Axboe
