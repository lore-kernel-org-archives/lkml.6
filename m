Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeCDHVa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 02:21:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeCDHV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 02:21:28 -0500
Date: Sun, 4 Mar 2018 08:21:20 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Frank Rowand <frowand.list@gmail.com>
cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ivan Gorinov <ivan.gorinov@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        laurent.pinchart+renesas@ideasonboard.com
Subject: Re: [PATCH] x86: devicetree: fix config option around
 x86_flattree_get_config()
In-Reply-To: <cd3d7bd4-5235-2c1a-b22b-a3a3756d6704@gmail.com>
Message-ID: <alpine.DEB.2.21.1803040820510.1654@nanos.tec.linutronix.de>
References: <1520050346-1333-1-git-send-email-frowand.list@gmail.com> <4284204.nJkDQ6O5Aj@avalon> <cd3d7bd4-5235-2c1a-b22b-a3a3756d6704@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2018, Frank Rowand wrote:
> I sent this patch to the x86 maintainers and to Rob because of a patch
> series that is modifying arch/x86/kernel/devicetree.c, in
> x86_flattree_get_config() [1].  It does not look like my patch will
> conflict with that patch at the moment, but it is possible that a conflict
> could develop as that patch is developed.

Even if it conflicts, its trivial enough ....
