Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3347819-1519921241-2-6281207571210343317
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519921241; b=t13K/vnINQzbcYfMmRE1zoV/VvN/fgZxy5dfrLEc/3+po2M
    qHXAxckN7dUx7jUphP7GXmUoqi2oMhGmIftt1ENXdA/O1h3Tij6j9+QdzYmSwqHU
    qS2WVPHFQUfimzuZBM++OLwMTRhKB1G8HDa8tF4F7AEtAz69J5kHrJTH4L6smwo0
    GbT9GRb5QgMhcomAOTgiVIUgkRvXcn74BvwvopPXWPe5bm33+qd1TJuPpUyVRqzC
    h/DZRZbBXitZzh3qhUgveR7pd1hVdDS1xNjMMNadL1GChihlWFTB3qZMHUTNe5Q9
    gq4J2PK59atArkkh9OFt8zLI7TNVAqxGvOFg+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519921241; bh=s
    lovreTuHYTID0Ngyl9LUn2Wd3wQ+IkbBsBX20B45HI=; b=Y1/HybDElGmEgX4Ft
    q4k++lfSRQIlX/2fsYO1dZ/Qmyi4iS0iHk6vsWtSa9UDg8w1eaU2rwmey2L2Wb4G
    zgkvPclD++Q/VUMsUI4amY3a3pfz82HT8ZBzVF8ZaOU344wi8n6DVak6ro834sN3
    1vV78aD6B4HmmgrtbtIrO3iznIWOPvTxTYXPJsgGFqQqBJ8KdVsq2afs5H5WRffa
    oiGJ6T0s1bwz99l+KAOWG9dIo+SAc3dze+R5QzbQrWTKp+o61sTrYIyMW1leNngX
    P3nR0H5Rm2epjOCsBxLFYxrxIA6R5ZAxRgZUv+/p4RGyw/1Cdpg3nlniK5+y7WOY
    4XXDA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 1 Mar 2018 17:20:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 1/4] staging: most: Fix coding style problems.
Message-ID: <20180301162034.GA15087@kroah.com>
References: <20180224075835.11618-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180224075835.11618-1-quytelda@tamalin.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: devel@driverdev.osuosl.org, christian.gromm@microchip.com,
 chris@engineersdelight.de, linux-kernel@vger.kernel.org,
 Michael.Fabry@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 11:58:32PM -0800, Quytelda Kahja wrote:
> Makes two very minor changes indicated by checkpatch:
> 1) Add a newline after components_show() definition.
> 2) Fix a line over the 80 character limit.

Do not do multiple things in the same patch, whenever possible.  Please
break this up into 2 patches.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
