Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeCDSP7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 13:15:59 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCDSP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 13:15:57 -0500
Date: Sun, 4 Mar 2018 19:15:15 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
        Stefan Schake <stschake@gmail.com>, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.org>, Gerd Hoffmann <kraxel@redhat.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1331293394.179376.1520187315077@email.1und1.de>
In-Reply-To: <20180304173653.78adac53@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
 <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
 <20180214202454.6e7ebeaf@naga.suse.cz>
 <166274019.307112.1520085525833@email.1und1.de>
 <20180304173653.78adac53@naga.suse.cz>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:ZVDSBRoXjiNvQhrytTT4Nby6xLilL86PkqyCLpJ7+542Wt+pwqJ
 11hhLqfQ5AhaljFXTaLGs40uLFJDE3S/98wISf+oPHEH3NjqyogINiWYJBbx9HDwlFvcQ+y
 UGeRHDFLe0/rNnV1YE8TNwL2WSw83rnTIsS922tiwjQqW19i8dvjFH/Cka03xCf7SsZUhNC
 VF9+4Q4bNPHjobCyZBqwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Him7Rh5YQY=:7oZD6/1HJ5cB/WDEl3vSTS
 h0XXu5UE441sQas+jaKtP8MAEjSgWrf1w6ylqo0vCstJtVNsG2x0gwfG51rIGdY7W4saDfcga
 VPHjbpDIla6pOd0uXCe60FzALI1CZ4uwyYBlA1/4j+jDJqDK4GLNXecB7pQaGVT+Nrw/d88x1
 wYdbQ40nnKz1IPl+VjmKYvpbyZghcgoz2IJI9BR5J+9Cg6SujwapN8s4YcwgqzzX85HFAMsTo
 Ld/6pCgKSITfgZgFf4a7gFLJj5nEsY12MWc96hL7pLsahxG4eWcslAEVVJCyj9SX2bo3aICgt
 dbMeylnQlbZjbOTT0+YmcAPNcLwYfYPaA5dCb+I3QH6n2k5E2qxldiCz+ALJPDUyImCI+fUHo
 Yy/PuaAIF2FVE65Z/OUyE39ypI50+CEsx6+Lq2j3XVf6thEJDns0tifLCq6Nl32celXT4I3lk
 ArxIHGpd+ePe6vMqau0JYxoYOT1a59RPvfZ0u009e1oJiiNppvONsO+/LPWqKrHp3JuDohGEK
 X7hLGZekvOVHFXubUKAwWNN9qnRij6Dsq7ocF3unc4GIOpIY8d+pIUeD7qYwqeHcEo9kN/S5C
 OcrNL9dYlDF3n6d87WAXcwjQi+9qHhRWLszrdQ77uDDX4J98ovHemKskkFIfwQF3DARyF+bUw
 pEyIm0hYfIpmbEngnxeMV3yOzSgZ0z6p8SLjczHaogz4I6H6Ui0HW3ncU96VS6geb3BCJnFI2
 BspI5VIEBMHsnXNeVNWv/+yMyEyGDsekH2iWTQ9KelrOoDXevHm46wnaJXk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

> Michal Suchánek <msuchanek@suse.de> hat am 4. März 2018 um 17:36 geschrieben:
> 
> 
> On Sat, 3 Mar 2018 14:58:45 +0100 (CET)
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > In a github issue, i've read that badblocks could reproduce the issue
> > more likely.
> 
> How many iterations of badblocks? It doe snot reproduce the issue for
> me.

i asked for the parameters here:

https://github.com/raspberrypi/linux/issues/2392

Stefan

> 
> Thanks
> 
> Michal
