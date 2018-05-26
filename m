Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031409AbeEZI7G convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:59:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36154 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031247AbeEZI7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:59:04 -0400
Date: Sat, 26 May 2018 10:58:48 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v3 14/16] mtd: rawnand: qcom: check for operation errors
 in case of raw read
Message-ID: <20180526105848.2fb1080f@xps13>
In-Reply-To: <1527250904-21988-15-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-15-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Fri, 25 May 2018 17:51:42 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> Currently there is no error checking for raw read. For raw
> reads, there won’t be any ECC failure but the operational
> failures are possible, so schedule the NAND_FLASH_STATUS read
> after each codeword.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
