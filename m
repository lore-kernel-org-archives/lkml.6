Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeDGRAm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 13:00:42 -0400
Received: from rgout0804.bt.lon5.cpcloud.co.uk ([65.20.0.151]:6916 "EHLO
        rgout0804.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751499AbeDGRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 13:00:40 -0400
X-OWM-Source-IP: 86.134.200.89 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtgedrhedtgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedrvddttddrkeelnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrddvtddtrdekledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtgedrhedtgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedrvddttddrkeelnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrddvtddtrdekledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuvehluhhsthgvrhfuihiivgepie
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtgedrhedtgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedrvddttddrkeelnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrddvtddtrdekledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtgedrhedtgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudefgedrvddttddrkeelnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrddvtddtrdekledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuvehluhhsthgvrhfuihiivgepvd
Message-ID: <1523120055.31267.13.camel@btinternet.com>
Subject: Re: [GIT PULL] SELinux patches for v4.17
From: Richard Haines <richard_c_haines@btinternet.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>, Xin Long <lucien.xin@gmail.com>
Cc: selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sat, 07 Apr 2018 17:54:15 +0100
In-Reply-To: <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
         <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-06 at 16:07 -0700, Linus Torvalds wrote:
> On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com>
> wrote:
> > 
> > Everything passes the selinux-testsuite, but there are a few known
> > merge conflicts.  The first is with the netdev tree and is in
> > net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully
> > Stephen
> > Rothwell has already done the heavy lifting in resolving the merge
> > for
> > you, and the SCTP folks have given his merge patch a thumbs-up.
> 
> I ended up re-doing the merge, and it looks like some more sctp
> changes happened after Stephen's merge anyway, so mine didn't end up
> quite like his.
> 
> Adding Xin Long to see if he can verify it again, but it all *looks*
> sane.
> 
> While looking at it, it struck me that the new security hooks don't
> seem to hook into __sctp_connect(), which also does that
> 
>                         scope = sctp_scope(&to);
>                         asoc = sctp_association_new(ep, sk, scope,
> GFP_KERNEL);
> 
> thing. Is that intentional? The sendmsg case does that
> security_sctp_bind_connect, the actual __sctp_connect() does not.
> 
> This is not because I screwed up the merge - it's that way in the
> SELinux tree too. And I obviously _left_ it that way, but while doing
> the merge and trying to understand what was going on, this struck me.
> 
> I'm probably missing something really obvious why the connect case
> doesn't want to do it thgere.
> 
> NOTE! I do see it being done in __sctp_setsockopt_connectx(). But
> __sctp_connect() has another caller (in sctp_connect()) which doesn't
> have that security_sctp_bind_connect() call.
> 
> So please check my resolution, but also somebody should tell me
> "Linus, you're a cretin, sctp_connect() doesn't want that
> security_sctp_bind_connect() at all because it was already done by
> XYZ"
> 
>                  Linus

Thought I would answer the questions as I wrote the SELinux/SCTP
patches.

sctp_connect() or __sctp_connect() do not need to call
security_sctp_bind_connect(). This is because the connect(2) call will
handle the checks required via security_socket_connect():

       connect(2)
          |
 SYSCALL_DEFINE3(connect, ....)
          |
   security_socket_connect()
          |
     sctp_connect()

SCTP uses security_sctp_bind_connect() as this can handle one or more
addresses for either sctp_connectx(3) or sctp_bindx(3). It is also used
for handling the sendmsg(2) and sctp_sendmsg(3) calls in SCTP for a new
association (that is effectively a "connect").

Hope this helps

Richard

> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
