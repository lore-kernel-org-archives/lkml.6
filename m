Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2443738-1523197019-3-15522404973443619642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523197018; b=UozHnDhN4LV3RX5RTyCaA0HudNZoLxVU3oYwbatI6U0QT/+SNo
    2OuVywtwza896j6PnvQBoowxvzpq2Rx4uhj7EcFRtilMMBmg+wz1499nGS5ZfPXW
    xLQGcoTc+xqjk08qY9WzhAnX6pqrDGaoNYN2aIICgPvk4LjtxoFiBgzE6DUxeqYV
    zsHixafAnRycBSdBaUfuURL0JyzQ5ixCJ7AA8bx5tNwxV5r1mz3loyvSAtEJAr/j
    wz324A9DCNFBYVWu30XQQw8ZebjXXMOkdzr3iMZwgJauOPSLiU/yJmIV6FAGUBWX
    x2i2zwHtBKimGLwslNw7JenrXH1MZ1uhGJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523197018; bh=7Wbyr
    z5WhIvzJpwir2ZZMFMLQmIueYn2F/C42qiANmA=; b=uLZXb9OnLwQ9DTwY9Jpq8
    i4Rq40n6ylhV6G+a4aA+URFmoJ72uEErTTfyu1wS81oWCgw9/jzG9PjFi7qdHYll
    4RfbrqYVrrVMVJQ5gPgRSj+8FdBJkT7ADNsWmFP8ZzPV7dTgTP2qXALG9Z7ylRMw
    vDfguWnCsajDK8CmE1LKaH25wZHMPHvqGwEINxu9GsNYiChZIDDVAYmFX12Cuw9H
    He5u9+ZllMBjc8IRrSN2WCQmVfYwK29d0j81mYCAkZVQlU/h/fivfUGcUkuqIniD
    PjKRo2hFSMdcXQ048bn3RCHRsDpijhVgDTvh0TbIvtEjo7Y3KIsP2qQYkmDpDkfW
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOjVXapiOiK5Pi9xQAk6B+FPCW2moY7OUTokOocc65YhtctyW2cOth9Es6vyLrotOfNh7bo+ro02/HMwyXQPbKExvjVhrM7PRFVRWZns1PKt09I3VGEC
    M7BN/SLVERayfJIf0LD6vOefMjTa+DeavklxC+omvqLBhZ8r8v9Ex7i8OFBh/mX/S6e/nxzpayuxf+xZxOIaWAzG2mkaGhSRIwHCefg0pxM73qU6iwawOgJC
    mJ/Y3K5eHMkfSQroTn2pTw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ifoZFUwOAAAA:8 a=DDOyTI_5AAAA:8
    a=IB8XoY4Civ89CGm_nikA:9 a=CjuIK1q_8ugA:10 a=yfv2_UWFUko4AKzirQaJ:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
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
 <8eba67bc-7480-f07e-9022-1aa19a4881f5@smarthome-wolf.de>
 <20180325142414.GW31333@gavran.carpriv.carnet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Openpgp: preference=signencrypt
Message-ID: <849553ae-5f62-0a06-f545-4d0fbaa513c3@smarthome-wolf.de>
Date: Sun, 8 Apr 2018 16:15:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180325142414.GW31333@gavran.carpriv.carnet.hr>
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

Hi Valentin,

The hardware of Pi433 is working with every Raspberry Pi (on zero, you
need to solder the GPIO-pins) and with several other fruits like banana
pi. The only thing is, that you need different versions of the driver,
according to the processor, mounted on your fruit.

If you'd like to test more then ther is no hang up or crash, you will
need a second party. You could use a 433MHz socket for testing TX or a
433 thermometer for testing RX. An example code for communication with a
socket is available on the Pi433 productpage (www.pi433.de). The sample
for the thermometer isn't published yet (as always lack of time).

If you want to test more deeply (using different features of the Rf69
chip or even do some long time testing, you have more options, if you
use to Pis with Pi433.

Just let me know, what you'd like to do and what equipment, you need.

Cheers,

Marcus

Am 25.03.2018 um 16:24 schrieb Valentin Vidic:
> On Sun, Mar 25, 2018 at 03:12:52PM +0200, Marcus Wolf wrote:
>> I am not at home the next two weeks. So I can do a codereading on
>> Easter, but testing will not take place earlier then mid/end of April :-(
>>
>> If you are interested, I can provide you an engineering sample of Pi433.
> 
> Sure, let me know which version of Rpi it supports and if I need two
> to test communication.
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
