Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeDZScF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:32:05 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:42122 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeDZScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:32:03 -0400
X-Google-Smtp-Source: AIpwx4+YgzKkWwCWN+jkhLeiP+V4XeEgE5nNiq1RiQDQjQTHZUv3PY/vXhXIZZAA1WBktfTtuwdR1g==
Date: Thu, 26 Apr 2018 11:32:00 -0700
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Joseph Qi <jiangqi903@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: testing io.low limit for blk-throttle
Message-ID: <20180426183200.GK1911913@devbig577.frc2.facebook.com>
References: <A749046B-BEB9-4278-ABEF-3007817D59DD@linaro.org>
 <4c6b86d9-1668-43c3-c159-e6e23ffb04b4@gmail.com>
 <A0424504-2778-41F4-B1C6-BE1B0253E524@linaro.org>
 <18accc1e-c7b3-86a7-091b-1d4b631fcd4a@gmail.com>
 <536A1B1D-575F-4193-ADA6-BA832AEC7179@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536A1B1D-575F-4193-ADA6-BA832AEC7179@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 24, 2018 at 02:12:51PM +0200, Paolo Valente wrote:
> +Tejun (I guess he might be interested in the results below)

Our experiments didn't work out too well either.  At this point, it
isn't clear whether io.low will ever leave experimental state.  We're
trying to find a working solution.

Thanks.

-- 
tejun
