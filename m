Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbeDSOwf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:52:35 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:41125 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753689AbeDSOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:52:33 -0400
X-Google-Smtp-Source: AB8JxZrOFfx5wWY6Di0LgUMxJFayj2GRW7GEfeiL2blpmipXRPBurukSGc0BEiOU51Fg6jpuFOI5pQ==
Subject: Re: [PATCH 1/2] blkcg: small fix on comment in blkcg_init_queue
To: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, zhong.weidong@zte.com.cn, wen.yang99@zte.com.cn
References: <1524110666-106945-1-git-send-email-jiang.biao2@zte.com.cn>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b24cd922-01c7-ce14-6427-1a8dd7819e58@kernel.dk>
Date: Thu, 19 Apr 2018 08:52:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1524110666-106945-1-git-send-email-jiang.biao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/18 10:04 PM, Jiang Biao wrote:
> The comment before blkg_create() in blkcg_init_queue() was moved
> from blkcg_activate_policy() by commit ec13b1d6f0a0457312e615, but
> it does not suit for the new context.

Applied - btw, in the future, if you send more than one patch in
a series, please include a cover letter.

I've applied 2/2 as well.

-- 
Jens Axboe
