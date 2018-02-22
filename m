Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-171462-1519307068-2-15960017412490686289
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519307068; b=cl6yvjkVp5gggFtyjjG+9nsqHkmljcShFFHmeWMM63L7ZSo
    JPwFoBP0UbAukfAbFTMHAgvWHcY/yu3GUejkerIUcUeV0irMUBcF7klei5+xP6k3
    tqh9ymuiSliGy9wJvAB6pwNVSLlf+1jecyuhuxXUAqaKQrPN2q55fi6T7NQKPQyJ
    HAh0+UC0J7azqsYMN39UHHqZzdTkhIVjeCDBfMRtv6bvo9axF0RW7cIl1ZzSU2Pa
    N2DYqamIbnWACA52ykmvP1K55wacHEPIC5aslyZaMPzC6zS9fvcXRCQdqoE8bx9Z
    vcIKfVkc1cA6n4xfc1MKM3VHHfFMDkLe8FmujtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519307068; bh=F
    Ew9N8kbrrxMYMM4xiqrzp3RnlUVL4cAWindRpMCDGs=; b=GMsKfqnNa+b9+c/cO
    MRGJuIBzRWo3Ic8Ps5vBTGl0d/CV0t+mLMMQd5Gyj0vhFY3iprgeU8h2QYFOsvXo
    Y6o09MzUuU26yqEOmA1r11SSBbgPEe73KZ3EpYop6g3GU2SY2BsL82n46Cc7qp0e
    eAUHkWIwHMiXC1CN/Nhe6OLGfQBETYidNI2UFC3o5VkOUgRVpeXPr91UlinWnOFI
    BFyV39dw6/xJbb70r1zoEWI/hndPJHh8DAUJmOvqPjTbLLoG1Sb19pBMXn8m8A3F
    V8BGZaWi0lEz3iIWtrwASj8WzRdFHhZCKukZe3a+nVc5ENlOEdKHlH3Aj9Rp5X1x
    fps3w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 22 Feb 2018 14:44:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Staging: gdm724x: hci: Changed camel-case to snake-case.
Message-ID: <20180222134421.GA19182@kroah.com>
References: <20180221103928.19599-1-quytelda@tamalin.org>
 <20180221104558.r7qgxyqshy37gej6@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180221104558.r7qgxyqshy37gej6@mwanda>
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
Cc: devel@driverdev.osuosl.org, jonathankim@gctsemi.com,
 linux-kernel@vger.kernel.org, deanahn@gctsemi.com,
 Quytelda Kahja <quytelda@gmail.com>, Quytelda Kahja <quytelda@tamalin.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:45:58PM +0300, Dan Carpenter wrote:
> On Wed, Feb 21, 2018 at 02:39:28AM -0800, Quytelda Kahja wrote:
> > Changed a variable name from camel to snake case to fix a coding style
> > issue.
> > 
> > Signed-off-by: Quytelda Kahja <quytelda@gmail.com>
> > ---
> >  drivers/staging/gdm724x/hci_packet.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/gdm724x/hci_packet.h b/drivers/staging/gdm724x/hci_packet.h
> > index 22ce8b9477b6..f8837c7103ac 100644
> > --- a/drivers/staging/gdm724x/hci_packet.h
> > +++ b/drivers/staging/gdm724x/hci_packet.h
> > @@ -50,7 +50,7 @@ struct tlv {
> >  struct sdu_header {
> >  	__dev16 cmd_evt;
> >  	__dev16 len;
> > -	__dev32 dftEpsId;
> > +	__dev32 dft_eps_ID;
> 
> I bet this is a part of the user space ABI or there is a specific reason
> for the name to match the spec or something so it can't be changed...

This structure is not even used anywhere :(

Quytelda, can you just remove all unused structure definitions from this
driver?  That would be a much better patch here instead of changing a
structure field that no one uses.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
