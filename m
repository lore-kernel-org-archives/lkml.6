Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCVVcb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:32:31 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:45775 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeCVVc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:32:28 -0400
X-Google-Smtp-Source: AG47ELt0gjrx8W9yJjyAkuUur7pURo2dqalpjGZJeYQ/shJx5/bGG710139wES1rdmqPGGRd7hVT4Q==
Date: Thu, 22 Mar 2018 14:32:24 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: sricharan@codeaurora.org
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
Message-ID: <20180322213224.csntaaysjy2k3v35@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
 <78806c70c85e3cecaadfc94b173cb139@codeaurora.org>
 <20180321150743.z7edb5xkevsdi4vw@localhost>
 <4a9891ee982b55a1e76b6143bb42853c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9891ee982b55a1e76b6143bb42853c@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 06:35:48PM +0530, sricharan@codeaurora.org wrote:
>   Meanwhile i just posted a v4 (CCed you), is it possible that
>   i can have test feedback ? . That will be great.

I don't have any DK in hand, but I do have a custom design most
similar to the DK7.  I'll gladly try to boot it with your series.

Just to be clear:  You are running pure mainline with absolutely no
out-of-tree patches or other modifications, right?

Thanks,
Richard
