Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935170AbeEIOoP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:44:15 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:55004 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbeEIOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:44:13 -0400
X-Google-Smtp-Source: AB8JxZpN0ZK8UNTYfEQty0A0qqd2yqJ55TyEvQ/BiAmcsamh/1ii26VBtuGaN3z8sEld5/Eca+mMeg==
Subject: Re: [PATCH] brd: Mark as non-rotational
To: SeongJae Park <sj38.park@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180503095326.7414-1-sj38.park@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4da307ac-77c5-1eed-434c-005c97f9a308@kernel.dk>
Date: Wed, 9 May 2018 08:44:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180503095326.7414-1-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/18 3:53 AM, SeongJae Park wrote:
> This commit sets QUEUE_FLAG_NONROT and clears up QUEUE_FLAG_ADD_RANDOM
> to mark the ramdisks as non-rotational device.

Applied for 4.18, thanks.

-- 
Jens Axboe
