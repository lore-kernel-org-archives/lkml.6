Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeC2Qce (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:32:34 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34923 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeC2Qcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:32:31 -0400
X-Google-Smtp-Source: AIpwx495E3sQFpHJSDriaSracWxtWlNnjzgmCAZdsK+mzC+YDE5EuuwgOwm7jDjAElMG2lUTp7AxWw==
Date: Thu, 29 Mar 2018 09:32:27 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Andy Gross <andy.gross@linaro.org>
Cc: Sricharan R <sricharan@codeaurora.org>, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        sboyd@codeaurora.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com
Subject: Re: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
Message-ID: <20180329163227.czbz7bang3oyiueh@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
 <20180329143715.GA31757@hector.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329143715.GA31757@hector.attlocal.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 09:37:15AM -0500, Andy Gross wrote:
> 
> If you aren't actually testing/validating this specific board, how can you make
> a statement like this?  Unless you have tested these specifically on this board,
> I'd appreciate not getting false information about what is or is not working.

I tested qualcomm's 4.4 kernel from codeaurora, and *it* doesn't boot
on the ipq4019.  I apologize for making a misleading statement.  I
assumed that the ipq4019 DTSs were merged in not booting from the
beginning.

Sorry,
Richard
