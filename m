Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968406AbeE2WTa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:19:30 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41081 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967660AbeE2WTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:19:25 -0400
X-Google-Smtp-Source: ADUXVKKg9qEgTDMIGfcs0Xcot3eyVtYHDVIAN2NBkq9u5qmIoALbz6/zq1ePzQLhf72qkNHnPy5CyA==
Subject: Re: [PATCH 0/2] Add Broadcom Stingray PCIe PHY support
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1526495010-2478-1-git-send-email-ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <e7f93dd7-32b1-1b14-8391-0938fd9e0c2d@broadcom.com>
Date: Tue, 29 May 2018 15:19:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526495010-2478-1-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Have you had a chance to review the following patch series?

Regards,

Ray

On 5/16/2018 11:23 AM, Ray Jui wrote:
> This patch series adds PCIe PHY support for both PAXB and PAXC root complex in
> Broadcom Stingray SOC
> 
> This patch series is based off v4.17-rc5 and is available on GIHUB:
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: sr-pcie-phy-v1
> 
> Ray Jui (2):
>    dt-bindings: phy: Add binding doc for Stingray PCIe PHY
>    phy: bcm-sr-pcie: Add Stingray PCIe PHY driver
> 
>   .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   |  39 +++
>   drivers/phy/broadcom/Kconfig                       |  10 +
>   drivers/phy/broadcom/Makefile                      |   2 +
>   drivers/phy/broadcom/phy-bcm-sr-pcie.c             | 306 +++++++++++++++++++++
>   4 files changed, 357 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
>   create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c
> 
