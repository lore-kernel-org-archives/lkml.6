Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0402C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0432147D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="i1tW9O+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0432147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbeK1CrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:47:02 -0500
Received: from mail-eopbgr60123.outbound.protection.outlook.com ([40.107.6.123]:30896
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729957AbeK1CrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QzgvU7hPslNCRjHkCJgL1+F9sj+tWkhegRZiRpv9sw=;
 b=i1tW9O+2RkAFVzd6ycjM585t4nDPlRbRKX7u4LA1chVyqo9sh708YXc4SbdbQcYu7bMND3bHus3aAC3U/JyL6wYCSEeAEQIEi7UMsNjpHqWr3r6NWKQmQKpHkVsuGA/hpNq5SJyQhPUCFuZPlKhIuKIXvurRooJLAhOvoz1TTV8=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2048.eurprd02.prod.outlook.com (10.167.207.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 27 Nov 2018 15:48:38 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22%8]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 15:48:38 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Thread-Topic: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Thread-Index: AQHUgytOysiM8kcmkUKH16YqSMYlpKVjmU8AgAAxqwA=
Date:   Tue, 27 Nov 2018 15:48:38 +0000
Message-ID: <cba730e8-d76b-6cc4-a6df-3aa79d86e580@axentia.se>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
 <20181123125138.22489-1-thierry.reding@gmail.com>
 <20181127125050.GO1107@kunai>
In-Reply-To: <20181127125050.GO1107@kunai>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0401CA0079.eurprd04.prod.outlook.com
 (2603:10a6:3:19::47) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2048;6:2gFWot13BJE/73gkZeCImeNBiILPXRYXSuuSuC74ZGKXg8sfVS8p+yjuc+ZTGoT6mmRbHUvO8d8koP9Z2uY5CaDghidFSNGAkRms4PImVL7FqHilOtDuI8mzdA1vl4lzApRja1KTjjKlYIcsfZLzej4XHHwwGOY8hK42atXFmnI3ldQT/y7DM81LYd2XcBJgD0yk8iU/hRjpJfiRd+9BuoSlTEXxoa9IS5lN22aVj2X0AqJaknQVIoTzz30TnEopLbujmHujuS7pgwcM2LruPWa31kZCg4FnRPNRI8iNRDXxGJm4LHZClfOU1lGKTs8lrx82wQq8rEtG5csr4OVyNhxXQV4Lz9kv9lYGrtoT9EWwyq0VteCs+T9ILCgR3pvktkctOf/HCiiH+44I2g8KKcjpenqOYOTpc1nYj12uWybZ2DI86vbIPrIWCuj4bjBt3dRvUcyYLXlOkWEmUu1LeQ==;5:E6FkCKbGCyHtyd2EY/IEi61+bLdA/60LUe5WRRxqsyAiyreuxBKiBNk5MptvG4qSkJUkP1OVA382S0kbAgDiF/pDrdhsGMRBoxbNMFNftUcIKAzMG6RaDycP6DspEI+NNxLghUUdhg1+fc0vaKbMic0SsBIxucaaIse0x3kQXqM=;7:FfqRLNmiZZLwhE51CpF0tIMpaTmiP582aPqzMqh0LrdJ/i5OkUuqF9/IvK+8j1gQEo/89XJn9hs//1cK0Fs46dK7sbI5ecZrUUKXN8JJv0kQh7uX5hPNF/Jiu9px0mP60nQrhiAcjI2A2AGL7wKm0A==
x-ms-office365-filtering-correlation-id: b1d80403-d79b-48d9-8f69-08d6547fcc4c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2048;
x-ms-traffictypediagnostic: VI1PR0201MB2048:
x-microsoft-antispam-prvs: <VI1PR0201MB204860BCFF1B4EE81EF58F01BCD00@VI1PR0201MB2048.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0201MB2048;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2048;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39840400004)(376002)(366004)(346002)(199004)(189003)(14454004)(74482002)(110136005)(68736007)(81166006)(8676002)(81156014)(106356001)(31686004)(54906003)(58126008)(316002)(31696002)(25786009)(39060400002)(53936002)(186003)(6246003)(86362001)(64126003)(105586002)(508600001)(256004)(8936002)(4326008)(7736002)(305945005)(65806001)(65956001)(66066001)(26005)(71190400001)(6506007)(6486002)(102836004)(2616005)(446003)(4001150100001)(71200400001)(386003)(53546011)(5660300001)(6116002)(76176011)(6512007)(2906002)(97736004)(6436002)(3846002)(52116002)(229853002)(65826007)(99286004)(476003)(486006)(11346002)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2048;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qs/VwivgkDQLHGb+1UYN2i50amDiRR9pfS0BtmrNo/Fr4yPtvA5JYBpgICZfv8ucZj3TUH3VqjzbRW4dKZdbewCwCu4tSk0U2aBN5kqIART0j6OKReMqyJO1HWcz6BKKrb4SxQKczKWzCEejdFKTM3WuJ/RezVzLPOiTwRxrPHMo5K3IbuaGCL2tZTvP0ZNsEEo5vGPUBZnX0Q3Awivzu7Sy7jEaxbIv3jiVxuOuKBFyFCWm3hBWb9psLLFq+QwSFan15VftSxeFqOPK0CiVToHQHQJhAeNZ4TomNqisUroWfl2f89egO6e/RWMb+nlFR/GGW2dAFEfbE1gdyDCX6dsfqANZckLIf2Y3D+c4soU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FBFB5628175A3C46B4E5B3652103CD4F@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d80403-d79b-48d9-8f69-08d6547fcc4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 15:48:38.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-27 13:50, Wolfram Sang wrote:
> On Fri, Nov 23, 2018 at 01:51:38PM +0100, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> The "at," prefix was never correct for Atmel, so fix the few occurrences
>> that got it wrong. Use "atmel," instead.
>>
>> While at it, remove the at,24c08 compatible string from the list of
>> trivial devices because it is already documented in eeprom/at24.txt.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Peter, I'd assume you are okay with me applying the patch directly?

Absolutely, go ahead.

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
