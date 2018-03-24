Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeCXGMf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 02:12:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCXGMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 02:12:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 24 Mar 2018 11:42:32 +0530
From: sricharan@codeaurora.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com
Subject: Re: [PATCH v5 00/13] ARM: dts: ipq: updates to enable a few
 peripherals
In-Reply-To: <20180324021708.onpakgbxc544cwz2@localhost>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <20180324021708.onpakgbxc544cwz2@localhost>
Message-ID: <f5e3729f5de2693144d1667812b61c5d@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-24 07:47, Richard Cochran wrote:
> On Fri, Mar 23, 2018 at 03:48:43PM +0530, Sricharan R wrote:
>> [v5]
>>     * Fixed a minor comment that i missed earlier.
> 
> I tried booting this series with qcom_defconfig on my custom,
> dk07-like board.  It works!

  Thanks.
  Can i take that as a Tested-by: Richard Cochran 
<richardcochran@gmail.com>
  on DK07 ?

Regards,
  Sricharan
