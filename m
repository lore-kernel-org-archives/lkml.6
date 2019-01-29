Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F75C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA67C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfA2HZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:25:29 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:49298 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfA2HZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:25:28 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id C4C8D6AC471;
        Tue, 29 Jan 2019 08:25:24 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 29 Jan
 2019 08:25:24 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 29 Jan 2019 08:25:24 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: linux-next: build warning after merge of the spi tree
Thread-Topic: linux-next: build warning after merge of the spi tree
Thread-Index: AQHUt3d+5IRg0ClEmk+Kz6f2xRdpC6XFwDSAgAAHsYA=
Date:   Tue, 29 Jan 2019 07:25:24 +0000
Message-ID: <384775b2-bf1c-3b85-9929-d883196fb90a@kontron.de>
References: <20190129130237.677e5ac8@canb.auug.org.au>
 <VI1PR04MB57262F1ADEEC151C11E0F48499970@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB57262F1ADEEC151C11E0F48499970@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB92287712B47E4D91F967EF50D9DA77@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: C4C8D6AC471.AF04B
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkuMDEuMTkgMDc6NTcsIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+IEhpLA0KPiAN
Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBTdGVwaGVuIFJvdGh3ZWxs
IFttYWlsdG86c2ZyQGNhbmIuYXV1Zy5vcmcuYXVdDQo+PiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5
IDI5LCAyMDE5IDc6MzMgQU0NCj4+IFRvOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+
DQo+PiBDYzogTGludXggTmV4dCBNYWlsaW5nIExpc3QgPGxpbnV4LW5leHRAdmdlci5rZXJuZWwu
b3JnPjsgTGludXggS2VybmVsIE1haWxpbmcNCj4+IExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBZb2dlc2ggTmFyYXlhbiBHYXVyDQo+PiA8eW9nZXNobmFyYXlhbi5nYXVyQG54
cC5jb20+OyBGcmllZGVyIFNjaHJlbXBmDQo+PiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRl
PjsgQm9yaXMgQnJlemlsbG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+Ow0KPj4gQXNoaXNoIEt1
bWFyIDxhc2hpc2gua3VtYXJAbnhwLmNvbT4NCj4+IFN1YmplY3Q6IGxpbnV4LW5leHQ6IGJ1aWxk
IHdhcm5pbmcgYWZ0ZXIgbWVyZ2Ugb2YgdGhlIHNwaSB0cmVlDQo+Pg0KPj4gSGkgYWxsLA0KPj4N
Cj4+IEFmdGVyIG1lcmdpbmcgdGhlIHNwaSB0cmVlLCB0b2RheSdzIGxpbnV4LW5leHQgYnVpbGQg
KEtDT05GSUdfTkFNRSkgcHJvZHVjZWQNCj4+IHRoaXMgd2FybmluZzoNCj4+DQo+PiBXQVJOSU5H
OiBtb2Rwb3N0OiBtaXNzaW5nIE1PRFVMRV9MSUNFTlNFKCkgaW4gZHJpdmVycy9zcGkvc3BpLW54
cC1mc3BpLm8NCj4+IHNlZSBpbmNsdWRlL2xpbnV4L21vZHVsZS5oIGZvciBtb3JlIGluZm9ybWF0
aW9uDQo+Pg0KPiBDYW4gc29tZW9uZSBoZWxwIGluIHBvaW50aW5nIG91dCB0aGF0IHdoeSBhYm92
ZSB3YXJuaW5nIG1lc3NhZ2UgaXMgY29taW5nIGZvciBtZW50aW9uZWQgY29tbWl0Lg0KPiBCZWxv
dyBNT0RVTEVfTElDRU5TRSBzdHJpbmcgaXMgcHJlc2VudCBpbiB0aGUgYWJvdmUgbWVudGlvbmVk
IGZpbGUsIGRyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jLg0KPiAgICAgIE1PRFVMRV9MSUNFTlNF
KCJHUEwgdjIiKTsNCg0KTm8sIGl0IGlzIG5vdCBwcmVzZW50LiBMb29rIGF0IHlvdXIgcGF0Y2hl
cyBbMV0gb3IgYXQgc3BpLW5leHQgWzJdLiANCk1PRFVMRV9MSUNFTlNFIGlzIGRlZmluaXRlbHkg
bWlzc2luZy4NCg0KSW4gcGF0Y2h3b3JrIHRoZSBtaXNzaW5nIGxpbmUgd2FzIGFwcGVuZGVkIHRv
IHRoZSBjb21taXQgbWVzc2FnZSBpbnN0ZWFkIA0Kb2YgdGhlIGFjdHVhbCBwYXRjaCBmb3Igc29t
ZSByZWFzb24uDQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNzY0
MzQ3Lw0KWzJdIA0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvYnJvb25pZS9zcGkuZ2l0L2NvbW1pdC8/aD1mb3ItbmV4dCZpZD1hNTM1NmFlZjZhOTA3YzJl
MmFlZDBjYWFhMmI4OGI2MDIxMzk0NDcx
