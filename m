Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeBBWCT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 17:02:19 -0500
Received: from gloria.sntech.de ([95.129.55.99]:52258 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751809AbeBBWCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 17:02:12 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: enable tsadc on rk3399-puma
Date: Fri, 02 Feb 2018 23:01:57 +0100
Message-ID: <9265333.RCTiQi6s6y@phil>
In-Reply-To: <20180130101555.41475-1-klaus.goger@theobroma-systems.com>
References: <20180130101555.41475-1-klaus.goger@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Januar 2018, 11:15:55 CET schrieb Klaus Goger:
> Enable the SoC thermal sensor on RK3399-Q7 (Puma).
> As we want to do do a full board reset instead of just a SoC one, set
> hw-tshut-mode to GPIO.
> 
> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

applied for 4.17

Thanks
Heiko
