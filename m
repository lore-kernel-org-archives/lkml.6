Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeEUOc7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:32:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53566 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeEUOc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:32:56 -0400
Date: Mon, 21 May 2018 16:32:54 +0200
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
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/14] dt-bindings: qcom_nandc: make
 nand-ecc-strength optional
Message-ID: <20180521163254.71ade105@xps13>
In-Reply-To: <1525350041-22995-4-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
        <1525350041-22995-4-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Thu,  3 May 2018 17:50:30 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> Now, nand-ecc-strength is optional. If specified in DT, then
> controller will use this ECC strength otherwise ECC strength will
> be calculated according to chip requirement and available OOB size.

Same comment as before: don't start the commit log with "now,".

Thanks,
Miquèl
