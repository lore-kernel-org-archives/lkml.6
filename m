Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCXCRO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 22:17:14 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:45334 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCXCRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 22:17:12 -0400
X-Google-Smtp-Source: AG47ELv9WKyKqdyg36sVBJlvu+TFuUUE0d3MDK8vspn2kGAnv1eAGX7np8M1hpOYQSiyk36QrIHNjg==
Date: Fri, 23 Mar 2018 19:17:08 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com
Subject: Re: [PATCH v5 00/13] ARM: dts: ipq: updates to enable a few
 peripherals
Message-ID: <20180324021708.onpakgbxc544cwz2@localhost>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 03:48:43PM +0530, Sricharan R wrote:
> [v5]
>     * Fixed a minor comment that i missed earlier.

I tried booting this series with qcom_defconfig on my custom,
dk07-like board.  It works!

Thanks a bunch,
Richard
