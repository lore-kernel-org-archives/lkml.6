Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeCPDLx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 23:11:53 -0400
Received: from vern.gendns.com ([206.190.152.46]:56164 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbeCPDLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 23:11:51 -0400
Subject: Re: [PATCH v8 12/42] clk: davinci: Add platform information for TI
 DA850 PSC
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-13-git-send-email-david@lechnology.com>
From: David Lechner <david@lechnology.com>
Message-ID: <6cf9d57c-206b-7295-f595-87a2205e289d@lechnology.com>
Date: Thu, 15 Mar 2018 22:11:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521168778-27236-13-git-send-email-david@lechnology.com>
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

On 03/15/2018 09:52 PM, David Lechner wrote:
> This adds platform-specific declarations for the PSC clocks on TI DA850/
> OMAP-L138/AM18XX SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> ---
> 

This Reviewed-by: was supposed to be dropped. This file has had some significant
changes.
