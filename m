Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeDFEzR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 00:55:17 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:46184 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeDFEzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 00:55:15 -0400
X-Google-Smtp-Source: AIpwx48ablsEkeh5WufEgk3YKKkXOtlRHpdCuO0NVk3bkc/MlrDcQnBcRB6cZvtseIScZ6kFwqGXFg==
Date: Thu, 5 Apr 2018 21:55:11 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: sricharan@codeaurora.org
Cc: Andy Gross <andy.gross@linaro.org>, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        sboyd@codeaurora.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com
Subject: Re: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
Message-ID: <20180406045511.hnzxe4nepl5sqmld@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
 <20180329143715.GA31757@hector.attlocal.net>
 <20180329163739.2fg5qxvb5j3fiy6r@localhost>
 <4073ec6b457cb369a83c710d0ae453b4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4073ec6b457cb369a83c710d0ae453b4@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 03:28:47PM +0530, sricharan@codeaurora.org wrote:
>   Yes, i will post another series for ipq806[2/4] updates and the
> corresponding
>   boards after this.

I tried mainline on the ap148 using qcom_defconfig and the
qcom-ipq8064-ap148.dtb, and it doesn't boot FYI.

Thanks,
Richard
