Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeEUOaT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:30:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53505 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbeEUOaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:30:16 -0400
Date: Mon, 21 May 2018 16:30:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
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
Message-ID: <20180521163014.355318d6@xps13>
In-Reply-To: <1525350041-22995-3-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
        <1525350041-22995-3-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Thu,  3 May 2018 17:50:29 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> Now, the NAND base layer has helper function for ecc
> parameters setup which does the same thing.

Even if this message has a meaning in the series, I would prefer
something more generic like:

"Use the NAND core helper function xxx() to tune the ECC parameters
instead of the function locally defined."

With this change:

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
