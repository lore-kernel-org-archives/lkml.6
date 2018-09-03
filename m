Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF76C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09352075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="huhS1UCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09352075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeICJ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:26:41 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:56239
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbeICJ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0WH1q0pBFQx4Kqy7o+EAFuLo5g8ovaxSSAaNNFDKDE=;
 b=huhS1UCFsmJx6JhjEzsNiSD+xFNNs9CBEcwQdAeptpaMRQcfEtjcLiSiY2wMDO0D+0hk0+K2xY3gmH16gtuFxtYLHHepXUAwgNTYS0ms9sLMyR221Q2Mk+zHLzTxzaplrxUtNFFOGBzm4P0THaSAToaFyb9sjys4dHxRkvxPZBQ=
Received: from DB7PR04MB4252.eurprd04.prod.outlook.com (52.135.131.26) by
 DB7PR04MB4268.eurprd04.prod.outlook.com (52.135.131.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 3 Sep 2018 05:08:08 +0000
Received: from DB7PR04MB4252.eurprd04.prod.outlook.com
 ([fe80::3d02:c408:f2af:3e18]) by DB7PR04MB4252.eurprd04.prod.outlook.com
 ([fe80::3d02:c408:f2af:3e18%5]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 05:08:08 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: Signed-off-by missing for commit in the net-next tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the net-next
 tree
Thread-Index: AQHUQwWjvHV0ScuB7EWUHsXdIy1BX6TeAbvQ
Date:   Mon, 3 Sep 2018 05:08:08 +0000
Message-ID: <DB7PR04MB4252FC3E1B9B2A56C5B81B268B0C0@DB7PR04MB4252.eurprd04.prod.outlook.com>
References: <20180903074043.65038277@canb.auug.org.au>
In-Reply-To: <20180903074043.65038277@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4268;6:ZKknJuTMLTo3sm/wmnEzbcBUwQRWt8iWwjcEZ4Xmis45SY3ZH31PSaEJEw9x1IgJTlSIItxwcgL1PL6zL59zZCYhubjMXXgelzTQ48h2C6n8OYRVcNNT1pRo0vb/OCduOMin52kZhYd6iTRMls0vqxM1okpA/fBO3jpfuRnsJZKxK93y42Q6c8dSzV0pToR/ITNUwAzyxPJxJ5kJMRbA9fE2pXzS2Sz3GoroW4z8qx2W/a6RHqIR6r0l6j8ILoaC9AOVBhKCZsvLu08QO+sf61C5u6KBhuqjjk/IOnjuUDbAU65QYvGJhWDE7iRUrn7clEsaP/s7wDH1rbkHiOg0D2uUxXrSqiKGTgdQyYu3Qai/2rLZRbxWAEOsmaJG+12jxcMsOFb5Yefe6mwYYNBc3Ec9vQ45VU0RnWrSzGQ6bunErdIJwfutKJHxeBeNW3XzhJHlQQVk8FrXkGU4SF1wgQ==;5:AnPh57WkvWUDQIEKMkcG+HSGgKQErxN+OHdo38VYz6dBOvBPSpdlbYVxgowAriSgwz6WDppdrw9wf7aWLjkfu+XLqosDp7bBkEdeJWh43tm3zTJL0JlRJZm4TRTHI9Cq6P3XNenv9P6fJmAx+GYGhJWGbilgjBkdlnnjzThgtvM=;7:aDMnQF1TO0u3QXsZGD9FbebKcLRIZR4IBsSppUfbG3RuinT9dVv2SCFkuj3Tjg97VFljG7zdB/khqxH5IalzNf1QTS5kzlomdFAG2od95hlTRoNSC+ZMLc1Ofy6m5E9cpkAsQLWyEUAl5s63vJFAkxzv8l0W+fhdtsNe92Mh00MKVqpgRh2dFaeiOJMszYN5Hdm5PqmWdaX1h5oDdqwTCk0skARNvqdikNxIGznVV9YWVj1CulZ7ypzJp+GQv11M
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 50b6e913-176f-4d47-5ca4-08d6115b3d4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4268;
x-ms-traffictypediagnostic: DB7PR04MB4268:
x-microsoft-antispam-prvs: <DB7PR04MB42688B71B39430839B9420A08B0C0@DB7PR04MB4268.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:DB7PR04MB4268;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4268;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(53754006)(13464003)(199004)(189003)(102836004)(3846002)(9686003)(6116002)(6506007)(86362001)(53546011)(14454004)(2900100001)(229853002)(68736007)(8936002)(186003)(66066001)(55236004)(53936002)(6436002)(2906002)(44832011)(446003)(26005)(256004)(55016002)(476003)(11346002)(486006)(74316002)(76176011)(97736004)(7696005)(7736002)(305945005)(99286004)(316002)(81166006)(5660300001)(81156014)(110136005)(54906003)(106356001)(33656002)(5250100002)(105586002)(478600001)(25786009)(8676002)(4326008)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4268;H:DB7PR04MB4252.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rbfYiDUUZ0/W2f6ewnevA5kkhG80itUu0CNCr2uY87sicu6a4Z2DqxRigwkhkF0Kraj6s3xE/O+k5a1967FZkpfAg73MHgM+IwNFuUztWLLp0EeZbyy7iCjrpRDWE5CaZkNWn7k5FgGObgre9pnK9bIobVO3gP+QVW8isHo/83nkwBiqV2fjWnIIHvXSmgfWAZx+iaA4Kdsq8G9bA4oSg3FHJLfq3AaIq7kUVCtHXxvgAoBjW/dKnynfDef770QFj2Gku0aOC8URh+KeMvtpr++FMlTmycpDQu4CaKH5mSH6lcl97uzIVtVHbN53S3XJsaISXwUTdG9P00IMDfmXdMaJTYWpz4C4KpFLKhXvYqg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b6e913-176f-4d47-5ca4-08d6115b3d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 05:08:08.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Monday, September 3, 2018 3:11 AM
> To: David Miller <davem@davemloft.net>; Networking
> <netdev@vger.kernel.org>
> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>; Vakul Garg
> <vakul.garg@nxp.com>
> Subject: linux-next: Signed-off-by missing for commit in the net-next tre=
e
>=20
> Hi all,
>=20
> Commit
>=20
>   c2ad647c6442 ("selftests/tls: Add test for recv(PEEK) spanning across
> multiple records")
>=20
> is missing a Signed-off-by from its author.
>=20

It is my fault to miss adding signoff.
I am sorry about that.
Please advise if I need to do something to fix it.
=20

> --
> Cheers,
> Stephen Rothwell
