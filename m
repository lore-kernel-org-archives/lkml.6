Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeB1Ajc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:39:32 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:37540 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeB1Aja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:39:30 -0500
X-Google-Smtp-Source: AG47ELt7RoQfIXa/q6+UUuSss2Z1hYO2Dly87HNCp6ezApKUkXJrbH3vE/b806cc1TxLabYyDMZ7/w==
Subject: Re: [PATCH] ARM: dts: NSP: Fix amount of RAM on BCM958625HR
To: Jon Mason <jon.mason@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE"
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180227010312.7495-1-f.fainelli@gmail.com>
 <CAC3K-4rqYMUBtbwaojWBF-0biEV-WSPpe=0bDocL4TUrrL4gGQ@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cf9e6bc5-094a-e658-cdd6-6495fbe99da6@gmail.com>
Date: Tue, 27 Feb 2018 16:39:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAC3K-4rqYMUBtbwaojWBF-0biEV-WSPpe=0bDocL4TUrrL4gGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 07:02 AM, Jon Mason wrote:
> On Mon, Feb 26, 2018 at 8:03 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> Jon attempted to fix the amount of RAM on the BCM958625HR in commit
>> c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
>> but it seems like we tripped over some poorly documented schematics.
>>
>> The top-level page of the schematics says the board has 2GB, but when
>> you end-up scrolling to page 6, you see two chips of 4GiB (512MB) but
>> what the bootloader really initializes only 512MB, any attempt to use
>> more than that results in data aborts. Fix this again back to 512MB.
>>
>> Fixes: c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Acked-by: Jon Mason <jon.mason@broadcom.com>

Applied to devicetree/fixes
-- 
Florian
