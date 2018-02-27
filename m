Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeB0W74 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:59:56 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:33203 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeB0W7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:59:54 -0500
X-Google-Smtp-Source: AG47ELuKQIg3dlZYdbpndCBAL1FJH8S5gxARBMu7tibh/qoJAZ+/gCXFutHcLktAQgM/g0CtmLhtAg==
Date: Tue, 27 Feb 2018 16:59:52 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] i2c: qup: use the complete transfer length to
 choose DMA mode
Message-ID: <20180227225952.GH20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-8-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517644697-30806-8-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:12PM +0530, Abhishek Sahu wrote:
> Currently each message length in complete transfer is being
> checked for determining DMA mode and if any of the message length
> is less than FIFO length then non DMA mode is being used which
> will increase overhead. DMA can be used for any length and it
> should be determined with complete transfer length. Now, this
> patch introduces DMA threshold length and the transfer will be
> done in DMA mode if the total length is greater than this
> threshold length.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---

I agree with Sricharan's nit.

Reviewed-by: Andy Gross <andy.gross@linaro.org>
