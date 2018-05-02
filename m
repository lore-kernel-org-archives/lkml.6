Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751080AbeEBD1T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:27:19 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:42639 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeEBD1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:27:15 -0400
X-Google-Smtp-Source: AB8JxZoSbyMBt/VQjKC3GE9fV+4Sr459AuJawSMdcPcneRJ729XLIkdcJa/witSREVih0H5TNFEJiPLa+TQ5rl7mxSo=
MIME-Version: 1.0
In-Reply-To: <20180427121417.auv4ppryegkprv32@ninjato>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 2 May 2018 11:27:14 +0800
Message-ID: <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] i2c: sprd: Prevent i2c accesses after suspend is called
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 27 April 2018 at 20:14, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Apr 09, 2018 at 02:40:54PM +0800, Baolin Wang wrote:
>> Add one flag to indicate if the i2c controller has been in suspend state,
>> which can prevent i2c accesses after i2c controller is suspended following
>> system suspend.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Applied to for-current, thanks!
>
> We should maybe handle this in the core somewhen, though. Or?

Thanks. Yes, It will more helpful if we can handle this in the i2c core.

-- 
Baolin.wang
Best Regards
