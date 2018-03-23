Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1533320-1521819544-2-2877182071453617921
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521819543; b=EvLsHAghiDW/cznYjcMhJHJ5QZmAIEVQSA21cg34E2uMQTJ
    ZLLQtR9E4369eBxTtsjFIqP5x5uMbwQQB9Dr2yhva2Fba1R1YDR38VoDMzgIVCLS
    lP3DsqQcUhBV8pX3YA1RWkSUxrjwjHDiF6y6GZxz+xbnDUqMSjhbT3I1SbXyzTe6
    OI9mPOxAvs6sFk4iRGfxdBls9X3wemos9BaYB/dGvcaSXEOIi8FItPvbDhYvBSTL
    2JIe8phDrjvOtD74+bbVt4T3lFC47jkDrbOIwM1cm4SN8luQBmju05fhZheORL8O
    TXr0zyUtEE2pijd7cIEFiBVnZfnP2/J4+uFZvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521819543; bh=6
    zylwDSQ0W/tykn9n72zbSpP0DyHG/iq/nv9iNXs/+A=; b=t7I86jw2MnwlIzgCq
    0xB4J1szc8LjI6lLKB1gHpY/zDq7N0ZVZ3SlH52cKloZNr2CwPHsBO9ZQk4sh3AZ
    P0Xkr8/FHP5at4atcl71kJAZ4uVr7xe6hUDl+mb3iwmDb7pv2Kmv5s6pW55o513e
    vtmqVAckyjxmIITmWLIIrG3mi44qHclfQ/NrLTGQKOCh9SyGYWbr2qOKXHnHI1Tt
    eYmUhaqsLsvGEPSyXCT3yhB92CDqxUvoCxmOLANpXqGmqlbvT9cAlSvJZLfjtA/Q
    pTBSMbwEXdMpGrzZJDNh05kmm526n1T/4bPMCFw97ezHaLm3hLg2XWi7hJua7CpX
    S5jGg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=smarthome-wolf.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=smarthome-wolf.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
From: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
Date: Fri, 23 Mar 2018 16:38:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323114254.GL31333@gavran.carpriv.carnet.hr>
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

SGkgVmFsZW50aW4sCgpJIGhhZCBubyB0aW1lIHRvIHdvcmsgb24gdGhlIGNvZGUgZm9yIG1vbnRo
ZXMgbm93IGFuZCB0aGUgbWVtb3Jpc2F0aW9uCm9mIG15IHRob3VnaHRzIHdoZW4gSSB3YXMgcHJv
Z3JhbW1pbmcgdGhhdCAoYXBwcm94LiBvbmUgeWVhciBhZ28pIGlzCnF1aXRlIHBhbGUuCgpBcyBm
YXIgYXMgSSByZW1lbWJlciwgSSByZWFkIHNvbWV0aGluZywgdGhhdCB0aGUgZmlmbyBoYXMgYW4g
aW50ZWdyYXRlZApwcm90ZWN0aW9uLCBzbyBubyBleHRlcm5hbCBwcm90ZWN0aW9uIGlzIG5lZWRl
ZC4gQnV0IGFic29sdXRlbHkgdW5zdXJlLgoKSWYgSSB3aWxsIGZpbmQgc29tZSB0aW1lIHdpdGhp
biB0aGUgbmV4dCBkYXlzLCBJJ2xsIGhhdmUgYSBsb29rIGF0IHRoZQpjb2RlIGFuZCB0cnkgdG8g
cmVjYWxsLgoKQnV0IHRoZSBtb3N0IGltcG9ydGFudCB0aGluZyBhbHJlYWR5IHRvb2sgcGxhY2U6
IFdlIHN0YXJ0ZWQgdGhpbmtpbmcKYWJvdXQgaXQgOi0pCgpUaGFua3MsCgpNYXJjdXMKCkFtIDIz
LjAzLjIwMTggdW0gMTI6NDIgc2NocmllYiBWYWxlbnRpbiBWaWRpYzoKPiBPbiBGcmksIE1hciAy
MywgMjAxOCBhdCAxMToyMjozOUFNICswMTAwLCBNYXJjdXMgV29sZiB3cm90ZToKPj4gY291bGQg
eW91IHBsZWFzZSBkZWNyaWJlIGluIHNob3J0IHdvcmRzLCB3aHkgeW91IHRoaW5rLCB0aGF0IGh0
ZSBsb2NrCj4+IGlzbid0IG9ic29sZXRlPwo+Pgo+PiBJIHdhc24ndCBzdXJlLCBidXQgY2xvc2Ug
dG8gcmVtb3ZlIHRoZSBsb2NrLiBUaGF0J3Mgd2h5IEkgcHV0dGVkIHRoZQo+PiBjb21tZW50Lgo+
IAo+IFN1cmUsIGlmIHBpNDMzX3R4X3RocmVhZCBydW5zIG9uIG9uZSBDUFUgaXQgbWlnaHQgYmUg
cG9zc2libGUKPiB0byBjYWxsIHBpNDMzX3dyaXRlIGNvbmN1cnJlbnRseSBvbiBhbm90aGVyIENQ
VSBhbmQgdGhleSB3b3VsZAo+IGJvdGggbW9kaWZ5IHR4X2ZpZm8uICBCdXQgbWF5YmUgdGhlcmUg
aXMgc29tZSBvdGhlciBwcm90ZWN0aW9uCj4gaW4gcGxhY2UgdGhhdCB3b3VsZCBwcmV2ZW50IHRo
aXM/Cj4gCgotLSAKU21hcnRob21lLVdvbGYgVUcgKGhhZnR1bmdzYmVzY2hyw6Rua3QpCkhlbGVu
ZS1MYW5nZS1XZWcgMjMKODA2MzcgTcO8bmNoZW4KQW10c2dlcmljaHQgTcO8bmNoZW4sIEhSQiAy
MjM1MjkKVW1hc3R6c3RldWVyLUlEOiBERTMwNDcxOTkxMQpHZXNjaMOkZnRzZsO8aHJlcjogTWFy
Y3VzIFdvbGYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZGV2ZWwgbWFpbGluZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2Ry
aXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2
LWRldmVsCg==
