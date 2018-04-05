Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1432864-1522892115-2-14181631483948704006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522892115; b=Wo58+sUU7HItzW6LEMXjA7FGjtxzpWzn8JgEerd3z7EZg5EMcu
    /lP78s6SecBc+md4TFVkxJKoXPxqMNrqO6yukKQ3FNQRlihry/gbL8NamQI6OGZr
    w2030sTfP4mRNOPmqejJEH6al9JDKNZo+lOdEv3mgIpMrj2elHuEL1qGoGwdDFDh
    0SgSncmzYYFefnfQlHKS5Mnw1Mr38e7m7kmPYUxatpIOEMEWBTvU2rH+jFPzsZ91
    TuKA10EkSIyEeljUOv4EJJHe7hcer1ooGpjPtC6swwLkoVjk6Tgc4CxI+GNxTSeo
    ADu/aDy8viQeKSxBvTyGGPe/Ncv/yGxNoE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1522892115; bh=1Fbw93jA4d
    ELiRJQncNpvoEg78Pz9IIbiuGZUwFWgv8=; b=Ve+BdVa7f2drSupXHBY6UqIdwc
    1sndK+L71CCZzxGi72ZXITW8ZvdINC0icuGF51uCCcyoZFVrCHUkEs5TVkSwTOv9
    +eEJIsF/trjlqmqr6v2FFUhyuU9uiPqokx7XV1Td9JND/nHZYXmJf5IMOTer56Hm
    XtUJLCE+lZuaK04wo3M8dNSU7ZvN9Ia9t52bzGBnmgSVK7wlQPM/2fvPO1xAlzwb
    mlO4/BdiQ+vItTe4hqw9WElP8oJGdrh4xlBOG1WSasocqBIAu35JmqH4ZojENwaZ
    GT+XZxarujOrq2+apMV8OBg0hJyELJsWrs5pt8Huu0fAtz82Nj5uaJt1AfVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vn/SixbJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vn/SixbJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN5cWtkhH12nIuI9vsdBpc3VqIjzozD/ibqpYjlj756JQW3d/NPXTBu5Ga9f3CY0lgGq2P69ArGqAE74+gzBJ35ilxixiAjWrsq+hT3iluyz2IctbfSE
    6GhjL7CP6rJz44/IdIN5IVGO0/JuSnhtEADXj9UCXf7LVJUYAH7s4QDuVqrTcdqTBBN6syXHspDtVZ371Q8aVYAR7x5oHQHfSwNenpbsLpvyO3Mt2OBq8UJ0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=_lFUNhwAzb0A:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=0dTTINSRTSE6oYq6QsUA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDEBfD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:35:03 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:31808
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752796AbeDEBeJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 21:34:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        Takashi Iwai <tiwai@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Henders <hendersm@shaw.ca>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] resource: Fix integer overflow at reallocation
Thread-Topic: [PATCH] resource: Fix integer overflow at reallocation
Thread-Index: AQHTzH4w1yhktpvEVkib+qx8lWr0ng==
Date: Thu, 5 Apr 2018 01:34:07 +0000
Message-ID: <DM5PR2101MB1032A83275F4F2C699B5CA8EFBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180402071616.27177-1-tiwai@suse.de>
In-Reply-To: <20180402071616.27177-1-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:y9LQrJUEA4wS+LaoKvCixkgyVDbjvsnj7/tCPiNIGyJWGGZdxArAPhB8IdFakFJ8btPR60hy4oQrywId6wNc7V/kECGsLhIBF8g6IL5PTxmdN4dRNEdl6ijYOWg72lVMfRdENYjfSFlLZ74DaniczshEGAticlQQKK4Iw0/yARn/TiS0zrmv3CwFjskzEJtgiYWGJXRkWz5cUNlcNvx3mmw8Jk2+EugmFjXaf4nFwBBE21RZVFROuc4WKJvolUjN;20:PAVAtxcbwUpHV3rE/jmfEHy4bnbIeqTpIf1B9ttb0LL2XXDKHorasn1ThCQNzJyHlzS2s0Rv8WFb2P8vmJoYv74BuaueGx2JYc2B1n1Jp8R+hGMp8dBGIhuq8F2U12wQTMf1BX+0CbrzY7hwLp909yZD7PwK0bcMy++JT4ZYlOs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 930a8c77-e065-4a2a-bca2-08d59a955326
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0933A5DC91F08A1B564AAB45FBBB0@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(86362001)(97736004)(7696005)(22452003)(55016002)(9686003)(110136005)(8656006)(11346002)(14454004)(53936002)(5660300001)(99286004)(5250100002)(66066001)(8990500004)(6436002)(54906003)(6246003)(26005)(4326008)(68736007)(316002)(10090500001)(2900100001)(446003)(6116002)(72206003)(3660700001)(76176011)(10290500003)(81156014)(86612001)(8676002)(3280700002)(106356001)(33656002)(476003)(102836004)(81166006)(478600001)(305945005)(105586002)(229853002)(74316002)(7736002)(25786009)(1511001)(8936002)(3846002)(6506007)(2906002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: szurReB/zXRYULEycz2AoNpyel2mVqsqhdGqeTjpBVkckQJV62su4bo2acoEUetNKwdtG6S7JIDIprmLuo+aEgtEY9CHwYKdQ+agvexxQWep8IKZ6w8kY4Kh4pCLtpY+XfsxB+BhQzGI4mBn+62qLwOGzMJr50U1pktewccyWoVB8pgIFBNFOVfzzBzeIRpoi43Hf8Lsf5TtWA077eI0N4fG/LlGcbELsGQ3qzm7G6+MJoyDfMdT+JOAHK3oMgsH9y/7htB0QjkPCqSrl5uyZaXpHMmrJeBW/ewLJcqePvF3QDIshnNikt9MXUyz4sCEi4sqWT/wE7Y0dMqUJC2W8wnrzYc2/JYPQanb0ASFokH0M+gu7VfyatFu1ykj2+OFdnJoPWItbwI8GqZzfBoJe49XcmM5lHmIfReCTKueNL8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930a8c77-e065-4a2a-bca2-08d59a955326
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 01:34:07.7453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Takashi Iwai.

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag.
fixing commit: 23c570a67448 resource: ability to resize an allocated resour=
ce.

The bot has also determined it's probably a bug fixing patch. (score: 99.21=
57)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!
v4.4.126: Build OK!

--
Thanks.
Sasha=
