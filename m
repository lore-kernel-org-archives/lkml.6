Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2783707-1524130450-2-12187951771898942099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524130450; b=w55lD/nEeYUbG0Mxv1jzmJGJpgREL0FU5oFah9N54URfKP3X3b
    PMiCr7xI/zvl8wDAs+ILzQRN5+RK9M8KPwQVrQNem7nxOhhEv2UidvqYzFup5yhg
    0XIZv5q0djr4u4JYycbEWDTqK65nP8okj79gBZCKMRfHI83vV5FqjCVsNOKTg1dd
    zqpviyP/nl5N/DoyC/vLZOkRwlXvV68RtoKTJ6KIxiAY4yWYvshxfCwTtiODF6rE
    Tx79eGVD+S7YqwPT6UAhwHihL7y97jnAvqjPhgFVWXkfpuPwg1mKqrc6XTl6RSiV
    uPLWmfHA8sk1tepXsLt/nQwC5qCjsA9AtG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524130450; bh=qVBdL
    h326klP2DJfZQm6PSVFCAz9Fyy3whbbs70BS8E=; b=pih5wWT7hp/Vpcn4BynsL
    VoGqEDDpmr2KJVsZ1gJ/Dwuy12McZoGdpPNpN+jkgUn2QcyBwaEMlGqTWtmkMsI0
    UjnsANcz94gr8cX8evH+r+225zN2uOW/KctxZFs7bUixmegyVTXmSlANBQpfWcUM
    Ic1s9oOIa1Dz1CEEY/Q5Bs0zCEZ9RlA5UHNWd39X4LpTIVsyb22kNTLqp2kYJAWx
    3Kx3JSp/M7Ou852msNN3oWfFi1l50DkGRx1P4PEsk8uh47ENJ/UGBPrG6Vr9RclV
    2yYzbJVSqYPiVquTyvu2QEohMrVnaSL03jsL0bO2lNzQO5E43dJ5TOEYIMbUpu27
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBvT+jH3dv3d9UOqKb/0UUJS6SN7k3q7TfgkM1mIBu0X+3qEcWTF80gGadKA0+n1J+M92mV12N6k+T3cyJaKaCW3E0yBIme+KATG7Ak2thga6rKcSQ/7
    J6nSul0g1P63k50ZBkxO8belxeKw+eILXW4WDR+W9QrhVRt/mdSznqgFsS2TCKW4eRJpQzo7bSr/earVUUl2STM0v3v+VXrs3lRVgHoW3yEhJe0ZK3FnjTEh
    nC8CCvXIDFQEH96foRIYHw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=7suqGn6raZlRI_YAGIkA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
 <20180325130944.GU31333@gavran.carpriv.carnet.hr>
 <68bb0145-b144-b442-7ff3-c6080e44f377@smarthome-wolf.de>
 <20180412184608.GV3257@gavran.carpriv.carnet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Openpgp: preference=signencrypt
Message-ID: <4dba7594-2661-edd5-24ba-cffdf24021c5@smarthome-wolf.de>
Date: Thu, 19 Apr 2018 11:33:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412184608.GV3257@gavran.carpriv.carnet.hr>
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
 =?UTF-8?Q?Luca_S=c3=b6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 =?UTF-8?Q?Simon_Sandstr=c3=b6m?= <simon@nikanor.nu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Am 12.04.2018 um 20:46 schrieb Valentin Vidic:
> On Sun, Apr 08, 2018 at 05:22:46PM +0200, Marcus Wolf wrote:
>> Regarding your patch, I did not understand, why you did not remove
>> the mutex_lock in pi433_write. Wasn't it the goal to remove it?
> 
> Is it possible for more than one userspace program to open the pi433
> device and send messages?  In that case more than one pi433_write
> could be running and it needs to hold a mutex_lock before calling
> kfifo_in.

You are right. The write function is open for multiple userspace programs.
So mutex_lock schould remain.

>> Below find a proposal of pi433_write function, I wrote on base
>> of my outdated (!), private repo. It is not compiled and not tested.
>> Since there is no more handling in case of an error (as well in the
>> propsal as in your patch), I removed the error handling completely.
>> I only do a test to detect proplems while writing to the tx_fifo,
>> but (like in your patch) do nothing for solving, just printing a line.
>> If this unexpected situation will occur (most probably never),
>> the tx_fifo will be (and stay) out of sync until driver gets unloaded.
>> We have to decide, whether we can stay with that. Like written above,
>> I thinkt the benefits are great, the chance of such kind of error
>> very low.
>> What do you think?
> 
> Yes, if there is only one writer and it checks the available size,
> kfifo_in should not fail.  The only problem might be copy_from_user
> but perhaps that is also quite unlikely.  A workaround for that could
> be to copy the data into a temporary kernel buffer first and than
> start kfifo writes using only kernel memory.

For my feeling, that's a safe solution but most probably oversized.

>> It could be discussed, whether it is better to return EMSGSIZE or
>> EAGAIN on the first check. On the one hand, there is a problem with
>> the message size, on the other hand (if message isn't generally too
>> big) after a while, there should be some more space available in
>> fifo, so EAGAIN may be better choice.
> 
> EAGAIN does seem better unless the message is too big to ever fit
> in the kfifo.
> 
>> 	if (retval != required ) {
>> 		dev_dbg(device->dev, "write to fifo failed, reason unknown, non recoverable.");
>> 		return -EAGAIN;
>> 	}
> 
> Maybe this should be dev_warn or even dev_crit if the driver is not
> usable anymore when this happens?  The error message should than also
> be adjusted to EBADF or something similar.

>From my point of veiew, the warning is (in combination of the
size-check) the by far better solution then the fifo reset.

So all in all, I think, we should go with your proposal.

Unfortunaly still no time to setup my test environment with a current
version of the driver in order to give it a try :-(
Sorry,

Marcus
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
