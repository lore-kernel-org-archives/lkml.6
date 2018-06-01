Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeFARR4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:17:56 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.132]:34161 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeFARRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:17:54 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBi5Qpz9LpBMKaNaHMpOKE="
X-RZG-CLASS-ID: mo05
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
From: "H. Nikolaus Schaller" <hns@computer.org>
In-Reply-To: <20180601162645.GA30792@amd>
Date: Fri, 1 Jun 2018 18:37:36 +0200
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3A356534-FEB0-4E0D-A8C8-922EEF1E0926@computer.org>
References: <20180601082259.17563-1-johan@kernel.org> <20180601093311.GA31639@amd> <20180601094959.GA13775@localhost> <20180601102612.GC31639@amd> <20180601122217.GB13775@localhost> <20180601162645.GA30792@amd>
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> Am 01.06.2018 um 18:26 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> NMEA would not be my first choice, really. I'd propose something very
> similar to existing /dev/input/eventX, but with wider data types.

Since even Rome wasn't built in a day, my first choice is NMEA, but I am
open to anything on higher level to come second.

What about iio?

It is quite flexible and extensible and GNSS coordinates are a not very
different from accelerometer, gyroscope or compass data as all of them
describe the position and orientation, maybe speed of the device these
things are built into (at least for mobile devices).

--hns
