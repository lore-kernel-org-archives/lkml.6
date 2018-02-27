Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeB0XRn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:17:43 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37322 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeB0XRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:17:40 -0500
X-Google-Smtp-Source: AG47ELsuv4tF8nJoM46yFL57Ean+UVkMj4RYgTGo9quBYMG/XKW13+izlhwix5Gyep78x40cu/bRpQ==
Date: Tue, 27 Feb 2018 17:17:39 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] i2c: qup: send NACK for last read sub transfers
Message-ID: <20180227231739.GK20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-11-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517644697-30806-11-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:15PM +0530, Abhishek Sahu wrote:
> According to I2c specification, “If a master-receiver sends a
> repeated START condition, it sends a not-acknowledge (A) just
> before the repeated START condition”. QUP v2 supports sending
> of NACK without stop with QUP_TAG_V2_DATARD_NACK so added the
> same.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
