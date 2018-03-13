Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2553705-1520926266-2-8391804268685729642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520926265; b=NdJ45O/qgOWYc6BKb59MdLWhR02uI51jyRRzlpF5kKn7XKT
    SvtbaU+U67oH8v89wwwlN0k9OkyUXSchTebcjLMgEFoJ28UuUjd7q9lg4DiAGOQb
    76SztQ/sWy8OvcRKItj38+QuFbQUUERkMHxWDsym1Dd/x2dZPmwT8JurOQz8tCZT
    xPDrRhMjNRMvP7qQzok5j3KwRy/7rO7blkf3AnKWNRJOF/asyFaNnSd8NIzuwbPI
    7+1fYv9emCY9utK5TY6Ltk4y3DOfCsVju1d17GSv1jXO2q0yXaQl7uJa0C5oFJuN
    oZmsXzzkIyqDNjieX6Vjip2znKMbj6P1FZgOAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520926265; bh=g
    2U4GUHj6upeMa/kxMaxOlJXoGK1IISEcUOWyrYI1Sw=; b=bKsUtqvkFr2TLJKrp
    zORI9TdPKuTIHsMNjk9ghz09ugN0bTrOUX7vvl5zDda4R2J91548Z7b55Eqx8YlY
    oAWztDqYJE8tSTCKPZh2ovF6SotAneWcoNee85SsZBmdb3LyVbKgvJBOlWKNzftO
    UJmZ2B2X3+KHv7y6D+Xu0AGGGJepDy8ZR/bwAyK38m7E1GiMantI7m473OjeNS4t
    R9Ov0367DE9qYNPTw97gQGEanKPlnroGWxJsFkXD9NQG+ggors0S0aYNqBv5KlzP
    qpGnaKaN25d2eEzyh7R9jcdrZZeocDOath3VAivFKz26m2JmS/xdOrMtdhJ167I6
    mByYw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,464,1515481200"; d="scan'208";a="12256380"
Date: Tue, 13 Mar 2018 13:00:51 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: <hariprasath.elango@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] staging: wilc1000: use pre-defined macro
 is_broadcast_ether_addr
Message-ID: <20180313130051.43b087dd@ajaysk-VirtualBox>
In-Reply-To: <20180312093903.9147-1-hariprasath.elango@gmail.com>
References: <20180312093903.9147-1-hariprasath.elango@gmail.com>
Organization: Microchip Techonology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Ganesh Krishna <ganesh.krishna@microchip.com>,
 aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>

On Mon, 12 Mar 2018 15:09:03 +0530
<hariprasath.elango@gmail.com> wrote:

> From: HariPrasath Elango <hariprasath.elango@gmail.com>
>

Please avoid use of 'From' tag specially when there is only one
'Signed-off-by' tag and its same.

> Use the kernel pre-defined macro is_broadcast_ether_addr() instead of
> doing a memcmp here.
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> ---

Regards,
Ajay
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
