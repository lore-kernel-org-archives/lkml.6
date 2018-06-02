Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeFBOaM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:30:12 -0400
Received: from vern.gendns.com ([206.190.152.46]:58428 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeFBOaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:30:10 -0400
Subject: Re: [PATCH] clk: Return void from debug_init op
To: sboyd@kernel.org, Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180602050643.87253-1-sboyd@kernel.org>
From: David Lechner <david@lechnology.com>
Message-ID: <35a797de-35ec-ce65-64c4-8d2137b55c53@lechnology.com>
Date: Sat, 2 Jun 2018 09:29:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180602050643.87253-1-sboyd@kernel.org>
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

On 06/02/2018 12:06 AM, sboyd@kernel.org wrote:
> From: Stephen Boyd <sboyd@kernel.org>
> 
> We only have two users of the debug_init hook, and we recently stopped
> caring about the return value from that op. Finish that off by changing
> the clk_op to return void instead of int because it doesn't matter if
> debugfs fails or not.
> 
> Cc: Eric Anholt <eric@anholt.net>
> Cc: David Lechner <david@lechnology.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Acked-by: David Lechner <david@lechnology.com>
