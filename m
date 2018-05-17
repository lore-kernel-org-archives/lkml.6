Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeEQQfA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:35:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33321 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeEQQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:34:59 -0400
X-Google-Smtp-Source: AB8JxZp2A2y7MJSH8tst/JeP5RONi/ArCH3jFJ7q4byIehwrBvvZOLMFJ49i6Oqj+6Gh9TV8dwo+nw==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 17 May 2018 12:34:56 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Stefan Wahren <stefan.wahren@i2se.com>
cc: Florian Fainelli <f.fainelli@gmail.com>, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <1412187220.62585.1526572780332@email.1und1.de>
Message-ID: <alpine.DEB.2.21.1805171233500.7984@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net> <1412187220.62585.1526572780332@email.1und1.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018, Stefan Wahren wrote:

> 
> > Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:
> > 
> > 
> > The a53 and a7 counters seem to match up, so we advertise a7 so that
> > arm32 can probe.

so how closely did you look at the a53/a7 differences?  I see some major 
differences, especially with the CPU_CYCLES event (0xff vs 0x11).

The proper fix here might be to add a cortex-a53 PMU entry to the armv7 
code rather than trying to treat it as a cortex-a7.

Vince
