Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEOWPO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeEOWPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:15:13 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Tali Perry <tali.perry1@gmail.com>, avifishman70@gmail.com,
        brendanhiggins@google.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        raltherr@google.com, robh+dt@kernel.org, tmaimon77@gmail.com,
        weiyongjunl@huawei.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525159407-31708-2-git-send-email-tali.perry1@gmail.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-arm-kernel@lists.infradead.org
References: <1525159407-31708-1-git-send-email-tali.perry1@gmail.com>
 <1525159407-31708-2-git-send-email-tali.perry1@gmail.com>
Message-ID: <152642251190.237094.2880285895652897578@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 1/1] clk: npcm750: fix base address and of_clk_get_by_name
 error handling. Also update error messages to be more informative
Date: Tue, 15 May 2018 15:15:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FMFL6q029191

Quoting Tali Perry (2018-05-01 00:23:27)
> 
> Nuvoton NPCM7XX Clock Controller
> fix base address and of_clk_get_by_name error handling.
>     Also update error messages to be more informative.
>     
>     In case clk_base allocation is erronoeous the return value is null.
>     Also fix handling of of_clk_get_by_name returns an error. 
>     Print a better error message pointing to the dt-binding documention.
> 
> 
> Signed-off-by: Tali Perry <tali.perry1@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Tali Perry (2):
>  

This doesn't apply to clk-next so I'm not sure what's going on. Please
resend if something needs to be fixed.
