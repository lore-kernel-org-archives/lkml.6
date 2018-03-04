Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeCDQhA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 11:37:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:53312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751893AbeCDQg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 11:36:57 -0500
Date: Sun, 4 Mar 2018 17:36:53 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.org>, Gerd Hoffmann <kraxel@redhat.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-arm-kernel@lists.infradead.org,
        Stefan Schake <stschake@gmail.com>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
Message-ID: <20180304173653.78adac53@naga.suse.cz>
In-Reply-To: <166274019.307112.1520085525833@email.1und1.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
        <20180214163649.3a0c9476@kitsune.suse.cz>
        <20180214165827.386b9bb1@kitsune.suse.cz>
        <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
        <20180214202454.6e7ebeaf@naga.suse.cz>
        <166274019.307112.1520085525833@email.1und1.de>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2018 14:58:45 +0100 (CET)
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> In a github issue, i've read that badblocks could reproduce the issue
> more likely.

How many iterations of badblocks? It doe snot reproduce the issue for
me.

Thanks

Michal
