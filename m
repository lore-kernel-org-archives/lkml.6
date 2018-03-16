Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeCPKms convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:42:48 -0400
Received: from gloria.sntech.de ([95.129.55.99]:32886 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752946AbeCPKmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:42:47 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Jacob Chen <jacob-chen@iotwrt.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: fix uart4 pin-num for rk3288
Date: Fri, 16 Mar 2018 11:42:45 +0100
Message-ID: <1777649.aQ8WR3JL3p@phil>
In-Reply-To: <20180315071714.11589-1-jacob-chen@iotwrt.com>
References: <20180315071714.11589-1-jacob-chen@iotwrt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 15. März 2018, 08:17:14 CET schrieb Jacob Chen:
> According to TRM, uart4 tx/rx should be 14/15
> 
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>

applied for 4.17 (but may move to 4.18 depending on timing)

Thanks
Heiko
