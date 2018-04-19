Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2811296-1524131713-2-13397605533123251568
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524131712; b=Fus/YngQ0KC+TcC59e4N5IsIq7afDgIdexcaCnZ16PSqlp+7tC
    WNYnjX2uYlv2eXkLtM8gwfkgv9UmC7A6As2kf3sA7ybC5mlQvAZPnWM3IhBHX1M+
    BdU7M2Gi8AphwXsJQ+ilCQU0D9mcLinjvXF4J8/1QzGWX/fpBdFHHbQg8NuuU29I
    zVpnWiY5uMhhf3byqSOjclayAtvAaC5ToIEoCnbds3KZXInmTVdimvE5yeAc5wF3
    8m/OCWiVRdYrFDWjk8YzhvcT44oegM4kaA3mrrS66MR3IOW4PwWOSE+ms3F886pK
    RmualbFTxoIDv6b6hZnV6nS2zA/6CvpYGdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524131712; bh=w/0Pv
    lTa4ENBkw0crIjtv/xq36rb/wp1DKdAIilgQso=; b=qQHYz9SPzxCKXcwq8GOmi
    t7PWfsTJHI2ohcSnx6/CPMhgQ2Da0RMiTtMCtgWfRmJbiBPRTRehd5MxAYTpzrve
    1kdaw/dldRA6NjoBwhPHawui+l4f9s2RiEfBfURg44Rgi8pdTqRd4ymqdSAkyfJW
    kPgkWfG1mVAcd6szMNIBkx/IGhsuWLpSTIhJpzqPjUoTIuho3yyvUcb4JucMnnPv
    toL75vtv7aIXEmXHBVIj+z0JYa3GDc21lZ6iJfnb4iq6hMJJHef1eKcGt9628hHl
    PhMNaC1Or08jPvl4IUG1jlG5JgsZJ48r1zzslllgx0RWivVLVTf6cCH0g+Mbu6VT
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBaGeiYRCI3QsdzpbvnsCLBfMuTnlMOjbGy22kzLfuy17EfGA99d/9GnqiT+AgltXSkPdxDXoE1SHxAeTwXNUPSg4dTIoeNSvXVJcFeTTYIJGrepak+U
    tjiZh3ShxYFJmAfc1smLfyDXxp3mMPtEiVYz52v5nE8fUUFxcXou94SGAw5Da5EoGSElKRCtt7Z9i8qQfEa6ZPue1W8aCzuBGpLnsOXAsjMsmpjZ5yLNwqrS
    2RpCU8Ao2w37A+io3NtS1Q==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=dCgDCzU-EPzWkRZQnGIA:9
    a=QEXdDO2ut3YA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
References: <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
 <20180323180027.GM31333@gavran.carpriv.carnet.hr>
 <20180323221821.GP31333@gavran.carpriv.carnet.hr>
 <8544b858-673f-0f59-0d8b-0474036068ce@smarthome-wolf.de>
 <20180325130944.GU31333@gavran.carpriv.carnet.hr>
 <8eba67bc-7480-f07e-9022-1aa19a4881f5@smarthome-wolf.de>
 <20180325142414.GW31333@gavran.carpriv.carnet.hr>
 <849553ae-5f62-0a06-f545-4d0fbaa513c3@smarthome-wolf.de>
 <20180412171504.GU3257@gavran.carpriv.carnet.hr>
 <61ce1de5-6562-2843-7e63-6a15c16b42a8@smarthome-wolf.de>
 <20180419094748.GA2383@gavran.carpriv.carnet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Openpgp: preference=signencrypt
Message-ID: <1f4f77c8-dc45-9904-7b87-59a94674f274@smarthome-wolf.de>
Date: Thu, 19 Apr 2018 11:55:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419094748.GA2383@gavran.carpriv.carnet.hr>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkhCgpTbyBpZiB5b3UgbGlrZSwgZ2l2ZSBtZSB5b3VyIGFkZHJlc3MsIGFuZCBJJ2xsIHNlbmQg
eW91IHR3byBkZXZlbG9wbWVudApzYW1wbGVzIG9mIFBpNDMzLgoKQ2hlZXJzLAoKTWFyY3VzCgpB
bSAxOS4wNC4yMDE4IHVtIDExOjQ3IHNjaHJpZWIgVmFsZW50aW4gVmlkaWM6Cj4gT24gVGh1LCBB
cHIgMTksIDIwMTggYXQgMTE6MjU6MTlBTSArMDIwMCwgTWFyY3VzIFdvbGYgd3JvdGU6Cj4+IGxl
dCBtZSBrbm93LCB3aGF0IHlvdSBsaWtlIHRvIGhhdmUuIEZvciBzdXJlIHdpdGgganVzdCBvbmUg
c3RhdGlvbiBhbmQKPj4gbm8gb3RoZXIgNDMzTUh6IGVxdWlwbWVudCwgb3B0aW9ucyBmb3IgdGVz
dGluZyBhcmUgcXVpdGUgbGltaXRlZC4KPiAKPiBJIGNhbiBnZXQgUnBpMyBhbmQgd2l0aCB0d28g
c2hpZWxkcyB0ZXN0IDQzM01IeiBjb21tdW5pY2F0aW9uIGJldHdlZW4KPiBScGkyIGFuZCBScGkz
Lgo+IAoKLS0gClNtYXJ0aG9tZS1Xb2xmIFVHIChoYWZ0dW5nc2Jlc2NocsOkbmt0KQpIZWxlbmUt
TGFuZ2UtV2VnIDIzCjgwNjM3IE3DvG5jaGVuCkFtdHNnZXJpY2h0IE3DvG5jaGVuLCBIUkIgMjIz
NTI5ClVtYXN0enN0ZXVlci1JRDogREUzMDQ3MTk5MTEKR2VzY2jDpGZ0c2bDvGhyZXI6IE1hcmN1
cyBXb2xmCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRl
dmVsIG1haWxpbmcgbGlzdApkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnCmh0dHA6Ly9kcml2
ZXJkZXYubGludXhkcml2ZXJwcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaXZlcmRldi1k
ZXZlbAo=
