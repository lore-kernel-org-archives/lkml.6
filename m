Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeCZSGD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:06:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33784 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751964AbeCZSGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:06:02 -0400
Date: Mon, 26 Mar 2018 20:05:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Satish Baddipadige <satish.baddipadige@broadcom.com>
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: NETDEV WATCHDOG: eth0 (tg3): transmit queue 0 timed out
Message-ID: <20180326180508.GE28372@pd.tnic>
References: <CA+oDAx8CCW8rUfdqSZJpKFzHUBocY_Q1xbJXB0y8qa6qP0iUAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+oDAx8CCW8rUfdqSZJpKFzHUBocY_Q1xbJXB0y8qa6qP0iUAg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 11:41:06AM +0530, Satish Baddipadige wrote:
> Can you please test the attached patch?

Well, the network connection just died with it. It didn't fire the
netdev watchdog but I still had to down and up eth0 in order to continue
using it. ssh connection into the box survived so I didn't have to login
again but it still died intermittently.

I'll keep playing with it to see if I'll catch some sort of splat...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
