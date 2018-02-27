Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeB0W3A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:29:00 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:36913 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeB0W25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:28:57 -0500
X-Google-Smtp-Source: AG47ELs5qCeqh3CsmfOAIb0X08KhjO6aW5J5yoKlh4rPe6OhyxvzUcwwjcpoMmeIFe4oi3/97cCF+w==
Date: Tue, 27 Feb 2018 16:28:55 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] i2c: qup: remove redundant variables for BAM SG
 count
Message-ID: <20180227222855.GD20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517644697-30806-4-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:08PM +0530, Abhishek Sahu wrote:
> The rx_nents and tx_nents are redundant. rx_buf and tx_buf can
> be used for total number of SG entries.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---

Naming conventions aside,

Reviewed-by: Andy Gross <andy.gross@linaro.org>
