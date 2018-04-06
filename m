Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeDFPNU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:13:20 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34109 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeDFPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:13:16 -0400
X-Google-Smtp-Source: AIpwx4+3FONHjMlCFCP1j6fvkI4w3Sl9qAlfco2xm3QS4jdS4qFEDhTjYdt0SMeyvt5BhTXFUYqCAQ==
Date: Fri, 6 Apr 2018 08:13:12 -0700
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
Message-ID: <20180406151312.ehx4qtxcylkw4uhi@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
 <20180329143715.GA31757@hector.attlocal.net>
 <20180329163739.2fg5qxvb5j3fiy6r@localhost>
 <4073ec6b457cb369a83c710d0ae453b4@codeaurora.org>
 <20180406045511.hnzxe4nepl5sqmld@localhost>
 <7dc41c73f594918701c21075dde30870@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dc41c73f594918701c21075dde30870@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 06:35:49PM +0530, sricharan@codeaurora.org wrote:
>  I tried booting mainline built with qcom_defconfig on ap148 and
>  did boot. Not sure if your bootloader's bootarg is this,
>   'console=ttyMSM0,115200n8' ?

Yes, I think so.  I'll double check it.

Do you have any out-of-tree patches or special jumper settings?

Thanks,
Richard
