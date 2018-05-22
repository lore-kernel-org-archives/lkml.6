Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeEVWa2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:30:28 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42161 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbeEVWa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:30:26 -0400
X-Google-Smtp-Source: AB8JxZrI6+8xhtGP49HN0n9nqMQMhXNupIsg9NJrfS0r3oxy+9Lzs4CiLvFo6Bk8NMQ7WvyFFiyXkw==
Date: Tue, 22 May 2018 17:30:24 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Doug Berger <opendmb@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
        <bcm-kernel-feedback-list@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] soc: bcm: brcmstb: pm: Add support for newer rev
 B3.0 controllers
Message-ID: <20180522223024.GA7817@rob-hp-laptop>
References: <20180511220242.837-1-f.fainelli@gmail.com>
 <20180511220242.837-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511220242.837-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 03:02:41PM -0700, Florian Fainelli wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> Update the Device Tree binding document and add a matching entry for the
> MEMC DDR controller revision B3.0 which is found on chips like 7278A0
> and newer.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> [florian: tweak commit message, make it apply to upstream kernel]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt | 1 +
>  drivers/soc/bcm/brcmstb/pm/pm-arm.c                        | 4 ++++
>  2 files changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

Side note: this should really move out of bindings/arm/ to 
bindings/memory-controllers/ or at least to its own file.

Rob
