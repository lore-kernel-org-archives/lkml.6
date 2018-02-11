Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3946819-1518390976-2-1951296245991056686
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518390975; b=fxLwOSRG564UNX3J6P9Hgtq+/08w5lxDkWwVobDln8eg1ld
    hZXZDAGkFcsgeHeI2BUy+WAcQopfaM9yUDA0n/zHr0pUUete01qwtWbN29mLdWgg
    F866h7NVEQDS2IN1RvgbuNMh6qnXiKrfmnesAKifku9i6shbtUKpMRPNzW+KXst1
    BGx/Q4x2Rk4sbLXwx+QiFsiwoBA2zmkNhrm7qJzT+sZaH5+nL0Mg0XOxN8Wot+LJ
    MsbP5Rm4ewokczz6ssK/zIBqcHjp0LiMJSZ+4a6ZehtP0TVUksL6RB1Pa7E9eJqI
    +uVgvWH0g8hR9fVGyT2unElMq288lLa8N2NLnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518390975; bh=0
    qYQaPMBPegk/aJ9WMXCaaz2nHIrld4YTlAakHn6NWw=; b=S2eqtzoxJK8dXxOsc
    5pIYdzAna6uOsin7t3ZQSUwcv74VTTpMFKJKTKg03W7E7FhCV7z/3TLO7+n4LOc+
    dBXoNl2VmQyp5Ro6hiBNSvubTpbVsD4nXPTelf6LjJ9veYLV62T4qBoI1Knp+qUp
    vsnYa+wnNN5SLXs8Az0/BAW00YlCmZQwYGIqKVNuQ2tcnMp/j1VZ7FQ6IhRu2ec9
    Rk2vkOpt4AoenARiqOVAsDvaUfQGdg5JTelM3X0cCK0d9qNF6iUkF1H7FGkS3Uq/
    ch/iXw5lI+lL7rrETq0HTCvys3A1+4yaEQ44ZijHhZizuiONrIeCw/YWGS1GZUMz
    yjQsA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=perches.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=perches.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Remote-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3874:4250:4321:5007:9010:9012:10004:10400:10848:11232:11658:11914:12048:12664:12740:12760:12895:13069:13311:13357:13439:14659:21080:21611:21627:30012:30051:30054:30060:30070:30091,
 0, RBL:none, CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none,
 DomainCache:0, MSF:not bulk, SPF:, MSBL:0, DNSBL:none, Custom_rules:0:0:0,
 LFtime:1, LUA_SUMMARY:none
X-HE-Tag: angle90_8c2185b649307
X-Filterd-Recvd-Size: 1662
Message-ID: <1518390961.4139.1.camel@perches.com>
Subject: Re: [PATCH] staging: lustre: update the TODO list
From: Joe Perches <joe@perches.com>
To: James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, Andreas Dilger
 <andreas.dilger@intel.com>, Oleg Drokin <oleg.drokin@intel.com>, NeilBrown
 <neilb@suse.com>
Date: Sun, 11 Feb 2018 15:16:01 -0800
In-Reply-To: <1518390008-17876-1-git-send-email-jsimmons@infradead.org>
References: <1518390008-17876-1-git-send-email-jsimmons@infradead.org>
X-Mailer: Evolution 3.26.1-1 
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-02-11 at 18:00 -0500, James Simmons wrote:
> As more people become involved with the progression of the lustre
> client it needs to more clear what needs to be done to leave
> staging. Update the TODO list with the various bugs and changes
> to accomplish this. Some are simple bugs and others are far more
> complex task that will change many lines of code. Some even cover
> updating the user land utilities to meet the kernel requirements.
> Several bugs have already been addressed and just need to be
> pushed to the staging tree.

Nice list.

Are or should those entries that have been addressed
also in this new list?

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
