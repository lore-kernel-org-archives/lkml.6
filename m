Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeBXKhx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 05:37:53 -0500
Received: from rgout0301.bt.lon5.cpcloud.co.uk ([65.20.0.207]:30543 "EHLO
        rgout03.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750905AbeBXKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 05:37:52 -0500
X-OWM-Source-IP: 81.132.46.76 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtfedrheejgddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtofgggfesthejredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpedtuddrohhrghenucfkphepkedurddufedvrdegiedrjeeinecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddufedv
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtfedrheejgddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtofgggfesthejredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpedtuddrohhrghenucfkphepkedurddufedvrdegiedrjeeinecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddufedv
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtfedrheejgddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtofgggfesthejredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpedtuddrohhrghenucfkphepkedurddufedvrdegiedrjeeinecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddufedv
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedtfedrheejgddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtofgggfesthejredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpedtuddrohhrghenucfkphepkedurddufedvrdegiedrjeeinecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddufedv
Message-ID: <1519468182.2469.7.camel@btinternet.com>
Subject: Re: [PATCH] selinux: fix typo in selinux_netlbl_sctp_sk_clone
 declaration
From: Richard Haines <richard_c_haines@btinternet.com>
To: Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Martin Kepplinger <martink@posteo.de>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Feb 2018 10:29:42 +0000
In-Reply-To: <CAHC9VhTVaogfgf-R=so5mtrh9i1Vy9bnNm5CENgKKDKnSeWjZw@mail.gmail.com>
References: <20180223211235.2402024-1-arnd@arndb.de>
         <CAHC9VhTVaogfgf-R=so5mtrh9i1Vy9bnNm5CENgKKDKnSeWjZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-23 at 16:25 -0500, Paul Moore wrote:
> On Fri, Feb 23, 2018 at 4:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > A missing 'struct' keyword caused a build error when
> > CONFIG_NETLABEL
> > is disabled:
> > 
> > In file included from security/selinux/hooks.c:99:
> > security/selinux/include/netlabel.h:135:66: error: unknown type
> > name 'sock'
> >  static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> > sock *newsk)
> >                                                                   ^
> > ~~~
> > security/selinux/hooks.c: In function 'selinux_sctp_sk_clone':
> > security/selinux/hooks.c:5188:2: error: implicit declaration of
> > function 'selinux_netlbl_sctp_sk_clone'; did you mean
> > 'selinux_netlbl_inet_csk_clone'? [-Werror=implicit-function-
> > declaration]
> > 
> > Fixes: db97c9f9d312 ("selinux: Add SCTP support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  security/selinux/include/netlabel.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Thanks, merged and pushed to selinux/next.
> 
> Richard was going to submit a patch for that, but I don't think he
> would mind you beating him :)

Don't mind at all. What I will do then is fix the problem highlighted
by [1] that affects "[PATCH V7 2/4] sctp: Add ip option support", I'll
issue a V8 asap.

[1] https://lists.01.org/pipermail/kbuild-all/2018-February/043695.html

> 
> > diff --git a/security/selinux/include/netlabel.h
> > b/security/selinux/include/netlabel.h
> > index 6ef4953431dc..8671de09c363 100644
> > --- a/security/selinux/include/netlabel.h
> > +++ b/security/selinux/include/netlabel.h
> > @@ -132,7 +132,8 @@ static inline void
> > selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
> >  {
> >         return;
> >  }
> > -static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> > sock *newsk)
> > +static inline void selinux_netlbl_sctp_sk_clone(struct sock *sk,
> > +                                               struct sock *newsk)
> >  {
> >         return;
> >  }
> > --
> > 2.9.0
> > 
> 
> 
