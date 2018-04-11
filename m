Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeDKGS0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:18:26 -0400
Received: from la.guarana.org ([173.254.219.205]:35088 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeDKGSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:18:24 -0400
Date: Wed, 11 Apr 2018 02:18:24 -0400
From: Kevin Easton <kevin@guarana.org>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        syzbot
        <bot+5022a34ca5a3d49b84223653fab632dfb7b4cf37@syzkaller.appspotmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in pfkey_add
Message-ID: <20180411061824.GA28791@la.guarana.org>
References: <001a114292fadd3e2505607060a8@google.com>
 <20180409040433.GJ685@sol.localdomain>
 <20180409055636.GA2551@la.guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409055636.GA2551@la.guarana.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 01:56:36AM -0400, Kevin Easton wrote:
> On Sun, Apr 08, 2018 at 09:04:33PM -0700, Eric Biggers wrote:
> ...
> > 
> > Looks like this is going to be fixed by
> > https://patchwork.kernel.org/patch/10327883/ ("af_key: Always verify length of
> > provided sadb_key"), but it's not applied yet to the ipsec tree yet.  Kevin, for
> > future reference, for syzbot bugs it would be helpful to reply to the original
> > bug report and say that a patch was sent out, or even better send the patch as a
> > reply to the bug report email, e.g.
> > 
> > 	git format-patch --in-reply-to="<001a114292fadd3e2505607060a8@google.com>"
> > 
> > for this one (and the Message ID can be found in the syzkaller-bugs archive even
> > if the email isn't in your inbox).
> 
> Sure, I can do that.

I recalled one reason I _didn't_ do this - the message ID is retrievable
from the archived email, but because the archive is Google Groups the
message recipients aren't (only masked).

    - Kevin
