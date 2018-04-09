Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240857-2-4874861465135684112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240852; b=hpPOxGdebKaia/nnqnT0eLY0jlr2Z2IynDYX8FmxsZxLS1eMTr
    6ecG97TGETrpog2kQs1TsVBvM2et//jA/x8EL5ivdBw9LXVnHYpamxgKPISU6buK
    SN9PZ54YGB7L2UIapfd9ZKuzUyI0UYe74fsHy317Z6JgPQ8u4L0WJBdzlf4DdECH
    mYuf/7cjafm7iHeYEiQVAQefVVkj8ib4WOdqnDNbaQLzroWMkJVlu81vgmZ5fNbx
    ZLuVl/4HxmG+IUxBLrao7Dj8R7k954js7KLEFQr1oW/vMw/IG8k851m9rcxJYMpJ
    Gpd7cIAd0UhYVmXYNfSW1ursnobx1jx5DONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523240852; bh=Fm3Dp6Oow/sqj+vRqpg/7yEssiVRGO1nnU0YctqS57E=; b=
    ucr5PdSHPSBYVOewbMoD/L/CTE5s1+avCceBxZ4qUn9ILJsll/3Dack4Y/9QTqau
    7T/SCPcpbnMKXxV1FT8niFdAHzdfSc06ZctQi7FK6+/kcyo2z3rVY9n6peJsbzy0
    zKw0csbXmJcOR9Q+sV3wBq1pJDXGyY1lDl7D14mRXjsbandvvohIrhzw9ZhdFZqR
    gNIB9dUNyy8A0u5Mfb26BfwwEHRB1saF9jz1Kt+P24VCo1Ttg5WB2Fk4yHzzVBXu
    LQ1qcFSgrN/KXrAtS7bh8IGTlq+kr7EJgcp5Dqup7n9BhgLe2OFULb5txj3y54lu
    y5mfHNz2OD22DtBFMGQSRw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TIwKNxI3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TIwKNxI3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLLwxHrN7KsB+dp/8DjoaPqcbf5mRXNbtsFbOrUX1WYWbsiR+5KS5V0ltIqPkEVA0d3ssAGtjT6UNqjKN+AA5tRq8CWwZR2LEr76YEHK2x5JcrtkbpbB
    quEftEkPihWJAOOFy3MNHmLQ18+3UFZnRWwADZhKbJJZ8810R3EdntNjiFl1RwUR/VKHNX+4/OeDfr9dssJoSpHek2BkOMTuvkxvxFw/qgfryh4xUISswqTu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=R5C9hjxsAAAA:8 a=pGLkceISAAAA:8 a=JBLUpSMPAAAA:8
    a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=yiG7SrZZ7GZEzMu36yQA:9 a=QEXdDO2ut3YA:10
    a=KpS7wOGxO9l4JKx0McS0:22 a=o8iT8L5u9Sa769JGGcpz:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755909AbeDIC1P (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:27:15 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755900AbeDIA2p (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Peter Dawson <petedaws@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 089/293] ip6_tunnel: Correct tos value in
 collect_md mode
Thread-Topic: [PATCH AUTOSEL for 4.9 089/293] ip6_tunnel: Correct tos value in
 collect_md mode
Thread-Index: AQHTz5kQe6wWfqiBXkiMfyUZnpMKyQ==
Date: Mon, 9 Apr 2018 00:24:03 +0000
Message-ID: <20180409002239.163177-89-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:HTShqbjuKJy49HZUD27IrRyPO7R26xC5Y9quFGCugaDLTcF0KVGEU0MskCkRg+xEvbS2In0PnBKwKFVPCPgk6ssONmpz+ZlmsphfXtE4kPb79ZGyqxyQZ2d4qWEb/DIbkw5ZnI2NeNTML2rKn1ZL3isXlTaed0ZbATiodGCsSF+fXUUmNrUnPRfjHGawY8M2YtpfHYeVdOS/T56pZyNFRm1wtmV9jUzI2IaJXfe1oRvkfpdmDsptqaPL/+uDdjHI;20:e4Ru73qJG6+X6Jsn8ksMmGbmuofuyCsaDU46YLPVFFfb35Iatgu/2I+LwNROKIvji57j/GxKHsLX9WkwSZGEI+gh51Q66/dlubebcLNIJzJVxrHNA797hEnVVRSWc3+PrEXxR+Qm7QlzTSAK/Q5C3yE/Pv8lGYVx3SWklfpKARc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2d878f8-59ae-48fb-d364-08d59db0d593
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807D96958602CAA2418F316FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(173505980823694)(85827821059158)(39337521807258);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(39060400002)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ilfj88WJLp9FLJM/Z/MlkCK3dEA8611vw6uy+R1qMOjV5oDaZu/v+cnYxztHzS3PxX3qKRzVPMzhnAjZMyYag0A9RMPKhOKdYAXaTGYpGscphZi4U2XmifugIB2WswPmfHAKC6wyAOM/ffaA22BiiVLYkis+N8tSJPcCb/sgfsknLkkQ8NLf6REPZT6ZSaRxkZAtlws+CbP5OZlkefcWLpbfauhk67wdXR2VKLgv3KTFcBbs/PA0anwByTjkDRQWJ8TT2ZWwGhQh5J5ifT4bIC+XOzDOj+QH8vOknWzv4AZfdAiTwkxUGOgAqfqpptTnCp05HSrOOHFPzFs1jA/qz0YVyTtvP+6UBmUDdEpMk0Cn1iNTM82y7DvQTRI1ViXPr4CnW1SqfK3joFAdpMvnUFEf+t06BIgR/0bqEboIGE0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <36C4C53A9EC4B849A776900D64D74189@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d878f8-59ae-48fb-d364-08d59db0d593
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:03.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSGFpc2h1YW5nIFlhbiA8eWFuaGFpc2h1YW5nQGNtc3MuY2hpbmFtb2JpbGUuY29tPg0K
DQpbIFVwc3RyZWFtIGNvbW1pdCA0NmY4Y2Q5ZDJmYzFlNGU4YjgyYjUzYTAwMDdmNmM5MmU4MGM5
MzBiIF0NCg0KU2FtZSBhcyBpcF9ncmUsIGdlbmV2ZSBhbmQgdnhsYW4sIHVzZSBrZXktPnRvcyBh
cyB0cmFmZmljIGNsYXNzIHZhbHVlLg0KDQpDQzogUGV0ZXIgRGF3c29uIDxwZXRlZGF3c0BnbWFp
bC5jb20+DQpGaXhlczogMGU5YTcwOTU2MGRiICgiaXA2X3R1bm5lbCwgaXA2X2dyZTogZml4IHNl
dHRpbmcgb2YgRFNDUCBvbg0KZW5jYXBzdWxhdGVkIHBhY2tldHPigJ0pDQpTaWduZWQtb2ZmLWJ5
OiBIYWlzaHVhbmcgWWFuIDx5YW5oYWlzaHVhbmdAY21zcy5jaGluYW1vYmlsZS5jb20+DQpBY2tl
ZC1ieTogUGV0ZXIgRGF3c29uIDxwZXRlci5hLmRhd3NvbkBib2VpbmcuY29tPg0KU2lnbmVkLW9m
Zi1ieTogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogbmV0
L2lwdjYvaXA2X3R1bm5lbC5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL25ldC9pcHY2L2lwNl90dW5uZWwu
YyBiL25ldC9pcHY2L2lwNl90dW5uZWwuYw0KaW5kZXggNWEwMDk4MDdhYzJmLi5kZGI0MDNkNTQy
YjIgMTAwNjQ0DQotLS0gYS9uZXQvaXB2Ni9pcDZfdHVubmVsLmMNCisrKyBiL25ldC9pcHY2L2lw
Nl90dW5uZWwuYw0KQEAgLTEyNTMsNyArMTI1Myw3IEBAIGlwNGlwNl90bmxfeG1pdChzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIAkJZmw2LmZsb3dpNl9wcm90
byA9IElQUFJPVE9fSVBJUDsNCiAJCWZsNi5kYWRkciA9IGtleS0+dS5pcHY2LmRzdDsNCiAJCWZs
Ni5mbG93bGFiZWwgPSBrZXktPmxhYmVsOw0KLQkJZHNmaWVsZCA9IGlwNl90Y2xhc3Moa2V5LT5s
YWJlbCk7DQorCQlkc2ZpZWxkID0gIGtleS0+dG9zOw0KIAl9IGVsc2Ugew0KIAkJaWYgKCEodC0+
cGFybXMuZmxhZ3MgJiBJUDZfVE5MX0ZfSUdOX0VOQ0FQX0xJTUlUKSkNCiAJCQllbmNhcF9saW1p
dCA9IHQtPnBhcm1zLmVuY2FwX2xpbWl0Ow0KQEAgLTEzMjAsNyArMTMyMCw3IEBAIGlwNmlwNl90
bmxfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIAkJ
Zmw2LmZsb3dpNl9wcm90byA9IElQUFJPVE9fSVBWNjsNCiAJCWZsNi5kYWRkciA9IGtleS0+dS5p
cHY2LmRzdDsNCiAJCWZsNi5mbG93bGFiZWwgPSBrZXktPmxhYmVsOw0KLQkJZHNmaWVsZCA9IGlw
Nl90Y2xhc3Moa2V5LT5sYWJlbCk7DQorCQlkc2ZpZWxkID0ga2V5LT50b3M7DQogCX0gZWxzZSB7
DQogCQlvZmZzZXQgPSBpcDZfdG5sX3BhcnNlX3Rsdl9lbmNfbGltKHNrYiwgc2tiX25ldHdvcmtf
aGVhZGVyKHNrYikpOw0KIAkJLyogaXA2X3RubF9wYXJzZV90bHZfZW5jX2xpbSgpIG1pZ2h0IGhh
dmUgcmVhbGxvY2F0ZWQgc2tiLT5oZWFkICovDQotLSANCjIuMTUuMQ0K
