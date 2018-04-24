Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDXRZW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:25:22 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35591 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeDXRZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:25:16 -0400
X-Google-Smtp-Source: AB8JxZoEvKzC+VAwd6x7yhW+AZHaomTH8sEP9MyA5euJJNDXd7sHcuhyD2foijIa/lpuQNdm6Pv/ZQ==
Date: Tue, 24 Apr 2018 19:25:13 +0200
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: dav.lebrun@gmail.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 1/2] ipv6: sr: add a per namespace sysctl to control
 seg6 flowlabel
Message-Id: <20180424192513.113ec48f44792cad25eeffba@gmail.com>
In-Reply-To: <20180424.131650.2276839479783300009.davem@davemloft.net>
References: <1524519420-1612-1-git-send-email-amsalam20@gmail.com>
        <20180424.131650.2276839479783300009.davem@davemloft.net>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.21; x86_64-apple-darwin10.8.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 13:16:50 -0400 (EDT)
David Miller <davem@davemloft.net> wrote:

> From: Ahmed Abdelsalam <amsalam20@gmail.com>
> Date: Mon, 23 Apr 2018 23:36:59 +0200
> 
> > This patch adds a per namespace sysctl, named 'seg6_flowlabel', to be used
> > by seg6_do_srh_encap() to control the behaviour of setting the flowlabel
> > value of outer IPv6.
> > 
> > The currently support behaviours are as follows:
> > -1 set flowlabel to zero.
> >  0 copy flowlabel from Inner paceket in case of Inner IPv6 (0 for IPv4/L2)
> >  1 Compute the flowlabel using seg6_make_flowlabel()
> > 
> > Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
> 
> There really isn't a reason to make this a separate patch.
> 
> Adding a sysctl that nothing refers to doesn't add much value.
> 
> So please combine patches #1 and #2.

Ok, I will combine them and send you a new patch. 

Thanks

-- 
Ahmed Abdelsalam <amsalam20@gmail.com>
