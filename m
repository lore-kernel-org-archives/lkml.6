Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755487AbeEaOtD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:49:03 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53184 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755042AbeEaOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:49:01 -0400
X-Google-Smtp-Source: ADUXVKKvLAh/RgenwPog9tgZkTYd4YfdkvcJyp/wgIt1BxzPxYjwVzPLzx2x8tpYVspPfpWs5/u04w==
Subject: Re: [PATCH BUGFIX 0/3] three fixes for the function
 bfq_requests_merged
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        filippo.muzzini@outlook.it
References: <20180531132313.2986-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d2f92f58-598f-d75c-8120-71cf269738fe@kernel.dk>
Date: Thu, 31 May 2018 08:48:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180531132313.2986-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/18 7:23 AM, Paolo Valente wrote:
> Hi Jens,
> this series fixes three bugs in bfq_requests_merged. In more detail:
> 
> - two linked bugs, with the first (critical: wrong lock) hidden by the
>   second (less critical: wrong check that made the body of the
>   function not be executed at all)
> - a rather minor bug: superflous code

Patch #2 doesn't apply on for-4.18/block. I hand applied it, all
3 are queued up now.

-- 
Jens Axboe
