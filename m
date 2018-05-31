Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755393AbeEaO4M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:56:12 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34250 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755134AbeEaO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:56:07 -0400
X-Google-Smtp-Source: ADUXVKIjbifICFD9DJ1kHyPRngxTSF9kZoaA3V4w4oe9o0OMT6TouizkRdh7L0l+AUSxN58HF27fpQ==
Subject: Re: [PATCH BUGFIX/IMPROVEMENTS 0/4] bfq: fix regressions on slow
 virtual machines
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        sapienza.dav@gmail.com, 177992@studenti.unimore.it
References: <20180531144508.3927-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2e19f92d-5319-f023-7f4c-89ee81c58348@kernel.dk>
Date: Thu, 31 May 2018 08:56:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180531144508.3927-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/18 8:45 AM, Paolo Valente wrote:
> Hi,
> we have bumped into some BFQ latency regressions on slow virtual
> machines. The patches in this series fix all these regressions, apart
> from the first patch, which provides an indirect contribution, by
> improving the description of the mechanisms affected by these
> regressions.

Pulled for 4.18, thanks Paolo.

-- 
Jens Axboe
