Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeBQJ3M convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 04:29:12 -0500
Received: from gloria.sntech.de ([95.129.55.99]:56288 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbeBQJ3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 04:29:11 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: add Haikou baseboard with RK3368-uQ7 SoM
Date: Sat, 17 Feb 2018 10:28:58 +0100
Message-ID: <1860444.sEZiGd3jTf@diego>
In-Reply-To: <20180130123931.50781-4-klaus.goger@theobroma-systems.com>
References: <20180130123931.50781-1-klaus.goger@theobroma-systems.com> <20180130123931.50781-4-klaus.goger@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Januar 2018, 13:39:30 CET schrieb Klaus Goger:
> Haikou is a Qseven and μQseven baseboard used in Theobroma Systems
> evaluation kits. This dts adds a version for use with a RK3368-uQ7 SoM
> called Lion.
> 
> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

applied for 4.17 after moving some things around and also fixing
some indentation issues.
