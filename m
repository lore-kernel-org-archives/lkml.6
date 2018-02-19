Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbeBSSDY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 13:03:24 -0500
Received: from vern.gendns.com ([206.190.152.46]:51544 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753185AbeBSSDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 13:03:22 -0500
Subject: Re: [PATCH v2 0/2] Add reboot modes for LEGO MINDSTORMS EV3
To: linux-arm-kernel@lists.infradead.org
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1515724191-30499-1-git-send-email-david@lechnology.com>
From: David Lechner <david@lechnology.com>
Message-ID: <be3b9e55-a425-cf82-39e4-6ee625ece7fd@lechnology.com>
Date: Mon, 19 Feb 2018 12:03:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1515724191-30499-1-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2018 08:29 PM, David Lechner wrote:
> This series adds a new device tree node to declare a special memory
> address that is used by the I2C bootloader on LEGO MINDSTORMS EV3
> to boot into a special firmware update mode and enables the required
> module to use it.
> 
> v2 changes:
> * rebase on linux-davinci/master
> 
> David Lechner (2):
>    ARM: dts: da850-lego-ev3: Add node for reboot modes
>    ARM: davinci_all_defconfig: enable SYSCON_REBOOT_MODE
> 
>   arch/arm/boot/dts/da850-lego-ev3.dts   | 17 +++++++++++++++++
>   arch/arm/configs/davinci_all_defconfig |  1 +
>   2 files changed, 18 insertions(+)
> 

Hi Sekhar,

Any objection to pickup up this series? It is independent of all
of the other changes I have been working on.
