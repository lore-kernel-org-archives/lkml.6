Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AH8x226vztaP9Wm+sEADXmDScIgrlCC8Ylb8/pzqzq92qUMB2pcPxASTCSEXvXuA14Jrcyfgm+8q
ARC-Seal: i=1; a=rsa-sha256; t=1518878262; cv=none;
        d=google.com; s=arc-20160816;
        b=K+2xS7CewG+d61H4B2EXKjYNJ9NkObCl5PxvD8bP3KAxLSQSvk7S3dE1lGVVlnkPTb
         R41OcKeq6CYR47Yfn1ACgDdD4HTES7SfDhIXNBdQPb754AcSXEVXyhlmAojlftdiFkHi
         xv9nwTbg9DTnRUbIwEVzhxwpm/b65enPVTeo/oEjMkDgdkawMvLUWoDpED1mKPsgW5vn
         20GWtTu38rwFw62qMr4ymh+HRa5CamR2jXm5VJBMN2sTqSmbn+u5ehVPlFY8okDmj41r
         cG1BDJTTsmnCcYZjMXeq2P1zNCw2Md0yzyGa3Rjkib6rO600RZZ63YsmVyNl+ZOChv5F
         TUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=yGq6HICsQdFqwLnaYSsJSGd/GDGxpRgjB7KVhOMu9eE=;
        b=GgXVGhW9F11CPFkh/6JMJM6i9rFMsgydE7uXYPo071grnoOjOr5wHM9maWOGj9ISWD
         f/YJ01C8xYtSCisRrk92wm9NmwBomO222ZqSSaDzgVdNq8mxk+XF2OYk3GtTMYwacvMP
         MFOQPYsBl/DzKoUTqZQ2dhd4UAFvU1PDSROhslaBxCeFfy7QvXUZY16WOCV+NyiIfWt2
         ufSvXVpBgN89CraqEQsJaq07BCautb82IXLLDGEVxCsG906FLZwrkNW2Wl1YpBQwNf/W
         N8kXc8hkINKLcPOT7YLyjJrZBtc2Z1AZyXh/kxdd3eDsfuTDmJboUwW0b+6klTQ1muzo
         WUVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.46,525,1511823600";
   d="scan'208";a="314057946"
Date: Sat, 17 Feb 2018 15:37:41 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Ed Cashin <ed.cashin@acm.org>
cc: Aishwarya Pant <aishpant@gmail.com>, linux-kernel@vger.kernel.org,
    Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] aoe: document sysfs interface
In-Reply-To: <9ddc04c5-eedf-b88a-0cea-bd0c91a2dfcc@acm.org>
Message-ID: <alpine.DEB.2.20.1802171537240.2205@hadrien>
References: <20180216153900.GA12832@mordor.localdomain> <9ddc04c5-eedf-b88a-0cea-bd0c91a2dfcc@acm.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592572558446163401?=
X-GMAIL-MSGID: =?utf-8?q?1592659292950713748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Fri, 16 Feb 2018, Ed Cashin wrote:

> On 02/16/2018 10:39 AM, Aishwarya Pant wrote:
> > Documentation has been compiled from git commit logs and descriptions in
> > Documentation/aoe/aoe.txt. This should be useful for scripting and
> > tracking changes in the ABI.
> ...
> > +What:		/sys/block/etherd*/netif
> ...
> > +Description:
> > +		(RO) The name of the network interface on the localhost
> > through
> > +		which we are communicating with the remote AoE device.
>
> I'd recommend changing that to, "network interfaces".

Should it then be "names"?

julia
