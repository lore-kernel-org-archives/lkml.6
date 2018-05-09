Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933476AbeEIBpR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:45:17 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:44862 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933223AbeEIBpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:45:14 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <ca3f3cd1a5038541a1168cd9ebe3481c>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>, shawn.lin@rock-chips.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] mmc: dw_mmc-bluefield: Add driver extension
To: Liming Sun <lsun@mellanox.com>, Will Deacon <will.deacon@arm.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525805210-15246-1-git-send-email-lsun@mellanox.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <6a25eb18-a2d3-8004-563c-2655287932df@rock-chips.com>
Date: Wed, 9 May 2018 09:45:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525805210-15246-1-git-send-email-lsun@mellanox.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/5/9 2:46, Liming Sun wrote:
> This commit adds extension to the dw_mmc driver for Mellanox BlueField
> SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> this SoC.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
