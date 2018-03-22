Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755128AbeCVNFy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:05:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754805AbeCVNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:05:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Mar 2018 18:35:48 +0530
From: sricharan@codeaurora.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: mark.rutland@arm.com, robh@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        absahu@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <20180321150743.z7edb5xkevsdi4vw@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
 <78806c70c85e3cecaadfc94b173cb139@codeaurora.org>
 <20180321150743.z7edb5xkevsdi4vw@localhost>
Message-ID: <4a9891ee982b55a1e76b6143bb42853c@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 20:37, Richard Cochran wrote:
> On Wed, Mar 21, 2018 at 02:40:43PM +0530, sricharan@codeaurora.org 
> wrote:
>>  Yes, i saw that it was booting out of mainline.
>>  Both DK01 and DK04 boards boots out of mainline.
> 
> Well, that is good news.
> 
> Which kernel config did you use?

   qcom_defconfig.
   Meanwhile i just posted a v4 (CCed you), is it possible that
   i can have test feedback ? . That will be great.

Regards,
  Sricharan
