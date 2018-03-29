Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeC2OhX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:37:23 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41083 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeC2OhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:37:20 -0400
X-Google-Smtp-Source: AIpwx49DRVY3twXC1C+vBVCXuqc5TLJ3kC1bcB5WIXKCjx3EbnQzt422XjZbeH6pEZG2CBrdTnAxHw==
Date: Thu, 29 Mar 2018 09:37:15 -0500
From: Andy Gross <andy.gross@linaro.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Sricharan R <sricharan@codeaurora.org>, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        sboyd@codeaurora.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com
Subject: Re: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
Message-ID: <20180329143715.GA31757@hector.attlocal.net>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320143131.4eenixtbhciq5fwc@localhost>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 07:31:31AM -0700, Richard Cochran wrote:
> On Tue, Mar 20, 2018 at 09:28:47AM +0530, Sricharan R wrote:
> > Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> > Adds missing memory, reserved-memory nodes.
> > 
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > ---
> >  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 28 +++++++++++++++++++++++++++
> 
> Q: Does mainline Linux even boot on the DK?
> 
> A: No, it doesn't.

If you aren't actually testing/validating this specific board, how can you make
a statement like this?  Unless you have tested these specifically on this board,
I'd appreciate not getting false information about what is or is not working.

> 
> Please add the missing basic board support before hacking random stuff
> into the DTS.

Feel free to send your own contributions where you are adding the things that
are important to you.

Regards,

Andy Gross
