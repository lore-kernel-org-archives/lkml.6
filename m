Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeCTObi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:31:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36187 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeCTObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:31:34 -0400
X-Google-Smtp-Source: AG47ELsomOACl2BlkNJGBNi2ZRPl0APR6vQIwH4G/b61yciwlBXarB+WE18PZvBo/TwOA4xKVZCgYg==
Date: Tue, 20 Mar 2018 07:31:31 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com
Subject: Re: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
Message-ID: <20180320143131.4eenixtbhciq5fwc@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 09:28:47AM +0530, Sricharan R wrote:
> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Adds missing memory, reserved-memory nodes.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 28 +++++++++++++++++++++++++++

Q: Does mainline Linux even boot on the DK?

A: No, it doesn't.

Please add the missing basic board support before hacking random stuff
into the DTS.

Thanks,
Richard
