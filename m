Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeEKVOX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:14:23 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:53354 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:14:21 -0400
Date: Fri, 11 May 2018 14:14:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: James Hogan <jhogan@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 5/8] MIPS: jz4740: dts: Add bindings for the
 jz4740-wdt driver
Message-ID: <20180511211416.GA10947@roeck-us.net>
References: <5af5c20f.1c69fb81.e968b.17c0SMTPIN_ADDED_MISSING@mx.google.com>
 <20180511205413.GA18694@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180511205413.GA18694@jamesdev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 09:54:14PM +0100, James Hogan wrote:
> On Fri, May 11, 2018 at 01:17:04PM -0300, Paul Cercueil wrote:
> > Le 11 mai 2018 11:52, James Hogan <jhogan@kernel.org> a écrit :
> > > Otherwise 
> > > Acked-by: James Hogan <jhogan@kernel.org> 
> > >
> > > I'm happy to apply for 4.18 with that change if you want it to go 
> > > through the MIPS tree. 
> > 
> > Yes please!
> 
> Done
> 
Does that include the watchdog changes ? No problem with it, just asking to make
sure that those don't get lost.

Thanks,
Guenter
