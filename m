Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeEVOIH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:08:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:08:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 22 May 2018 19:38:01 +0530
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
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/14] dt-bindings: qcom_nandc: make nand-ecc-strength
 optional
In-Reply-To: <20180521163254.71ade105@xps13>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
 <1525350041-22995-4-git-send-email-absahu@codeaurora.org>
 <20180521163254.71ade105@xps13>
Message-ID: <66498b23730297c67604f274419931bf@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-21 20:02, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Thu,  3 May 2018 17:50:30 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> Now, nand-ecc-strength is optional. If specified in DT, then
>> controller will use this ECC strength otherwise ECC strength will
>> be calculated according to chip requirement and available OOB size.
> 
> Same comment as before: don't start the commit log with "now,".
> 
> Thanks,
> Miquèl

  Thanks Miquel.
  I will change the commit message.

  Regards,
  Abhishek
