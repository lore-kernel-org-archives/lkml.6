Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756219AbeCWKZP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:25:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48992 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756187AbeCWKZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:25:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Mar 2018 15:55:06 +0530
From: sricharan@codeaurora.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        david.brown@linaro.org, absahu@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linux-soc@vger.kernel.org,
        sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <20180322213224.csntaaysjy2k3v35@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
 <78806c70c85e3cecaadfc94b173cb139@codeaurora.org>
 <20180321150743.z7edb5xkevsdi4vw@localhost>
 <4a9891ee982b55a1e76b6143bb42853c@codeaurora.org>
 <20180322213224.csntaaysjy2k3v35@localhost>
Message-ID: <99ad33aae8e1210f8da15161ebfea2d2@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-23 03:02, Richard Cochran wrote:
> On Thu, Mar 22, 2018 at 06:35:48PM +0530, sricharan@codeaurora.org 
> wrote:
>>   Meanwhile i just posted a v4 (CCed you), is it possible that
>>   i can have test feedback ? . That will be great.
> 
> I don't have any DK in hand, but I do have a custom design most
> similar to the DK7.  I'll gladly try to boot it with your series.
> 
> Just to be clear:  You are running pure mainline with absolutely no
> out-of-tree patches or other modifications, right?

  Yes, mainline (4.16-rc6), plus my patches, pushed it here as well [1]
  Btw, posted v5 to fix a minor thing that i missed earlier.

  [1] https://github.com/sricharanaz/kernel/tree/ipq_test

Regards,
  Sricharan
