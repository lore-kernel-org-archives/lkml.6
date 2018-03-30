Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeC3LCp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 07:02:45 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:46551 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3LCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 07:02:43 -0400
Subject: Re: [PATCH] ARM: dts: da850-evm: Enable usb_phy, usb0 and usb1
To: Adam Ford <aford173@gmail.com>, <adam.ford@logicpd.com>
CC: Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1521476482-23335-1-git-send-email-aford173@gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <eec8a86a-13a6-34c2-c353-1cf6bf69e4e7@ti.com>
Date: Fri, 30 Mar 2018 16:32:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521476482-23335-1-git-send-email-aford173@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 March 2018 09:51 PM, Adam Ford wrote:
> The EVM kit has two USB ports.  This patch will enable both
> when booting with device tree.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied for v4.18

Thanks,
Sekhar
