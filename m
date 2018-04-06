Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeDFQIv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:08:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeDFQIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:08:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Apr 2018 21:38:47 +0530
From: sricharan@codeaurora.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        sboyd@codeaurora.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com
Subject: Re: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <20180406151312.ehx4qtxcylkw4uhi@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
 <20180329143715.GA31757@hector.attlocal.net>
 <20180329163739.2fg5qxvb5j3fiy6r@localhost>
 <4073ec6b457cb369a83c710d0ae453b4@codeaurora.org>
 <20180406045511.hnzxe4nepl5sqmld@localhost>
 <7dc41c73f594918701c21075dde30870@codeaurora.org>
 <20180406151312.ehx4qtxcylkw4uhi@localhost>
Message-ID: <82ba83a1a8ebb8a5ef2fa71356374be3@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-06 20:43, Richard Cochran wrote:
> On Fri, Apr 06, 2018 at 06:35:49PM +0530, sricharan@codeaurora.org 
> wrote:
>>  I tried booting mainline built with qcom_defconfig on ap148 and
>>  did boot. Not sure if your bootloader's bootarg is this,
>>   'console=ttyMSM0,115200n8' ?
> 
> Yes, I think so.  I'll double check it.
> 
> Do you have any out-of-tree patches or special jumper settings?

  No out of tree patches or special jumper settings. I am booting the
  mainline kernel, ap148.dtb + ramfs.

Regards,
  Sricharan
