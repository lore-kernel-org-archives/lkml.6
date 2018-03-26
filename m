Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1424330-1522080513-5-14403678039681424707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522080512; b=BId7ldx53pGcYw5nE0syu3SxsXWStd3dFAMORGTn4cOJ0xp
    BxjYq+RtPYK8SFjm1sMaRngCdn095+xVSIwJIQdQHc6/jFsSzgmCFmKT80jIsgZZ
    fVTjxLuXJJ2tncvLIwRIVJux4HZ+K6pnb9XSrRTXnzV55QFXuuY38BzL+xbDXIWt
    2XD45oFOvglo1J+3rkXmkHnWgAOR/IhxUn6TKhcTBpjlovUXsO7O6iezYLpRrsL2
    8cKmz3zHiZ3alcgrWpOpnt+KQL1CV++Nb0jM65/AIGQ5QmUQXGBCZBzT3jozF7kP
    g0/Lw3LMFfoj+qiF3r+RUV00qZEQ5EqKCxdzp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:subject:from
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522080512; bh=N
    Bt1CmLlcVSGYRe6DaJb5YnvpngjGZnsnnmn+bBWS0g=; b=b4LcXruM8t1SYEDxR
    k1Z/Q/99NRsf6SABXS+7sEfdxApwL6LIJJx+bzq6+zz2JDXOBzLQgOTJR1/SwME2
    wBG19AJl6CauqW686/r15LWgPXmd1XdHuuhgOr4Ku85ysA5Uw/LcVc1DisKo/uAX
    5iQQPogDvF0GZl9aUSlK+7kpJJjewjRTAwkUkktiSM2llTrzRDYndU7nHGELWE4+
    dKaQKMPaK8Tr9+XqFcL9FxQyCwyNhVuv7ASk+MRkMrcsB12ET/eFbQ4RI+0FwekO
    nME7pjruELDnkRyhrIpdynwZvJgO9wBLCibbPdkp6BoGicOPdX2PK2e3qgnrICy4
    AX9JQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfErSs45oFo0P+zgmmF80Ms8EVLIXs+yLXBg8PAi11JxhU3RnebadSofq2ZSHMz1u2s7+dsSLGLhDGy0kGIh17y7MsqjVARhRoSHTVuaW/Ifda0MGi3em
    M6t1S5yGEMA0PhFWMT4/PEDFT5uPN9HsH9wqEQBzQtkOfNq4AaOg3wQwQ2zjopegBBzmWtavkN5Tx4Drshmc3XDg59ScrDPiY9GZntbb9/DYLDFASlFxSluu
    U7pyOtGVZ89yBKqwLBoR2w==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=IJv9LcIfAAAA:8 a=DDOyTI_5AAAA:8
    a=k67FR9TxJlSnfS4_WSkA:9 a=CjuIK1q_8ugA:10 a=cmr4hm9N53k6aw-X_--Q:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 26 Mar 2018 12:08:20 -0400 (EDT)
Message-Id: <20180326.120820.1903008086350362171.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH 4/4] drivers/net: Use octal not symbolic permissions
From: David Miller <davem@davemloft.net>
In-Reply-To: <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
References: <cover.1521845235.git.joe@perches.com>
 <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: dmitry.tarnyagin@lockless.no, alexandre.belloni@bootlin.com,
 linux-usb@vger.kernel.org, andrew@lunn.ch, alex.aring@gmail.com,
 linux-kernel@vger.kernel.org, paulus@samba.org, andy@greyhouse.net,
 f.fainelli@gmail.com, sthemmin@microsoft.com, stefan@osg.samsung.com,
 vfalico@gmail.com, xen-devel@lists.xenproject.org, jpr@f6fbb.org,
 wg@grandegger.com, j.vosburgh@gmail.com, haiyangz@microsoft.com,
 linux-can@vger.kernel.org, mostrows@earthlink.net, mkl@pengutronix.de,
 linux-hams@vger.kernel.org, boris.ostrovsky@oracle.com,
 linux-arm-kernel@lists.infradead.org, jgross@suse.com, wei.liu2@citrix.com,
 netdev@vger.kernel.org, oliver@neukum.org, nicolas.ferre@microchip.com,
 paul.durrant@citrix.com, linux-ppp@vger.kernel.org,
 devel@linuxdriverproject.org, linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joe Perches <joe@perches.com>
Date: Fri, 23 Mar 2018 15:54:39 -0700

> Prefer the direct use of octal for permissions.
> 
> Done with checkpatch -f --types=SYMBOLIC_PERMS --fix-inplace
> and some typing.
> 
> Miscellanea:
> 
> o Whitespace neatening around these conversions.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
