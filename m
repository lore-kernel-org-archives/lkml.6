Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2310776-1521843515-2-13528474688929430223
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521843514; b=bIlKCl+v0e6dDoYJuMPPadtzdFoe4vTAclsluWBXchQIJYu
    dGgCYKUqXXTUjs825zwhoKeApf3PnT/1+QhJUHQC2L4rfKRSED7s6sj7ZxrV/5Lu
    ms2A/BMEPJSPX5cQOxGr0ZkRZAFXfL8IQHGdQUaIABS2F2EAOSJh4AKfpL2h9ew5
    kHkPXE/uc+PvJeXIEvaDoipGapkSwjwuQU+DWLj4ANMTrZ2YCat70qi4e3bZ/CT+
    wJVV4pAi0ih0dPKevYTcpyC6mC0VGvDX7XgKeQSYQLfoQz1RHPvf/V/WjtN5nN8U
    bUY8pLqrDj5xb8/l9+4hUHFOjW3sOIKNXBaxNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521843514; bh=M
    zq0wOGGh4Ig5W20GhcQCw6U9S/p9+qW1yNTeE0Yi1o=; b=w+TSAQ93Q6RA/wI6U
    XWDm18pjsiLrIlz5OlxlqnZLSM46fZZMfLcXFoMjC7/qDELkRllA0m9Zmquv9Diy
    2k77JJSXRc5FX7//zbziK7PeC0+SuztNaMFAk1RqIllBqQ9quykDLgKZbzIVcDn6
    iEmIaTzCBCh5XTwl8aqJ4fzNOfpFhmcdG8W/we2lHFJzgSioFxsfb1Gv0oBpmFuT
    QTgmkM7Gkpl3PR092O18AL8ALuYBnvt+MjJBOEFhxtRFUZQK1gaBWCl1Uj8OrVj4
    q+eD3mmgqyMITwwbWHDx1187wdN286xHSY7h5pbne8F2EcrpCQTZREAc2uaOREfH
    e2R/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 23:18:21 +0100
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <20180323221821.GP31333@gavran.carpriv.carnet.hr>
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180323180027.GM31333@gavran.carpriv.carnet.hr>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Fri, Mar 23, 2018 at 07:00:27PM +0100, Valentin Vidic wrote:
> You are right, here is what kfifo.h says:
> 
> /*
>  * Note about locking : There is no locking required until only * one reader
>  * and one writer is using the fifo and no kfifo_reset() will be * called
>  *  kfifo_reset_out() can be safely used, until it will be only called
>  * in the reader thread.
>  *  For multiple writer and one reader there is only a need to lock the writer.
>  * And vice versa for only one writer and multiple reader there is only a need
>  * to lock the reader.
>  */
> 
> In the case of pi433 there is only one reader (pi433_tx_thread) and
> there is no need for a lock there. But the char device (pi433_write)
> might have multiple writers so we leave the mutex just in that function?

Ah, but there is a kfifo_reset call in pi433_write that requires a
mutex for both readers and writers:

"Usage of kfifo_reset is dangerous. It should be only called when the
fifo is exclusived locked or when it is secured that no other thread is
accessing the fifo."

Also kfifo_reset_out would probably not help here:

"The usage of kfifo_reset_out is safe until it will be only called from
the reader thread and there is only one concurrent reader. Otherwise it
is dangerous and must be handled in the same way as kfifo_reset."

But I have an idea to remove this kfifo_reset call in pi433_write
handling partial message writes:

  kfifo_reset(&device->tx_fifo); // TODO: maybe find a solution, not to discard already stored, valid entries

The writer could acquire the lock and than use kfifo_avail to check if
there is enough space to write the whole message.  What do you think?

-- 
Valentin
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
