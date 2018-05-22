Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeEVOJG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:09:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:09:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 22 May 2018 19:39:00 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 02/14] mtd: rawnand: denali: use helper function for
 ecc setup
In-Reply-To: <20180521163014.355318d6@xps13>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
 <1525350041-22995-3-git-send-email-absahu@codeaurora.org>
 <20180521163014.355318d6@xps13>
Message-ID: <952e3cf1756dc5b5aa8b85b142eb7750@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-21 20:00, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Thu,  3 May 2018 17:50:29 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> Now, the NAND base layer has helper function for ecc
>> parameters setup which does the same thing.
> 
> Even if this message has a meaning in the series, I would prefer
> something more generic like:
> 
> "Use the NAND core helper function xxx() to tune the ECC parameters
> instead of the function locally defined."
> 

  Sure Miquel. I will change the commit message.

  Thanks,
  Abhishek

> With this change:
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Thanks,
> Miquèl
