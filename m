Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeBSOr5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:47:57 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:54650 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752890AbeBSOry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:47:54 -0500
Subject: Re: [PATCH v2 0/5] Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
 <CACRpkdbBA0DX22ZGSkQxi+euTSROPzsmLTvSPwY8peg6+7igFQ@mail.gmail.com>
 <20180131022151.GA14668@sophia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <02989234-6b1c-0118-2a38-a600fb892f11@maciej.szmigiero.name>
Date: Mon, 19 Feb 2018 15:47:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180131022151.GA14668@sophia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 31.01.2018 03:22, William Breathitt Gray wrote:
> On Tue, Jan 02, 2018 at 10:29:30AM +0100, Linus Walleij wrote:
>> On Fri, Dec 29, 2017 at 9:13 PM, William Breathitt Gray
>> <vilhelm.gray@gmail.com> wrote:
>>
>>> Linus, please pickup this entire patchset through your GPIO subsystem
>>> tree; a recursive dependency error is present if these patches are
>>> cherry-picked (see https://lkml.org/lkml/2017/12/26/235), so they should
>>> be merged together in the same tree.
>>
>> OK I just need a bunch of ACKs so giving subsystem maintainers some
>> days to come back on this.
>>
>> Yours,
>> Linus Walleij
> 
> Hi Linus,
> 
> Do you have any objections to picking up this patchset now; or would you
> prefer to wait for some more input from the other maintainers?
> 
> William Breathitt Gray
> 

Anything still blocking this patchset?
It is a pure Kconfig change, however it has been waiting nearly
2 months now...

Maciej
