Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeBUErs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 23:47:48 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34195 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeBUErq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 23:47:46 -0500
X-Google-Smtp-Source: AG47ELure/VQjDazgLTvyvOVJOtNCCXiMO5k+ZkWhbJhUBhhNyAbtcWqL1ddlryNSD3xG5HGMXHJ334lz+WgPhkflO4=
MIME-Version: 1.0
In-Reply-To: <20180219144905.bfrycjnas7dcuo34@rob-hp-laptop>
References: <1518701959-22899-1-git-send-email-tali.perry1@gmail.com>
 <1518701959-22899-2-git-send-email-tali.perry1@gmail.com> <CAFd5g44gBJp0-mYEWGdyiA67BCi2pZWAG2bYPS-WdJEwH1oA5A@mail.gmail.com>
 <20180219144905.bfrycjnas7dcuo34@rob-hp-laptop>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 20 Feb 2018 20:47:44 -0800
Message-ID: <CAFd5g44argF0oaOq7fOM0YbCBK5h8NyRia+H8CbRC5qAQHe5WA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] clk: npcm750: update text with fixed clocks
To: Rob Herring <robh@kernel.org>
Cc: Tali Perry <tali.perry1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Rick Altherr <raltherr@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Nancy Yuen <yuenn@google.com>, Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 6:49 AM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Feb 15, 2018 at 02:38:12PM -0800, Brendan Higgins wrote:
>> On Thu, Feb 15, 2018 at 5:39 AM, Tali Perry <tali.perry1@gmail.com> wrote:
>> >
>> > Signed-off-by: Tali Perry <tali.perry1@gmail.com>
>> >
>>  <snip>
>>
>> I think this should probably be rolled into [PATCH v2 1/1] npcm750: add fixed
>> clocks (moved from drivers/clk/clk-npcm7xx.c):
>> https://www.spinics.net/lists/arm-kernel/msg634678.html
>
> No, binding docs, dts files and driver code should all be separate
> patches.

My mistake. This patch has a dt-bindings include file; should the include file
go in here, with the dtsi changes, or in its own separate patch?

Thanks
