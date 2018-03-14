Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeCNXmh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:42:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42334 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeCNXme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:42:34 -0400
X-Google-Smtp-Source: AG47ELtmJjS0rHhWrd7PeW0ORyQFdNrzVc3dQW8XTv63dUm+sTm5n9oKNZz8mJr7LG3pwUlQ+8weXQ==
Date: Wed, 14 Mar 2018 16:42:31 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] thermal: exynos: sanitize DeviceTree support
Message-ID: <20180314234230.GA9784@localhost.localdomain>
References: <CGME20180306144427epcas1p3bd260e382c61ab5176a50aa95084b542@epcas1p3.samsung.com>
 <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 06, 2018 at 03:43:43PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Values passed through DT properties specific to Exynos thermal
> driver ("samsung,*") are SoC (not platform) specific so just
> define them in struct exynos_tmu_data instance (or just use
> constants where values are identical for all SoCs) and remove
> "samsung," DT properties altogether.
> 
> The patchset should not cause any functionality changes.  This
> means that unless there are some bugs in the patches itself there
> should be no behavior changes for the driver (this also includes
> lack of changes in the way hardware is accessed by the driver).
> 
> Tested on Exynos5422 based Odroid-XU3 Lite board.

applied this series. except for patch 10, which should go through your
arch tree.

Thanks.

> 1.9.1
