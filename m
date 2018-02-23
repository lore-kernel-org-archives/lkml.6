Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBWLzT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:55:19 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:16321 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbeBWLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:55:17 -0500
Subject: Re: [PATCH v2 2/2] ARM: davinci_all_defconfig: enable
 SYSCON_REBOOT_MODE
To: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC: Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1515724191-30499-1-git-send-email-david@lechnology.com>
 <1515724191-30499-3-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <ce54ca3f-2bef-8001-19d9-6e493f92fed9@ti.com>
Date: Fri, 23 Feb 2018 17:24:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1515724191-30499-3-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 January 2018 07:59 AM, David Lechner wrote:
> This enables SYSCON_REBOOT_MODE as a module. This is used by LEGO
> MINDSTORMS EV3 to reboot into a special firmware update mode.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.17/defconfig

Thanks,
Sekhar
