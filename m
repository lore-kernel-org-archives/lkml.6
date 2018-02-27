Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeB0Wib (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:38:31 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:41221 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeB0Wi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:38:27 -0500
X-Google-Smtp-Source: AH8x227xG/t0g3ohxQOgD2gw1FgdTzbF3S3vqO4KxEgL1gSE6VxfcEww6nf2KF3VYg9wsst9VLyYlA==
Date: Tue, 27 Feb 2018 16:38:25 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] i2c: qup: fix the transfer length for BAM rx EOT
 FLUSH tags
Message-ID: <20180227223825.GF20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-6-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517644697-30806-6-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:10PM +0530, Abhishek Sahu wrote:
> In case of FLUSH operation, BAM copies INPUT EOT FLUSH (0x94)
> instead of normal EOT (0x93) tag in input data stream when an
> input EOT tag is received during flush operation. So only one tag
> will be written instead of 2 separate tags.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
