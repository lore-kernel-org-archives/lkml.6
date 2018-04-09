Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeDIMY0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:24:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:38238 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeDIMYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:24:24 -0400
Date: Mon, 9 Apr 2018 06:24:22 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: Gergo Huszty <huszty.gergo@digitaltrip.hu>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixed typo in onewire generic doc
Message-ID: <20180409062422.40423c00@lwn.net>
In-Reply-To: <6472401523231809@web57o.yandex.ru>
References: <20171220190709.6584-1-huszty.gergo@digitaltrip.hu>
        <6472401523231809@web57o.yandex.ru>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Apr 2018 02:56:49 +0300
Evgeniy Polyakov <zbr@ioremap.net> wrote:

> Hi everyone
> 
> I'm really sorry for that long delay.
> 
> Was this patch accepted or should I push it upstream?
> 
> 20.12.2017, 22:09, "Gergo Huszty" <huszty.gergo@digitaltrip.hu>:
> > Onewire devices has 6 byte long unique serial numbers, 1 byte family
> > code and 1 byte CRC. Linux sysfs presents the device folder in the
> > form of familyID-deviceID, so CRC is not shown. The consequence is
> > that the device serial number is always a 12 long hex-string, but
> > doc says 13 in one place. This is corrected by this change.
> > Reference: https://en.wikipedia.org/wiki/1-Wire

Commit d6f44b3bd870ff5946fcd4293b4c07029d8d93c9, merged for 4.16.

jon
