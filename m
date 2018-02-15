Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166380AbeBOSWz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:22:55 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:46717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163425AbeBOSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:22:52 -0500
Date: Thu, 15 Feb 2018 19:22:00 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        Gerd Hoffmann <kraxel@redhat.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1950058855.86123.1518718920111@email.1und1.de>
In-Reply-To: <20180214204733.7987d16c@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
 <F404E9C8-AE64-4B36-AD1B-911BD3C33946@gmail.com>
 <20180214204733.7987d16c@naga.suse.cz>
Subject: Re: [PATCH 2/2] mmc: bcm2835: print some informational messages
 during reset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev21
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:Q0Y0lXZamD40EiqFUsNON6Jep9X/jGzVg3Ja823izwfS1hP+aCB
 2ZRC78gYfff0UgYn0orAO87E02NnKdNxRfBEt6k8hzIzQeWEIbus+V60HxHRHHALIfdsFEg
 OrjXp0qh8t7/jjTGy14Q34GiXr24EJIPMLz5rapz0Bv7zOUGfJfq++7/RqN6kyprQfKIIJ4
 iE7YQVmyPvOvpRdxqxfTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9rGAQlD6LPg=:7G4IYsdEwivhQI61IzkjvZ
 BbLnDzj46ZGtPNQJv1/YRirrVM9WLFkgKZMJG0XbB/+C0jjzjjVfimYVJQ2EKMyMmEIOBoT3x
 g59YPbLJGAufJVCPK0+E0UHGqRGQ++XCveAgsdcxmhgk7U9aN03+nOPbFQDjqq/Yle3+Ny+dh
 hBQV9NcDTiN3tWaAvPqRlaMlGKUhk/I+vb9R0KQWjfi7xcmOjE7TyquHNlVRltHrHU6YyfC83
 p72Pfxa7XVQt4rkokFvhi2CxUx1P5Oi8zwUOEl49uRGttmKHHPAKGLJleun48cSaVoqnzCUAw
 kw4wGJ85Ifi98JbMSF3G7AWfv4FIy3L2inAbTuT6YYzcueNJXZYnoM+J7EoYY951kRCv8LmdP
 IG8yYpNxtR8qYghdYSuYuXdvu8LCe2FIVKwvl6J77Npn/VD3rKBts/+NtXrjwUaPl1anXF+c3
 qXgxWQa8qBrwylXyKqxNT4yVlVeCM1w+2Ej7WU5wpAndCh5beJvH5tvvy1+BZDOmWQVrlFq9K
 vPaUBXcpZfq3ya2eJ9FS5bp8QJqQvKoWP81qL8sWw1xKXxKqLzL/zdjT2i2cdi6uzMtaF+RM/
 mpIRE9lUfcwjGnOo3aA4LtDNA22ve4TaRyP2PB4ifEwQDgVV21yx5OwXAIGlaTn0LWzGS4kvf
 4Exdf+ppjW0ftXPwqzkRhdpYGsByVLwgY3GDx10LxWkERvZsZ981DcOBOypZ1BjyWaX55H46U
 oaa8q/nTTRpFdAtcP3d5OQOjbQ1RPCZ8n3Eg4X+BTFoWMZNHBdYRVpeRWu8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

> Michal Suchánek <msuchanek@suse.de> hat am 14. Februar 2018 um 20:47 geschrieben:
> 
> 
> On Wed, 14 Feb 2018 08:50:16 -0800
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> > On February 14, 2018 6:38:58 AM PST, Michal Suchanek
> > <msuchanek@suse.de> wrote:
> > >The previous patch does reset during hardware error so make the reset
> > >progress more visible.  
> > 
> > Based on your previous email it looks like this can happen quite
> > frequently so we might be spamming the kernel log with such reset
> > messages. Turning this into a debug print would not be great either,
> > how about a custom sysfs attribute counting the number of times a
> > reset was done?
> 
> Since every such message happens when the system stalls for like half a
> minute I don't think there will be that many until somebody notices
> something is amiss. It might be also helpful in diagnosing if other
> cards lock up in different way - for me the DMA shutdown is short so I
> guess it's the mmc host that is locked up and the DMA engine is fine.
> It might look differently on different systems, though.

FWIW according to your dmesg your RPi doesn't use the DMA engine:

[ 5.004609] sdhost-bcm2835 3f202000.sdhost: unable to initialise DMA channel. Falling back to PIO
[ 5.154518] sdhost-bcm2835 3f202000.sdhost: loaded - DMA disabled

For me it's a chicken and egg problem if the DMA driver is build as a kernel module.

Stefan

> 
> I understand that adding messages it somewhat controversial so I added
> them in separate patch.
> 
> Thanks
> 
> Michal
