Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeEHOxI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:53:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:35356 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932742AbeEHOxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:53:06 -0400
Date: Tue, 8 May 2018 08:53:02 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eric Anholt <eric@anholt.net>, linux-doc@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] doc: botching-up-ioctls: Make it clearer why structs
 must be padded
Message-ID: <20180508085302.3ce62ef4@lwn.net>
In-Reply-To: <20180502075106.7476-1-daniel.vetter@ffwll.ch>
References: <20180502075106.7476-1-daniel.vetter@ffwll.ch>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 May 2018 09:51:06 +0200
Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> This came up in discussions when reviewing drm patches.

Applied, thanks.

> Aside: I wonder whether we shouldn't move this to some other place and
> rst-ify it? Any good suggestions?

For the moment, probably in Documentation/process, next to
volatile-considered-harmful.rst and such.  Even better, of course, would
be to have some nice document on designing user-space APIs in general...
one can always dream ... :)

Thanks,

jon
