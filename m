Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbeDYEHh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:07:37 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:47066 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDYEHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:07:34 -0400
X-Google-Smtp-Source: AIpwx48ndRCPlkzEtxNlT71SOo9GKobcTZxOIt9j5V923CNPsTL1FbN7mwUVatXFQ6X8syacTFDXsw==
Date: Tue, 24 Apr 2018 23:07:28 -0500
From: Andy Gross <andy.gross@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] soc: qcom: smem: bug fixes
Message-ID: <20180425040728.GA12778@hector.attlocal.net>
References: <20180410222542.29474-1-elder@linaro.org>
 <e4cc56de-71d9-4904-ab09-92fa079c956a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4cc56de-71d9-4904-ab09-92fa079c956a@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 07:11:41AM -0500, Alex Elder wrote:
> On 04/10/2018 05:25 PM, Alex Elder wrote:
> > This series contains mostly bug fixes to the Qualcomm shared memory
> > ("smem") code.  Although the bugs are real, they have most likely
> > never been observed.
> > 
> > 					-Alex
> 
> Ping?	-Alex

It's only been a couple of weeks =P  That said, I looked over all of these and
they look reasonable.  I'd like Bjorn to take a look as well.

Andy
