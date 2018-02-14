Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161718AbeBNSLY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:11:24 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:57690 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161606AbeBNSLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:11:22 -0500
From: Richard Weinberger <richard@sigma-star.at>
To: Enrico Weigelt <lkml@metux.net>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Date: Wed, 14 Feb 2018 19:12:33 +0100
Message-ID: <6753239.SmZu9LK57z@blindfold>
In-Reply-To: <794929ce-0ecb-4c93-d51e-e94fcf749cfa@metux.net>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net> <4042675.OEy7g9C5ya@blindfold> <794929ce-0ecb-4c93-d51e-e94fcf749cfa@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. Februar 2018, 19:01:52 CET schrieb Enrico Weigelt:
> On 14.02.2018 18:50, Richard Weinberger wrote:
> >> hmm, now it works, but only when strace'ing it.
> >> that's really strange.
> > 
> > On my box, with my patch applied, also busybox works now.
> 
> hmm, w/o strace, too ?

Sure.

> Which version are you using ? I've got 1.27.2

Both master and 1.12.x

BTW: Your issue is fixed/known. Just checked.

commit 1b510900e24459353922a1bc83c0b58bc8bafe1c
Author: Denys Vlasenko <vda.linux@googlemail.com>
Date:   Thu Nov 9 16:06:33 2017 +0100

    unshare: -r should map root to user, not the other way around
    
    Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
