Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeCLKxC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:53:02 -0400
Received: from gloria.sntech.de ([95.129.55.99]:35654 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeCLKxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:53:01 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Shunqian Zheng <zhengsq@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org
Subject: Re: [PATCH] arm64: dts: rockchip: assign clock rate for ACLK_VIO
Date: Mon, 12 Mar 2018 11:52:54 +0100
Message-ID: <4610682.YhluMk2iks@phil>
In-Reply-To: <1520819448-8316-1-git-send-email-zhengsq@rock-chips.com>
References: <1520819448-8316-1-git-send-email-zhengsq@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 12. März 2018, 02:50:48 CET schrieb Shunqian Zheng:
> The ACLK_VIO is a parent clock used by a several children,
> its suggested clock rate is 400MHz. Right now it gets 400MHz
> because it sources from CPLL(800M) and divides by 2 after reset.
> It's good not to rely on default values like this, so let's
> explicitly set it.
> NOTE: it's expected that at least one board may override cru node and
> set the CPLL to 1.6 GHz. On that board it will be very important to be
> explicit about aclk-vio being 400 MHz.
> 
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>

applied for 4.17

Thanks
Heiko
