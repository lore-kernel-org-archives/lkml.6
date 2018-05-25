Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965604AbeEYKNI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:13:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55268 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936026AbeEYKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:13:06 -0400
Date: Fri, 25 May 2018 12:12:55 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PM / suspend / s2idle: avoiding splats on RT
Message-ID: <20180525101255.htxgtjd3efunlfcq@linutronix.de>
References: <20180525094648.15464-1-bigeasy@linutronix.de>
 <CAJZ5v0j9hjASBOyrkCQ1CxF812THJZOHahJwpcmyC3XC4Fr6xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j9hjASBOyrkCQ1CxF812THJZOHahJwpcmyC3XC4Fr6xA@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-25 12:05:31 [+0200], Rafael J. Wysocki wrote:
> On Fri, May 25, 2018 at 11:46 AM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > Patch #1 is a repost with the s2idle bits included. I tested via
> >         echo s2idle > mem_sleep && echo mem > state
> >
> > and I woke up the machine via the power on button. Patches #2+ were
> > additionally required with s2idle.
> 
> I quite don't like the first one for reasons explained in the reply to it.
> 
> The others are fine by me and I can queue them up if you want me to do that.

Yes, please. I will talk to tglx regarding #1 and get back to you.

> Thanks,
> Rafael

Sebastian
