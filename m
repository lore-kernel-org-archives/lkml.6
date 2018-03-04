Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2727825-1520170806-2-2435407706507051363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520170806; b=KSgD2N9ARzlD5RbEgld+gwKRF9eB4cg/qZ6/u0aR1SSXhWu
    0622BREn3yRFm+ZgB7gRh2u5NK/5QE3noZiRCzUyinc+p5RX3+ubStxLoa/JtmOf
    N2uox8pPKzbdfBXPFE3kzeX0hlRix2FWj4guMkgrZmBCTgmDce4ARk/OiEbqECTd
    odOb79AXwnYtpvSXWgC0t8rxwbTSO5rrOXCOII1LhOEbbhDIzRi8wQGTqyIOWHYb
    WYEF71wuZYIOgK3AMKOsX/MQ49cPtwcwv4tnxnJTF1p2TnbYlrIKOZIDuAhjTZ3P
    hP3VCJTEMkVZknybxLcLD93Gx3sUCNIvzywGrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520170806; bh=s
    R55mXpWY9cQZLSdssxC8guS4jB1kgxKDoZ/x+7+7nM=; b=ATV3JtKMo9/tnsO9o
    1aItcexDT89c4skpnU0phK9VE2ekj2BXSt57wdEJjDSRdqBMFxDTjI9j8S8JmR31
    MTSodWpYIe+YM4zgouyZe3qKEf1M9DLUIOPEVfEwD2B6xfJQwRUNrK75lIdUzGWE
    BpxpFvAMOudbY7tA1vegq6UFKYgM39VynmggMnq41PqwYQcVGef8EihCMHqeYEna
    N6bMxIxBP2EVQ/XV/IOCTFUth52uWLb8ZI4BR61+qBDkXnPu8n38hmnveGhUN/j9
    aa8u+Tlr9vWt8GMvh6GPvZaFkMxrLDJBvJmo6mPtoEGmfJc2RNzXwR79LkhEDqKO
    b7VxQ==
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
Date: Sun, 4 Mar 2018 14:38:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Subject: Re: [PATCH] staging: pi433: fix CamelCase for packetFormat enum
Message-ID: <20180304133837.GA5215@kroah.com>
References: <20180304095556.10335-1-Valentin.Vidic@CARNet.hr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180304095556.10335-1-Valentin.Vidic@CARNet.hr>
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
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Luca =?iso-8859-1?Q?S=F6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 04, 2018 at 10:55:56AM +0100, Valentin Vidic wrote:
> Fixes checkpatch warnings:
> 
>   CHECK: Avoid CamelCase: <packetFormat>
>   CHECK: Avoid CamelCase: <packetLengthFix>
>   CHECK: Avoid CamelCase: <packetLengthVar>
> 
> Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
> ---

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
