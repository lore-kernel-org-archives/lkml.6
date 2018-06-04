Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeFDQVT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:21:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33796 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeFDQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:21:18 -0400
X-Google-Smtp-Source: ADUXVKKPQc2C+/9OzAyevoLcTmZSd52c3yDZGNDWOz/v7gZQMfNevZ4cxuB//QEPL5vHmdFE/EFouw==
Subject: Re: [PATCH] blk-mq: return when BLK_MQ_S_STOPPED in
 blk_mq_run_work_fn
To: Jianchao Wang <jianchao.w.wang@oracle.com>, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d6cee6a0-d20a-0055-24f7-a3e625c2f5b3@kernel.dk>
Date: Mon, 4 Jun 2018 10:21:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/18 3:03 AM, Jianchao Wang wrote:
> if hctx is stopped, don't run the queue in blk_mq_run_work_fn.

I was puzzled, so had to look up those changes. That's definitely
a regression caused by 15fe8a9, as you highlighted. Looks good to
me, I'll apply it.

BTW, this should have been explained in the commit message. I'll
change it a bit.

-- 
Jens Axboe
