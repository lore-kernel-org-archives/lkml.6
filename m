Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeDFNF4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:05:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbeDFNFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:05:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Apr 2018 18:35:49 +0530
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
In-Reply-To: <20180406045511.hnzxe4nepl5sqmld@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
 <20180329143715.GA31757@hector.attlocal.net>
 <20180329163739.2fg5qxvb5j3fiy6r@localhost>
 <4073ec6b457cb369a83c710d0ae453b4@codeaurora.org>
 <20180406045511.hnzxe4nepl5sqmld@localhost>
Message-ID: <7dc41c73f594918701c21075dde30870@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-06 10:25, Richard Cochran wrote:
> On Mon, Apr 02, 2018 at 03:28:47PM +0530, sricharan@codeaurora.org 
> wrote:
>>   Yes, i will post another series for ipq806[2/4] updates and the
>> corresponding
>>   boards after this.
> 
> I tried mainline on the ap148 using qcom_defconfig and the
> qcom-ipq8064-ap148.dtb, and it doesn't boot FYI.
> 

  I tried booting mainline built with qcom_defconfig on ap148 and
  did boot. Not sure if your bootloader's bootarg is this,
   'console=ttyMSM0,115200n8' ?


  root@(none):/# cat /proc/version
  Linux version 4.16.0 (srichara@srichara-linux) (gcc version 6.3.1 
20170109 (Linaro GCC 6.3-2017.02)) #1691 SMP PREEMPT Fri Apr 6 15:30:45 
IST 2018
  root@(none):/#

Regards,
  Sricharan
