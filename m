Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCWOVz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:21:55 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:57684 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeCWOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:21:42 -0400
Subject: Re: [PATCH 1/2] dt-bindings: clock: reset: Add AXG AO Clock and Reset
 Bindings
To: Philippe Ombredanne <pombredanne@nexb.com>
References: <20180209070026.193879-1-yixun.lan@amlogic.com>
 <20180209070026.193879-2-yixun.lan@amlogic.com>
 <CAOFm3uFj-7kZNp6b3SerOzQ8Amfa5Usod+MxwvZJ1E1Z_V9VJA@mail.gmail.com>
CC: <yixun.lan@amlogic.com>, Neil Armstrong <narmstrong@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>,
        "Carlo Caione" <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <dffeba58-1326-1dbd-38fc-c3b0f51d9c73@amlogic.com>
Date: Fri, 23 Mar 2018 22:06:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAOFm3uFj-7kZNp6b3SerOzQ8Amfa5Usod+MxwvZJ1E1Z_V9VJA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.159.118.39]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe

On 02/09/2018 07:07 PM, Philippe Ombredanne wrote:
> On Fri, Feb 9, 2018 at 8:00 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
>> Add dt-bindings headers for the Meson-AXG's AO clock and
>> reset controller.
>>
>> CC: <devicetree@vger.kernel.org>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  include/dt-bindings/clock/axg-aoclkc.h | 26 ++++++++++++++++++++++++++
>>  include/dt-bindings/reset/axg-aoclkc.h | 20 ++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
>>  create mode 100644 include/dt-bindings/reset/axg-aoclkc.h
>>
>> diff --git a/include/dt-bindings/clock/axg-aoclkc.h b/include/dt-bindings/clock/axg-aoclkc.h
>> new file mode 100644
>> index 000000000000..78683abb4247
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/axg-aoclkc.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD) */
> 
> nit... BSD is not a valid license id as documented in LICENSES [1] :
> please use one of these:
> BSD-2-Clause or BSD-3-Clause
> 
> Thank you!
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES/preferred
> 


  Thanks for the hint

  I'll update to BSD-3-Clause, since this license is just a copy from
previous gxbb-aoclkc.h file.

Yixun
