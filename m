Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeCXRQ0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:16:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38356 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCXRQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:16:24 -0400
X-Google-Smtp-Source: AG47ELvYWX8N/An7lHcsOXKjDdPfp0uhhUM89mXdnE+iaainYQe7o2tlB/WoJobONOTp1WI3rMa/rg==
Date: Sat, 24 Mar 2018 10:16:20 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: sricharan@codeaurora.org
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com
Subject: Re: [PATCH v5 00/13] ARM: dts: ipq: updates to enable a few
 peripherals
Message-ID: <20180324171620.inhscxq67vwgaway@localhost>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <20180324021708.onpakgbxc544cwz2@localhost>
 <f5e3729f5de2693144d1667812b61c5d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e3729f5de2693144d1667812b61c5d@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 11:42:32AM +0530, sricharan@codeaurora.org wrote:
>  Can i take that as a Tested-by: Richard Cochran <richardcochran@gmail.com>
>  on DK07 ?

I wouldn't go that far, because I only booted to the console.  I
didn't test any peripherals beside the UART!  I am planning to test as
much as I can, but bear in mind that a) my board isn't identical to
the DK07 and b) it will take me a week to do it.

Thanks,
Richard
