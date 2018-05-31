Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeEaEpU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:45:20 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:31997 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbeEaEpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:45:17 -0400
Subject: Re: [PATCH 0/9] clk: davinci: outstanding fixes
To: Michael Turquette <mturquette@baylibre.com>,
        David Lechner <david@lechnology.com>, Stephen Boyd <sboyd@kernel.org>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180525181150.17873-1-david@lechnology.com>
 <20180530200947.982.19495@harbor.lan>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <8f188ff5-50d1-f128-ecc5-d25edda325d4@ti.com>
Date: Thu, 31 May 2018 10:13:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530200947.982.19495@harbor.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 May 2018 01:39 AM, Michael Turquette wrote:
> Hi David,
> 
> Quoting David Lechner (2018-05-25 11:11:41)
>> This is a resend of all of the outstanding DaVinci clock patches plus one new
>> patch. All of the patches (except the new one) have been reviewed and tested
>> by someone other than me.
>>
>> The new patch ("clk: davinci: Fix link errors when not all SoCs are enabled")
>> should be fairly trivial.
>>
>> I am resending them all in one series to hopefully make it easier to get them
>> picked up by having them in the correct order to avoid merge conflicts. This
>> series is based on the clk/clk-davinci-psc-da830 branch.
> 
> I picked them all and pushed to clk/clk-davinci based on -rc1. There are
> some comments on the individual patches, all of which are of the "please
> revisit this and fix it up later" variety.
> 
> Going forward I'm happy for you and/or Sekhar to send clk PRs to Stephen
> and myself. The same rules apply for PRs: all patches need to be posted
> to the list the old fashioned way for review. But PRs make our lives a
> bit easier, especially when dealing with chip variants from the same SoC
> family like we have with davinci.

Thanks Mike! David is listed as maintainer for drivers/clk/davinci/* and
I believe he can be generating pull requests going forward. I can work
as the backup, of course.

Regards,
Sekhar
