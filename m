Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBWLwl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:52:41 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:57770 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBWLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:52:39 -0500
Subject: Re: [PATCH v2 1/2] ARM: dts: da850-lego-ev3: Add node for reboot
 modes
To: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC: Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1515724191-30499-1-git-send-email-david@lechnology.com>
 <1515724191-30499-2-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <08386992-0df8-2db7-76d6-98bda137bb49@ti.com>
Date: Fri, 23 Feb 2018 17:21:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1515724191-30499-2-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 January 2018 07:59 AM, David Lechner wrote:
> This adds a new node for reboot modes on LEGO MINDSTORMS EV3. The EV3's
> bootloader looks for a magic number in the ARM local RAM and if found,
> it will boot into a special firmware update mode where the flash memory
> can be written via USB.
> 
> This has been testing working using the command:
> 
>     # systemctl reboot loader
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Added to v4.17/dt

Thanks,
Sekhar
