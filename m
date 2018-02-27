Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeB0W0M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:26:12 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:54365 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeB0W0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:26:09 -0500
X-Google-Smtp-Source: AG47ELuHwGbCMo0/p7t1S9CqPcMbFttjdrUJu91ridQbmGOSIGvAfBdsNbDiKpyWMJk1uTirUcOFVQ==
Date: Tue, 27 Feb 2018 16:26:07 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] i2c: qup: minor code reorganization for use_dma
Message-ID: <20180227222607.GC20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-3-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517644697-30806-3-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:07PM +0530, Abhishek Sahu wrote:
> 1. Assigns use_dma in qup_dev structure itself which will
>    help in subsequent patches to determine the mode in IRQ handler.
> 2. Does minor code reorganization for loops to reduce the
>    unnecessary comparison and assignment.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
