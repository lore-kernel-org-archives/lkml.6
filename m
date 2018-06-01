Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeFASp3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbeFASp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:45:26 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>, robh@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1525295174-15995-2-git-send-email-mgautam@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
 <1525295174-15995-2-git-send-email-mgautam@codeaurora.org>
Message-ID: <152787872536.144038.14465736571389918971@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/7] clk: msm8996-gcc: Mark halt check as no-op for USB/PCIE
 pipe_clk
Date: Fri, 01 Jun 2018 11:45:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51Il4Q9023803

Quoting Manu Gautam (2018-05-02 14:06:08)
> The USB and PCIE pipe clocks are sourced from external clocks
> inside the QMP USB/PCIE PHYs. Enabling or disabling of PIPE RCG
> clocks is dependent on PHY initialization sequence hence
> update halt_check to BRANCH_HALT_SKIP for these clocks so
> that clock status bit is not polled when enabling or disabling
> the clocks. It allows to simplify PHY client driver code which
> is both user and source of the pipe_clk and avoid error logging
> related status check on clk_disable/enable.
> 
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---

Applied to clk-next
