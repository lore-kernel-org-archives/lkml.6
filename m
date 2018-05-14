Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeENKGL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:06:11 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:47543 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeENKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:06:09 -0400
Subject: Re: [PATCH] ARM: dts: da850-lego-ev3: remove unnecessary gpio-keys
 properties
To: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC: Kevin Hilman <khilman@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180512214159.22041-1-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <95feb477-cd17-54e2-4a99-62a8a5e6f993@ti.com>
Date: Mon, 14 May 2018 15:34:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512214159.22041-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 May 2018 03:11 AM, David Lechner wrote:
> This removes the #address-cells and #size-cells properties from the
> gpio-keys node in the da850-lego-ev3 device tree. These properties are
> not needed since the child nodes don't have a reg property.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.18/dt. Its too late to sent W=1 warning fixes for v4.17 cycle.

Thanks,
Sekhar
