Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754376AbeEaJwZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:52:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:13589 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754356AbeEaJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:52:22 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN1FzaY"
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/8] gnss: add new GNSS subsystem
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180531085242.GE3259@localhost>
Date: Thu, 31 May 2018 11:52:18 +0200
Cc: Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Message-Id: <943C21CA-EEC6-45E2-997E-A6E1FA0549EB@goldelico.com>
References: <20180530103242.20773-1-johan@kernel.org> <20180530143822.lvtwjvbqe7gvbvgq@localhost> <20180531085242.GE3259@localhost>
To: Johan Hovold <johan@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4V9r6GO000605


> Am 31.05.2018 um 10:52 schrieb Johan Hovold <johan@kernel.org>:
> 
> On Wed, May 30, 2018 at 07:38:22AM -0700, Richard Cochran wrote:
>> On Wed, May 30, 2018 at 12:32:34PM +0200, Johan Hovold wrote:
>>> Another possible extension is to add generic 1PPS support.
>> 
>> There are two possibilities to consider.
>> 
>> 1. If the PPS causes an interrupt, then it should hook into the PPS
>>   subsystem.
> 
> Registering a PPS child device is what I had in mind for this.

This seems to be duplicating functionality that is already solved by

https://elixir.bootlin.com/linux/v4.17-rc7/source/Documentation/devicetree/bindings/pps/pps-gpio.txt

and

https://elixir.bootlin.com/linux/v4.17-rc7/source/drivers/pps/clients/pps-gpio.c

Or what is bad with just using that?

BR,
Nikolaus
